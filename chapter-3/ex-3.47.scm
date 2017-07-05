(define false #f)
(define true #t)

(define (make-mutex)
  (let ((cell (list false)))            
    (define (the-mutex m)
      (cond ((eq? m 'acquire)
             (if (test-and-set! cell)
                 (the-mutex 'acquire))) ; retry
            ((eq? m 'release) (clear! cell)))) the-mutex))

(define (clear! cell)
  (set-car! cell false))

(define (test-and-set! cell)
  (if (car cell)
      true
      (begin (set-car! cell true)
             false)))

; a

(define (make-semaphore-a n)
  (let ((mutex (make-mutex))
        (count 0))
    (define (acquire)
      (mutex 'acquire)
      (cond ((< count n)
             (set! count (+ count 1))
             (mutex 'release))
            (else
              (mutex 'release)
              (acquire))))
    (define (release)
      (let ((is-out-of-range false))
        (mutex 'acquire)
        (if (> count 0)
          (set! count (- count 1))
          (set! is-out-of-range true))
        (mutex 'release)
        (if is-out-of-range (error "count is 0"))))
    (define (the-semaphore m)
      (cond ((eq? m 'acquire) (acquire))
            ((eq? m 'release) (release))))
    the-semaphore))

; b

(define (init-cells n)
  (if (= n 0)
    '()
    (cons (list false) (init-cells (- n 1)))))

(define (make-semaphore-b n)
  (let ((cells (init-cells n)))
    (define (the-semaphore m)
      (define (loop lst)
        (if (null? lst)
          true
          (if (test-and-set! (car lst))
            (loop (cdr lst))
            false)))
      (cond ((eq? m 'acquire)
             (if (loop cells)
               (the-semaphore 'acquire)))
            ((eq? m 'release)
             (clear! (car cells))
             (set! cells (append (cdr cells) (list (car cells)))))))
  the-semaphore))

(define sa (make-semaphore-a 3))
(sa 'acquire)
(sa 'acquire)
(sa 'acquire)
(sa 'release)
(sa 'acquire)

(define sb (make-semaphore-b 3))
(sb 'acquire)
(sb 'acquire)
(sb 'acquire)
(sb 'release)
(sb 'acquire)
