(load "./3.5")

(define (stream-map proc . argstreams)
  (if (stream-null? (car argstreams))
      the-empty-stream
      (cons-stream
       (apply proc (map stream-car argstreams))
       (apply stream-map
              (cons proc (map stream-cdr argstreams))))))

(display-stream
    (stream-map
      list
      (stream-enumerate-interval 1 10)
      (stream-map (lambda (x) (* x 3)) (stream-enumerate-interval 1 10))
      (stream-enumerate-interval 3 12)))

#?=
(stream-map
  list
  (stream-enumerate-interval 1 10)
  (stream-map (lambda (x) (* x 3)) (stream-enumerate-interval 1 10))
  (stream-enumerate-interval 3 12))

#?=
(stream-car
  (stream-cdr
    (stream-map
      list
      (stream-enumerate-interval 1 10)
      (stream-map (lambda (x) (* x 3)) (stream-enumerate-interval 1 10))
      (stream-enumerate-interval 3 12))))

