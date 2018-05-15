{-# LANGUAGE DuplicateRecordFields, OverloadedStrings, DeriveGeneric #-}

module ReceivedPaquet where
  import Data.Aeson
  import GHC.Generics
  import qualified Data.ByteString.Lazy.Char8 as C
  import qualified Data.ByteString as B

  data PaquetJSON =
    PaquetJSON { event      :: String
            , sensor_id     :: Int
            , entity_id     :: Int
            , x             :: Maybe Float
            , y             :: Maybe Float 
  } deriving(Show, Ord, Eq, Generic)

  instance FromJSON PaquetJSON
  instance ToJSON PaquetJSON

  getJSON :: B.ByteString -> Maybe PaquetJSON
  getJSON buffer = decode (C.fromStrict buffer) :: Maybe PaquetJSON
