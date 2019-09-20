;1 anida
;Escribe una función que dado dos parámetros, n y x, anide x n veces en una lista.
;Ejemplo:anida 3 ‘anidado tiene como resultado: (((‘anidado)))
(define (anida que? cuanto?)
  (cond [(null? que?) '()]
        [(= cuanto? 0) que?]
        [else (list (anida que? (- cuanto? 1)))])

;2 max-anidado
;Escribe una función que dada una lista de listas, determina el máximo nivel de anidación
;existente. Ejemplo max-anidado de ((‘a (‘b (‘c (‘d))))) es 4.
(define (mayor n1 n2)
  (cond [(= n1 n2) n1]
        [(> n1 n2) n1]
        [(> n2 n1) n2]))
(define (max-anidado li)
  (cond [(null? li) 0]
        [(list? (car li)) (mayor (max-anidado (car li)) (max-anidado (cdr li)))]
        [else (+ 1 (max-anidado (cdr li)))]))


;3 filtra-anidada
;Escribe una función que dada una lista y un predicado, genera una lista resultante sólo con
;aquellos átomos para los cuales la aplicación del predicado fue positiva. Trabaja sobre listas
;anidadas y la lista resultante respeta los niveles de anidación originales. Por tanto, NO se
;puede usar flatten.
(define (filtra-anidada li pre)
  (cond [(null? li) '()]
        [(list? (car li)) (cons (filtra-anidada (car li) pre) (filtra-anidada (cdr li) pre))]
        [(pre (car li)) (cons (car li) (filtra-anidada (cdr li) pre))]
        [else (filtra-anidada (cdr li) pre)]))


;4 mapa-anidada
;Escribe una función que reciba una función y una lista anidada como parámetros. El
;resultado es una lista anidada con los resultados de aplicar la función a cada átomo de la
;lista. Se respetan los niveles de anidación de la lista original.
(define (mapa-anidada li pre)
  (cond [(null? li) '()]
        [(list? (car li)) (cons (mapa-anidada (car li) pre) (mapa-anidada (cdr li) pre))]
        [else (cons (pre (car li)) (mapa-anidada (cdr li) pre))]))



;5 suma-diagonal
;Escribe una función que sume la diagonal de una matriz cuadrada enviada como parámetro
;y representada como una lista de listas. 
(define (sum col ren x y)
  (cond [(null? col) 0]
        [(null? ren) 0]
        [(= x y) (+ (car col) (sum (cdr ren) (cdr ren) (+ x 1) 0))]
        [(= y 0) (sum (cdr (car col)) ren x (+ y 1))]
        [else (sum (cdr col) ren x (+ y 1))]))
(define (suma-diagonal li)
  (cond [(null? li) 0]
        [else (sum (car li) li 0 0 )]))


;6 selection-sort
;Escribe una función que reciba como parámetro una lista y regrese una versión ordenada
;ascendente de la misma usando el algoritmo selection sort. 
(define (menor li n)
  (cond [(null? li) n]
        [(< (car li) n) (menor (cdr li) (car li))]
        [else (menor (cdr li) n)]))
(define (remplazar li que por)
  (cond [(null? li) '()]
        [(= que (car li)) (cons por (cdr li))]
        [else (cons (car li) (remplazar (cdr li) que por))]))
(define (selection-sort li)
  (cond [(null? li) '()]
        [else (let ([min (menor (cdr li) (car li))])
                   (let ([nli (remplazar (cdr li) min (car li))])
                        (append (list min) (selection-sort nli))))]))


;7 pliega
;Escribe una función que reciba como parámetro una función, un valor inicial y una lista.
;Regresa un sólo valor, resultado de aplicar la función al valor inicial y al primer elemento,
;luego la función con el resultado y el segundo elemento, y así sucesivamente hasta que se
;pliegue toda la lista.
;Ejemplo: pliega + 2 ‘(5 6 7 8) es 28, esto es (((2 + 5) + 6) + 7...)
(define (pliega f num li)
  (cond [(null? li) num]
        [else (pliega f (f num (car li)) (cdr li))]))


;8 zipea
;Escribe una función que recibe dos listas como parámetro y regresa una lista de listas con
;dos elementos, el primero de las dos, luego el segundo de las dos, y así sucesivamente.
;Puedes asumir que ambas listas son de la misma longitud.
;Ejemplo: zipea ‘(1 2 3) ‘(a b c) es ‘((1 a) (2 b) (3 c))
(define (zipea li1 li2)
  (cond [(null? li1) '()]
        [else (cons (list (car li1) (car li2)) (zipea (cdr li1) (cdr li2)))]))
