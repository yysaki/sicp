```
31 {A B C D E}
          / \
15 {A B C D} E
        / \
 7 {A B C} D
      / \
 3 {A B} C
    / \
   A   B
```

```
1023 {A B C D E F G H I J}
                      / \
 511 {A B C D E F G H I} J
                    / \
 255 {A B C D E F G H} I
                  / \
 127 {A B C D E F G} H
                / \
  63 {A B C D E F} G
              / \
  31 {A B C D E} F
            / \
  15 {A B C D} E
          / \
   7 {A B C} D
        / \
   3 {A B} C
      / \
     A   B
```

> (一般のnの)こういう木で, 最高頻度の記号を符号化するのに必要なビット数はいくらか.

* 1

> 最低頻度の記号ではどうか.

* n - 1
