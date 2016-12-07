(load "./ex-2.68")

(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

(define (successive-merge leaf-set)
  (if (= (length leaf-set) 1) (car leaf-set)
    (successive-merge
      (adjoin-set (make-code-tree (car leaf-set)
                                  (cadr leaf-set))
                  (cddr leaf-set)))))

; (print (generate-huffman-tree '((C 1) (D 1) (E 1) (F 1) (G 1) (H 1) (B 3) (A 8))))
; ((leaf A 8) ((((leaf H 1) (leaf G 1) (H G) 2) ((leaf F 1) (leaf E 1) (F E) 2) (H G F E) 4) (((leaf D 1) (leaf C 1) (D C) 2) (leaf B 3) (D C B) 5) (H G F E D C B) 9) (A H G F E D C B) 17)

