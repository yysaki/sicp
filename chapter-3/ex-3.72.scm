(load "./3.5")

(define (merge-weighted s1 s2 weight)
  (cond ((stream-null? s1) s2)
        ((stream-null? s2) s1)
        (else
          (let ((s1car (stream-car s1))
                (s2car (stream-car s2)))
            (if (< (weight s1car) (weight s2car))
              (cons-stream s1car (merge-weighted (stream-cdr s1) s2 weight))
              (cons-stream s2car (merge-weighted s1 (stream-cdr s2) weight)))))))

(define (weighted-pairs s t weight)
  (cons-stream
    (list (stream-car s) (stream-car t))
    (merge-weighted
      (stream-map (lambda (x) (list (stream-car s) x))
                  (stream-cdr t))
      (weighted-pairs (stream-cdr s) (stream-cdr t) weight)
      weight)))

(define (weight pair)
  (define (square x) (* x x))
  (+ (square (car pair))
     (square (cadr pair))))

(define (three-count-stream s)
  (let ((s0 (stream-car s))
        (s1 (stream-car (stream-cdr s)))
        (s2 (stream-car (stream-cdr (stream-cdr s)))))
    (if (= (weight s0) (weight s1) (weight s2))
      (cons-stream (list (weight s0) s0 s1 s2)
                   (three-count-stream (stream-cdr (stream-cdr (stream-cdr s)))))
      (three-count-stream (stream-cdr s)))))

(display-stream-10 (three-count-stream (weighted-pairs integers integers weight)))

