(define (make-monitored f)
  (let ((count 0))
    (lambda (first . rest)
      (cond ((eq? first 'reset-count) (set! count 0))
            ((eq? first 'how-many-calls?) count)
            (else (set! count (+ count 1))
                  (apply f (cons first rest)))))))

(define s (make-monitored sqrt))

(print (s 100))
; 10

(print (s 'how-many-calls?))
; 1
