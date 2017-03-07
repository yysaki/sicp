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

(define (make-joint acc secret-password joint-password)
  (define (dispatch pwd m)
    (if (eq? joint-password pwd)
      (acc secret-password m)
      (lambda (_) "Incorrect password")))
  dispatch)

(define peter-acc (make-account 100 'open-sesame))
(define paul-acc
  (make-joint peter-acc 'open-sesame 'rosebud))

(print ((peter-acc 'open-sesame 'withdraw) 0)) ; 100
(print ((paul-acc 'rosebud 'withdraw) 50))     ; 50
(print ((peter-acc 'open-sesame 'withdraw) 0)) ; 50
(print ((paul-acc 'rosebud 'deposit) 100))     ; 150
(print ((peter-acc 'open-sesame 'withdraw) 0)) ; 150
