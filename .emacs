(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(fringe-mode (quote (1 . 1)) nil (fringe))
 '(indicate-buffer-boundaries nil)
 '(overflow-newline-into-fringe t)
 '(scroll-bar-mode (quote right)))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:stipple nil :background "white" :foreground "black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 98 :width normal :foundry "unknown" :family "Liberation Mono"))))
 '(font-lock-builtin-face ((((class color) (min-colors 88) (background light)) (:foreground "dark red"))))
 '(font-lock-comment-face ((((class color) (min-colors 88) (background light)) (:foreground "gray70"))))
 '(font-lock-doc-face ((t (:foreground "Gray70"))))
 '(font-lock-function-name-face ((((class color) (min-colors 88) (background light)) (:foreground "Black"))))
 '(font-lock-keyword-face ((((class color) (min-colors 88) (background light)) (:foreground "black" :weight extra-bold))))
 '(font-lock-preprocessor-face ((t (:inherit font-lock-builtin-face))))
 '(font-lock-string-face ((((class color) (min-colors 88) (background light)) (:foreground "DodgerBlue3"))))
 '(font-lock-variable-name-face ((((class color) (min-colors 88) (background light)) (:foreground "CadetBlue4"))))
 '(linum ((t (:inherit (shadow default)))))
 '(mode-line ((t (:background "gray30" :foreground "white" :box (:line-width -1 :style released-button)))))
 '(mode-line-inactive ((default (:inherit mode-line)) (((class color) (min-colors 88) (background light)) (:background "grey50" :foreground "grey90" :box (:line-width -1 :color "grey75") :weight light))))
 '(region ((((class color) (min-colors 88) (background light)) (:background "SteelBlue3" :foreground "White")))))
(global-linum-mode 1)
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
(global-set-key (kbd "C-c C-c") 'comment-region)
(global-auto-revert-mode 1)