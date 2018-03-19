{-# LANGUAGE DuplicateRecordFields, OverloadedStrings, DeriveGeneric #-}

module Map where
  import Data.Aeson
  import qualified Data.ByteString.Lazy as B
  import qualified Data.ByteString.Char8 as C
  import GHC.Generics

  data Sensor  =
    Sensor { id         :: Int
           , x          :: Double
           , y          :: Double
             } deriving (Show, Generic)

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
            streets          :: [Street]
           ,sensors         :: [Sensor]
           ,connections     :: [Connection]
             } deriving (Show, Generic)

  instance FromJSON MapJSON
  instance ToJSON MapJSON


  getJSON :: String -> IO B.ByteString
  getJSON path = B.readFile path

  getAsGraph :: String -> IO ()
  getAsGraph path = do
    str <- getJSON path
    d <- eitherDecode <$> getJSON path  :: IO (Either String MapJSON)
    -- If d is Left, the JSON was malformed.
    -- In that case, we report the error.
    -- Otherwise, we perform the operation of
    -- our choice. In this case, just print it.
    case d of
     Left err -> putStrLn err
     Right ps -> print ps
