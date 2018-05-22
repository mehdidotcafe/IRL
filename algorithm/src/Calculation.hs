{-# LANGUAGE LambdaCase #-}

module Calculation where
  import Network.Socket hiding (recv)
  import Control.Concurrent
  import qualified Data.ByteString.Char8 as C
  import qualified Data.ByteString as B
  import Network.Socket.ByteString
  import Data.ByteString.Char8 hiding (length, head, tail)
  import Data.Maybe
  import Control.Monad (forever)
  import ReceivedPaquet
  import RBTree
  import Map
  import Sensor
  import Debug.Trace
  import Data.Char
  import System.IO.Unsafe

  addCarValueToSensor sensorId value (Sensor id x y conn_id cars pieds delta state) = if id == sensorId
      then (Sensor id x y conn_id (max 0 (cars + value)) pieds delta state)
      else (Sensor id x y conn_id cars pieds delta state)

  addPiedestrianValueToSensor sensorId value (Sensor id x y conn_id cars pieds delta state) = if id == sensorId
      then (Sensor id x y conn_id cars (max 0 (pieds + value)) delta state)
      else (Sensor id x y conn_id cars pieds delta state)


  addCar :: RBTreeList -> Int -> Int -> RBTreeList
  addCar treeMap sensorId carId = ((RBTree.map (fst treeMap) (addCarValueToSensor sensorId 1)), (snd treeMap))

  moveCar :: RBTreeList -> Int -> (Float, Float) -> RBTreeList
  moveCar treeMap carId coords = treeMap

  delCar :: RBTreeList -> Int -> Int -> RBTreeList
  delCar treeMap sensorId carId = ((RBTree.map (fst treeMap) (addCarValueToSensor sensorId (-1))), (snd treeMap))


  addPiedestrian :: RBTreeList -> Int -> Int -> RBTreeList
  addPiedestrian treeMap sensorId pId = ((RBTree.map (fst treeMap) (addPiedestrianValueToSensor sensorId 1)), (snd treeMap))

  movePiedestrian :: RBTreeList -> Int -> (Float, Float) -> RBTreeList
  movePiedestrian treeMap pId coords = treeMap

  delPiedestrian :: RBTreeList -> Int -> Int -> RBTreeList
  delPiedestrian treeMap sensorId pId = ((RBTree.map (fst treeMap) (addPiedestrianValueToSensor sensorId (-1))), (snd treeMap))


  refreshDataFromPaquet :: RBTreeList -> PaquetJSON -> RBTreeList
  refreshDataFromPaquet treeMap paquet = case event paquet of
    "new_car" -> addCar treeMap (sensor_id paquet) (entity_id paquet)
    "move_car" -> moveCar treeMap (entity_id paquet) (fromMaybe (-1.0) (ReceivedPaquet.x paquet), fromMaybe (-1.0) (ReceivedPaquet.y paquet))
    "del_car" -> delCar treeMap (sensor_id paquet) (entity_id paquet)

    "new_pied" -> addPiedestrian treeMap (sensor_id paquet) (entity_id paquet)
    "move_pied" -> movePiedestrian treeMap (entity_id paquet) (fromMaybe (-1.0) (ReceivedPaquet.x paquet), fromMaybe (-1.0) (ReceivedPaquet.y paquet))
    "del_pied" -> delPiedestrian treeMap (sensor_id paquet) (entity_id paquet)

    -- Legacy
    "new_piedestrian" -> addPiedestrian treeMap (sensor_id paquet) (entity_id paquet)
    "move_piedestrian" -> movePiedestrian treeMap (entity_id paquet) (fromMaybe (-1.0) (ReceivedPaquet.x paquet), fromMaybe (-1.0) (ReceivedPaquet.y paquet))
    "del_piedestrian" -> delPiedestrian treeMap (sensor_id paquet) (entity_id paquet)

  newEvent :: MVar RBTreeList -> B.ByteString ->  IO ()
  newEvent wrappedTreeMap msg = case (ReceivedPaquet.getJSON msg) of
      Nothing -> print "Invalid Paquet"
      Just (paquet) -> do
        treeMap <- takeMVar wrappedTreeMap
        let ret = refreshDataFromPaquet treeMap paquet
        putMVar wrappedTreeMap ret

  getConnectedSensors :: RBTree Sensor -> [Int] -> [Sensor]
  getConnectedSensors sensors ids = case ids of
    [] -> []
    (x:xs) -> case RBTree.get sensors (\node -> (Sensor.id node) == x) of
      Nothing -> []
      Just sensor -> sensor : (getConnectedSensors sensors xs)

  computeSum :: Sensor -> Double
  computeSum (Sensor id x y conn_id cars pieds delta state) = 2.0 * (fromIntegral cars) - (fromIntegral pieds)

  getNextGreenSensor :: [Sensor] -> Sensor
  getNextGreenSensor sensors =  case length sensors of
    1 -> head sensors
    _ -> do
      let otherSensor = getNextGreenSensor $ tail sensors
      let currSensor = head sensors
      if (computeSum currSensor) > (computeSum otherSensor)
        then currSensor
        else otherSensor

  sendChange sensor buffer = unsafePerformIO $ do
    sensorList <- takeMVar buffer
    putMVar buffer $ sensor : sensorList
    -- Network.Socket.ByteString.send sock $ pack $ Sensor.toJSON sensor
    return sensor

  -- sendChange sensor sock = trace "SENSOR CHANGED" sensor

  updateSensorUnconnected :: Sensor -> MVar [Sensor] -> Sensor
  updateSensorUnconnected sensor buffer = if (computeSum sensor) > 0
    then if (state sensor) == Red
      then sendChange (setToGreen sensor) buffer
      else incrDelta sensor $ getDelay
    else if (state sensor) == Green
      then sendChange (setToRed sensor) buffer
      else incrDelta sensor $ getDelay

  getDelay :: Int
  getDelay = 100 * 1000

  updateSensorState :: RBTree Sensor -> ConnList -> Socket -> MVar [Sensor] -> Sensor -> Sensor
  updateSensorState sensors conns sock buffer sensor = case (conn_id sensor) of
    -1 -> updateSensorUnconnected sensor buffer
    _ -> do
      let connectedSensors = getConnectedSensors sensors (conns !! (conn_id sensor))
      case connectedSensors of
        [] -> updateSensorUnconnected sensor buffer
        _ -> if (Sensor.id $ getNextGreenSensor connectedSensors) == Sensor.id sensor
          then if (state sensor) == Red
              then sendChange (setToGreen sensor) buffer
              else incrDelta sensor $ getDelay
          else if (state sensor) == Green
              then sendChange (setToRed sensor) buffer
              else  incrDelta sensor $ getDelay


  sendData sock sensors = if (length sensors) > 0 then Network.Socket.ByteString.send sock $ pack $ Sensor.toJSONList sensors else return (0)

  calculate :: MVar RBTreeList -> Socket -> IO ()
  calculate wrappedTreeMap sock = forever $ do
    (tree, conns) <- takeMVar wrappedTreeMap
    buffer <- newMVar []
    let newTree = RBTree.map tree (updateSensorState tree conns sock buffer)
    RBTree.printTree newTree
    putMVar wrappedTreeMap (newTree, conns)
    toSend <- readMVar buffer
    sendData sock toSend
    threadDelay $ getDelay
