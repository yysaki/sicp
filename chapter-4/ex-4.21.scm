; a

((lambda (n)
   ((lambda (fact) (fact fact n))
    (lambda (ft k)
      (if (= k 1)
        1
        (* k (ft ft (- k 1)))))))
 10)

((lambda (n)
   ((lambda (fact)
      (fact fact n))
    (lambda (ft k)
      (if (<= k 2)
        1
        (+ (ft ft (- k 1)) (ft ft (- k 2)))))))
 5)

; b

(define true #t)
(define false #f)

(define (f x)
  ((lambda (even? odd?)
     (even? even? odd? x))
   (lambda (ev? od? n)
     (if (= n 0) true (od? ev? od? (- n 1))))
   (lambda (ev? od? n)
     (if (= n 0) false (ev? ev? od? (- n 1))))))

#?=(f 3)
#?=(f 4)
#?=(f 5)
