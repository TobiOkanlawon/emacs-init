;; start the initial frame maximized
(add-to-list 'initial-frame-alist '(fullscreen . maximized))

;; start every frame maximized
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; disable menu bar on startup
(menu-bar-mode -1)

;; disable tool bar on startup
(tool-bar-mode -1)

;; disable scroll bar on startup
(toggle-scroll-bar -1)

;; inhibit splash screen
(setq inhibit-splash-screen t)

;; line numbers
(global-display-line-numbers-mode t)
(setq display-line-numbers-type 'absolute)

;; set up MELPA
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(which-key elpher rjsx-mode helm-dash emmet-mode dracula-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; load dracula theme
(load-theme 'dracula t)

;; beancount mode for plaintext bookkeeping.
(add-to-list 'load-path "~/.emacs.d/beancount-mode/")
(require 'beancount)
(add-to-list 'auto-mode-alist '("\\.beancount\\'" . beancount-mode))

;; disable auto-indent for beancount-mode
(add-hook 'beancount-mode-hook
	  (lambda () (setq-local electric-indent-chars nil)))

;; use outline mode for beancount. To allow subsectioning.
(add-hook 'beancount-mode-hook #'outline-minor-mode)

;; change keyboard mappings for outline minor mode when used with beancount major mode.
(define-key beancount-mode-map (kbd "C-c C-n") #'outline-next-visible-heading)
(define-key beancount-mode-map (kbd "C-c C-p") #'outline-previous-visible-heading)

;; require emmet-mode and setup
(require 'emmet-mode)
(add-hook 'sgml-mode-hook 'emmet-mode)
(add-hook 'html-mode-hook 'emmet-mode)
(add-hook 'css-mode-hook 'emmet-mode)


;; configure backups
(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
  backup-by-copying t    ; Don't delink hardlinks
  version-control t      ; Use version numbers on backups
  delete-old-versions t  ; Automatically delete excess backups
  kept-new-versions 20   ; how many of the newest versions to keep
  kept-old-versions 5    ; and how many of the old
)

;; configure org-mode
(require 'org)
(define-key global-map "\C-csl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)


;; enable the time in mode-line
(display-time-mode 1)
(require 'helm)

;; make jsx-mode the default for opening JS files
(add-to-list 'auto-mode-alist '("\\.js\\'" . rjsx-mode))

;; adding org-timer to org-mode
(add-to-list 'org-modules 'org-timer)
(setq org-timer-default-timer 25)

;;Modify the org-clock-in so that a timer is started with the default
;; value except if a timer is already started
(add-hook 'org-clock-in-hook (lambda ()
      (if (not org-timer-current-timer)
      (org-timer-set-timer '(16)))))

;; Enable IDO mode everywhere
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;; change prefix key for lsp-mode keybindings
;; (setq lsp-keymap-prefix "C-c l")
(define-key lsp-mode-map (kbd "C-c l") lsp-command-map)

(with-eval-after-load 'lsp-mode
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
  )


(require 'lsp-mode)
(add-hook 'rjsx-mode #'lsp-deferred)

;; Performance adjustments for lsp-mode

;; adjust gc-cons-threshold for performance reasons
(setq gc-cons-threshold 100000000)

;; increase the amount of data which emacs reads from the process
(setq read-process-output-max (* 1024 1024)) ;; 1 megabyte

(setq lsp-idle-delay 0.500)
(setq lsp-log-io nil) 

;; LSP-mode usage settings
(setq lsp-modeline-diagnostics-enable t)
(setq lsp-modeline-code-actions-segments '(count icon name))
