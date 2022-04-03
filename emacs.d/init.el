;; Fix colors for st terminal
(defun terminal-init-st ()
  "Terminal initialization function for st-terminal."
  (tty-run-terminal-initialization (selected-frame) "screen-256color"))

(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)
;;(setq frame-background-mode 'dark)

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
(setq sml/no-confirm-load-theme t)
(sml/setup)


(add-hook 'python-mode-hook 'eldoc-mode)
(setq elpy-rpc-backend "jedi")
(setq elpy-rpc-python-command "/usr/bin/python3")
(setq python-shell-interpreter "python3"
      python-shell-interpreter-args "-i")

(require 'lsp-mode)
(add-hook 'python-mode-hook #'lsp)

(global-set-key [f8] 'neotree-toggle)
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))    

(use-package undo-tree
  :diminish                       ;; Don't show an icon in the modeline
  :bind ("C-x u" . undo-tree-visualize)
  :hook (org-mode . undo-tree-mode) ;; For some reason, I need this. FIXME.
  :config
    ;; Always have it on
    (global-undo-tree-mode)

    ;; Each node in the undo tree should have a timestamp.
    (setq undo-tree-visualizer-timestamps t)

    ;; Show a diff window displaying changes between undo nodes.
    (setq undo-tree-visualizer-diff t))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/elisp"))
(require 'awesome-tab)
(awesome-tab-mode t)
(setq awesome-tab-height 150)
(global-set-key (kbd "M-1") 'awesome-tab-select-visible-tab)
(global-set-key (kbd "M-2") 'awesome-tab-select-visible-tab)
(global-set-key (kbd "M-3") 'awesome-tab-select-visible-tab)
(global-set-key (kbd "M-4") 'awesome-tab-select-visible-tab)
(global-set-key (kbd "M-5") 'awesome-tab-select-visible-tab)
(global-set-key (kbd "M-6") 'awesome-tab-select-visible-tab)
(global-set-key (kbd "M-7") 'awesome-tab-select-visible-tab)
(global-set-key (kbd "M-8") 'awesome-tab-select-visible-tab)
(global-set-key (kbd "M-9") 'awesome-tab-select-visible-tab)
(global-set-key (kbd "M-0") 'awesome-tab-select-visible-tab)

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

(use-package company
  :diminish
  :config
  (global-company-mode 1)
  (setq ;; Only 2 letters required for completion to activate.
   company-minimum-prefix-length 2

   ;; Search other buffers for compleition candidates
   company-dabbrev-other-buffers t
   company-dabbrev-code-other-buffers t

   ;; Show candidates according to importance, then case, then in-buffer frequency
   company-transformers '(company-sort-by-backend-importance
                          company-sort-prefer-same-case-prefix
                          company-sort-by-occurrence)

   ;; Flushright any annotations for a compleition;
   ;; e.g., the description of what a snippet template word expands into.
   company-tooltip-align-annotations t

   ;; Allow (lengthy) numbers to be eligible for completion.
   company-complete-number t

   ;; M-⟪num⟫ to select an option according to its number.
   company-show-numbers t

   ;; Show 10 items in a tooltip; scrollbar otherwise or C-s ^_^
   company-tooltip-limit 10

   ;; Edge of the completion list cycles around.
   company-selection-wrap-around t

   ;; Do not downcase completions by default.
   company-dabbrev-downcase nil

   ;; Even if I write something with the ‘wrong’ case,
   ;; provide the ‘correct’ casing.
   company-dabbrev-ignore-case nil

   ;; Immediately activate completion.
   company-idle-delay 0)

  ;; Use C-/ to manually start company mode at point. C-/ is used by undo-tree.
  ;; Override all minor modes that use C-/; bind-key* is discussed below.
  (bind-key* "C-/" #'company-manual-begin)

  ;; Bindings when the company list is active.
  :bind (:map company-active-map
              ("C-d" . company-show-doc-buffer) ;; In new temp buffer
              ("<tab>" . company-complete-selection)
              ;; Use C-n,p for navigation in addition to M-n,p
              ("C-n" . (lambda () (interactive) (company-complete-common-or-cycle 1)))
              ("C-p" . (lambda () (interactive) (company-complete-common-or-cycle -1)))))

