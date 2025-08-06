(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(tsdh-dark))
 '(package-selected-packages
   '(jekyll-modes markdown-mode eglot matlab-mode xclip cmake-mode auctex jdee slime-volleyball slime))
 '(warning-suppress-log-types '((comp))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-latex-bold-face ((t nil)))
 '(font-latex-doctex-documentation-face ((t nil)))
 '(font-latex-doctex-preprocessor-face ((t nil)))
 '(font-latex-italic-face ((t nil)))
 '(font-latex-math-face ((t nil)))
 '(font-latex-sectioning-0-face ((t nil)))
 '(font-latex-sectioning-1-face ((t nil)))
 '(font-latex-sectioning-2-face ((t nil)))
 '(font-latex-sectioning-3-face ((t nil)))
 '(font-latex-sectioning-4-face ((t nil)))
 '(font-latex-sectioning-5-face ((t nil)))
 '(font-latex-sedate-face ((t nil)))
 '(font-latex-slide-title-face ((t nil)))
 '(font-latex-string-face ((t nil)))
 '(font-latex-subscript-face ((t nil)))
 '(font-latex-superscript-face ((t nil)))
 '(font-latex-verbatim-face ((t nil)))
 '(font-latex-warning-face ((t nil))))

;;; Add this at the top of the init.el file:
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

(setq cursor-type 'box)
(setq visible-cursor t)
(setq inferior-lisp-program "sbcl")

(add-to-list 'custom-theme-load-path "/home/mufaro/.emacs.d/themes/firebelly/")
(load-theme 'firebelly t)

(setq backup-directory-alist
      `(("." . ,(expand-file-name
                 (concat user-emacs-directory "backups")))))

(require 'slime)
(slime-setup)

(defun my-slime-keybindings ()
  "For use in `slime-mode-hook' and 'slime-repl-mode-hook."
  (local-set-key (kbd "C-l") 'slime-repl-clear-buffer))

(add-hook 'slime-mode-hook      #'my-slime-keybindings)
(add-hook 'slime-repl-mode-hook #'my-slime-keybindings)



(setq font-latex-fontify-sectioning 0)  ;; Disable section title styling
(setq font-latex-fontify-script nil)    ;; Disable superscript/subscript formatting
(setq font-latex-fontify-quotes nil)    ;; Disable quote prettification

(add-hook 'TeX-mode-hook #'my/plain-tex-mode-setup)
(add-hook 'LaTeX-mode-hook #'my/plain-tex-mode-setup)

(defun copy-current-line ()
  "Copy the current line to the kill ring."
  (interactive)
  (kill-ring-save (line-beginning-position) (line-beginning-position 2)))
(global-set-key (kbd "C-c l") 'copy-current-line)
(windmove-default-keybindings)

(xclip-mode)

(define-derived-mode coalton-mode lisp-mode "Coalton"
  "Major mode for editing Coalton language embedded in Common Lisp."
  (font-lock-add-keywords
   nil
   '(("\\<\\(define\\|define-type\\|lambda\\|let\\|match\\|if\\|then\\|else\\|case\\|type\\|fn\\|struct\\|derive\\)\\>" . font-lock-keyword-face)
     ("\\<\\(Int\\|Integer\\|Bool\\|String\\|Unit\\|Option\\|Either\\|Array\\|List\\|Char\\|Float\\|Double\\|U8\\|U16\\|U32\\|U64\\|I8\\|I16\\|I32\\|I64\\)\\>" . font-lock-type-face)
     ("[0-9]+" . font-lock-constant-face))))
