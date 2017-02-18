(load "./ex-2.69")

(define rock (generate-huffman-tree '((BOOM 1) (WAH 1) (A 2) (GET 2) (JOB 2) (SHA 3) (YIP 9) (NA 16))))
;((leaf NA 16) ((leaf YIP 9) (((leaf A 2) ((leaf WAH 1) (leaf BOOM 1) (WAH BOOM) 2) (A WAH BOOM) 4) ((leaf SHA 3) ((leaf JOB 2) (leaf GET 2) (JOB GET) 4) (SHA JOB GET) 7) (A WAH BOOM SHA JOB GET) 11) (YIP A WAH BOOM SHA JOB GET) 20) (NA YIP A WAH BOOM SHA JOB GET) 36)
;      .
;     / \
;   NA   .
;       / \
;     YIP  .
;       /     \
;     .         .
;    / \      /   \
;   A   .   SHA    .
;      / \        / \
;    WAH BOOM  JOB   GET

(define song
  '(GET A JOB
    SHA NA NA NA NA NA NA NA NA
    GET A JOB
    SHA NA NA NA NA NA NA NA NA
    WAH YIP YIP YIP YIP YIP YIP YIP YIP YIP
    SHA BOOM))

; (print (length (encode song rock)))
; 84bit
; 固定長の場合、(* 3 (length song)): 108bit
