(define (call-the-cops) "Called cops!")

(define (make-account balance secret-password)
  (let ((wrong-count 0))
    (define (withdraw amount)
      (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))
    (define (deposit amount)
      (set! balance (+ balance amount))
      balance)
    (define (dispatch pwd m)
      (let ((is-correct (eq? secret-password pwd)))
        (set! wrong-count (if is-correct 0 (+ wrong-count 1)))
        (if is-correct
          (cond ((eq? m 'withdraw) withdraw)
                ((eq? m 'deposit) deposit)
                (else (error "Unknown request -- MAKE-ACCOUNT"
                             m)))
          (if (< wrong-count 7)
            (lambda (_) "Incorrect password")
            (lambda (_) call-the-cops)))))
    dispatch))

(define acc (make-account 100 'secret-password))
(print ((acc 'some-other-password 'deposit) 50)) ; "Incorrect password"
(print ((acc 'secret-password 'withdraw) 40)) ; 60

(print ((acc 'some-other-password 'deposit) 50)) ; "Incorrect password"
(print ((acc 'some-other-password 'deposit) 50)) ; "Incorrect password"
(print ((acc 'some-other-password 'deposit) 50)) ; "Incorrect password"
(print ((acc 'some-other-password 'deposit) 50)) ; "Incorrect password"
(print ((acc 'some-other-password 'deposit) 50)) ; "Incorrect password"
(print ((acc 'some-other-password 'deposit) 50)) ; "Incorrect password"
(print ((acc 'some-other-password 'deposit) 50)) ; "Called cops!"
