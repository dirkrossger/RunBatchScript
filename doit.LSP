(defun c:doit ()
; Move all to origin 0,0 after block "A3"
  (command-s "_layer" "_t" "*" "" "")
  (if (setq e (ssname (ssget "X" '((0 . "INSERT")(2 . "A3"))) 0))
    (progn
      (setq nullp (cdr (assoc 10 (entget e))))

      (if (setq ss (ssget "X"))
	(repeat (setq i (sslength ss))
	  (setq item (ssname ss (setq i (1- i)) ))
	  (setq ip (cdr (assoc 10 (entget item))))
	  (setq np
		 (list (- (car ip) (car nullp))
		       (- (cadr ip) (cadr nullp))
		       )
		)
	  
	  (command-s "_move" item "" ip np "")
	  )
	)
      )
    )
 )
