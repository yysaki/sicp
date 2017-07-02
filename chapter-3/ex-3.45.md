```
(define (make-account-and-serializer balance)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (let ((balance-serializer (make-serializer)))
    (define (dispatch m)
      (cond ((eq? m 'withdraw) (balance-serializer withdraw))
            ((eq? m 'deposit) (balance-serializer deposit))
            ((eq? m 'balance) balance)
            ((eq? m 'serializer) balance-serializer)
            (else (error "Unknown request -- MAKE-ACCOUNT"
                         m))))
    dispatch))

(define (exchange account1 account2)
  (let ((difference (- (account1 'balance)
                       (account2 'balance))))
    ((account1 'withdraw) difference)
    ((account2 'deposit) difference)))

(define (serialized-exchange account1 account2)
  (let ((serializer1 (account1 'serializer))
        (serializer2 (account2 'serializer)))
    ((serializer1 (serializer2 exchange))
     account1
     account2)))
```

> Louisの考えで何が悪いか説明せよ. 特にserialized-exchangeを呼び出した時, 何が起きるか考えよ.


serialized-exchangeを呼び出すとデッドロックが発生し永遠に手続きが終わらなくなる.

serialized-exchangeではexchange手続きが直列化される.
一方exchange中のwithdrawも直列化されており、直列化されたwithdrawはexchangeが終わるまで完了するまで待たされる.
exchangeもwithdrawが終わるまで終わらないため手続きが終わらなくなってしまう.

