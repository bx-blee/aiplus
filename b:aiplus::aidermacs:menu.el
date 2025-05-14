;;;-*- mode: Emacs-Lisp; lexical-binding: t ; -*-
;;;
;;;

(require 'easymenu)
(require 'b:menu)

;; (b:aiplus:aidermacs:menu:plugin|install modes:menu:global (s-- 6))
(defun b:aiplus:aidermacs:menu:plugin|install (<menuLabel <menuDelimiter)
  "Adds this as a submenu to menu labeled <menuLabel at specified delimited <menuDelimiter."

  (easy-menu-add-item
   <menuLabel
   nil
   (b:aiplus:aidermacs:menu|define :active t)
   <menuDelimiter
   )

  (add-hook 'menu-bar-updae-hook 'b:aiplus:aidermacs:menu|update-hook)
  )

(defun b:aiplus:aidermacs:menu|update-hook ()
  "This is to be added to menu-bar-update-hook.
It runs everytime any menu is invoked.
As such what happens below should be exactly what is necessary and no more."
  ;;(modes:menu:global|define)
  )

;;
;; (b:aiplus:aidermacs:menu|define :active nil)
;; (popup-menu (symbol-value (b:aiplus:aidermacs:menu|define)))
;;
(defun b:aiplus:aidermacs:menu|define (&rest <namedArgs)
  "Returns b:aiplus:aidermacs:menu.
:active can be specified as <namedArgs.
"
  (let (
	(<active (get-arg <namedArgs :active t))
	($thisFuncName (compile-time-function-name))
	)

    (easy-menu-define
      b:aiplus:aidermacs:menu
      nil
      (format "Aidermacs Menu")
      `(
	,(format "Aidermacs Menu")
	:help "aidermacs menu"
	:active ,<active
	:visible t
	,(s-- 3)
	,(s-- 4)
	,(s-- 5)
	,(s-- 6)
	,(s-- 7)
	,(s-- 8)
	))

    (easy-menu-add-item
     b:aiplus:aidermacs:menu nil
     (b:aiplus:aidermacs:menuItem:transit-menu|define)
     (s-- 3))

    ;;; Help Sub-Menu (bxblee.blee-libs@b:menu)
    ;;;
    (easy-menu-add-item
     b:aiplus:aidermacs:menu nil
     (b:menu:panelAndHelp|define
      :panelName "/bisos/panels/blee-core/AI/aidermacs/_nodeBase_"
      :funcName $thisFuncName
      :pkgRepoUrl "https://github.com/MatthewZMD/aidermacs"
      )
     (s-- 8))

    'b:aiplus:aidermacs:menu
    ))

(defun b:aiplus:aidermacs:menuItem:transit-menu|define ()
  (car `(
         [,(format "aidermacs-transient-menu")
          (aidermacs-transient-menu)
          :help "aidermacs-transient-menu"
          ]
         )))

(provide 'b:aiplus:aidermacs:menu)
