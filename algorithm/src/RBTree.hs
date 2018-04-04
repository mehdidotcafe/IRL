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

  map tree fx = case tree of
    Empty -> Empty
    (RBNode color x left right) -> RBNode color (fx x) (RBTree.map left fx) (RBTree.map right fx)
