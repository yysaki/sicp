(load "./tables")

(install-scheme-number-package)
(install-rational-package)
(install-polynomial-package)

(define p1 (make-polynomial 'x '((4 1) (3 -1) (2 -2) (1 2))))
(define p2 (make-polynomial 'x '((3 1) (1 -1))))
(print (greatest-common-divisor p1 p2))
