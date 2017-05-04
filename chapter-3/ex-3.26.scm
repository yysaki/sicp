(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))

(define (make-tree entry left right)
  (list entry left right))

(define (make-entry key value)
  (cons key value))

(define (get-key entry)
  (car entry))

(define (make-table) (cons '*table* '()))

(define (adjoin-set x set)
  (cond ((null? set) (make-tree x '() '()))
        ((= (get-key x) (get-key (entry set)))
         (make-tree x
                    (left-branch set)
                    (right-branch set)))
        ((< (get-key x) (get-key (entry set)))
         (make-tree (entry set)
                    (adjoin-set x (left-branch set))
                    (right-branch set)))
        ((> (get-key x) (get-key (entry set)))
         (make-tree (entry set)
                    (left-branch set)
                    (adjoin-set x (right-branch set))))))

(define (lookup key table)
  (define (lookup-iter set)
    (cond ((null? set) #f)
          ((= key (get-key (entry set))) (entry set))
          ((< key (get-key (entry set)))
           (lookup-iter (left-branch set)))
          ((> key (get-key (entry set)))
           (lookup-iter (right-branch set)))))
  (lookup-iter (cdr table)))

(define (insert! key value table)
  (let ((record (lookup key table)))
    (if record
      (set-cdr! record value)
      (set-cdr! table (adjoin-set (cons key value) (cdr table))))))

(define t (make-table))
(insert! 1 'a t)
(insert! 2 'b t)
(insert! 3 'c t)
(insert! 1 'a t)
(insert! 5 'z t)

#?=(lookup 1 t)
#?=(lookup 2 t)
#?=(lookup 3 t)
#?=(lookup 4 t)
#?=(lookup 5 t)
