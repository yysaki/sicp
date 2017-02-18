(load "./ex-2.48")

(define (frame-coord-map frame)
  (lambda (v)
    (add-vect
     (origin-frame frame)
     (add-vect (scale-vect (xcor-vect v)
                           (edge1-frame frame))
               (scale-vect (ycor-vect v)
                           (edge2-frame frame))))))

(define (segments->painter segment-list)
  (lambda (frame)
    (for-each
     (lambda (segment)
       (draw-line
        ((frame-coord-map frame) (start-segment segment))
        ((frame-coord-map frame) (end-segment segment))))
     segment-list)))

(define a
  (segments->painter
    (list (make-segment (make-vect 0 0) (make-vect 0 1))
          (make-segment (make-vect 0 1) (make-vect 1 1))
          (make-segment (make-vect 1 1) (make-vect 1 0))
          (make-segment (make-vect 1 0) (make-vect 0 0)))))

(define b
  (segments->painter
    (list (make-segment (make-vect 0 0) (make-vect 1 1))
          (make-segment (make-vect 0 1) (make-vect 1 0)))))

(define c
  (segments->painter
    (list (make-segment (make-vect   0  0.5) (make-vect 0.5   1))
          (make-segment (make-vect 0.5    1) (make-vect   1 0.5))
          (make-segment (make-vect   1  0.5) (make-vect 0.5   0))
          (make-segment (make-vect 0.5    0) (make-vect   0 0.5)))))

(define wave
  (segments->painter
    (list (make-segment (make-vect 0.2 0.0) (make-vect 0.4 0.4))
          (make-segment (make-vect 0.4 0.4) (make-vect 0.3 0.5))
          (make-segment (make-vect 0.3 0.5) (make-vect 0.1 0.3))
          (make-segment (make-vect 0.1 0.3) (make-vect 0.0 0.6))
          (make-segment (make-vect 0.0 0.8) (make-vect 0.1 0.5))
          (make-segment (make-vect 0.1 0.5) (make-vect 0.3 0.6))
          (make-segment (make-vect 0.3 0.6) (make-vect 0.4 0.6))
          (make-segment (make-vect 0.4 0.6) (make-vect 0.3 0.8))
          (make-segment (make-vect 0.3 0.8) (make-vect 0.4 1.0))
          (make-segment (make-vect 0.6 1.0) (make-vect 0.7 0.8))
          (make-segment (make-vect 0.7 0.8) (make-vect 0.6 0.6))
          (make-segment (make-vect 0.6 0.6) (make-vect 0.8 0.6))
          (make-segment (make-vect 0.8 0.6) (make-vect 1.0 0.4))
          (make-segment (make-vect 1.0 0.2) (make-vect 0.6 0.4))
          (make-segment (make-vect 0.6 0.4) (make-vect 0.8 0.0))
          (make-segment (make-vect 0.7 0.0) (make-vect 0.5 0.3))
          (make-segment (make-vect 0.5 0.3) (make-vect 0.3 0.0)))))
