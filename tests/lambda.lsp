((lambda f (f (quote (2 3)))) ((lambda a (lambda b (cons (a (quote 1)) b))) (lambda a a)))
