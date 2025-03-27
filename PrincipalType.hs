module PrincipalType (typeA, typeB, typeC, typeD, typeE) where

import           Prelude hiding (filter, fmap, foldl, foldr, liftA2, map, mapM,
                          mapM_, pure, replicate, return, reverse, sequence,
                          sequenceA, unzip, zip, zip3, zipWith, (*>), (<$),
                          (<$>), (<*), (<*>), (>>), (>>=))

{--

DO NOT use any additional imports. You will be penalised for that.

You are not allowed to use
    - list comprehensions
    - do-notation
    - any imports
    - any zips or unzips
    - any maps and their operator counterparts (including, but not limited to fmap, amap, mapM, mapM_)
    - any functions on lists and their operator counterparts (including but not limited to sorts, folds, filters, reverse, replicate)
    - (<$>), (<*>), (*>). (>>=), (>>).

Gradescope will check your submission for any of the prohibited syntax, functions, operators and imports.

 ** Basically, the rule is: if you want to use something, implement it yourself! **

Execution time and memory consumption are limited.

Memory consumption is limited to 4 GB.

DO NOT uncomment or write type annotations. You will be penalised for this.

Remember, the task is to get the desired type when typing ":t myFunction" in GHCi.

This problem is worth 10 POINTS.

--}

-- typeA :: (a -> b, b -> c) -> (a -> c)
-- DO NOT UNCOMMENT OR ADD TYPE ANNOTATION
typeA (f, g) x = g (f x)

-- typeB :: a -> (b, c, d) -> c
-- DO NOT UNCOMMENT OR ADD TYPE ANNOTATION
typeB _ (_,y,_)= y

-- typeC :: (a -> [b]) -> (b -> [c]) -> a -> [c]
-- DO NOT UNCOMMENT OR ADD TYPE ANNOTATION
typeC f g x = z (f x)
  where
    z []     = []
    z (y:ys) = g y `append` z ys

    append [] zs     = zs
    append (x:xs) zs = x : append xs zs

-- typeD :: (a -> b) -> ((a -> c) -> d) -> ((b -> c) -> d)
-- DO NOT UNCOMMENT OR ADD TYPE ANNOTATION
typeD = undefined

-- typeE :: ((a -> b -> c) -> a) -> (a -> c) -> c
-- DO NOT UNCOMMENT OR ADD TYPE ANNOTATION
typeE = undefined
