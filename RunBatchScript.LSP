(defun c:xx (/ UserFile UserCat FileList File#1 DwgName FileName)
  (vl-load-com)
  ; http://forums.augi.com/showthread.php?14243-Script-to-execute-lisp-on-multiple-drawings
  (setq UserFile (getfiled "Select a drawing within the directory to process" (if (setq UserFile (getenv "infratools\\dwg")) UserFile "w:/") "dwg" 2))
  (setenv "infratools\\dwg" UserFile)
  (setq UserCat (vl-filename-directory UserFile))
  (setq FileList (vl-directory-files UserCat "*.dwg" 1))

  (setq UserLisp (getfiled "Select a Lisp for editing" (if (setq UserLisp (getenv "infratools\\lisp")) UserLisp "w:/") "lsp" 2))
  (setenv "infratools\\lisp" UserLisp)
  
  (setq File#1 (open (strcat UserCat "/doit.scr") "w"))
  ;; open/make a scriptfile to write to
  (foreach DwgName FileList
    (setq FileName (strcat "\"" UserCat "\\" DwgName "\""))
    (princ "open\n" File#1)
    (princ (strcat FileName "\n") File#1)

    ;;Below are commands to run on each drawing...
    (princ (strcat "(load ""\"" (acet-str-replace "\\" "/" UserLisp) "\")\n") File#1)
    (princ "(c:doit)\n" File#1)
    (princ "_.qsave\n" File#1)
    (princ "_.close\n" File#1)
    )
  (close File#1)
  (command "script" (strcat UserCat "/doit.scr"))
	
  (princ "\nBatch script editing complete...")
  (princ)
  )

  