import Control.Concurrent
import Network.Socket hiding (recv)
import Network.Socket.ByteString (recv)
import ServerNetwork
import Calculation
import Map
import System.Environment
import Control.Exception
import Data.Typeable

main = do
  args <- getArgs

  case (args) of
    [] -> error "please, provide a map as argument"
    [path] -> do
      treeMap <- Map.getSensorsAsBtree path
      forkIO (do
        Calculation.calculate treeMap)
      ServerNetwork.start Calculation.printRawMsg
