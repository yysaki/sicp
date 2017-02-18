(define (union-set set1 set2)
  (list->tree
    (union-list
      (tree->list-2 set1)
      (tree->list-2 set2))))

(define (intersection-set set1 set2)
  (list->tree
    (intersection-list
      (tree->list-2 set1)
      (tree->list-2 set2))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (intersection-list ls1 ls2)
  (if (or (null? ls1) (null? ls2))
      '()
      (let ((x1 (car ls1)) (x2 (car ls2)))
        (cond ((= x1 x2)
               (cons x1
                     (intersection-list (cdr ls1)
                                       (cdr ls2))))
              ((< x1 x2)
               (intersection-list (cdr ls1) ls2))
              ((< x2 x1)
               (intersection-list ls1 (cdr ls2)))))))

(define (union-list ls1 ls2)
  (cond ((null? ls1) ls2)
        ((null? ls2) ls1)
        (else
          (let ((x1 (car ls1)) (x2 (car ls2)))
            (cond ((= x1 x2) (cons x1 (union-list (cdr ls1) (cdr ls2))))
                  ((< x1 x2) (cons x1 (union-list (cdr ls1) ls2)))
                  (else (cons x2 (union-list ls1 (cdr ls2)))))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define true #t)
(define false #f)

(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
  (list entry left right))

(define (tree->list-2 tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list (right-branch tree)
                                          result-list)))))
  (copy-to-list tree '()))

(define (list->tree elements)
  (car (partial-tree elements (length elements))))

(define (partial-tree elts n)
  (if (= n 0)
      (cons '() elts)
      (let ((left-size (quotient (- n 1) 2)))
        (let ((left-result (partial-tree elts left-size)))
          (let ((left-tree (car left-result))
                (non-left-elts (cdr left-result))
                (right-size (- n (+ left-size 1))))
            (let ((this-entry (car non-left-elts))
                  (right-result (partial-tree (cdr non-left-elts)
                                              right-size)))
              (let ((right-tree (car right-result))
                    (remaining-elts (cdr right-result)))
                (cons (make-tree this-entry left-tree right-tree)
                      remaining-elts))))))))
