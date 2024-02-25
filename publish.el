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
       "<meta name='viewport' content='width=device-width, initial-scale=1'>\n"
       "<link rel='stylesheet' href='./css/tufte.css' />\n"
       "<link rel='stylesheet' href='./css/header.css' />\n"
       "<script src='js/cube.js'></script>"
       "       <!-- Google tag (gtag.js) -->
       <script async src='https://www.googletagmanager.com/gtag/js?id=G-LXHEWSS0SC'></script>
       <script>
       window.dataLayer = window.dataLayer || [];
       function gtag(){dataLayer.push(arguments);}
       gtag('js', new Date());

       gtag('config', 'G-LXHEWSS0SC');
       </script>"

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
             :publishing-function 'org-html-publish-to-html
             :publishing-directory "./public"
	     :with-toc nil
	     :section-numbers nil
	     
	     ;; the following removes extra headers from HTML output -- important!
	     :html-head nil ;; cleans up anything that would have been in there.
	     :html-head-extra my-blog-extra-head
	     :html-head-include-default-style nil
	     :html-head-include-scripts nil
             :html-preamble 'my-blog-header
             :html-postamble my-blog-footer
	     )
       (list "org-site:css"
	     :base-directory "./css"
	     :base-extension "css"
	     :publishing-directory "./public/css"
	     :publishing-function 'org-publish-attachment)
       (list "org-site:js"
	     :base-directory "./elm"
	     :base-extension "js"
	     :publishing-directory "./public/js"
	     :publishing-function 'org-publish-attachment)
       (list "org-site:images"
	     :base-directory "./posts/images"
	     :base-extension "png\\|jpg"
	     :publishing-directory "./public/images"
	     :publishing-function 'org-publish-attachment)
       ))    

;; Generate the site output
(org-publish-all t)

(message "Build complete!")
