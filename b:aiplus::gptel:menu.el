;;;-*- Mode: Emacs-Lisp; lexical-binding: t ; -*-
;;;
;;;

(require 'easymenu)
(require 'cl-lib)  ;; For using cl functions like cl-loop, cl-letf, etc.
(require 'gptel)   ;; Ensure gptel functions are available
(require 'subr-x)  ;; For using string manipulation functions like string-trim

(require 'compile-time-function-name)
(require 'b:aiplus::gptel:canned:menu)

;; (b:aiplus:gptel:menu:plugin|install modes:menu:global (s-- 6))
(defun b:aiplus:gptel:menu:plugin|install (<menuLabel <menuDelimiter)
  "Adds this as a submenu to menu labeled <menuLabel at specified delimited <menuDelimiter."

  (easy-menu-add-item
   <menuLabel
   nil
   (b:aiplus:gptel:menu|define :active t)
   <menuDelimiter
   )

  (add-hook 'menu-bar-update-hook 'b:aiplus:gptel:menu|update-hook)
  )

(defun b:aiplus:gptel:menu|update-hook ()
  "This is to be added to menu-bar-update-hook.
It runs everytime any menu is invoked.
As such what happens below should be exactly what is necessary and no more."
  ;;(modes:menu:global|define)
  )

;;
;; (b:aiplus:gptel:menu|define :active nil)
;; (popup-menu (symbol-value (b:aiplus:gptel:menu|define)))
;;
(defun b:aiplus:gptel:menu|define (&rest <namedArgs)
  "Returns b:aiplus:gptel:menu.
:active can be specified as <namedArgs.
"
  (let (
	(<active (get-arg <namedArgs :active t))
	($thisFuncName (compile-time-function-name))
	)

    (easy-menu-define
      b:aiplus:gptel:menu
      nil
      (format "Gptel Menu")
      `(
	,(format "AI-Plus :: Gptel Menu")
	:help "gptel menu"
	:active ,<active
	:visible t
	,(s-- 3)
	,(s-- 4)
	,(s-- 5)
	,(s-- 6)
	,(s-- 7)
	,(s-- 8)
	))

   (b:aiplus:gptel:canned:menu:plugin|install
     b:aiplus:gptel:menu (s-- 3))

   (b:aiplus:gptel:translate:menu:plugin|install
     b:aiplus:gptel:menu (s-- 3))

    
    (dolist (item '(b:aiplus:gptel:menuItem:gptel|define
                    b:aiplus:gptel:menuItem:gptel-send|define
                    b:aiplus:gptel:menuItem:gptel-rewrite|define))
      (easy-menu-add-item
       b:aiplus:gptel:menu nil
       (funcall item)
       (s-- 4)))

   (dolist (item '(b:aiplus:gptel:menuItem:gptel-menu|define))
      (easy-menu-add-item
       b:aiplus:gptel:menu nil
       (funcall item)
       (s-- 5)))

   (dolist (item '(b:aiplus:gptel:menuItem:gptel-add|define
                    b:aiplus:gptel:menuItem:gptel-add-file|define))
      (easy-menu-add-item
       b:aiplus:gptel:menu nil
       (funcall item)
       (s-- 6)))


   (dolist (item '(b:aiplus:gptel:menuItem:gptel-org-set-topic|define
                    b:aiplus:gptel:menuItem:gptel-org-set-properties|define))
      (easy-menu-add-item
       b:aiplus:gptel:menu nil
       (funcall item)
       (s-- 7)))

   (easy-menu-add-item
    b:aiplus:gptel:menu nil
    (b:aiplus:gptel:menuItem:gptel-quick|define)
    (s-- 7))


   (easy-menu-add-item
    b:aiplus:gptel:menu nil
    (b:menu:panelAndHelp|define
      :panelName "/bisos/panels/blee-core/AI/gptel/_nodeBase_"
      :funcName $thisFuncName
      :pkgRepoUrl "https://github.com/karthink/gptel"
      )
     (s-- 8))

    'b:aiplus:gptel:menu
    ))

(defun b:aiplus:gptel:menuItem:gptel|define ()
  (car `(
    [,(format "gptel  -- Create Dedicate Chat Buffer Send Query (with C-c En)")
     (gptel)
     :help "Create a new dedicated chat buffer. Not required to use gptel."
     ]
    )))

(defun b:aiplus:gptel:menuItem:gptel-send|define ()
  (car `(
    [,(format "gptel-send  -- Send Query")
     (gptel-send)
     :help "Send all text up to point, or the selection if region is active. Works anywhere in Emacs."
     ]
    )))

(defun b:aiplus:gptel:menuItem:gptel-rewrite|define ()
  (car `(
    [,(format "gptel-rewrite  -- Rewrite Region")
     (gptel-rewrite)
     :help "Rewrite, refactor or change the selected region. Can diff/ediff changes before merging/applying."
     ]
    )))

(defun b:aiplus:gptel:menuItem:gptel-menu|define ()
  (car `(
    [,(format "gptel-menu  -- Preferences Menu")
     (gptel-menu)
     :help "Transient menu for preferences, input/output redirection etc."
     ]
    )))

(defun b:aiplus:gptel:menuItem:gptel-add|define ()
  (car `(
    [,(format "gptel-add  -- Add Context")
     (gptel-add)
     :help "Add/remove a region or buffer to gptel's context. In Dired, add/remove marked files."
     ]
    )))

(defun b:aiplus:gptel:menuItem:gptel-add-file|define ()
  (car `(
    [,(format "gptel-add-file  -- Add File to Context")
     (gptel-add-file)
     :help "Add a file (text or supported media type) to gptel's context. Also available from the transient menu."
     ]
    )))

(defun b:aiplus:gptel:menuItem:gptel-org-set-topic|define ()
  (car `(
    [,(format "gptel-org-set-topic  -- Set Org Topic")
     (gptel-org-set-topic)
     :help "Limit conversation context to an Org heading."
     ]
    )))

(defun b:aiplus:gptel:menuItem:gptel-org-set-properties|define ()
  (car `(
    [,(format "gptel-org-set-properties  -- Set Org Properties")
     (gptel-org-set-properties)
     :help "Write gptel configuration as Org properties, for per-heading chat configuration."
     ]
    )))

(defun b:aiplus:gptel:menuItem:gptel-quick|define ()
  (car `(
    [,(format "gptel-quick  -- Lookup point or region")
     (gptel-quick)
     :help "gptel-quick: Quick LLM lookups in Emacs."
     ]
    )))


(provide 'b:aiplus::gptel:menu)
