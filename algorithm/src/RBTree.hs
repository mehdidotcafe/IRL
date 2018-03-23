module RBTree where
  data Color = Red | Black deriving Show
  data RBTree a  = Empty | RBNode Color a (RBTree a) (RBTree a) deriving (Show)

  insert :: (Ord a) => RBTree a -> a -> RBTree a
  insert s value = makeBlack $ ins s
    where ins Empty  = RBNode Red value Empty Empty
          ins (RBNode color y left right)
            | value < y  = balance color y (ins left) right
            | value == y = RBNode color y left right
            | value > y  = balance color y left (ins right)
          makeBlack (RBNode _ value left right) = RBNode Black value left right

  balance :: Color -> a -> RBTree a -> RBTree a -> RBTree a
  balance Black z (RBNode Red y (RBNode Red x a b) c) d = RBNode Red y (RBNode Black x a b) (RBNode Black z c d)
  balance Black z (RBNode Red x a (RBNode Red y b c)) d = RBNode Red y (RBNode Black x a b) (RBNode Black z c d)
  balance Black x a (RBNode Red z (RBNode Red y b c) d) = RBNode Red y (RBNode Black x a b) (RBNode Black z c d)
  balance Black x a (RBNode Red y b (RBNode Red z c d)) = RBNode Red y (RBNode Black x a b) (RBNode Black z c d)
  balance color x a b = RBNode color x a b

  map tree fx = case tree of
    Empty -> Empty
    (RBNode color x left right) -> RBNode color (fx x) (RBTree.map left fx) (RBTree.map right fx)
