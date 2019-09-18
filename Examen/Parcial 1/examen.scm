(define (nombre)
  (display "Naomi Macias Honti\n"))
(define (matricula)
  (display "A01282098\n"))
(define (calificacion)
  (display "100 de 10\n"))

;Teoría (20 pts)

;1 Familia de analizadores sintácticos que utilizan una estrategia bottom-up, shift-reduce, apoyado en un stack para ir generalizando las producciones (subárboles) hasta llegar a la raíz

(define (teoria1)
  (display "\n"))


;2 Describe cada uno de los cuatro estratos de la jerarquía de Chomsky

(define (teoria2)
  (display "\n"))


;3 Elimina la recursividad terminal de la siguiente gramática. Las mayúsculas son no-terminales, las minúsculas son terminales. 
; A -> Ab | c | D
; D -> e | f

(define (teoria3)
  (display "A  -> cA' | DA'\n")
  (display "A' -> bA' | vacio\n")
  (display "D  -> e | f\n"))

;4 Diseña una expresión regular que acepte la notación de números complejos en Racket. Ejemplos: 3+0i, 3-8i, 3, -5i, -i, 0

(define (teoria4)
  (display "[0-9]* ([+|-] [0-9]* i)?\n")
  (display "Lo mismo\n[0-9]* [ [+|-] [0-9]* i | vacio ]\n"))


;5 Menciona 3 validaciones pertinentes a la fase de análisis semántico

(define (teoria5)
  (display "El que este dentro del lenguaje\nPor ejemplo\nSi el lenguaje es de solo numeros, debe de haber solo numeros\n")
  (display "El que haga \"palabras\" correctas\nPor ejemplo\nQue el conjunto de datos que te den formen estructuras correctas\n")
  (display "La sintatix correcto\nPor ejemplo\nQue las palabras dadas formen oraciones coherentes\n"))


;-------------------------

;Práctica (80 pts)


;1 (10 pts) tiene-ceros? (funciones auxiliares: remainder, quotient)
;Escribe una función que recibe un número entero positivo y regresa un booleano que determine si tiene o no ceros

