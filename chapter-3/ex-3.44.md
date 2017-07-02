> お金を口座から口座へ移す問題を考えよう. Ben Bitdiddleは例えば本文にあったmake-accountの版のような, 預入れと払出しの取引きを直列化する口座の機構を使えば, 多くの人が多くの口座の間で並列的にお金を移したとしても, 次の手続きで達成出来ると主張した.

```
(define (transfer from-account to-account amount)
  ((from-account 'withdraw) amount)
  ((to-account 'deposit) amount))
```

> Louis Reasonerは, ここに問題があり, 交換の問題を扱うのに必要だったような,より巧妙な方法を使う必要があると主張する. Louisは正しいか.

Louisは正しくない、直列化されたwithdrawと直列化されたdepositがあれば移動(transfer)は十分である.

> そうでなければ, 移動の問題と交換の問題の間にはどういう本質的な違いがあるか. (from-accountの残高は, 少なくてもamountであると仮定せよ.)

交換(exchange)の場合、複数のexchange操作が並列に走るとき対になるwithdrawとdepositは直列化しないと問題となるが,
移動(exchange)の場合、対になるwithdrawとdepositがどの順番で行われても問題とならない。
