(load "./ex-2.44")
(load "./ex-2.51")

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
          (make-segment (make-vect 0.5 0.3) (make-vect 0.3 0.0))
          (make-segment (make-vect 0.40 0.90) (make-vect 0.45 0.90))
          (make-segment (make-vect 0.55 0.90) (make-vect 0.60 0.90))
          (make-segment (make-vect 0.45 0.80) (make-vect 0.50 0.75))
          (make-segment (make-vect 0.50 0.75) (make-vect 0.55 0.80)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (corner-split painter n)
 (if (= n 0)
   painter
   (let ((top-left (up-split painter (- n 1)))
         (bottom-right (right-split painter (- n 1)))
         (corner (corner-split painter (- n 1))))
     (beside (below painter top-left)
             (below bottom-right corner)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (square-of-four tl tr bl br)
  (lambda (painter)
    (let ((top (beside (tl painter) (tr painter)))
          (bottom (beside (bl painter) (br painter))))
      (below bottom top))))

(define (square-limit painter n)
  (let ((combine4 (square-of-four flip-horiz identity
                                  rotate180 flip-vert)))
    (combine4 (corner-split painter n))))
