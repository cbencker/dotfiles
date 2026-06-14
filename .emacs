;;; .emacs --- Custom settings

;;; Commentary:

;;; Code:

;; Defaults for Gnu-Emacs
(if (file-readable-p "~/.gnu-emacs")
    (load "~/.gnu-emacs" nil t)
  (if (file-readable-p "/etc/skel/.gnu-emacs")
	  (load "/etc/skel/.gnu-emacs" nil t)))

;; Put Customize-based settings in custom.el instead of here
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file 'noerror)

;; Use spaces instead of tabs
(setq-default indent-tabs-mode nil)

;; Set tab width
(setq-default tab-width 4)

;; Insert spaces when pressing tab
(setq indent-line-function 'insert-tab)

;; No bell sounds
(setq ring-bell-function 'ignore)

;; Easier other-window
(global-set-key (kbd "M-o") 'other-window)

;; Unbind M-c (capitalize-word)
(global-unset-key (kbd "M-c"))

;; Set default font and size
(set-face-attribute 'default nil
                    :family "Hack"
                    :height 120)  ;; In 10ths of a point

;; Fullscreen right away
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Allow undo (C-c <left>) and redo (C-c <right>) of window changes
(winner-mode 1)

;; Enable line numbers globally
(global-display-line-numbers-mode 1)

;; Make room for three-digit line numbers by default
(setq display-line-numbers-width 3)

;; Remember recently edited files (recentf-open-files)
(recentf-mode 1)

;; Update buffers when underlying file changes
(global-auto-revert-mode 1)

;; Automatic handling of paired characters and indentations
(electric-pair-mode 1)
(electric-indent-mode 1)

;; Automatically indent after yanking
(defun indent-region-after-yank (&rest _args)
  "Indent the region after yanking."
  (let ((mark-even-if-inactive t))
    (indent-region (region-beginning) (region-end))))

(advice-add 'yank :after #'indent-region-after-yank)
(advice-add 'yank-pop :after #'indent-region-after-yank)

;; Update Dired and other buffers when relevant files change
(setq global-auto-revert-non-file-buffers t)

;; Remember minibuffer prompt history (M-n, M-p)
(setq history-length 25)
(savehist-mode 1)

;; Remember last cursor location of opened files
(save-place-mode 1)

;; Scroll before hitting the edge of the screen
(setq scroll-margin 8)

(require 'package)

;; Macro for updating lists in place
(defmacro append-to-list (target suffix)
  "Append SUFFIX to TARGET in place."
  `(setq ,target (append ,target ,suffix)))

;; Set up Emacs package archives
(append-to-list package-archives
                '(("melpa" . "http://melpa.org/packages/")                ;; Main package archive
                  ("melpa-stable" . "http://stable.melpa.org/packages/")  ;; For packages that only have stable releases
                  ("org-elpa" . "https://orgmode.org/elpa/")))            ;; Org packages

(package-initialize)

;; Ensure use-package is present (a macro for importing and installing packages).
;; Also refresh the package archive on load so we can pull the latest packages.
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t  ;; Downloads new packages
      use-package-verbose t)       ;; Logging for package installations in case something breaks

;;; Themes:

;; Dark gray with bold colors
(use-package one-themes
  :init
  (load-theme 'one-dark t))

;; Very low contrast
;; (use-package zenburn-theme
;;   :init
;;   (load-theme 'zenburn t))

;; Dark gray with muted colors, orange cursor
;; (use-package timu-spacegrey-theme
;;   :ensure t
;;   :config
;;   (load-theme 'timu-spacegrey t))

;; Favorite doom themes
;; (use-package doom-themes
;;   :init
;;   (load-theme 'doom-spacegrey))       ;; Gray with muted colors, orange cursor
;;   (load-theme 'doom-tomorrow-night))  ;; Dark gray/brown with neutral colors
;;   (load-theme 'doom-one))             ;; Blues and pinks
;;   (load-theme 'doom-oceanic-next))    ;; Dark greenish background
;;   (load-theme 'doom-solarized-dark))  ;; Solarized Dark
;;   (load-theme 'doom-material))        ;; Like Solarized Dark, very bright text
;;   (load-theme 'doom-nord))            ;; Nord colors, white is bright
;;   (load-theme 'doom-dark+))           ;; Visual Studio colors but brighter
;;   (load-theme 'doom-gruvbox))         ;; Very warm color temperatures
;;   (load-theme 'doom-city-lights))     ;; Very dark background, blues/greens
;;   (load-theme 'doom-opera))           ;; Gray/brown with pale cool colors
;;   (load-theme 'doom-snazzy))          ;; Dark purple background, bright text
;;   (load-theme 'doom-sourcerer))       ;; Dark browns

;;; Packages:

;; Show key map for partially complete commands
(use-package which-key
  :config
  (which-key-mode 1))

;; Retrieves environment variables from the shell
(use-package exec-path-from-shell
  :ensure t
  :config
  (exec-path-from-shell-initialize))

;; Move line/region up/down with M-<up> and M-<down>
(use-package drag-stuff
  :ensure t
  :config
  (drag-stuff-global-mode 1)
  (drag-stuff-define-keys))

;; Automatically pair certain characters
(use-package smartparens
  :ensure t
  :hook
  (prog-mode text-mode markdown-mode)  ;; Add `smartparens-mode` to these hooks
  :config
  ;; Load default config
  (require 'smartparens-config))

;; Multiple cursors
(use-package multiple-cursors
  :ensure t
  :bind (("C-S-c C-S-c" . mc/edit-lines)
         ("C->" . mc/mark-next-like-this)
         ("C-<" . mc/mark-previous-like-this)
         ("C-c C-<" . mc/mark-all-like-this)))

;; Completion framework for commands, files, etc.
(use-package ivy
  :ensure t
  :init
  (ivy-mode 1)
  (setq ivy-height 15
        ivy-use-virtual-buffers t
        ivy-use-selectable-prompt t))

;; Enhances commands
(use-package counsel
  :after ivy
  :init
  (counsel-mode 1)
  :bind (:map ivy-minibuffer-map))

;; Project management and navigation
(use-package projectile
  :init
  (projectile-mode t)
  :config
  (setq projectile-enable-caching t
        projectile-completion-system 'ivy))

;; Integrate Projectile into Ivy/Counsel
(use-package counsel-projectile
  :ensure t
  :init
  (counsel-projectile-mode))

;; Context-aware autocompletion
(use-package company
  :bind (("C-." . company-complete))
  :custom
  (company-idle-delay 0.4)  ;; In seconds
  (company-dabbrev-downcase nil "Don't downcase completion suggestions.")
  (company-show-numbers t "Show numbers next to suggestions.")
  (company-tooltip-limit 15 "Show up to 15 suggestions in the tooltip.")
  :config
  (global-company-mode)  ;; Enable completion everywhere
  (setq company-minimum-prefix-length 2)  ;; Start completing after 2 characters
  ;; Use numbers 0-9 to select Company completion candidates
  (let ((map company-active-map))
    (mapc (lambda (x) (define-key map (format "%d" x)
                                  `(lambda () (interactive) (company-complete-number ,x))))
          (number-sequence 0 9))))

