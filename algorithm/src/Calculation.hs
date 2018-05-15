{-# LANGUAGE LambdaCase #-}

module Calculation where
  import qualified Data.ByteString.Char8 as C
  import qualified Data.ByteString as B
  import Data.Maybe
  import Control.Monad (forever)
  import ReceivedPaquet
  import RBTree
  import Map

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

    "new_piedestrian" -> addPiedestrian treeMap (sensor_id paquet) (entity_id paquet)
    "move_piedestrian" -> movePiedestrian treeMap (entity_id paquet) (fromMaybe (-1.0) (ReceivedPaquet.x paquet), fromMaybe (-1.0) (ReceivedPaquet.y paquet))
    "del_piedestrian" -> delPiedestrian treeMap (sensor_id paquet) (entity_id paquet)

  parseMessage :: (RBTree Sensor, [[Int]]) -> B.ByteString ->  IO (RBTree Sensor, [[Int]])
  parseMessage treeMap msg = case (ReceivedPaquet.getJSON msg) of
      Nothing -> do
        print "Invalid Paquet"
        return treeMap
      Just (paquet) -> do
        let ret = refreshDataFromPaquet treeMap paquet
        RBTree.printTree $ fst ret
        return ret

  calculate (tree, m) = print "in calculate"
