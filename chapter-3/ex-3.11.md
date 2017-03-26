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
  (define (dispatch m)
    (cond ((eq? m 'withdraw) withdraw)
          ((eq? m 'deposit) deposit)
          (else (error "Unknown request -- MAKE-ACCOUNT"
                       m))))
  dispatch)
```

```
(define acc (make-account 50))

大域環境
+---------------------------------------------------+
|                                                   |
| make-account:--+                                  |
| acc:-----------|-------------------+              |
|                |                   |              |
|                |                   |              |
+----------------|-------------------|--------------+
                 |  ^                |          ^
                 |  |                |    E1    |
                @_@-+                |    +----------------+
                |                    |    | balance: 50    |
       parameters: balance           |    | withdraw:...   |
       body: (define withdraw ...)   |    | deposit:...    |
             (define deposit ...)    |    | dispatch:-+    |
             (define dispatch ...)   |    +-----------|----+
             dispatch                |                |  ^
                                     |             +-@_@-+
                                     |             |  ^
                                     |             |  |
                                     +-------------|---
                                                   |
                                                   v
                                           parameters: m
                                           body: ...
```

```
((acc 'deposit) 40)
90

大域環境
+---------------------------------------------------+
|                                                   |
| make-account:--+                                  |
| acc:-----------|-------------------+              |
|                |                   |              |
|                |                   |              |
+----------------|-------------------|--------------+
                 |  ^                |          ^
                 |  |                |    E1    |               E2
                @_@-+                |    +----------------+    +----------------+
                |                    |    | balance: 50    |<---| m: 'deposit    |
       parameters: balance           |    | withdraw:...   |    +----------------+
       body: (define withdraw ...)   |    | deposit:...    |      dispatch呼び出し
             (define deposit ...)    |    | dispatch:...   |<-+
             (define dispatch ...)   |    +-----------|----+  | +----------------+
             dispatch                |                |  ^    +-| amount: 40     |
                                     |             +-@_@-+      +----------------+
                                     |             |  ^           deposit呼び出し
                                     |             |  |
                                     +-------------|---
                                                   |
                                                   v
                                           parameters: m
                                           body: ...

```

```
((acc 'withdraw) 60)
30

大域環境
+---------------------------------------------------+
|                                                   |
| make-account:--+                                  |
| acc:-----------|-------------------+              |
|                |                   |              |
|                |                   |              |
+----------------|-------------------|--------------+
                 |  ^                |          ^
                 |  |                |    E1    |               E2
                @_@-+                |    +----------------+    +----------------+
                |                    |    | balance: 90    |<---| m: 'widhdraw   |
       parameters: balance           |    | withdraw:...   |    +----------------+
       body: (define withdraw ...)   |    | deposit:...    |      dispatch呼び出し
             (define deposit ...)    |    | dispatch:...   |<-+ E3
             (define dispatch ...)   |    +-----------|----+  | +----------------+
             dispatch                |                |  ^    +-| amount: 60     |
                                     |             +-@_@-+      +----------------+
                                     |             |  ^           widhdraw呼び出し
                                     |             |  |
                                     +-------------|---
                                                   |
                                                   v
                                           parameters: m
                                           body: ...

```

```
(define acc2 (make-account 100))

大域環境
+---------------------------------------------------------------------------+
|                                                                           |
| make-account:--+                                                          |
| acc:-----------|-------------------+                                      |
| acc2: -----------------------------------------------------+              |
|                |                   |                       |              |
+----------------|-------------------|--------------------------------------+
                 |  ^                |          ^            |          ^
                 |  |                |    E1    |            |    E2    |
                @_@-+                |    +----------------+ |    +----------------+
                |                    |    | balance: 30    | |    | balance: 100   |
       parameters: balance           |    | withdraw:...   | |    | withdraw:...   |
       body: (define withdraw ...)   |    | deposit:...    | |    | deposit:...    |
             (define deposit ...)    |    | dispatch:...   | |    | dispatch:...   |
             (define dispatch ...)   |    +-----------|----+ |    +-----------|----+
             dispatch                |                |  ^   |                |  ^
                                     |             +-@_@-+   |             +-@_@-+
                                     |             |  ^      |             |  ^
                                     |             |  |      |             |  |
                                     +-------------|---      +-------------|---
                                                   |                       |
                                                   v                       v
                                           parameters: m           parameters: m
                                           body: ...               body: ...

```

