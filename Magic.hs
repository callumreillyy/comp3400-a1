module Magic (magic, enumerate, dropEvenIx, sumOddIx) where

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


Implement the function

magic :: (Natural -> a -> b -> b) -> b -> [a] -> b
             ^       ^                     ^
       Index of    this element       in this list

where Natural corresponds to the index of the element in the list (starting from zero)

Important! This is NOT a Principal Type question! The function must be total and do something useful.

Trivial implementations like

        magic f b lst = f 42 b (head lst)

will be REJECTED even though the type is correct.

You MUST use magic exactly once in each function below.

EASY:

    sumOddIx returns the sum of elements with odd indices (starting from zero)


MEDIUM:

    dropEvenIx returns the input list without all elements which had even indices (starting from zero)

HARD:

    enumerate returns the input list but each element is associated with its index (starting from zero)


Examples:

sumOddIx [1] == 0
sumOddIx [1, 2] == 2
sumOddIx [1, 2, 3] == 2
sumOddIx [1, 2, 3, 4] == 6

dropEvenIx [1] == []
dropEvenIx [1, 2] == [2]
dropEvenIx [1, 2, 3] == [2]
dropEvenIx [1, 2, 3, 4] == [2, 4]

enumerate ['a'] == [(0, 'a')]
enumerate [True, False] == [(0, True), (1, False)]
enumerate [[1, 2], [3], [4, 5, 6]] == [(0, [1, 2]), (1, [3]), (2, [4, 5, 6])]


We advise you to analyse the three functions above and find a common pattern in them.
This pattern will help you implement @magic@

This problem is worth 10 POINTS.

--}

-- 4 POINTS
magic :: (Natural -> a -> b -> b) -> b -> [a] -> b
magic f y xs = doMagic 0 y xs
    where
        doMagic _ y []     = y
        doMagic n y (x:xs) = f n x (doMagic (n + 1) y xs)

-- EASY: 2.5 POINTS
-- init y as accumulator starting 0
sumOddIx :: [Integer] -> Integer
sumOddIx nums = magic f 0 nums
    where
        f n num sum = if odd n then sum + num else sum

-- MEDIUM: 2.5 POINTS
-- init y as empty list []
-- use : to preappend x to list y (compared to ++)
dropEvenIx :: [a] -> [a]
dropEvenIx nums = magic f [] nums
    where
        f n num lst = if odd n then num : lst else lst

-- HARD: 1 POINT
enumerate :: [a] -> [(Natural, a)]
enumerate vals = magic f [] vals
    where
        f n val dict = (n, val) : dict
