module Calculation where
  import qualified Data.ByteString.Char8 as C
  import Control.Monad (forever)

  printRawMsg msg = C.putStrLn msg

  calculate (tree, m) = forever $ do
    print "in calculate"
