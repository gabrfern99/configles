;; Fix colors for st terminal
(defun terminal-init-st ()
  "Terminal initialization function for st-terminal."
  (tty-run-terminal-initialization (selected-frame) "screen-256color"))

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

;; Ensure `use-package' is installed.
(unless (package-installed-p 'use-package)
  (progn (package-refresh-contents)
                 (package-install 'use-package)))

(use-package try
  :commands try)

(elpy-enable)

(setq sml/theme 'dark)
(sml/setup)

(add-hook 'python-mode-hook 'eldoc-mode)
(setq elpy-rpc-backend "jedi")
(setq elpy-rpc-python-command "/usr/bin/python3")
(setq python-shell-interpreter "python3"
      python-shell-interpreter-args "-i")

(add-hook 'after-init-hook 'global-company-mode)

(global-set-key [f8] 'neotree-toggle)
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))    
       
(require 'centaur-tabs)
(centaur-tabs-mode t)
(global-set-key (kbd "C-<left>")  'centaur-tabs-backward)
(global-set-key (kbd "C-<right>") 'centaur-tabs-forward)
(centaur-tabs-headline-match)
(setq centaur-tabs-style "bar"
	  centaur-tabs-height 32
	  centaur-tabs-set-icons t
	  centaur-tabs-set-modified-marker t
	  centaur-tabs-show-navigation-buttons t
	  centaur-tabs-set-bar 'under
	  x-underline-at-descent-line t)

(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))
    
(global-set-key "\C-h" 'delete-backward-char)

(ivy-mode)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
;; enable this if you want `swiper' to use it
;; (setq search-default-mode #'char-fold-to-regexp)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> o") 'counsel-describe-symbol)
(global-set-key (kbd "<f1> l") 'counsel-find-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c k") 'counsel-ag)
(global-set-key (kbd "C-x l") 'counsel-locate)
(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
(define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)

(use-package smartparens
  :hook (lua-mode c-mode java-mode LilyPond-mode emacs-lisp-mode python-mode)
  :bind ("C-M-d" . sp-kill-sexp)
  :config
  (defalias 'smartparens 'smartparens-mode)
  (sp-with-modes '(c-mode c++-mode)
    (sp-local-pair "{" nil :post-handlers '(("||\n[i]" "RET"))))
  (show-smartparens-global-mode)
  :custom
  (sp-autoskip-closing-pair t)
  (sp-autodelete-closing-pair t)
  (sp-highlight-pair-overlay nil))

(use-package auto-highlight-symbol
  :defer 1
  :config (global-auto-highlight-symbol-mode t)
  :custom (ahs-inhibit-face-list nil "Highlight everything"))

(use-package linum-relative
  :defer 0.2
  :config
  (linum-relative-global-mode t)
  :custom
  (linum-relative-current-symbol ""))

