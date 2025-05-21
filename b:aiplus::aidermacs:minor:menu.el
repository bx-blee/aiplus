;;;-*- mode: Emacs-Lisp; lexical-binding: t ; -*-
;;;
;;;

(require 'easymenu)
(require 'b:menu::panelAndHelp)

;;
;; (b:aiplus:aidermacs:menu|define :active nil)
;; (popup-menu (symbol-value (b:aiplus:aidermacs:minor:menu|define)))
;;
(defun b:aiplus:aidermacs:minor:menu|define ()
  "Returns b:aiplus:aidermacs:menu.
:active can be specified as <namedArgs.
"
  (let (
	($thisFuncName (compile-time-function-name))
	)

    (easy-menu-define
      b:aiplus:aidermacs:minor:menu
      aidermacs-minor-mode-map
      (format "Aidermacs")
      `(
	,(format "Aidermacs")
	:help "Aidermacs Minor Mode Menu"
	"---"
	 [
	  "Aidermacs:: C-<return>      aidermacs-send-line-or-region"
	  (call-interactively 'aidermacs-send-line-or-region)
	  :help "Aidermacs::C-<return>      aidermacs-send-line-or-region"
	  ]
         ["Aidermacs:: C-c C-c         aidermacs-send-block-or-region"
	  (call-interactively 'aidermacs-send-block-or-region)
	  :help "Aidermacs:: C-c C-c         aidermacs-send-block-or-region"
	  ]
	 [
	  "Aidermacs:: C-c C-n         aidermacs-send-line-or-region"
	  (call-interactively 'aidermacs-send-line-or-region)
	  :help "Aidermacs:: C-c C-n         aidermacs-send-line-or-region"
	  ]
         ["Aidermacs:: C-c C-z         aidermacs-switch-to-buffer"
	  (call-interactively 'aidermacs-send-block-or-region)
	  :help "Aidermacs:: C-c C-z         aidermacs-switch-to-buffer"
	  ]
	"-----"
	))

    ;;; Help Sub-Menu (bxblee.blee-libs@b:menu)
    ;;;
    (easy-menu-add-item
     b:aiplus:aidermacs:minor:menu nil
     (b:menu:panelAndHelp|define
      :panelName "/bisos/panels/blee-core/AI/aidermacs/_nodeBase_"
      :funcName $thisFuncName
      :pkgRepoUrl "https://github.com/MatthewZMD/aidermacs"
      )
     (s-- 8))

    'b:aiplus:aidermacs:minor:menu
    ))

(b:aiplus:aidermacs:minor:menu|define)

(provide 'b:aiplus::aidermacs:minor:menu)
