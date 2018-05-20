module RBTree where
  data Color = RedN | BlackN deriving Show
  data RBTree a  = Empty | RBNode Color a (RBTree a) (RBTree a) deriving (Show)

  insert :: (Ord a) => RBTree a -> a -> RBTree a
  insert s value = makeBlackN $ ins s
    where ins Empty  = RBNode RedN value Empty Empty
          ins (RBNode color y left right)
            | value < y  = balance color y (ins left) right
            | value == y = RBNode color y left right
            | value > y  = balance color y left (ins right)
          makeBlackN (RBNode _ value left right) = RBNode BlackN value left right

  balance :: Color -> a -> RBTree a -> RBTree a -> RBTree a
  balance BlackN z (RBNode RedN y (RBNode RedN x a b) c) d = RBNode RedN y (RBNode BlackN x a b) (RBNode BlackN z c d)
  balance BlackN z (RBNode RedN x a (RBNode RedN y b c)) d = RBNode RedN y (RBNode BlackN x a b) (RBNode BlackN z c d)
  balance BlackN x a (RBNode RedN z (RBNode RedN y b c) d) = RBNode RedN y (RBNode BlackN x a b) (RBNode BlackN z c d)
  balance BlackN x a (RBNode RedN y b (RBNode RedN z c d)) = RBNode RedN y (RBNode BlackN x a b) (RBNode BlackN z c d)
  balance color x a b = RBNode color x a b

  get :: RBTree a -> (a -> Bool) -> Maybe a
  get Empty fx = Nothing
  get (RBNode color x left right) fx = case fx x of
    True -> Just x
    False -> case get left fx of
      Nothing -> get right fx
      Just x -> Just x

  map :: RBTree a -> (a -> a) -> RBTree a
  map tree fx = case tree of
    Empty -> Empty
    (RBNode color x left right) -> RBNode color (fx x) (RBTree.map left fx) (RBTree.map right fx)

  value :: RBTree a -> Maybe a
  value Empty = Nothing
  value (RBNode color x left right) = Just x

  getLeft :: RBTree a -> RBTree a
  getLeft (RBNode color x left right) = left

  printTree :: (Show a) => RBTree a -> IO ()
  printTree tree =
    case tree of
      (RBNode color value left right) -> do
        print value
        printTree left
        printTree right
      Empty -> return ()
