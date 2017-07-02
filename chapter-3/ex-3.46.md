```
(define (make-serializer)
  (let ((mutex (make-mutex)))
    (lambda (p)
      (define (serialized-p . args)
        (mutex 'acquire)
        (let ((val (apply p args)))
          (mutex 'release)
          val))
      serialized-p)))

(define (make-mutex)
  (let ((cell (list false)))
    (define (the-mutex m)
      (cond ((eq? m 'acquire)
             (if (test-and-set! cell)
                 (the-mutex 'acquire))) ; retry
            ((eq? m 'release) (clear! cell))))
    the-mutex))

(define (clear! cell)
  (set-car! cell false))

(define (test-and-set! cell)
  (if (car cell)
      true
      (begin (set-car! cell true)
             false)))
```

> test-and-set!を演算を不可分にしようとは試みず, 本文に示したような通常の手続きを使って実装したとしよう. 図3.29のようなタイミング図を描き, 二つのプロセスが同時に相互排除器を獲得するのを許すと, 相互排除の実装が破綻することを示せ.

下図のように二つのプロセスが同時に相互排除器を獲得でき, serialized-p のpが不可分に行われなくなってしまう.

```
 | A                                     B
 | test-and-set!                         test-and-set!
 |  \                                      |
 |   +-----------------------------------+ |
 |   |(car cell): false                  | |
 |   +-----------------------------------+ |
 |  /                                     /
 | | +-----------------------------------+
 | | |(car cell): false                  |
 | | +-----------------------------------+
 |  \                                     \
 |   +-----------------------------------+ |
 |   |(begin (set-car! cell true) false) | |
 |   +-----------------------------------+ |
 |  /                                     /
 | | +-----------------------------------+
 | | |(begin (set-car! cell true) false) |
 | | +-----------------------------------+
 | |                                      \
 | v                                       v
 | false                                   false
 v
時
```
