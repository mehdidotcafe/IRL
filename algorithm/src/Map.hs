{-# LANGUAGE DuplicateRecordFields, OverloadedStrings, DeriveGeneric #-}

module Map where
  import Data.Aeson
  import qualified Data.ByteString.Lazy as B
  import qualified Data.ByteString.Char8 as C
  import GHC.Generics
  import RBTree

  data Sensor  =
    Sensor { id         :: Int
           , x          :: Double
           , y          :: Double
             } deriving (Eq, Ord, Show, Generic)

  instance FromJSON Sensor
  instance ToJSON Sensor

  data Street  =
    Street { id         :: Int
           , dir        :: Int
           , startX     :: Double
           , startY     :: Double
           , endX       :: Double
           , endY       :: Double
             } deriving (Show, Generic)

  instance FromJSON Street
  instance ToJSON Street

  data Connection =
    Connection { sensor_A :: Int
               , sensor_B :: Int
                 } deriving (Show, Generic)

  instance FromJSON Connection
  instance ToJSON Connection

  data MapJSON  =
    MapJSON {
            streets         :: [Street]
           ,sensors         :: [Sensor]
           ,connections     :: [Connection]
             } deriving (Show, Generic)

  instance FromJSON MapJSON
  instance ToJSON MapJSON


  getJSON :: String -> IO B.ByteString
  getJSON path = B.readFile path

  getSensorsAsList :: String -> IO [Sensor]
  getSensorsAsList path = do
    d <- eitherDecode <$> getJSON path :: IO (Either String MapJSON)

    return (case d of
     Left err -> error "the provided file is not valid"
     Right ps -> sensors ps)

  listToBtreeFromTree :: [Sensor] -> RBTree Sensor -> IO (RBTree Sensor)
  listToBtreeFromTree list tree = case list of
    [] -> return tree
    otherwise -> listToBtreeFromTree (tail list) (RBTree.insert tree (head list))

  listToBtree :: [Sensor] -> IO (RBTree Sensor)
  listToBtree list = listToBtreeFromTree list Empty

  getSensorsAsBtree :: String -> IO (RBTree Sensor)
  getSensorsAsBtree path = getSensorsAsList path >>= listToBtree
