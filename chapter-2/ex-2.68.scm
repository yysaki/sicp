(load "./ex-2.67")

(define (encode message tree)
  (if (null? message)
    '()
    (append (encode-symbol (car message) tree)
            (encode (cdr message) tree))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (encode-symbol symbol tree)
  (define (encode-symbol-1 current-branch)
    (if (leaf? current-branch) '()
      (let ((bit (if (memq symbol (symbols (left-branch current-branch))) 0 1)))
        (let ((next-branch (if (= bit 0) left-branch right-branch)))
          (cons bit (encode-symbol-1 (next-branch current-branch)))))))
  (encode-symbol-1 tree))

; (define encoded-message (encode '(A D A B B C A) sample-tree))
;
; (print encoded-message)
; (0 1 1 0 0 1 0 1 0 1 1 1 0)
;
; (print (decode encoded-message sample-tree))
; (A D A B B C A)
