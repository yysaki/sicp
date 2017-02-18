(define (pascal-triangle n i)
  (cond ((= i 1) 1)
        ((= i n) 1)
        (else (+ (pascal-triangle (- n 1) (- i 1))
                 (pascal-triangle (- n 1) i)))))

(define (sum-of-pascal-triangle-row n col)
  (if (> col n) 0
    (+ (pascal-triangle n col)
       (sum-of-pascal-triangle-row n (+ col 1)))))

(print (sum-of-pascal-triangle-row 1 1))
(print (sum-of-pascal-triangle-row 2 1))
(print (sum-of-pascal-triangle-row 3 1))
(print (sum-of-pascal-triangle-row 4 1))
(print (sum-of-pascal-triangle-row 5 1))
(print (sum-of-pascal-triangle-row 6 1))
(print (sum-of-pascal-triangle-row 7 1))
(print (sum-of-pascal-triangle-row 8 1))
