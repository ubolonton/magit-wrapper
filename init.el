;;; Load paths
(let ((init-dir (getenv "COGINI_EMACS")))
  (unless (equal "/" (substring init-dir -1))
    (setq init-dir (concat init-dir "/")))
  (mapcar (lambda (dir)
            (add-to-list 'load-path
                         (concat init-dir dir)))
          '("" "magit")))

;;; My theme rulez
(require 'ubolonton-dark)
(color-theme-ubolonton-dark)

;;; ido-mode, flex matching FTW
(require 'ido)
(ido-mode t)
(setq ido-enable-prefix nil
      ido-enable-flex-matching t
      ido-create-new-buffer 'always
      ido-use-filename-at-point 'guess
      ido-max-prospects 10)
(setq ido-decorations '( "" "" "
" "
..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]"))
(ido-everywhere t)
(defvar ido-enable-replace-completing-read t)
(defadvice completing-read
  (around use-ido-when-possible activate)
  (if (or (not ido-enable-replace-completing-read)
          (and (boundp 'ido-cur-list) ido-cur-list)
          )  ; Avoid infinite loop from ido calling this
      ad-do-it
    (let ((allcomp (all-completions "" collection predicate)))
      (if allcomp
          (setq ad-return-value
                (ido-completing-read
                 prompt
                 allcomp
                 nil require-match initial-input hist def))
        ad-do-it))))

;;; The main thing
(require 'magit)
(setq magit-diff-options '("-w"))
(setq magit-status-buffer-switch-function 'switch-to-buffer)

;;; Key bindings
(defadvice ido-setup-completion-map (after set-ido-up-down-keys activate)
  (define-key ido-completion-map (kbd "<down>") 'ido-next-match)
  (define-key ido-completion-map (kbd "<up>") 'ido-prev-match))
(define-key global-map (kbd "S-<up>") 'windmove-up)
(define-key global-map (kbd "S-<down>") 'windmove-down)
(define-key global-map (kbd "S-<left>") 'windmove-left)
(define-key global-map (kbd "S-<right>") 'windmove-right)

;;; Some options to make life easier
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(defalias 'yes-or-no-p 'y-or-n-p)
(setq ediff-split-window-function 'split-window-horizontally)
(setq split-height-threshold nil)
(setq split-width-threshold 80)

;;; Invoke magit, finally
(call-interactively 'magit-status)

