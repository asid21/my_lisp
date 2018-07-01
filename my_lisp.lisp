(defparameter *env*
  (list
    (cons 'nil 'nil)
    (cons 't 't)
    (list 'car 'primitive 1 #'car)
    (list 'cdr 'primitive 1 #'cdr)
    (list 'atom 'primitive 1 #'atom)
    (list 'cons 'primitive 2 #'cons)
    (list 'eq 'primitive 2 #'eq)
    (list 'print 'primitive 1 #'print)
    (list 'quote 'syntax 1 #'(lambda (x) x))
    (list 'lambda 'syntax 'syntax #'(lambda (x env) (list 'closure x env)))
    (list 'if 'syntax 'syntax #'(lambda (x env) (if (m-eval (car x) env) (m-eval (cadr x) env) (m-eval (caddr x) env))))))

(defun m-eval (e env)
  (cond ((symbolp e) (cdr (assoc e env)))
        ((consp e) (m-apply e env))
        (t e)))

(defun call-function (head body env)
  (case (cadr head)
    (1 (funcall (caddr head) (car body)))
    (2 (funcall (caddr head) (car body) (cadr body)))
    (t (funcall (caddr head) body env))))

(defun closure-eval (head env)
  (cond ((null (cdr head)) (m-eval (car head) env))
        (t (m-eval (car head) env) (closure-eval (cdr head) env))))

(defun closure-add-env (head body env nenv)
  (cond ((null (cdr head)) (cons (cons (car head) (m-eval (car body) nenv)) env))
        (t (closure-add-env (cdr head) (cdr body) (cons (cons (car head) (m-eval (car body) nenv)) env) nenv))))

(defun m-apply (e env)
  (let ((head (m-eval (car e) env)) (body (cdr e)))
    (case (car head)
      (primitive (call-function
                   head (mapcar #'(lambda (x) (m-eval x env)) body) env))
      (syntax (call-function head body env))
      (closure (closure-eval (cdadr head) (closure-add-env (caadr head) body (caddr head) env))))))
