module ServerNetwork where
  import Control.Concurrent
  import Network.Socket hiding (send, sendTo, recv, recvFrom)
  import Network.Socket.ByteString
  import Data.ByteString.Char8
  import Control.Monad (forever)

  -- readSock d sock callback = recv sock 1024 >>= (\msg -> callback d msg) >>= (\newD -> readSock newD sock callback)
  readSock d sock callback = forever $ do
    recv sock 1024 >>= (\msg -> callback d msg)

  loop d sock forkCallback callback = forever $
      do
       (sock, _) <- accept sock
       send sock $ pack "=== CONNECTION ACCEPTED ===\n"
       forkIO (do
         forkCallback d sock)
       readSock d sock callback
       close sock

  start d forkCallback callback = do
    sock <- socket AF_INET Stream 0
    setSocketOption sock ReuseAddr 1
    bind sock (SockAddrInet 4242 iNADDR_ANY)
    print "=== CREATING SERVER AT PORT 4242 ==="
    listen sock 2
    loop d sock forkCallback callback
