;;;-*- mode: Emacs-Lisp; lexical-binding: t ; -*-
;;;
;;;

(require 'easymenu)
(require 'b:menu::panelAndHelp)

;; (b:aiplus:claude-ide:menu:plugin|install modes:menu:global (s-- 6))
(defun b:aiplus:claude-ide:menu:plugin|install (<menuLabel <menuDelimiter)
  "Adds this as a submenu to menu labeled <menuLabel at specified delimited <menuDelimiter."

  (easy-menu-add-item
   <menuLabel
   nil
   (b:aiplus:claude-ide:menu|define :active t)
   <menuDelimiter
   )

  (add-hook 'menu-bar-update-hook 'b:aiplus:claude-ide:menu|update-hook)
  )

(defun b:aiplus:claude-ide:menu|update-hook ()
  "This is to be added to menu-bar-update-hook.
It runs everytime any menu is invoked.
As such what happens below should be exactly what is necessary and no more."
  ;;(modes:menu:global|define)
  )

;;
;; (b:aiplus:claude-ide:menu|define :active nil)
;; (popup-menu (symbol-value (b:aiplus:claude-ide:menu|define)))
;;
(defun b:aiplus:claude-ide:menu|define (&rest <namedArgs)
  "Returns b:aiplus:claude-ide:menu.
:active can be specified as <namedArgs.
"
  (let (
	(<active (get-arg <namedArgs :active t))
	($thisFuncName (compile-time-function-name))
	)

    (easy-menu-define
      b:aiplus:claude-ide:menu
      nil
      (format "Claude Code IDE Menu")
      `(
	,(format "AI-Plus :: Claude Code IDE Menu")
	:help "claude-code-ide menu"
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
     b:aiplus:claude-ide:menu nil
     (b:aiplus:claude-ide:menuItem:transit-menu|define)
     (s-- 3))

    (easy-menu-add-item
     b:aiplus:claude-ide:menu nil
     (b:aiplus:claude-ide:menuItem:start|define)
     (s-- 4))

    ;;; Help Sub-Menu (bxblee.blee-libs@b:menu)
    ;;;
    (easy-menu-add-item
     b:aiplus:claude-ide:menu nil
     (b:menu:panelAndHelp|define
      :panelName "/bisos/panels/blee-core/AI/claude-code-ide/_nodeBase_"
      :funcName $thisFuncName
      :pkgRepoUrl "https://github.com/manzaltu/claude-code-ide.el"
      )
     (s-- 8))

    'b:aiplus:claude-ide:menu
    ))

(defun b:aiplus:claude-ide:menuItem:transit-menu|define ()
  (car `(
         [,(format "claude-code-ide-menu")
          (claude-code-ide-menu)
          :help "claude-code-ide-menu"
          ]
         )))

(defun b:aiplus:claude-ide:menuItem:start|define ()
  (car `(
         [,(format "claude-code-ide")
          (claude-code-ide)
          :help "claude-code-ide start"
          ]
         )))

(provide 'b:aiplus::claude-ide:menu)
