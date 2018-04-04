module ServerNetwork where

  import Network.Socket hiding (recv)
  import Network.Socket.ByteString (recv)
  import Control.Monad (forever)

  readSock (sock, _) callback = forever $
      do
        print "new client"
        msg <- recv sock 1024
        callback msg

  loop sock callback = forever $
      do
       conn <- accept sock
       readSock conn callback
       close sock

  start callback = do
    sock <- socket AF_INET Stream 0
    setSocketOption sock ReuseAddr 1
    bind sock (SockAddrInet 4242 iNADDR_ANY)
    print "creating server at port 4242"
    listen sock 2
    loop sock callback
