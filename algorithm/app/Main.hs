import Control.Concurrent
import Control.Monad (forever)
import Network.Socket hiding (recv)
import Network.Socket.ByteString (recv)
import ServerNetwork
import Map
import System.Environment
import Control.Exception
import Data.Typeable

startCalculus :: IO ()
startCalculus = forever $ do
  return startCalculus

main = do
  args <- getArgs
  case (args) of
    [] -> error "please, provide a map as argument"
    [path] -> Map.getSensorsAsBtree path >>= print

  -- forkIO ServerNetwork.start
  -- startCalculus
  putStrLn "YOLO"
