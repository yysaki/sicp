(define (front-ptr deque) (car deque))
(define (rear-ptr deque) (cdr deque))

(define (set-front-ptr! deque item) (set-car! deque item))
(define (set-rear-ptr! deque item) (set-cdr! deque item))

(define (empty-deque? deque) (null? (front-ptr deque)))
(define (make-deque) (cons '() '()))

(define (make-item value)
  (cons value (cons '() '())))

(define (set-next-item! item next)
  (set-cdr! (cdr item) next))

(define (set-prev-item! item prev)
  (set-car! (cdr item) prev))

(define (item-value item)
  (car item))

(define (prev-item item)
  (cadr item))

(define (next-item item)
  (cddr item))

(define (front-deque deque)
  (if (empty-deque? deque)
    (error "FRONT called with an empty deque" deque)
    (car (item-value (front-ptr deque)))))

(define (front-insert-deque! deque value)
  (let ((new-item (make-item value)))
    (cond ((empty-deque? deque)
           (set-front-ptr! deque new-item)
           (set-rear-ptr! deque new-item)
           deque)
          (else
            (set-prev-item! (front-ptr deque) new-item)
            (set-next-item! new-item (front-ptr deque))
            (set-front-ptr! deque new-item)
            deque))))

(define (rear-insert-deque! deque value)
  (let ((new-item (make-item value)))
    (cond ((empty-deque? deque)
           (set-front-ptr! deque new-item)
           (set-rear-ptr! deque new-item)
           deque)
          (else
            (set-prev-item! new-item (rear-ptr deque))
            (set-next-item! (rear-ptr deque) new-item)
            (set-rear-ptr! deque new-item)
            deque))))

(define (front-delete-deque! deque)
  (cond ((empty-deque? deque)
         (error "DELETE! called with an empty deque" deque))
        (else
          (set-front-ptr! deque (next-item (front-ptr deque)))
          deque)))

(define (rear-delete-deque! deque)
  (cond ((empty-deque? deque)
         (error "DELETE! called with an empty deque" deque))
        (else
          (set-rear-ptr! deque (prev-item (rear-ptr deque)))
          deque)))

(define (print-deque deque)
  (define (iter item)
    (if (eq? item (rear-ptr deque))
      (display (item-value item))
      (begin
        (display (item-value item))
        (display " ")
        (iter (next-item item)))))
  (if (empty-deque? deque)
    (print "()")
    (begin
      (display "(")
      (iter (front-ptr deque))
      (display ")")
      (newline))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define q1 (make-deque))

(front-insert-deque! q1 'b)
(front-insert-deque! q1 'a)

(rear-insert-deque! q1 'c)
(front-insert-deque! q1 'd)

(rear-delete-deque! q1)
(front-delete-deque! q1)

(print q1)
(print-deque q1)
