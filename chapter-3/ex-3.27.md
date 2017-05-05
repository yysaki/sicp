```
(define memo-fib
  (memoize (lambda (n)
             (cond ((= n 0) 0)
                   ((= n 1) 1)
                   (else (+ (memo-fib (- n 1))
                            (memo-fib (- n 2))))))))
```

```
(define (memoize f)
  (let ((table (make-table)))
    (lambda (x)
      (let ((previously-computed-result (lookup x table)))
        (or previously-computed-result
            (let ((result (f x)))
              (insert! x result table)
              result))))))
```

```
(memo-fib 3)

大域環境
+---------------------------------------------------------------+
|                                                               |
| memoize:--+                                                   |
| memo-fib:-|------------+                                      |
|           |            |                                      |
+-----------|------------|--------------------------------------+
            |   ^        |     ^                         ^
         +-@_@--+        | E1  |                         |
         |               | +-------+                     |
         |               | | f:----------------------+   |
         |               | +-------+                 |   |
         |               |     ^                  +-@_@--+
         v               | E2  |                  |
     parameters: f       | +------------+         |
     body: (let ...)     | | table      |         |
                         | +------------+         |
                         |   ^      ^^^^          v
                      +-@_@--+      ||||        parameters: n
                      |             ||||        body: (cond ...)
                      |             ||||
                      v             |||+-------------------------------------+
                  parameters: x     ||+------------------------+             |
                  body: (let ...)   |+-----------+             |             |
                                 E3 |         E4 |          E5 |          E6 |
                                 +------+     +------+      +------+      +------+
                                 | x: 3 |     | x: 2 |      | x: 1 |      | x: 0 |
                                 +------+     +------+      +------+      +------+
                                 (f 3)        (f 2)         (f 1)         (f 0)
```
