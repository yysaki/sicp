(define true #t)
(define false #f)

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

(define (union-set set1 set2)
  (cond ((null? set1) set2)
        ((null? set2) set1)
        ((element-of-set? (car set1) set2) (union-set (cdr set1) set2))
        (else union-set (cdr set1) (cons (car set1) set2))))

(print (union-set '(1 2 3) '(1 3 5)))
