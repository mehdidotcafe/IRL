module ServerNetwork where

  import Network.Socket hiding (recv)
  import Network.Socket.ByteString (recv)
  import Control.Monad (forever)

  readSock d sock callback = recv sock 1024 >>= (\msg -> callback d msg) >>= (\newD -> readSock newD sock callback)

  loop d sock callback = forever $
      do
       conn <- accept sock
       print "new client"
       readSock d (fst conn) callback
       close sock

  start d callback = do
    sock <- socket AF_INET Stream 0
    setSocketOption sock ReuseAddr 1
    bind sock (SockAddrInet 4242 iNADDR_ANY)
    print "creating server at port 4242"
    listen sock 2
    loop d sock callback
