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
            ((eq? m 'balance) balance)
            (else (error "Unknown request -- MAKE-ACCOUNT"
                         m))))
    dispatch))

(define (exchange account1 account2)
  (let ((difference (- (account1 'balance)
                       (account2 'balance))))
    ((account1 'withdraw) difference)
    ((account2 'deposit) difference)))
```


> 三つの口座の初めの残高が10ドル, 20ドルおよび30ドルで, 口座の残高を交換しながら複数のプロセスが走るとしよう.

> プロセスが逐次的に走ったなら, 任意の回数の並列の交換の後で, 口座の残高はある順序で10ドル, 20ドルおよび30ドルであるべきことを論ぜよ.

プロセスが逐次的に走るのであれば、exchange手続きの前後でaccount1 account2 の組は値が逆転するのみで他の値になることはない。
そのため、何度交換したあとも3つの口座のbalanceはある順で10, 20, 30 となる。

> 図3.29のようなタイミング図を描き, 本節の口座交換プログラムの最初の版を使って交換を実装すると, この条件が破られ得ることを示せ.


```
 |  A                   B                   C
 |
 | 10                  20                  30
 |   \                /  \                /
 |   v                v  |                |
 |   +----------------+  |                |
 |   |difference: 10  |  |                |
 |   +----------------+  |                |
 |  /                 \  v                v
 |  |                  | +----------------+
 |  |                  | |difference: 10  |
 |  \                 /  +----------------+
 |   v                v  /                \
 |   +----------------+ |                  |
 |   |withdraw,deposit| |                  |
 |   +----------------+ |                  |
 |   /                \ |                  |
 |  v                  v\                  |
 | 20                  10|                 |
 |                      /                  |
 |                      |                  |
 |                       \                /
 |                       v                v
 |                       +----------------+
 |                       |withdraw,deposit|
 |                       +----------------+
 |                       /                \
 |                      v                  v
 |                     20                  20
 v
時 20                  20                  20
```

> 他方, このexchangeプログラムを使っても, 残高の合計は保存されることを論ぜよ.

exchange内で取引されるwithdraw, depositの値は同じ値(difference)のため、
withdraw, depositが直列化されていれば合計値は保存される。

> タイミング図を描き, 各口座の取引きを直列化しなければ, この条件さえも破れることを示せ.

```
 |  A                   B                   C
 |
 | 10                  20                  30
 |   \                /  \                /
 |   v                v  |                |
 |   +----------------+  +----------------+
 |   |difference: 10  |  |difference: 10  |
 |   +----------------+  +----------------+
 |  /                 \  /                \
 |  |                  ||                  |
 |  |                  ||                  |
 |  \                 / |                  |
 |   v                v |                  |
 |   +----------------+  +----------------+
 |   |a: 10 b: 20     |  |a: 10 c: 30     |
 |   +----------------+  +----------------+
 |  /                 \  /                \
 |  |                  ||                  |
 |  |                  ||                  |
 |  \                 / |                  |
 |   v                v |                  |
 |   +----------------+ |                  |
 |   |set!            | |                  |
 |   +----------------+ |                  |
 |   /                \ |                  |
 |  v                  v\                  |
 | 20                  10|                 |
 |                      /                  |
 |                      |                  |
 |                       \                /
 |                       v                v
 |                      .+----------------+
 |                      ||set!            |
 |                       +----------------+
 |                       /                \
 |                      v                  v
 |                     30                  20
 |                       +----------------+
 |                       /                \
 |                      v                  v
 |                     30                  20
 v
時 20                  30                  20
```
