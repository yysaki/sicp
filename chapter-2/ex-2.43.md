```
問題2.42

(flatmap
 (lambda (rest-of-queens)
   (map (lambda (new-row)
          (adjoin-position new-row k rest-of-queens))
        (enumerate-interval 1 board-size)))
 (queen-cols (- k 1)))
```

2.42はflatmap1回につき、1回queens-colsが実行される。

```
問題2.43

(flatmap
 (lambda (new-row)
   (map (lambda (rest-of-queens)
          (adjoin-position new-row k rest-of-queens))
        (queen-cols (- k 1))))
 (enumerate-interval 1 board-size)
```

一方, 2.43はflatmap1回につき、n回queens-colsが実行される。
そのため、2.43における (queen-cols i) の実行時間 T(i)は、

T(i) = T(i-1) * n = ... = T(0) * n^n 

の漸化式となる。

よって、2.42の実行時間をTとした時、T *n^n かかると見られる。