(define (tiene-ceros? num)
  (cond [(= num 0) #t]
        [(< num 10) #f]
        [(= (mod num 10) 0) #t]
        [else (tiene-ceros? (floor (/ num 10)))]))

(define (practica1)
  (if (tiene-ceros? 1111)
    (display "Caso 1.1 Tiene Ceros\n")
    (display "Caso 1.1 No tiene cerros\n"))
  (if (tiene-ceros? 1234033)
    (display "Caso 1.2 Tiene ceros\n")
    (display "Caso 1.2 No tiene cerros\n")))

;Casos de prueba
;(check-eq? (tiene-ceros? 1111) #f "Caso 1.1 Incorrecto")
;(check-eq? (tiene-ceros? 1234033) #t "Caso 1.2 Incorrecto")




;-----
;2 (15 pts) sumatoria1/i (recursividad terminal)
;Escribe una función que recibe un número entero positivo y regresa la sumatoria 1 + (1 / 2) + (1 / 3)...(1 / n)
;Si recibe 0 o negativo, regresa falso. Utiliza la técnica de recursividad terminal para que el intérprete pueda optimizarla.

(define (sumatoria num sum)
  (cond [(= num 0) 0]
        [(= num 1) (+ sum 1)]
        [(< num 0) 0]
        [else (sumatoria (- num 1) (+ sum (/ 1 num)))]))

(define (practica2)
  (list (list "Caso 2.1" (sumatoria 4 0) (+ 1 (/ 1 2) (/ 1 3) (/ 1 4)))
        (list "Caso 2.2" (sumatoria 0 0) 0)
        (list "Caso 2.3" (sumatoria 1 0) 1)))
        
;Casos de prueba
;(check-eqv? (sumatoria1/i-term 4) (+ 1 (/ 1 2) (/ 1 3) (/ 1 4)) "Caso 2.1 Incorrecto")
;(check-eqv? (sumatoria1/i-term 0) #f "Caso 2.2 Incorrecto")
;(check-eqv? (sumatoria1/i-term 1) 1 "Caso 2.3 Incorrecto")




;-----
;3 (10 pts) teje-lista
;Escribe una función que recibe dos listas como parámetro y regresa una sola lista con los elementos entrelazados de las dos enviadas.
;Esto es l1 es (1 1 1) y l2 es (2 2 2), entonces el resultado es (1 2 1 2 1 2).
;NOTA: las listas pueden ser de distintos tamaños

(define (teje-lista li1 li2)
  (cond [(null? li1) li2]
        [(null? li2) li1]
        [else (append (list (car li1) (car li2)) (teje-lista (cdr li1) (cdr li2)))]))

(define (practica3)
  (list (list "Caso 3.1" (teje-lista '(1 1 1) '(2 2 2)) '(1 2 1 2 1 2))
        (list "Caso 3.2" (teje-lista '() '(2 2 2)) '(2 2 2))
        (list "Caso 3.3" (teje-lista '(1 1 1) '()) '(1 1 1))
        (list "Caso 3.4" (teje-lista '(1 1) '(2 2 2 2 2)) '(1 2 1 2 2 2 2))))

;Casos de prueba
;(check-equal? (teje-lista '(1 1 1) '(2 2 2)) '(1 2 1 2 1 2) "Caso 3.1 Incorrecto")
;(check-equal? (teje-lista '() '(2 2 2)) '(2 2 2) "Caso 3.2 Incorrecto")
;(check-equal? (teje-lista '(1 1 1) '()) '(1 1 1) "Caso 3.3 Incorrecto")
;(check-equal? (teje-lista '(1 1) '(2 2 2 2 2)) '(1 2 1 2 2 2 2) "Caso 3.4 Incorrecto")




;-----
;4 (10 pts) toma-mientras
;Escribe una función que recibe como parámetro un predicado y una lista. Toma elementos hasta que se encuentre con el primero que no
;cumple con la condición del predicado

(define (toma-mientras pred li)
  (if (null? li)
    '()
    (if (pred (car li))
      (cons (car li) (toma-mientras pred (cdr li)))
      '())))

(define (practica4)
  (list (list "Caso 4.1" (toma-mientras (lambda (x) (< x 5)) '(1 2 3 4 5 6 7 8)) '(1 2 3 4))
        (list "Caso 4.2" (toma-mientras (lambda (x) #t) '(6 7 8)) '(6 7 8))
        (list "Caso 4.3" (toma-mientras (lambda (x) (not (equal? x 'shift))) '(token1 token2 shift token3)) '(token1 token2))
        (list "Caso 4.4" (toma-mientras (lambda (x) #t) '()) '())))

;Casos de prueba
;(check-equal? (toma-mientras (lambda (x) (< x 5)) '(1 2 3 4 5 6 7 8)) '(1 2 3 4) "Caso 4.1 Incorrecto")
;(check-equal? (toma-mientras (lambda (x) #t) '(6 7 8)) '(6 7 8) "Caso 4.2 Incorrecto")
;(check-equal? (toma-mientras (lambda (x) (not (equal? x 'shift))) '(token1 token2 shift token3)) '(token1 token2) "Caso 4.3 Incorrecto")
;(check-equal? (toma-mientras (lambda (x) #t) '()) '() "Caso 4.4 Incorrecto")




;-----
;5 (15 pts) zipeamapea
;Escribe una función que recibe como parámetro dos listas y una función, y regresa como resultado una lista plana con el resultado
;de aplicar la función a cada sublista formada resultante de "zippearlas". Ver casos de prueba para ejemplos:
;Nota: puedes asumir que las listas enviadas como parámetro tienen la misma longitud

(define (zipeamapea f li1 li2)
  (if (null? li1)
    '()
    (cons (f (list (car li1) (car li2))) (zipeamapea f (cdr li1) (cdr li2)))))

(define (practica5)
  (list (list "Caso 5.1" (zipeamapea (lambda (li) (+ (car li) (cadr li))) '(1 2 3) '(3 2 1)) '(4 4 4))
        (list "Caso 5.2" (zipeamapea (lambda (li) (+ (car li) (cadr li))) '() '()) '())
        (list "Caso 5.3" (zipeamapea (lambda (li) #f) '(1 2 3 4 5) '(6 7 8 9 0)) '(#f #f #f #f #f))))

;Casos de prueba
;(check-equal? (zipeamapea (lambda (li) (+ (car li) (cadr li))) '(1 2 3) '(3 2 1)) '(4 4 4) "Caso 5.1 Incorrecto")
;(check-equal? (zipeamapea (lambda (li) (+ (car li) (cadr li))) '() '()) '() "Caso 5.2 Incorrecto")
;(check-equal? (zipeamapea (lambda (li) #f) '(1 2 3 4 5 ) '(6 7 8 9 0)) '(#f #f #f #f #f) "Caso 5.3 Incorrecto")




;-----
;6 (20 pts) gana-diagonal
;Escribe una función que recibe una lista de listas representando un tablero de gato (tic-tac-toe) y regresa un booleano
;que determina si ganó o no de forma diagonal.
;Nota: puedes asumir que el tablero siempre es de 3x3

(define (g-1 li)
  (equal? li '(x o o)))

(define (g-2 li)
  (equal? li '(o x o)))

(define (g-3 li)
  (equal? li '(o o x)))

(define (gana-diagonal li)
  (cond [(not (g-2 (car (cdr li)))) #f]
        [(g-1 (car li)) (g-3 (car (cdr (cdr li))))]
        [(g-3 (car li)) (g-1 (car (cdr (cdr li))))]
        [else #f]))

(define (practica6)
  (list (list "Caso 6.1" (gana-diagonal '((x o o) (o x o) (o o x))) #t)
        (list "Caso 6.2" (gana-diagonal '((x o o) (o x o) (o x o))) #f)
        (list "Caso 6.3" (gana-diagonal '((o o x) (o x o) (x o o))) #t)))

;Casos de prueba
;(check-eq? (gana-diagonal '((x o o) (o x o) (o o x))) #t "Caso 6.1 Incorrecto")
;(check-eq? (gana-diagonal '((x o o) (o x o) (o x o))) #f "Caso 6.2 Incorrecto")
;(check-eq? (gana-diagonal '((o o x) (o x o) (x o o))) #t "Caso 6.3 Incorrecto")
