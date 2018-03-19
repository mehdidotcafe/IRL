import Control.Concurrent
import Control.Monad (forever)
import Network.Socket hiding (recv)
import Network.Socket.ByteString (recv)
import ServerNetwork
import Map

startCalculus = forever $ do
  return startCalculus

main = do
  Map.getAsGraph
  -- forkIO ServerNetwork.start
  -- startCalculus
  putStrLn "Ca va faire des calculs et du reset de timeout"
