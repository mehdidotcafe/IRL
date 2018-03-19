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
