;; -*- Mode: Emacs-Lisp -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Public Domain                                           ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;When moving to another screen using up or down arrow don't move the cursor
;;keep it either at the bottom when moving down or at the top when moving up
(setq scroll-step 1)

;;Don't use tabs to indent lines, always use spaces
(setq-default indent-tabs-mode nil)

;; default to better frame titles
(setq frame-title-format (concat  "%b - emacs@" system-name))

;;Highlight currentline
;;(global-hl-line-mode 1)

;;Turn on colors for all
(global-font-lock-mode 1)

;;Customize colors
;;Strings
(set-face-foreground 'font-lock-string-face "Red")
;;Comment
(set-face-foreground 'font-lock-comment-face "Purple2")
;;Keywords
(set-face-foreground 'font-lock-keyword-face "purple2")
;;Keywords
(set-face-foreground 'font-lock-function-name-face "blue")
;;Variables
(set-face-foreground 'font-lock-variable-name-face "blue")
;;Variables
(set-face-foreground 'font-lock-warning-face "Yellow")
;;Types
(set-face-foreground 'font-lock-type-face "red")
;;Builtin ( preprocessors in c++ mode )
(set-face-foreground 'font-lock-builtin-face "cyan")
;;Constants
(set-face-foreground 'font-lock-constant-face "green")

;;Setup ENV_HOME_DIR environment variable
(or (stringp (getenv "ENV_HOME_DIR"))
    (setenv "ENV_HOME_DIR" (expand-file-name "~/.env")))
(or (stringp (getenv "ENV_DATA_DIR"))
    (setenv "ENV_HOME_DIR" (expand-file-name "~/.envData")))

;;Abbreviations
(setq-default abbrev-mode t)
(read-abbrev-file (substitute-in-file-name "$ENV_HOME_DIR/etc/emacs/abbreviations.el") )
(setq save-abbrevs t)

;;Enable wheel-mouse scrolling
;;(mouse-wheel-mode t)

;;Setup Backup
(setq make-backup-files t)
(setq version-control t)
(setq delete-old-versions t)            ; clean up a little
(setq kept-new-versions 2)              ; keep 6 new
(setq kept-old-versions 1)              ; keep only 2 old
(defvar backup-dir (substitute-in-file-name "$ENV_DATA_DIR/emacs/backup"))
(setq backup-directory-alist (list (cons ".*" backup-dir)))

;;Setup Autosave Files
(defvar autosave-dir (concat "/tmp/emacs_autosaves/" (user-login-name) "/"))
(make-directory autosave-dir t)
(defun auto-save-file-name-p (filename)  (string-match "^#.*#$" (file-name-nondirectory filename)))
(defun make-auto-save-file-name ()
  (concat autosave-dir
          (if buffer-file-name
              (concat "#" (file-name-nondirectory buffer-file-name) "#")
            (expand-file-name
             (concat "#%" (buffer-name) "#")))))


;;Enable line and column numbering
(line-number-mode 1)
(column-number-mode 1)

;;Wrap lines when the cursor goes beyond the column limit
(setq auto-fill-mode 1)

;;Let the default mode be text mode
(setq default-major-mode 'text-mode)

;;Fix Ctrl-Left and Ctrl-Right
(global-set-key "\M-[1;5C"    'forward-word) ; Ctrl+right   => forward word
(global-set-key "\M-[1;5D"    'backward-word) ; Ctrl+left    => backward word
;; Make sure backspace and delete works as expected

;;(normal-erase-is-backspace-mode 1)


;;Save some space exept when running in x window
(cond
 ((string= "x" window-system) (menu-bar-mode t) )
 ( t (menu-bar-mode nil) )
 )

;; WINDOWID is defined only when xterm is running remotely
;; We don't turn on normal-erase-is-backspace-mode because it causes emacs to reverse backspace
;; when running under xterm
;; So we turn on this mode only when running under a ssh terminal
;;(cond
;; ( (not (stringp (getenv "WINDOWID")))  (normal-erase-is-backspace-mode 1) )
;; )


;;Programming
;;define C-c C-c as the key to save and compile
;;(defun my-save-and-compile ()
;;  (interactive "")
;;  (save-buffer 0)
;;  (compile "make -k"))

;;(define-key c++-mode-map "\C-c\C-c" 'my-save-and-compile)
;;(define-key c-mode-map "\C-c\C-c" 'my-save-and-compile)


;;Use "%" to jump to the matching parenthesis.
(defun goto-match-paren (arg)
  "Go to the matching parenthesis if on parenthesis, otherwise insert the character typed."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
        (t                    (self-insert-command (or arg 1))) ))
(global-set-key "%" `goto-match-paren)


;;Global Key Bindings
(global-set-key "\C-x\C-c"      'goto-line)
(global-set-key "\C-x\C-v"      'find-tag)

;;Config File Extensions
;;Auto-mode list
(setq auto-mode-alist
      (append '(("\\.cxx$"        .       c++-mode)
                ("\\.CPP$"        .       c++-mode)
                ("\\.cc$"         .       c++-mode)
                ("\\.cs$"         .       java-mode)
                ("\\.tex$"         .      tex-mode)
                ("\\.C$"          .       c++-mode)
                ("\\.c$"          .       c-mode)
                ("\\.h$"          .       c++-mode)
                ("\\.java$"       .       java-mode)
                ("\\.emacs$"       .       emacs-lisp-mode)
                ("\\.kan$"        .       java-mode)
                ("\\.pl$"         .       cperl-mode)
                ("\\.xml$"        .       xml-mode)
                ("\\.pm$"         .       cperl-mode)
                ("\\.emacs$"      .       emacs-lisp-mode)
                ("make_[a-z]*$"   .       makefile-mode)
                ("Make_[a-z]*$"   .       makefile-mode)
                ("\\.txt$"        .       text-mode)
                ("\\.php$"        .       php-mode)
                ("\\.inc$"        .       php-mode)
                ("\\.html$"       .       html-mode)
                ("\\.lp$"         .       lisp-interaction-mode))
              auto-mode-alist))

;;Config C++
(defun my-cc-c++-hook ()
  ;; already default (font-lock-mode t)
  ;; already default (abbrev-mode t)
  (c-set-style "ellemtel")
  (setq c-indent-level 4 )
  )
(add-hook 'c++-mode-hook 'my-cc-c++-hook)


;;Css Mode
;;(if
;;    (not (require 'css-mode nil 'noerror) )
;;    (and
;;        (file-exists-p (substitute-in-file-name "$ENV_DATA_DIR/emacs/modules/css-mode.el"))
;;        (and
;;         (load (substitute-in-file-name "$ENV_DATA_DIR/emacs/modules/css-mode.el") )
;;         (add-to-list 'auto-mode-alist '("\\.css\\'" . css-mode))
;;         )
;;    )
;;)


(defun iwb ()
  "indent whole buffer"
  (interactive)
  (delete-trailing-whitespace)
  (indent-region (point-min) (point-max) nil)
  (untabify (point-min) (point-max)))

(global-set-key (kbd "<f12>") 'iwb)
