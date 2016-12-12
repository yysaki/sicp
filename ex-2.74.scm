; a

(define (get-record staff-name section)
  ((get section 'record) staff-name))

; b

(define (get-salary record section)
  ((get section 'salary) staff-name))

; c

(define (find-employee-record staff-name section-list)
  (if (null? section-list)
    #f
    (or (get-record staff-name (car section-list))
        (find-employee-record staff-name (cdr section-list))))

; d

; recordおよびsalary opを持つ新しいsection向けの install-sectionr-package パッケージを作成する。
