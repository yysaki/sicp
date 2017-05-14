(load "./3.3.4")

(define (make-wire)
  (let ((signal-value 0) (action-procedures '()))
    (define (call-each procedures)
      (if (null? procedures)
        'done
        (begin
          ((car procedures))
          (call-each (cdr procedures)))))

    (define (set-my-signal! new-value)
      (if (not (= signal-value new-value))
        (begin (set! signal-value new-value)
               (call-each action-procedures))
        'done))

    (define (accept-action-procedure! proc)
      (set! action-procedures (cons proc action-procedures))
      (proc))

    ; (define (accept-action-procedure! proc)
    ;   (set! action-procedures (cons proc action-procedures)))

    (define (dispatch m)
      (cond ((eq? m 'get-signal) signal-value)
            ((eq? m 'set-signal!) set-my-signal!)
            ((eq? m 'add-action!) accept-action-procedure!)
            (else (error "Unknown operation -- WIRE" m))))
    dispatch))

(define (half-adder a b s c)
  (let ((d (make-wire)) (e (make-wire)))
    (or-gate a b d)
    (and-gate a b c)
    (inverter c e)
    (and-gate d e s)
    'ok))

(define the-agenda (make-agenda))
(define inverter-delay 2)
(define and-gate-delay 3)
(define or-gate-delay 5)

(define input-1 (make-wire))
(define input-2 (make-wire))
(define sum (make-wire))
(define carry (make-wire))

(probe 'input-1 input-1)
(probe 'sum sum)
(probe 'carry carry)

(half-adder input-1 input-2 sum carry)

(set-signal! input-1 1)

(propagate)

(set-signal! input-2 1)

(propagate)

; accept-action-procedure! で新しいアクション手続きが即時実行されない場合, inverterが正しい値を示さないため途中経過がおかしくなる.
; 半加算器の場合(inverter c e) によりeが1になるところ、即時実行されないためc に変更が行われるまで0のままとなってしまう.
; そのため, この場合最終的に帳尻があったが、(set-signal! input-1 1)された時にsumが更新されない挙動となった.
