import Control.Concurrent
import Network.Socket hiding (recv)
import Network.Socket.ByteString (recv)
import ServerNetwork
import Calculation
import RBTree
import Map
import System.Environment
import Control.Exception
import Data.Typeable

main = do
  args <- getArgs

  case (args) of
    [] -> error "please, provide a map as argument"
    [path] -> do
      mvar <- Map.getSensorsAsBtree path >>= newMVar
      ServerNetwork.start mvar Calculation.calculate Calculation.newEvent
