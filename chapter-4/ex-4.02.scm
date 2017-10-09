(load "./4.1")

; a. Louisの計画では何が悪かったか. (ヒント: 式(define x 3)に対して, Louisの評価器は何をするか.) 
; 式(define x 3) はdefinition? が真を戻すが、application? も真を戻すため、手続き作用としても判断できる。
; 並び順を帰ると代入判断されるべき式が手続き作用として処理されてしまうため、defineが正常に動作しなくなる.

; b

(define (application? exp) (tagged-list? exp 'call))

(define (operator exp) (cadr exp))

(define (operands exp) (cddr exp))

(driver-loop)
; (call + 1 2)
