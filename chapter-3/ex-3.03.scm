(define (make-account balance secret-password)
  (define (withdraw amount)
    (if (>= balance amount)
      (begin (set! balance (- balance amount))
             balance)
      "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (dispatch pwd m)
    (if (eq? secret-password pwd)
      (cond ((eq? m 'withdraw) withdraw)
            ((eq? m 'deposit) deposit)
            (else (error "Unknown request -- MAKE-ACCOUNT"
                         m)))
      (lambda (_) "Incorrect password")))
  dispatch)

(define acc (make-account 100 'secret-password))
(print ((acc 'secret-password 'withdraw) 40))
; 60

(print ((acc 'some-other-password 'deposit) 50))
"Incorrect password"
