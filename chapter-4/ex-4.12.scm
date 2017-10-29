(load "./4.1")

(define (env-loop env action not-found)
  (if (eq? env the-empty-environment)
    (not-found)
    (let ((frame (first-frame env)))
      (action frame))))

(define (scan-frame vars vals var found not-found)
  (cond ((null? vars) (not-found))
        ((eq? var (car vars)) (found vals))
        (else (scan-frame (cdr vars) (cdr vals) var found not-found))))

(define (lookup-variable-value var env)
  (define (action frame)
    (scan-frame (frame-variables frame)
                (frame-values frame)
                var
                (lambda (vars) (car vars))
                (lambda () (env-loop (enclosing-environment env) action not-found))))
  (define (not-found) (error "Unbound variable" var))
  (env-loop env action not-found))

(define (set-variable-value! var val env)
  (define (action frame)
    (scan-frame (frame-variables frame)
                (frame-values frame)
                var
                (lambda (vals) (set-car! vals val))
                (lambda () (env-loop (enclosing-environment env) action not-found))))
  (define (not-found) (error "Unbound variable -- SET!" var))
  (env-loop env action not-found))

(define (define-variable! var val env)
  (define (action frame)
    (scan-frame (frame-variables frame)
                (frame-values frame)
                var
                (lambda (vals) (set-car! vals val))
                (lambda () (add-binding-to-frame! var val frame))))
  (define (not-found) (error "Unbound variable -- DEFINE!" var))
  (env-loop env action not-found))

(driver-loop)
