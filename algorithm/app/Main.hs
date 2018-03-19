import Control.Concurrent
import Control.Monad (forever)
import Network.Socket hiding (recv)
import Network.Socket.ByteString (recv)
import ServerNetwork
import Map
import System.Environment

startCalculus :: IO ()
startCalculus = forever $ do
  return startCalculus

main = do
  args <- getArgs
  Map.getAsGraph $ head args
  -- forkIO ServerNetwork.start
  -- startCalculus
  putStrLn "YOLO"
