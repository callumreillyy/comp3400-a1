module FirstTriple (firstTriple, firstN, firstNInf, mapHelper) where

import           GHC.Natural (Natural)
import           Prelude     hiding (filter, fmap, foldl, foldr, liftA2, map,
                              mapM, mapM_, pure, replicate, return, reverse,
                              sequence, sequenceA, unzip, zip, zip3, zipWith,
                              (*>), (<$), (<$>), (<*), (<*>), (>>), (>>=))


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


                                                    THE TASK


You will need to implement three versions of a function that returns the first (leftmost) element that occurs at least three times.

EASY:
    Given a finite list of elements, return the first element that occurs three times. You may assume that the answer exists.

    firstTriple [1, 1, 1] == 1
    firstTriple [2, 3, 1, 1, 3, 1] == 1
    firstTriple [2, 3, 1, 1, 3, 1, 3] == 1 -- Although 3 also appears three times, the third occurrence of 1 is earlier than that of 3
    firstTriple [3, 3, 1, 1, 3, 1, 3, 1, 4, 6, 2, 1, 3, 1] == 3

MEDIUM:
    Given a finite list of elements, return the first element that occurs N (N > 0) times. You may assume that the answer exists.

    firstN 2 [1, 2, 3, 2] == 2
    firstN 1 [1, 2, 3, 2] == 1
    firstN 5 [1, 2, 3, 2, 4, 2, 1, 5, 1, 3, 2, 1, 6, 2] == 2
    firstN 5 [1, 2, 3, 2, 4, 2, 1, 5, 1, 3, 2, 1, 6, 2, 1] == 2

HARD:
    Given an infinite list of elements, return the first element that occurs N (N > 0) times.
    You are guaranteed that the answer exists and can be found within a reasonable time with an appropriate algorithm.

    firstNInf 2 ([1, 2, 3, 2] ++ [1, 2 ..]) == 2
    firstNInf 1 ([1, 2, 3, 2] ++ [2, 4 ..]) == 1
    firstNInf 5 ([1, 2, 3, 2, 4, 2, 1, 5, 1, 3, 2, 1, 6, 2] ++ [3, 3 ..]) == 2
    firstNInf 5 ([1, 2, 3, 2, 4, 2, 1, 5, 1, 3, 2, 1, 6, 1, 2] ++ [2..]) == 1

This problem is worth 10 POINTS.

--}

-- EASY: 6 POINTS
firstTriple :: Eq a => [a] -> a
firstTriple xs = findTriple xs []
    where
        findTriple (x:xs) countDict =
            case lookup x countDict of
                Just n | n + 1 == 3 -> x -- check count plus current match (+1)
                       | otherwise  -> findTriple xs (updateCount x (n + 1) countDict) -- update count
                Nothing             -> findTriple xs ((x, 1) : countDict) -- create new count 

        -- update count of current matched value by remapping the countDict using map helper
        updateCount x newCount = mapHelper replaceCount
            where
                replaceCount (y, n) = if y == x then (y, newCount) else (y, n)

-- MEDIUM: 3 POINTS
firstN :: Eq a => Natural -> [a] -> a
firstN n xs = findN xs []
    where
        findN (x:xs) countDict =
            case lookup x countDict of
                Just count | count + 1 == fromIntegral n -> x
                           | otherwise                   -> findN xs (updateCount x (count + 1) countDict) 
                Nothing    | n == 1                      -> x -- return x (first value in list)
                           | otherwise                   -> findN xs ((x, 1) : countDict)

        updateCount x newCount = mapHelper replaceCount
            where
                replaceCount (y, count) = if y == x then (y, newCount) else (y, count)


-- HARD: 1 POINT
-- Completed firstN to work with infinite lists so the function is called here
firstNInf :: Eq a => Natural -> [a] -> a
firstNInf = firstN

-- Helper function for mapping 
mapHelper :: (a -> b) -> [a] -> [b]
mapHelper _ []     = []
mapHelper f (x:xs) = f x : mapHelper f xs