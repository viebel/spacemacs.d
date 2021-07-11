(require 'parseclj)

(defun my-stuff-first-form ()
  (save-excursion
    (goto-char 1)
    (setq my-ff (parseclj-parse-clojure :read-one t))))


(defun my-stuff-children (form)
  (let (res)
    (while form
      (let ((elem (car form)))
        (if (eq :children (car elem))
            (progn
              (setq res (cdr elem))
              (setq form nil))))
      (setq form (cdr form)))
    res))

(defun my-stuff-node (form node-name)
  (let (res)
    (while form
      (let ((elem (car form)))
        (if (eq node-name (car elem))
            (progn
              (setq res (cdr elem))
              (setq form nil))))
      (setq form (cdr form)))
    res))

(defun my-stuff-ns-name ()
  (let ((first-form (my-stuff-first-form)))
    (symbol-name (my-stuff-node (second (my-stuff-node first-form :children))
                          :value))))

(defun my-stuff-rename-buffer-ns ()
  (interactive)
  (rename-buffer (my-stuff-ns-name)))
