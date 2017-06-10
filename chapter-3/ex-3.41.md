```
 (define (make-account balance)
   (define (withdraw amount)
     (if (>= balance amount)
         (begin (set! balance (- balance amount))
                balance)
         "Insufficient funds"))
   (define (deposit amount)
     (set! balance (+ balance amount))
     balance)
   (let ((protected (make-serializer)))
     (define (dispatch m)
       (cond ((eq? m 'withdraw) (protected withdraw))
             ((eq? m 'deposit) (protected deposit))
             ((eq? m 'balance)
              ((protected (lambda () balance)))) ; 直列化した.
             (else (error "Unknown request -- MAKE-ACCOUNT"
                          m))))
     dispatch))
```

> 賛成するか. Benの心配を示すシナリオはあるだろうか. 

基本的には賛成しないが、
balanceの値が非常に大きく、読み取りがatomicでない可能性がある場合には必要かもしれない。
