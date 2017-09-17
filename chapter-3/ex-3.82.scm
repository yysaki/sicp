(load "./3.5")
(use srfi-27)

(define (random-in-range low high)
  (let ((range (- high low)))
    (+ low (* range (random-real)))))

(define (random-stream-in-range low high)
  (stream-map (lambda (_) (random-in-range low high)) integers))

(define (monte-carlo experiment-stream passed failed)
  (define (next passed failed)
    (cons-stream
      (/ passed (+ passed failed))
      (monte-carlo
        (stream-cdr experiment-stream) passed failed)))
  (if (stream-car experiment-stream)
    (next (+ passed 1) failed)
    (next passed (+ failed 1))))

(define (estimate-integral P x1 x2 y1 y2)
  (let ((area (* 1.0 (* (- x1 x2) (- y1 y2)))))
    (scale-stream
      (monte-carlo
        (stream-map P
                    (random-stream-in-range x1 x2)
                    (random-stream-in-range y1 y2))
        0
        0)
      area
      )))

(define (circle? x y)
  (<=
    (+ (square (- x 5)) (square (- y 7)))
    (square 3)))

(define (unit-circle? x y)
  (<= (+ (square x) (square y)) 1))

(print (stream-ref (estimate-integral circle? 2 8 4 10) 1000))
(print (stream-ref (estimate-integral unit-circle? -1 1 -1 1) 1000))
