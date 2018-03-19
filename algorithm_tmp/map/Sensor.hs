data Sensor  =
  Sensor { id         :: Int
         , x          :: Int
         , y          :: Int
           } deriving (Show, Generic)

instance FromJSON Person
instance ToJSON Person
