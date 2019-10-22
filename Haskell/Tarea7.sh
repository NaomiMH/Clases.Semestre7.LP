lambda _ [] = []
lambda f (x:xs)
  | f x = x:(lambda f xs)
  | otherwise = lambda f xs
quickshort [] = []
quickshort (x:xs) = do
  let menor = quickshort (lambda (<=x) xs)
  let mayor = quickshort (lambda (>x) xs)
  menor++[x]++mayor
compr [] = False
compr [9] = True
compr (x:xs)
  | x == 0 = False
  | (x+1) == (head xs) = compr xs
  | otherwise = False
agarra _ _ [] = []
agarra _ 0 _ = []
agarra 1 a (x:xs) = x:(agarra 1 (a-1) xs)
agarra de a (x:xs) = agarra (de-1) a xs
esta _ [] = False
esta n (x:xs)
  | n == x = True
  | otherwise = esta n xs
quita _ [] = []
quita n (x:xs)
  | n == x = xs
  | otherwise = x:(quita n xs)
agregar2 [] li = li
agregar2 (x:xs) li
  | (esta x li) = agregar2 xs li
  | otherwise = x:(agregar2 xs li)
agregar [] _ = []
agregar (x:xs) (li:lista) = do
  let ttam = length li
  let tli = agregar2 x li
  if (length tli == (ttam + 3))
    then [tli]++(agregar xs lista)
    else []
checarCud [] _ = []
checarCud xs c
  | (length c) == 0 = [(agarra 1 3 xs)]++[(agarra 4 3 xs)]++[(agarra 7 3 xs)]
  | otherwise = agregar (checarCud xs []) c
checarCol [] [] = []
checarCol (x:xs) (li:lista)
 | (esta x li) = [(quita x li)]++(checarCol xs lista)
 | otherwise = []
sud [] _ _ _ = True
sud (x:xs) col cud n = do
  if (compr (quickshort x))
    then do
      let tcol = checarCol x col
      let tcud = checarCud x cud
      if (length tcol == 9)
        then do
          if (length tcud == 3)
            then do
              if (n == 3)
                then sud xs col [] 1
                else sud xs col tcud (n+1)
            else False
        else False
    else False
sudoQ li = sud li [[1..9],[1..9],[1..9],[1..9],[1..9],[1..9],[1..9],[1..9],[1..9]] [] 1



cam _ _ [] hi = []
cam de a ((n1,n2):li) hi
  | de == a = [hi]
  | n1 == de = (cam n2 a li (hi++[(n1,n2)]))++(cam de a li hi)
  | otherwise = cam de a li hi
elCamino de a li = cam de a li []



myord _ [] = True
myord x li
  | x > 0 = if ((head li) >= (2*x))
    then myord (head li) (tail li)
    else False
  | x < 0 = if ((head li) >= (x/2))
    then myord (head li) (tail li)
    else False
  | otherwise = False
muyOrdenados li = myord (head li) (tail li)



cmab _ [] = []
cmab n1 li
  | n1 == (head li) = cmab (head li) (tail li)
  | otherwise = n1:(cmab (head li) (tail li))
cambios li = cmab (head li) (tail li)



triPas n1 n2 li
  | n2 == 0 = [(n1+n2)]
  | otherwise = [(n1+n2)]++(triPas n2 (head li) (tail li))
trianguloPascal li = triPas 0 (head li) ((tail li)++[0])
