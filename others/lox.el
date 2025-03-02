;;; lox.el --- Major mode for editing Lox files

(defun lox-indent-line ()
  "Indent current line."
  (let (indent
        boi-p                           ;begin of indent
        move-eol-p
        (point (point)))                ;lisps-2 are truly wonderful
    (save-excursion
      (back-to-indentation)
      (setq indent (car (syntax-ppss))
            boi-p (= point (point)))
      ;; don't indent empty lines if they don't have the in it
      (when (and (eq (char-after) ?\n)
                 (not boi-p))
        (setq indent 0))
      ;; check whether we want to move to the end of line
      (when boi-p
        (setq move-eol-p t))
      ;; decrement the indent if the first character on the line is a
      ;; closer.
      (when (or (eq (char-after) ?\))
                (eq (char-after) ?\}))
        (setq indent (1- indent)))
      ;; indent the line
      (delete-region (line-beginning-position)
                     (point))
      (indent-to (* tab-width indent)))
    (when move-eol-p
      (move-end-of-line nil))))

(defvar lox-mode-syntax-table
  (let ((table (make-syntax-table)))
    ;; C/C++ style comments
    (modify-syntax-entry ?/ ". 124b" table)
    (modify-syntax-entry ?* ". 23" table)
    (modify-syntax-entry ?\n "> b" table)
    ;; Preprocessor stuff?
    (modify-syntax-entry ?# "." table)
    ;; Chars are the same as strings
    (modify-syntax-entry ?' "\"" table)
    table))



(defun lox-types ()
  '("var" "char" "int" "long" "short" "void" "bool" "float" "double" "signed" "unsigned"
    "char16_t" "char32_t" "char8_t"
    "int8_t" "uint8_t" "int16_t" "uint16_t" "int32_t" "uint32_t" "int64_t" "uint64_t"
    "uintptr_t"
    "size_t"))
(defun lox-keywords ()
  '("fun" "print" "class" "return" "var" "if" "else" "or" "and" "for" "while" "true" "false" "nil"))

(defun lox-font-lock-keywords ()
  (list
   `(,(regexp-opt (lox-keywords) 'symbols) . font-lock-keyword-face)
   `(,(regexp-opt (lox-types) 'symbols) . font-lock-type-face)))

;;;###autoload
(define-derived-mode lox-mode prog-mode "Lox"
  "Major mode for editing Lox files."
  ;; Customizations for lox-mode
  :syntax-table lox-mode-syntax-table
  (setq font-lock-defaults '(lox-font-lock-keywords))
  (setq-local indent-line-function 'lox-indent-line)
  (setq-local comment-start "// "))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.lox\\'" . lox-mode))

(provide 'lox)
