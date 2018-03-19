data MapJSON  =
  MapJSON { sensors         :: [Sensor]
         , streets          :: [Street]
           } deriving (Show, Generic)

instance FromJSON MapJSON
instance ToJSON MapJSON
