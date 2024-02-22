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
;; (package-install 'ox-tufte)

(require 'ox-publish)

;; customize the HTML output
(setq org-html-validation-link nil	;; Don't show validation link
      org-html-head-include-scripts nil	;; Use our own scripts
      org-html-head-include-default-style nil ;; Use our own styles
      org-html-head "
	<link rel=\"stylesheet\" type=\"text/css\" href=\"./css/tufte.css\"/>
  	<script src=\"js/main.js\"></script>
")

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
	     :html-link-up "index.html"
	     :html-link-home "index.html"
             :section-numbers nil       ;; Don't include section numbers
             :time-stamp-file nil)	;; Don't include time stamp in file
       (list "org-site:css"
	     :base-directory "./css"
	     :base-extension "css"
	     :publishing-directory "./public/css"
	     :publishing-function 'org-publish-attachment
	     :htmlized-source t
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
