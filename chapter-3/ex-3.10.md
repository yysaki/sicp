```
(define (make-withdraw initial-amount)
  (let ((balance initial-amount))
    (lambda (amount)
      (if (>= balance amount)
          (begin (set! balance (- balance amount))
                 balance)
          "Insufficient funds"))))

(define W1 (make-withdraw 100))

(W1 50)

(define W2 (make-withdraw 100))

```

```

+--------------------------------------+
|                                      |
| make-withdraw:------------------------------+
| W1:-------------------------+        |      |
| W2:------------+            |        | <-------+
|                |            |        |      v  |
|                |            |        |     @_@-+
|                |            |        |     |
|                |            |        |     v
|                |            |        |   parameters: n
|                |            |        |   body: (let ((balance initial-amount))
|                |            |        |           (lambda (amount)
|                |            |        |             (if (>= balance amount)
|                |            |        |                 (begin (set! balance (- balance amount))
|                |            |        |                        balance)
|                |            |        |                 "Insufficient funds"))))
|                |            |        |
|                |            |        |<-----------+
|                |            |        |            |
|                |            |        |            |
|                |            |        |         +---------------------+
|                |            |        |    E1-> | initial-amount: 100 |
|                |            |        |         +---------------------+
|                |            |        |            ^
|                |            |        |            |
|                |            |        |         +------------+
|                |            +-----------+ E2-> | balance:50 |
|                |                     |  |      +------------+
|                |                     |  |         ^
|                |                     |  |         |
|                |                     | @_@--------+
|                |                     | |
|                |                     | v
|                |                     | (lambda (amount)
|                |                     |   (if (>= balance amount)
|                |                     |       (begin (set! balance (- balance amount))
|                |                     |              balance)
|                |                     |       "Insufficient funds"))))
|                |                     |
|                |                     |<-----------+
|                |                     |            |
|                |                     |            |
|                |                     |         +---------------------+
|                |                     |    E3-> | initial-amount: 100 |
|                |                     |         +---------------------+
|                |                     |            ^
|                |                     |            |
|                |                     |         +-------------+
|                +------------------------+ E4-> | balance:100 |
|                                      |  |      +-------------+
|                                      |  |         ^
|                                      |  |         |
|                                      | @_@--------+
|                                      | |
|                                      | v
|                                      | (lambda (amount)
|                                      |   (if (>= balance amount)
|                                      |       (begin (set! balance (- balance amount))
|                                      |              balance)
|                                      |       "Insufficient funds"))))
+--------------------------------------+

```

> 二つの版で環境構造はどう違うか.

make-withdraw手続きはまずinitial-amountを束縛し、大域環境へのポインタを持つフレーム(E1, E3)を作り出す。
このフレームへのポインタを持つ、amountを束縛し、フレーム(E2, E4)を作りだす。
W1, W2は後者のフレームへのポインタを持つ。
本文の版と異なり、問の版では大域環境へのポインタまでにinitial-amountを束縛するフレームがはさまれる点が異なる。
