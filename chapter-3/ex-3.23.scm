(define (front-ptr queue) (car queue))
(define (rear-ptr queue) (cdr queue))

(define (set-front-ptr! queue item) (set-car! queue item))
(define (set-rear-ptr! queue item) (set-cdr! queue item))

(define (empty-queue? queue) (null? (front-ptr queue)))
(define (make-queue) (cons '() '()))

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

(define (front-queue queue)
  (if (empty-queue? queue)
    (error "FRONT called with an empty queue" queue)
    (car (item-value (front-ptr queue)))))

(define (front-insert-queue! queue value)
  (let ((new-item (make-item value)))
    (cond ((empty-queue? queue)
           (set-front-ptr! queue new-item)
           (set-rear-ptr! queue new-item)
           queue)
          (else
            (set-prev-item! new-item (front-ptr queue))
            (set-next-item! new-item (front-ptr queue))
            (set-front-ptr! queue new-item)
            queue))))

(define (rear-insert-queue! queue value)
  (let ((new-item (make-item value)))
    (cond ((empty-queue? queue)
           (set-front-ptr! queue new-item)
           (set-rear-ptr! queue new-item)
           queue)
          (else
            (set-prev-item! new-item (rear-ptr queue))
            (set-next-item! (rear-ptr queue) new-item)
            (set-rear-ptr! queue new-item)
            queue))))

(define (front-delete-queue! queue)
  (cond ((empty-queue? queue)
         (error "DELETE! called with an empty queue" queue))
        (else
          (set-front-ptr! queue (next-item (front-ptr queue)))
          queue)))

(define (rear-delete-queue! queue)
  (cond ((empty-queue? queue)
         (error "DELETE! called with an empty queue" queue))
        (else
          (set-rear-ptr! queue (prev-item (rear-ptr queue)))
          queue)))

(define (print-queue queue)
  (define (iter item)
    (if (eq? item (rear-ptr queue))
      (display (item-value item))
      (begin
        (display (item-value item))
        (display " ")
        (iter (next-item item)))))
  (if (empty-queue? queue)
    (print "()")
    (begin
      (display "(")
      (iter (front-ptr queue))
      (display ")")
      (newline))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define q1 (make-queue))

(front-insert-queue! q1 'b)
(front-insert-queue! q1 'a)

(rear-insert-queue! q1 'c)
(front-insert-queue! q1 'd)

(rear-delete-queue! q1)
(front-delete-queue! q1)

(print q1)
(print-queue q1)
