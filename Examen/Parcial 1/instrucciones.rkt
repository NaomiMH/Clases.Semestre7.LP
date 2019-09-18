#lang racket

(require rackunit)

;Teoría (20 pts)

;1 Familia de analizadores sintácticos que utilizan una estrategia bottom-up, shift-reduce, apoyado en un stack para ir generalizando las producciones (subárboles) hasta llegar a la raíz




;2 Describe cada uno de los cuatro estratos de la jerarquía de Chomsky




;3 Elimina la recursividad terminal de la siguiente gramática. Las mayúsculas son no-terminales, las minúsculas son terminales. 
; A -> Ab | c | D
; D -> e | f



;4 Diseña una expresión regular que acepte la notación de números complejos en Racket. Ejemplos: 3+0i, 3-8i, 3, -5i, -i, 0




;5 Menciona 3 validaciones pertinentes a la fase de análisis semántico




;-------------------------

;Práctica (80 pts)


;1 (10 pts) tiene-ceros? (funciones auxiliares: remainder, quotient)
;Escribe una función que recibe un número entero positivo y regresa un booleano que determine si tiene o no ceros


;Casos de prueba
;(check-eq? (tiene-ceros? 1111) #f "Caso 1.1 Incorrecto")
;(check-eq? (tiene-ceros? 1234033) #t "Caso 1.2 Incorrecto")




;-----
;2 (15 pts) sumatoria1/i (recursividad terminal)
;Escribe una función que recibe un número entero positivo y regresa la sumatoria 1 + (1 / 2) + (1 / 3)...(1 / n)
;Si recibe 0 o negativo, regresa falso. Utiliza la técnica de recursividad terminal para que el intérprete pueda optimizarla.

        
;Casos de prueba
;(check-eqv? (sumatoria1/i-term 4) (+ 1 (/ 1 2) (/ 1 3) (/ 1 4)) "Caso 2.1 Incorrecto")
;(check-eqv? (sumatoria1/i-term 0) #f "Caso 2.2 Incorrecto")
;(check-eqv? (sumatoria1/i-term 1) 1 "Caso 2.3 Incorrecto")




;-----
;3 (10 pts) teje-lista
;Escribe una función que recibe dos listas como parámetro y regresa una sola lista con los elementos entrelazados de las dos enviadas.
;Esto es l1 es (1 1 1) y l2 es (2 2 2), entonces el resultado es (1 2 1 2 1 2).
;NOTA: las listas pueden ser de distintos tamaños


;Casos de prueba
;(check-equal? (teje-lista '(1 1 1) '(2 2 2)) '(1 2 1 2 1 2) "Caso 3.1 Incorrecto")
;(check-equal? (teje-lista '() '(2 2 2)) '(2 2 2) "Caso 3.2 Incorrecto")
;(check-equal? (teje-lista '(1 1 1) '()) '(1 1 1) "Caso 3.3 Incorrecto")
;(check-equal? (teje-lista '(1 1) '(2 2 2 2 2)) '(1 2 1 2 2 2 2) "Caso 3.4 Incorrecto")




;-----
;4 (10 pts) toma-mientras
;Escribe una función que recibe como parámetro un predicado y una lista. Toma elementos hasta que se encuentre con el primero que no
;cumple con la condición del predicado


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


;Casos de prueba
;(check-equal? (zipeamapea (lambda (li) (+ (car li) (cadr li))) '(1 2 3) '(3 2 1)) '(4 4 4) "Caso 5.1 Incorrecto")
;(check-equal? (zipeamapea (lambda (li) (+ (car li) (cadr li))) '() '()) '() "Caso 5.2 Incorrecto")
;(check-equal? (zipeamapea (lambda (li) #f) '(1 2 3 4 5 ) '(6 7 8 9 0)) '(#f #f #f #f #f) "Caso 5.3 Incorrecto")




;-----
;6 (20 pts) gana-diagonal
;Escribe una función que recibe una lista de listas representando un tablero de gato (tic-tac-toe) y regresa un booleano
;que determina si ganó o no de forma diagonal.
;Nota: puedes asumir que el tablero siempre es de 3x3


;Casos de prueba
;(check-eq? (gana-diagonal '((x o o) (o x o) (o o x))) #t "Caso 6.1 Incorrecto")
;(check-eq? (gana-diagonal '((x o o) (o x o) (o x o))) #f "Caso 6.2 Incorrecto")
;(check-eq? (gana-diagonal '((o o x) (o x o) (x o o))) #t "Caso 6.3 Incorrecto")
