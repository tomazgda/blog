;; Set the package installation directory so that packages aren't stored in the
;; ~/.emacs.d/elpa path.
(require 'package)
(setq package-user-dir (expand-file-name "./.packages"))
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

;; Initialize the package system
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Install dependencies
(package-install 'htmlize)

(require 'ox-publish)

;; define headers, footers and ensure that the right style sheets are used
(setq my-blog-extra-head
      (concat
       "<link rel='stylesheet' href='./css/tufte.css' />\n"
       "<link rel='stylesheet' href='./css/header.css' />\n"
       "<script src='js/cube.js'></script>"
       ))

(setq my-blog-header-file "../templates/header.html")
(defun my-blog-header (arg)
  (with-temp-buffer
    (insert-file-contents my-blog-header-file)
    (buffer-string)))

(setq my-blog-footer
"<hr />\n
Bring back the blogosphere!")

;; Define the publishing project
(setq org-publish-project-alist
      (list
       (list "org-site:main"
             :recursive t
             :base-directory "./posts"
	     :auto-sitemap t
	     :sitemap-filename "sitemap.org"
             :publishing-function 'org-html-publish-to-html
             :publishing-directory "./public"
	     :author "Tomaz Geddes de Almeida"
             :section-numbers nil       ;; Don't include section numbers
             :time-stamp-file nil	;; Don't include time stamp in file
	     
	     ;; the following removes extra headers from HTML output -- important!
	     :html-link-home "/"
	     :html-head nil ;; cleans up anything that would have been in there.
	     :html-head-extra my-blog-extra-head
	     :html-head-include-default-style nil
	     :html-head-include-scripts nil
	     :html-viewport nil
	     :html-link-up ""
             :html-link-home ""
             :html-preamble 'my-blog-header
             :html-postamble my-blog-footer
	     :with-toc nil
	     :with-date t
	     )
       (list "org-site:css"
	     :base-directory "./css"
	     :base-extension "css"
	     :publishing-directory "./public/css"
	     :publishing-function 'org-publish-attachment
	     )
       (list "org-site:js"
	     :base-directory "./elm"
	     :base-extension "js"
	     :publishing-directory "./public/js"
	     :publishing-function 'org-publish-attachment )
       ))    

;; Generate the site output
(org-publish-all t)

(message "Build complete!")
