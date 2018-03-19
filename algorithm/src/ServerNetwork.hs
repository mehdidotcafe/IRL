module ServerNetwork where

  import Network.Socket hiding (recv)
  import Network.Socket.ByteString (recv)
  import qualified Data.ByteString.Char8 as C
  import Control.Monad (forever)

  readSock (sock, _) = forever $
      do
        msg <- recv sock 1024
        C.putStrLn msg

  loop sock = forever $
      do
       conn <- accept sock
       readSock conn
       close sock

  start = do
    sock <- socket AF_INET Stream 0
    setSocketOption sock ReuseAddr 1
    bind sock (SockAddrInet 4242 iNADDR_ANY)
    listen sock 2
    loop sock
