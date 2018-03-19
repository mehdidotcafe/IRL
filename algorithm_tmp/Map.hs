module Map where
  import Data.Aeson
  import qualified Data.ByteString.Lazy as B

  data Sensor  =
    Sensor { id         :: Int
           , x          :: Int
           , y          :: Int
             } deriving (Show, Generic)

  instance FromJSON Person
  instance ToJSON Person

  data Street  =
    Street { id         :: Int
           , dir        :: Int
           , startX     :: Int
           , startX     :: Int
           , endX       :: Int
           , endX       :: Int
             } deriving (Show, Generic)

  instance FromJSON Person
  instance ToJSON Person


  data MapJSON  =
    MapJSON { sensors         :: [Sensor]
           , streets          :: [Street]
             } deriving (Show, Generic)

  instance FromJSON MapJSON
  instance ToJSON MapJSON



  getJSON path = B.readFile jsonFile


  getAsGraph path = do
    d <- (eitherDecode <$> getJSON)
    -- If d is Left, the JSON was malformed.
    -- In that case, we report the error.
    -- Otherwise, we perform the operation of
    -- our choice. In this case, just print it.
    case d of
     Left err -> putStrLn err
     Right ps -> print ps