;; Syntax and error checking (updated version of flymake)
(use-package flycheck
  :config
  (add-hook 'prog-mode-hook 'flycheck-mode)
  (add-hook 'after-init-hook #'global-flycheck-mode))

;; IDE-like features ("Language Server Protocol")
(use-package lsp-mode
  :commands lsp
  :config
  (setq lsp-prefer-flymake nil  ;; Flymake is outdated
        lsp-headerline-breadcrumb-mode nil))  ;; Disable header symbols
;; (use-package lsp-mode
;;   :commands (lsp lsp-deferred)
;;   :init
;;   (setq lsp-keymap-prefix "C-c l")
;;   :config
;;   (lsp-enable-which-key-integration t))

;; Better help pages
(use-package helpful
  :ensure t
  :after (ivy counsel)
  :config
  (setq counsel-describe-function-function #'helpful-callable
        counsel-describe-variable-function #'helpful-variable)
  :bind
  (("C-h f" . helpful-callable)
   ("C-h v" . helpful-variable)
   ("C-h k" . helpful-key)
   ("C-h x" . helpful-command)
   ("C-h F" . helpful-function)
   ("C-c C-d" . helpful-at-point)))

;; Allow quickly restarting emacs, with state saving
(use-package restart-emacs
  :ensure t
  :config
  (setq restart-emacs-restore-frames t)
  :bind ("C-c r" . restart-emacs))

;;; .emacs ends here
