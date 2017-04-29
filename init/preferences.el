;; NO WELCOME SCREEN
(setq inhibit-startup-screen t)

;;TABS

(setq-default tab-width 2
							c-basic-offset 2
							indent-tabs-mode t)

;; FONTS
(defun font-exists-p (font)
	"check if font exists"
	(if (null (x-list-fonts font))
			nil t))
(defun set-font-if-exists (font)
	"set font if it exists"
	(if (font-exists-p font)
			(set-face-attribute 'default nil :font font)))

(when window-system
	(set-face-attribute 'default nil :font "Monospace-12")
	(set-font-if-exists "Consolas-13")
	(set-font-if-exists "Ubuntu Mono-13"))

;; do not confirm a new file or buffer
(setq confirm-nonexistent-file-or-buffer nil)

;; ENCONDING
(prefer-coding-system 'utf-8)

;; LINE NUMBERS
(global-linum-mode)
;; (setq linum-format "%4d\u2502 ")
(setq linum-format "%4d ")

;; HIGHLIGHT CURRENT LINE
(use-package hl-line
  :init
  (progn
    (global-hl-line-mode 1))
  :diminish 'highlight-parentheses-mode)

;; MAXIMIZED SCREEN
(require 'maxframe)
(when window-system
	(run-with-idle-timer 0.1 nil 'maximize-frame))

;; TEMP FILES LOCATION
;; Save all tempfiles in $TMPDIR/emacs$UID/
(defconst emacs-tmp-dir (format "%s/%s%s/" temporary-file-directory "emacs" (user-uid)))
(setq backup-directory-alist
      `((".*" . ,emacs-tmp-dir)))
(setq auto-save-file-name-transforms
      `((".*" ,emacs-tmp-dir t)))
(setq auto-save-list-file-prefix
      emacs-tmp-dir)

;; NO TOOLBAR
(tool-bar-mode -1)

;; NO SCROLLBAR
(scroll-bar-mode -1)

;; I HATE THOSE ALARMS
(setq ring-bell-function 'ignore)

;; BAR CURSOR
(setq-default cursor-type 'bar)

;; DELETE REGION
(delete-selection-mode 1)

;;BINDININGS
(global-set-key [f5] (lambda ()
                       (interactive)
                       (revert-buffer nil t)))


(defun px-raise-frame-and-give-focus (_)
  (when window-system
    (run-with-idle-timer
		 0.1 nil (lambda ()
							 (raise-frame)
							 (x-focus-frame (selected-frame))
							 (maximize-frame (selected-frame))
							 (print "Focused")))))

(add-hook 'after-make-frame-functions #'px-raise-frame-and-give-focus)
