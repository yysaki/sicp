(load "./3.5")

(define (sqrt-stream x)
  (cons-stream 1.0
               (stream-map (lambda (guess)
                             (sqrt-improve guess x))
                           (sqrt-stream x))))

; Louis の方式では都度ストリームを生成するため、memo化の恩恵を受けず非効率.
