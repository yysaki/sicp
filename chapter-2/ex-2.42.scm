(define nil '())

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (flatmap proc seq)
  (accumulate append nil (map proc seq)))

(define (enumerate-interval low high)
  (if (> low high)
      nil
      (cons low (enumerate-interval (+ low 1) high))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define empty-board '())

(define (exists-to-up y ls)
  (if (null? ls) #f
    (if (= (+ y 1) (car ls)) #t
      (exists-to-up (+ y 1) (cdr ls)))))

(define (exists-to-down y ls)
  (if (null? ls) #f
    (if (= (- y 1) (car ls)) #t
      (exists-to-down (- y 1) (cdr ls)))))

(define (exists-to-right y ls)
  (not (null? (filter (lambda (position) (= y position)) ls))))

(define (safe? k positions)
  (let ((y (car positions)) (rest (cdr positions)))
    (and
      (not (exists-to-up y rest))
      (not (exists-to-down y rest))
      (not (exists-to-right y rest)))))

(define (adjoin-position new-row k rest-of-queens)
  (cons new-row rest-of-queens))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
        (list empty-board)
        (filter
         (lambda (positions) (safe? k positions))
         (flatmap
          (lambda (rest-of-queens)
            (map (lambda (new-row)
                   (adjoin-position new-row k rest-of-queens))
                 (enumerate-interval 1 board-size)))
          (queen-cols (- k 1))))))
  (queen-cols board-size))

(print (queens 8))
