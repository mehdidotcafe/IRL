module Tree where

  data Tree a = Empty | Node a (Tree a) (Tree a) deriving (Show)

  insert :: (Ord a) => Tree a -> a -> Tree a
  insert Empty value = Node value Empty Empty
  insert (Node v t1 t2) value
    | v == value = Node v t1 t2
    | v  < value = Node v t1 (insert t2 value)
    | v  > value = Node v (insert t1 value) t2

  printTree :: (Show a) => Tree a -> IO ()
  printTree tree =
    case tree of
      (Node value left right) -> do
        print value
        printTree left
        printTree right
      Empty -> return ()
