(load "./3.3.5")

(define a (make-connector))
(define b (make-connector))
(set-value! a 10 'user)

; (for-each-except setter inform-about-value constraints)
;
; 大域環境
; +---------------------------------------------------------------+
; |                                                               |
; | a:--------+                                                   |
; | b:--------|--------------------------------+                  |
; |           |                                |                  |
; +-----------|--------------------------------|------------------+
;             |        ^                       |        ^
;             |        |                       |        |
;             | +---------------------+        | +---------------------+
;             | | value: 10           |        | | value: false        |
;             | | informant: 'user    |        | | informant: false    |
;             | | constraints: '()    |        | | constraints: '()    |
;             | | set-my-value:...    |        | | set-my-value:...    |
;             | | forget-my-value:... |        | | forget-my-value:... |
;             | | connect:...         |        | | connect:...         |
;             | | has-value?:...      |        | | has-value?:...      |
;             | | me:--+              |        | | me:--+              |
;             | |      |              |        | |      |              |
;             | +------|--------------+        | +------|--------------+
;             |   ^    |                       |   ^    |
;          +-@_@--+    |                    +-@_@--+    |
;          |  ^        |                    |  ^        |
;          |  +--------+                    |  +--------+
;          v                                v
;      parameters: request              parameters: request
;      body: (cond ...)                 body: (cond ...)
