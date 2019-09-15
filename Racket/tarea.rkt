;quicksort
(define (qsort li)
  (if (null? li) '()
      (append
       (qsort (filter (lambda (x) (< x (car li))) li))
       (list (car li))
       (qsort (filter (lambda (x) (> x (car li))) li)))))

;gcd
(define (gcd n m)
  (cond [(= n 0) m]
        [(= m 0) n]
        [(= n m) m]
        [(> n m) (gcd (- n m) m)]
        [else (gcd n (- m n))]))

;co-primo
(define (co-primo n m)
  (if (= (gcd n m) 1)
    (display "Son co-primos\n")
    (display "No son co-primos\n")))

;promedio
(define (sum li)
  (cond [(null? li) 0]
        [else (+ (car li) (sum (cdr li)))]))

(define (count li)
  (cond [(null? li) 0]
        [else (+ 1 (count (cdr li)))]))

(define (promedio li)
  (/ (sum li) (count li)))

;moda
(define (countn li n)
  (cond [(null? li) 0]
        [(= (car li) n) (+ 1 (countn (cdr li) n))]
        [else (countn (cdr li) n)]))

(define (ckmoda li li2 n m)
  (cond [(null? li) n]
        [else (let ([ckcar (countn li2 (car li))])
              (if (> ckcar m)
                (ckmoda (cdr li) li2 (car li) ckcar)
                (ckmoda (cdr li) li2 n m))])))

(define (moda li)
  (cond [(null? li) '()]
        [else (ckmoda (qsort li) li -1 -1)]))

;mediana
(define (posnmed li n)
  (cond [(null? li) -1]
        [(= n 1) (list (car li) (posnmed (cdr li) 0))]
        [(= n 0.5) (car li)]
        [(= n 0) (car li)]
        [else (posnmed (cdr li) (- n 1))]))

(define (mediana li)
  (cond [(null? li) -1]
        [else (posnmed li (/ (count li) 2))]))

;rango
(define (rango n m)
  (cond [(= n m) (list m)]
        [else (append (list n) (rango (+ 1 n) m))]))

;countatoms
(define (counta li)
  (cond [(null? li) 0]
        [(list? (car li)) (+ (counta (car li)) (counta (cdr li)))]
        [else (+ 1 (counta (cdr li)))]))

;toma
(define (toma li n)
  (cond [(null? li) '()]
        [(= n 0) '()]
        [else (append (list (car li)) (toma (cdr li) (- n 1)))]))

;deja
(define (deja li n)
  (cond [(null? li) '()]
        [(= n 1) (cdr li)]
        [else (deja (cdr li) (- n 1))]))

;split
(define (split li n)
  (cond [(null? li) '()]
        [(= n 0) (list '() li)]
        [else (list (toma li (- n 1)) (deja li n))]))
