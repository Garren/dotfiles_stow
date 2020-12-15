;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Sanemacs version 0.3.0 ;;;
;;; https://sanemacs.com   ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; For performance
(setq gc-cons-threshold 100000000)
(setq read-process-output-max (* 1024 1024)) ;; 1mb


(add-hook 'after-init-hook #'(lambda ()
                               ;; restore after startup
                               (setq gc-cons-threshold 800000)))

;;; Disable menu-bar, tool-bar, and scroll-bar.
(if (fboundp 'menu-bar-mode)
    (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode)
    (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode)
    (scroll-bar-mode -1))

;;; Fix this bug:
;;; https://www.reddit.com/r/emacs/comments/cueoug/the_failed_to_download_gnu_archive_is_a_pretty/
(when (version< emacs-version "26.3")
  (setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3"))

;;; Setup package.el
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(unless package--initialized (package-initialize))

;;; Setup use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))
(setq use-package-always-ensure t)

;;; Useful Defaults
(setq-default cursor-type 'bar)           ; Line-style cursor similar to other text editors
(setq inhibit-startup-screen t)           ; Disable startup screen
(setq initial-scratch-message "")         ; Make *scratch* buffer blank
(setq-default frame-title-format '("%b")) ; Make window title the buffer name
(setq ring-bell-function 'ignore)         ; Disable bell sound
(fset 'yes-or-no-p 'y-or-n-p)             ; y-or-n-p makes answering questions faster
(show-paren-mode 1)                       ; Show closing parens by default
(setq linum-format "%4d ")                ; Line number format
(delete-selection-mode 1)                 ; Selected text will be overwritten when you start typing
(global-auto-revert-mode t)               ; Auto-update buffer if file has changed on disk
(use-package undo-tree                    ; Enable undo-tree, sane undo/redo behavior
  :init (global-undo-tree-mode))
(add-hook 'before-save-hook
	  'delete-trailing-whitespace)    ; Delete trailing whitespace on save
(add-hook 'prog-mode-hook                 ; Show line numbers in programming modes
          (if (and (fboundp 'display-line-numbers-mode) (display-graphic-p))
              #'display-line-numbers-mode
            #'linum-mode))

(defun sanemacs/backward-kill-word ()
  (interactive "*")
  (push-mark)
  (backward-word)
  (delete-region (point) (mark)))

;;; Keybindings
(global-set-key [mouse-3] 'mouse-popup-menubar-stuff)          ; Gives right-click a context menu
(global-set-key (kbd "C->") 'indent-rigidly-right-to-tab-stop) ; Indent selection by one tab length
(global-set-key (kbd "C-<") 'indent-rigidly-left-to-tab-stop)  ; De-indent selection by one tab length
(global-set-key (kbd "M-DEL") 'sanemacs/backward-kill-word)    ; Kill word without copying it to your clipboard
(global-set-key (kbd "C-DEL") 'sanemacs/backward-kill-word)    ; Kill word without copying it to your clipboard
(global-set-key (kbd "M-j")
		(lambda ()
		  (interactive)
		  (join-line -1)))                             ; Join lines
(global-set-key (kbd "M-o") 'other-window)                     ; Move between windows ( C-x o alias )
(global-set-key (kbd "M-i") 'imenu)

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)

;;; Offload the custom-set-variables to a separate file
;;; This keeps your init.el neater and you have the option
;;; to gitignore your custom.el if you see fit.
 (setq custom-file "~/.emacs.d/custom.el")
 (unless (file-exists-p custom-file)
   (write-region "" nil custom-file))
;;; Load custom file. Don't hide errors. Hide success message
 (load custom-file nil t)

;;; Put Emacs auto-save and backup files to /tmp/ or C:/Temp/
 (defconst emacs-tmp-dir (expand-file-name (format "emacs%d" (user-uid)) temporary-file-directory))
 (setq
  backup-by-copying t			; Avoid symlinks
  delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t
  auto-save-list-file-prefix emacs-tmp-dir
  auto-save-file-name-transforms `((".*" ,emacs-tmp-dir t)) ; Change autosave dir to tmp
  backup-directory-alist `((".*" . ,emacs-tmp-dir)))

;;; Lockfiles unfortunately cause more pain than benefit
 (setq create-lockfiles nil)

;;; Load wheatgrass as the default theme if one is not loaded already

(load-theme 'zenburn t)
(set-face-attribute 'default nil :height 140)

(defun reload-config ()
  (interactive)
  (load-file (concat user-emacs-directory "init.el")))

(use-package slime)
(use-package paredit)
(use-package rainbow-delimiters)
(use-package geiser)
(use-package company)
(use-package slime-company)
(use-package ace-jump-mode
  :bind ("C-." . ace-jump-mode))
(use-package helm)
(use-package helm-slime)
(use-package whole-line-or-region) ;; modify C-w so it kills a line the point is on if no active region

;; M-x describe-personal-keybindings

(add-to-list 'exec-path "/usr/bin/sbcl")
(setq inferior-lisp-program "sbcl")

;; configure company
(add-hook 'after-init-hook #'global-company-mode)

;; Configure Paredit
(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'emacs-lisp-mode-hook #'enable-paredit-mode)
(add-hook 'eval-expression-minibugger-setup-hook #'enable-paredit-mode)
(add-hook 'ielm-mode-hook #'enable-paredit-mode)
(add-hook 'lisp-mode-hook #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'scheme-mode-hook #'enable-paredit-mode)
(add-hook 'slime-repl-mode-hook #'enable-paredit-mode)
(defun override-slime-del-key ()
  (define slime-repl-mode-map
    (read-kbd-macro paredit-backward-delete-key) nil))
(add-hook 'slime-repl-mode-hook 'override-slime-del-key)

;; configure rainbow delimiters
(add-hook 'emacs-lisp-mode-hook #'rainbow-delimiters-mode)
(add-hook 'ielm-mode-hook #'rainbow-delimiters-mode)
(add-hook 'lisp-mode-hook #'rainbow-delimiters-mode)
(add-hook 'lisp-interaction-mode-hook #'rainbow-delimiters-mode)
(add-hook 'slime-repl-mode-hook #'rainbow-delimiters-mode)

;; configure slime + company
(slime-setup '(slime-fancy slime-company))

;; additional geiser config
(eval-after-load "geiser-impl"
  '(add-to-list 'geiser-implementations-alist
                '((dir "/home/agarren/Projects/scheme/mit/") mit)))
(eval-after-load "geiser-impl"
  '(add-to-list 'geiser-implementations-alist
                '((dir "/home/agarren/Projects/scheme/guile/") guile)))

;; configure fido
(ido-mode 1)
;; (setq ido-everywhere t)
(setq ido-enable-flex-matching t)

;; configure helm
(helm-mode 1)
