
;; auto debug
(setq debug-on-error t)
 
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.
;; See `package-archive-priorities` and `package-pinned-packages`.
;; Most users will not need or want to do this.
;; (add-to-list 'package-archives
;;              '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

;; global variables.

(defvar n2e/custom-file (concat user-emacs-directory ".n2e/custom.el")
  "default custom file,")

(defvar n2e/tree-sitter-gram-load-path (concat user-emacs-directory ".n2e/treesit")
  "tree-sitter grammars directory.")

;; use package

(require 'use-package)

(setq use-package-always-ensure t)

;; emacs properties

(setq-default make-backup-files nil
	      ;; automatically add ending brackets
              electric-pair-mode t
	      ;; auto match branckets
              show-paren-mode t)

(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -3)

;; display line number

(setq display-line-numbers-width 5)
(setq display-line-numbers 'relative)
(global-display-line-numbers-mode)

;; custom file

(setq custom-file n2e/custom-file)
;; load custom file and ignore errors 
(load custom-file 'noerror) 


;; minibuffer completion

;; Enable vertico
(use-package vertico
  :custom
  ;; (vertico-scroll-margin 0) ;; Different scroll margin
  ;; (vertico-count 20) ;; Show more candidates
  (vertico-resize t) ;; Grow and shrink the Vertico minibuffer
  (vertico-cycle t) ;; Enable cycling for `vertico-next/previous'
  :init
  (vertico-mode))

;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :init
  (savehist-mode))

;; Optionally use the `orderless' completion style.
(use-package orderless
  :custom
  ;; Configure a custom style dispatcher (see the Consult wiki)
  ;; (orderless-style-dispatchers '(+orderless-consult-dispatch orderless-affix-dispatch))
  ;; (orderless-component-separator #'orderless-escapable-split-on-space)
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion)))))

;; A few more useful configurations...
(use-package emacs
  :custom
  ;; Support opening new minibuffers from inside existing minibuffers.
  (enable-recursive-minibuffers t)
  ;; Hide commands in M-x which do not work in the current mode.  Vertico
  ;; commands are hidden in normal buffers. This setting is useful beyond
  ;; Vertico.
  (read-extended-command-predicate #'command-completion-default-include-p)
  :init
  ;; Add prompt indicator to `completing-read-multiple'.
  ;; We display [CRM<separator>], e.g., [CRM,] if the separator is a comma.
  (defun crm-indicator (args)
    (cons (format "[CRM%s] %s"
                  (replace-regexp-in-string
                   "\\`\\[.*?]\\*\\|\\[.*?]\\*\\'" ""
                   crm-separator)
                  (car args))
          (cdr args)))
  (advice-add #'completing-read-multiple :filter-args #'crm-indicator))

  ;; Do not allow the cursor in the minibuffer prompt
  (setq minibuffer-prompt-properties
        '(read-only t cursor-intangible t face minibuffer-prompt))
  (add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)

;; completion at point

(use-package company
  :config
  (setq company-idle-delay 0.1
	company-minimum-prefix-length 1)
  :hook
  (after-init-hook . global-company-mode))

(use-package company-box
  :after (company)
  :hook
  (company-mode . company-box-mode))



;; A few more useful configurations...
(use-package emacs
  :custom
  ;; TAB cycle if there are only few candidates
  ;; (completion-cycle-threshold 3)

  ;; Enable indentation+completion using the TAB key.
  ;; `completion-at-point' is often bound to M-TAB.
  (tab-always-indent 'complete))

  ;; Emacs 30 and newer: Disable Ispell completion function.
  ;; Try `cape-dict' as an alternative.
  ;; (text-mode-ispell-word-completion nil)
  
  ;; Hide commands in M-x which do not apply to the current mode.  Corfu
  ;; commands are hidden, since they are not used via M-x. This setting is
  ;; useful beyond Corfu.
  ;; (read-extended-command-predicate #'command-completion-default-include-p))

;; Optionally use the `orderless' completion style.
(use-package orderless
  :custom
  ;; (orderless-style-dispatchers '(orderless-affix-dispatch))
  ;; (orderless-component-separator #'orderless-escapable-split-on-space)
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion)))))

;; parentheses faceOA

(use-package paren-face)

;; emacs theme

;; using `customize-theme` to set theme
(use-package color-theme-sanityinc-tomorrow)

;; search

(use-package fzf
  :bind
    ;; Don't forget to set keybinds!
  :config
  (setq fzf/args "-x --color bw --print-query --margin=1,0 --no-hscroll"
        fzf/executable "fzf"
        fzf/git-grep-args "-i --line-number %s"
        ;; command used for `fzf-grep-*` functions
        ;; example usage for ripgrep:
        fzf/grep-command "rg --no-heading -nH"
		;;  fzf/grep-command "grep -nrH"
        ;; If nil, the fzf buffer will appear at the top of the window
        fzf/position-bottom t
        fzf/window-height 15))

(use-package rg)
		  
;; project

(use-package projectile
  :ensure t
  :init
  (projectile-mode +1)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))

;; spell/error check

(use-package flycheck
  :init
  (global-flycheck-mode))
  
;; which key

(use-package which-key
   :init
   (which-key-mode))

;; yasnippet

(use-package yasnippet
  :init
  (yas-global-mode 1))

;; file explorer

(use-package treemacs)

(use-package treemacs-projectile
  :after projectile
  :init (treemacs-project-follow-mode t ))

;; LSP and DAP

(use-package lsp-mode
  :commands
  (lsp lsp-deferred)
  :init
  (setq lsp-keymap-prefix "C-c l")
  :hook
  (prog-mode . lsp)
  :config
  (setq lsp-enable-snippet t)
  (setq lsp-enable-completion-at-point t))

(use-package dap-mode
  :after lsp-mode
  :config
  (dap-auto-configure-mode))

;; java

(use-package lsp-java
  :config
  (add-hook 'java-mode-hook 'lsp))
