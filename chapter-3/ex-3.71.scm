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
  (define (cube x) (* x x x))
  (+ (cube (car pair))
     (cube (cadr pair))))

(define (print-stream s)
  (if (not (null? (stream-cdr s)))
    (let ((pair (stream-car s)))
      (print "weight=" (weight pair) ", i=" (car pair) ", j=" (cadr pair))
      (print-stream (stream-cdr s)))))


(print-stream
 (stream-take (weighted-pairs integers integers weight) 1000))

; weight=4104, i=9, j=15
; weight=4104, i=2, j=16

; weight=13832, i=18, j=20
; weight=13832, i=2, j=24

; weight=20683, i=19, j=24
; weight=20683, i=10, j=27

; weight=32832, i=18, j=30
; weight=32832, i=4, j=32

; weight=39312, i=15, j=33
; weight=39312, i=2, j=34

