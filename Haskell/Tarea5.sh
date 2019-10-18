palindrome :: String -> Bool
palindrome [] = True
palindrome (x:xs)
           | xs == [] = True
           | x == (last xs) = palindrome (init xs)
           | otherwise = False


comprime :: String -> String
comprime [] = []
comprime (x:xs)
         | xs == [] = [x]
         | x == (head xs) = comprime xs
         | otherwise = x:(comprime xs)



elimina [] _ = []
elimina xs n
        | (length xs) < n = xs
        | otherwise = (take (n-1) xs)++(elimina (drop n xs) n)

rota n (x:xs)
     | n == 0 = [x] ++ xs
     | otherwise = (rota (n-1) (xs ++ [x]))


factores :: Int -> [Int]
factores n = [d | d <- [2.. (n-1)], n `mod` d ==0]
isPrimos :: Int -> Bool
isPrimos n = if (factores n) == [] then True else False
