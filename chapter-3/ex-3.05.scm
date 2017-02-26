(use srfi-27)

(use slib)
(require 'trace)

(define (random x)
  (* x (random-real)))

(define (random-in-range low high)
  (let ((range (- high low)))
    (+ low (random range))))

(define (monte-carlo trials experiment)
  (define (iter trials-remaining trials-passed)
    (cond ((= trials-remaining 0)
           (/ trials-passed trials))
          ((experiment)
           (iter (- trials-remaining 1) (+ trials-passed 1)))
          (else
           (iter (- trials-remaining 1) trials-passed))))
  (iter trials 0))

(define (estimate-integral P x1 x2 y1 y2 trials)
  (define (experiment)
    (P (random-in-range x1 x2) (random-in-range y1 y2)))
  (let ((area (* (- x1 x2) (- y1 y2))))
    (* area (monte-carlo trials experiment))))

(define (circle? x y)
  (<=
    (+ (square (- x 5)) (square (- y 7)))
    (square 3)))

; (trace circle?)

(print (estimate-integral circle? 2 8 4 10 10))
