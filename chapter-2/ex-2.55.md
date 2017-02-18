```
(car ''abracadabra)
```

は

```
(car (quote (quote abracadabra)))
```

と等価のため、この式はquoteを戻す。
