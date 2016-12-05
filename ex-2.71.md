```
  {A B C D E} 31
 / \
A   {B C D E} 15
   / \
  B   {C D E} 7
     / \
    C   {D E} 3
       / \
      D   E
```

```
  {A B C D E F G H I J} 1023
 / \
A   {B C D E F G H I J} 511
   / \
  B   {C D E F G H I J} 255
     / \
    C   {D E F G H I J} 127
       / \
      D   {E F G H I J} 63
         / \
        E   {F G H I J} 31
           / \
          F   {G H I J} 15
             / \
            G   {H I J} 7
               / \
              H   {I J} 3
                 / \
                I   J
```

> (一般のnの)こういう木で, 最高頻度の記号を符号化するのに必要なビット数はいくらか.

* 1

> 最低頻度の記号ではどうか.

* n - 1
