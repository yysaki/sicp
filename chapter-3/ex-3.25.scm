(use srfi-27)

(use slib)
(require 'trace)

(define false #f)

(define (make-table)
  (list false))

(define (assoc key records)
  (cond ((null? records) false)
        ((equal? key (caar records)) (car records))
        (else (assoc key (cdr records)))))

(define (lookup keys table)
  (if (null? keys)
    (car table)
    (let ((record (assoc (car keys) (cdr table))))
      (if record
        (lookup (cdr keys) (cdr record))
        false))))

(define (insert! keys value table)
  (if (null? keys)
    (set-car! table value)
    (let ((record (assoc (car keys) (cdr table))))
      (if record
        (insert! (cdr keys) value (cdr record))
        (let ((new-table (make-table)))
          (set-cdr! table
                    (list (cons (car keys) new-table) (cdr table)))
          (insert! (cdr keys) value new-table)))))
  'ok)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


; (trace insert! lookup assoc)

(define t (make-table))
(insert! '(a) 'x t)
(insert! '(a b c) 'z t)
(print (lookup '(a) t))      ;==> x
(print (lookup '(a b) t))    ;==> #f
(print (lookup '(a b c) t))  ;==> z
