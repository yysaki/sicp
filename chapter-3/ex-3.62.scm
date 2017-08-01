(load "./3.5")

; 問題3.60と3.61を使い, 二つのべき級数を割る手続きdiv-seriesを定義せよ. 分母の級数は零でない定数項で始るとし, 任意の二つの級数について働くものとする. (分母が零の定数項を持つなら, div-seriesはエラーを出すべきである.)

; (load "./3.60")

(define (mul-series s1 s2)
  (cons-stream (* (stream-car s1) (stream-car s2))
               (add-streams (scale-stream (stream-cdr s1) (stream-car s2))
                            (mul-series s1 (stream-cdr s2)))))

; (load "./3.61")

(define (invert-unit-series s)
  (cons-stream 1 (scale-stream
                   (mul-series (stream-cdr s) (invert-unit-series s))
                   -1)))

(define (div-series s1 s2)
  (if (= (stream-car s2) 0)
    (error "-- DIV-SERIES divide zero")
    (scale-stream (mul-series s1
                              (invert-unit-series
                                (scale-stream s2 (/ 1 (stream-car s2)))))
                  (/ 1 (stream-car s2)))))

; div-seriesを問題3.59の結果と共に使い, 正接のべき級数を生成する方法を述べよ.

(define (integrate-series power-series)
  (stream-map / power-series integers))

(define cosine-series
  (cons-stream 1 (integrate-series (scale-stream sine-series -1))))

(define sine-series
  (cons-stream 0 (integrate-series cosine-series)))

(define tan-series (div-series sine-series cosine-series))

(display-stream (stream-take tan-series 10))
