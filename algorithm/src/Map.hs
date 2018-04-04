{-# LANGUAGE DuplicateRecordFields, OverloadedStrings, DeriveGeneric #-}

module Map where
  import Data.Aeson
  import qualified Data.ByteString.Lazy as B
  import qualified Data.ByteString.Char8 as C
  import GHC.Generics
  import RBTree
  import Prelude hiding (id)

  data SensorJSON  =
    SensorJSON { id         :: Int
           , x          :: Double
           , y          :: Double
             } deriving (Eq, Ord, Show, Generic)

  instance FromJSON SensorJSON
  instance ToJSON SensorJSON

  data StreetJSON  =
    StreetJSON { id         :: Int
           , dir        :: Int
           , startX     :: Double
           , startY     :: Double
           , endX       :: Double
           , endY       :: Double
             } deriving (Show, Generic)

  instance FromJSON StreetJSON
  instance ToJSON StreetJSON

  data MapJSON  =
    MapJSON {
            streets         :: [StreetJSON]
           ,sensors         :: [SensorJSON]
           ,connections     :: [[Int]]
             } deriving (Show, Generic)

  instance FromJSON MapJSON
  instance ToJSON MapJSON

  data SensorState = Red | Orange | Green deriving (Enum, Eq, Ord, Show, Generic)

  data Sensor =
    Sensor {
            id         :: Int
           , x          :: Double
           , y          :: Double
           , conn_id         :: Int
           , cars            :: Int
           , pieds           :: Int
           , delta           :: Double
           , state           :: SensorState
          } deriving (Eq, Ord, Show, Generic)

  unwrapSensors :: SensorJSON -> Sensor
  unwrapSensors (SensorJSON id x y) = Sensor id x y (-2) 0 0 0 Red

  linkSensors :: RBTree Sensor -> [[Int]] -> RBTree Sensor
  linkSensors sensors conns = let
      getListFromSensorId :: Int -> [[Int]] -> Int -> Int
      getListFromSensorId sensorId list idx =
        case list of
         [] -> -1
         (h:t) -> case (elem sensorId h) of
           False -> getListFromSensorId sensorId t (idx + 1)
           True -> idx

      updateSensor :: Sensor -> Sensor
      updateSensor (Sensor id x y conn_id 0 0 0 Red) = Sensor id x y (getListFromSensorId id conns 0) 0 0 0 Red
    in

    RBTree.map sensors updateSensor


  getJSON :: String -> IO B.ByteString
  getJSON path = B.readFile path

  getSensorsAsList :: String -> IO (([Sensor], [[Int]]))
  getSensorsAsList path = do
    d <- eitherDecode <$> getJSON path :: IO (Either String MapJSON)

    return (case d of
     Left err -> error "the provided file is not valid"
     Right ps -> (Prelude.map unwrapSensors $ sensors ps, connections ps))

  listToBtreeFromTree :: [Sensor] -> RBTree Sensor -> IO (RBTree Sensor)
  listToBtreeFromTree list tree = case list of
    [] -> return tree
    otherwise -> listToBtreeFromTree (tail list) (RBTree.insert tree (head list))

  listToBtree :: [Sensor] -> IO (RBTree Sensor)
  listToBtree list = listToBtreeFromTree list Empty

  getSensorsAsBtree :: String -> IO (RBTree Sensor, [[Int]])
  getSensorsAsBtree path = do
    dataTuple <- getSensorsAsList path
    let conns = snd dataTuple
    tree <- listToBtree $ fst dataTuple

    return (linkSensors tree conns, conns)
