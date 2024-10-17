
(require 'package)

(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(require 'use-package)

;; hide sartup message and startup screen
(setq-default inhibit-startup-screen  t
              inhibit-startup-message t
	      make-backuo-files nil) ;; disable backup file (#file.ext#)

(tool-bar-mode 0)      ;; no tool   bar
(menu-bar-mode 0)      ;; no menu   bar
(scroll-bar-mode 0)    ;; no scroll bar
(column-number-mode 1)
(show-paren-mode 1)

(use-package company
  :ensure t
  :config (progn (add-hook 'after-init-hook 'global-company-mode)))

;; using M-x customize-themes to change theme.
(use-package gruber-darker-theme
  :ensure t)

;; global line number relatively
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode)
(setq display-line-numbers-width 7) ;; %7d a.k.a
                                    ;; |      1 content pf line 1
                                    ;; |      2 contrnt of line 2
                                    ;; |      . ...
                                    ;; |    999 contrnt of line 999

;; keep customize settings in their own file 
(setq custom-file (concat user-emacs-directory "/custom.el"))

;; load custom file and ignore error messages.
(when (file-exists-p custom-file) (load-file custom-file 'noerror))


;; nix-ts-mode
;; !!! require feature: tree-sitter (emacs 29+)
(use-package nix-ts-mode
  :ensure t
  :mode "\\.nix\\'")
