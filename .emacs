(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(frame-background-mode (quote light))
 '(fringe-mode (quote (1 . 1)) nil (fringe))
 '(indicate-buffer-boundaries nil)
 '(overflow-newline-into-fringe t)
 '(scroll-bar-mode (quote right))
 '(sp-autodelete-closing-pair nil)
 '(sp-autodelete-opening-pair nil)
 '(sp-autodelete-pair nil))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:stipple nil :background "white" :foreground "black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 98 :width normal :foundry "unknown" :family "Liberation Mono"))))
 '(font-lock-builtin-face ((((class color) (min-colors 88) (background light)) (:foreground "dark red"))))
 '(font-lock-comment-delimiter-face ((default (:inherit font-lock-comment-face)) (((class color) (min-colors 16)) nil)))
 '(font-lock-comment-face ((((class color) (min-colors 88) (background light)) (:foreground "#0077ff" :slant italic :weight bold))))
 '(font-lock-doc-face ((t (:foreground "Gray70"))))
 '(font-lock-function-name-face ((((class color) (min-colors 88) (background light)) (:foreground "Black"))))
 '(font-lock-keyword-face ((((class color) (min-colors 88) (background light)) (:foreground "black" :weight extra-bold))))
 '(font-lock-preprocessor-face ((t (:inherit font-lock-builtin-face))))
 '(font-lock-string-face ((((class color) (min-colors 88) (background light)) (:foreground "DodgerBlue3"))))
 '(font-lock-variable-name-face ((((class color) (min-colors 88) (background light)) (:foreground "CadetBlue4"))))
 '(linum ((t (:inherit (shadow default)))))
 '(mode-line ((t (:background "gray30" :foreground "white" :box (:line-width -1 :style released-button)))))
 '(mode-line-inactive ((default (:inherit mode-line)) (((class color) (min-colors 88) (background light)) (:background "grey50" :foreground "grey90" :box (:line-width -1 :color "grey75") :weight light))))
 '(region ((((class color) (min-colors 88) (background light)) (:background "SteelBlue3" :foreground "White"))))
 '(scroll-bar ((t nil))))

;; Custom settings
(global-linum-mode 1)
(global-set-key (kbd "C-c C-c") 'comment-region)
(global-set-key (kbd "C-c C-u") 'uncomment-region)
(global-set-key (kbd "RET") 'newline-and-indent)
(tool-bar-mode -1)

   ;; cl-lib
(add-to-list 'load-path "/home/nick/.emacs.d/cl-lib/")
(require 'cl-lib)

   ;; Auto-Complete-Mode addition
(add-to-list 'load-path "/home/nick/.emacs.d/")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "/home/nick/.emacs.d//ac-dict")
(ac-config-default)
;; dirty fix for having AC everywhere
(define-globalized-minor-mode real-global-auto-complete-mode
  auto-complete-mode (lambda ()
                       (if (not (minibufferp (current-buffer)))
                           (auto-complete-mode 1))
                       ))

(real-global-auto-complete-mode t)

;; Dash addition (required for smartparens)
(add-to-list 'load-path "/home/nick/.emacs.d/dash")

;; Smartparens addition
(add-to-list 'load-path "/home/nick/.emacs.d/smartparens")
(require 'smartparens)
(smartparens-global-mode 1)

;; no splash screen displayed
(setq inhibit-splash-screen t)
;; no scratch message
(setq initial-scratch-message nil)
;; allow line wrap in split screen mode
(setq truncate-partial-width-windows nil)
;; switch on match bracket
(show-paren-mode)
;; No tabs!
(setq-default indent-tabs-mode nil)
;; Revert
(global-auto-revert-mode t)

;; Set frame title to the buffer and directory
(defun dev-frame-title (title)
  "Set frame title to:- title + ": " + full file path for current buffer."
  (interactive "sSet frame title to: ")
  (setq frame-title title)
  (setq frame-title-format '((concat "" frame-title) ": " (buffer-file-name "%f" (dired-directory dired-directory "%b"))))
)

(defun dev-term (&optional user)
  "Open ansi term"
  (interactive)
  (ansi-term "/bin/bash")
  ;; rename buffer to "*cp" or buffer_name if provided.
  (if (and user (not (string= user "")))
    (progn
       (insert (concat "sudo su - " user))
       (term-send-input)
       (rename-buffer (concat "*" user) 1))
    (rename-buffer "*term" 1)
  ) 
)

(defun dev-shell (&optional user)
  "Open shell"
  (interactive)
  (shell)
  ;; rename buffer to "*cp" or buffer_name if provided.
  (if (and user (not (string= user "")))
    (progn
       (insert (concat "sudo su - " user))
       (comint-send-input)
       (rename-buffer (concat "*" user) 1))
    (rename-buffer "*term" 1)
  ) 
)

(defun dev-psql (db &optional buffer_name)
  "Open ansi-term and connect to psql db."
  (interactive "sConnect to db: ")
  (shell)
  (insert (concat "psql " db))
  (comint-send-input)
  ;; rename buffer to "*psql" or buffer_name if provided.
  (if (and buffer_name (not (string= buffer_name "")))
    (rename-buffer (concat "*" buffer_name) 1)
    (rename-buffer "*psql" 1)
  )
)

(defun dev-tclsh (&optional buffer_name)
  "Open shell and run tclsh."
  (shell)
  (insert (concat "tclsh"))
  (comint-send-input)
  ;; rename buffer to "*tclsh" or buffer_name if provided.
  (if (and buffer_name (not (string= buffer_name "")))
    (rename-buffer (concat "*" buffer_name) 1)
    (rename-buffer "*tclsh" 1)
  )
)

;; Set initial frame width/height and position
(defun arrange-frame (w h x y)
  "Set the width, height, and x/y position of the current frame"
  (let ((frame (selected-frame)))
    (delete-other-windows)
    (set-frame-position frame x y)
    (set-frame-size frame w h)
  )
)
 
(arrange-frame 200 300 0 0)