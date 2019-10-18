fila n m = [n.. m]
quita n [] = []
quita n (x:li)
  | n == x = li
  | otherwise = x:(quita n li)
esta n [] = False
esta n (x:li)
  | n == x = True
  | otherwise = esta n li
sacaD1 1 y = (- y + 1)
sacaD1 x 1 = (x - 1)
sacaD1 x y = sacaD1 (x - 1) (y - 1)
sacaD2 x y a = (( x + y ) - (a+1))
cout (pos:xs)
  | xs == [] = print pos
  | otherwise = do
    print pos
    cout xs
busca x y d1s d2s a = do
  let td1 = sacaD1 x y
  if (esta td1 d1s)
    then do
      let td2 = sacaD2 x y a
      if (esta td2 d2s)
        then True
        else False
    else False
reina x [] [] _ _ his a
  | x == (a+1) = [his]
  | otherwise = []
reina _ _ [] _ _ _ _ = []
reina _ [] _ _ _ _ _ = []
reina x (t:ts) ys d1s d2s his a = do
  if (busca x t d1s d2s a)
    then do
      let td1 = sacaD1 x t
      let td2 = sacaD2 x t a
      reina (x+1) (quita t ys) (quita t ys) (quita td1 d1s) (quita td2 d2s) (his ++ [[x,t]]) a ++ reina x ts ys d1s d2s his a
    else reina x ts ys d1s d2s his a
ciclo n m a
  | n == ( a+1) = do
    putStrLn "Casos encontrados: "
    print m
  | otherwise = do
    let td1 = sacaD1 1 n
    let td2 = sacaD2 1 n a
    let temp = (reina 2 (quita n (fila 1 a)) (quita n (fila 1 a)) (quita td1 (fila (- a+1) ( a-1))) (quita td2 (fila (- a+1) ( a-1))) ([[1,n]]) a)
    if (temp /= [])
      then do
        cout temp
        ciclo (n+1) (m+(length temp)) a
      else ciclo (n+1) (m+(length temp)) a
nreina a = ciclo 1 0 a
