;;;-*- mode: Emacs-Lisp; lexical-binding: t ; -*-
;;;
;;;

(require 'easymenu)
(require 'b:menu::panelAndHelp)

;; (b:aiplus:monet:menu:plugin|install modes:menu:global (s-- 6))
(defun b:aiplus:monet:menu:plugin|install (<menuLabel <menuDelimiter)
  "Adds this as a submenu to menu labeled <menuLabel at specified delimited <menuDelimiter."

  (easy-menu-add-item
   <menuLabel
   nil
   (b:aiplus:monet:menu|define :active t)
   <menuDelimiter
   )

  (add-hook 'menu-bar-update-hook 'b:aiplus:monet:menu|update-hook)
  )

(defun b:aiplus:monet:menu|update-hook ()
  "This is to be added to menu-bar-update-hook.
It runs everytime any menu is invoked.
As such what happens below should be exactly what is necessary and no more."
  ;;(modes:menu:global|define)
  )

;;
;; (b:aiplus:monet:menu|define :active nil)
;; (popup-menu (symbol-value (b:aiplus:monet:menu|define)))
;;
(defun b:aiplus:monet:menu|define (&rest <namedArgs)
  "Returns b:aiplus:monet:menu.
:active can be specified as <namedArgs.
"
  (let (
	(<active (get-arg <namedArgs :active t))
	($thisFuncName (compile-time-function-name))
	)

    (easy-menu-define
      b:aiplus:monet:menu
      nil
      (format "Monet Menu")
      `(
	,(format "AI-Plus :: Monet Menu")
	:help "monet menu"
	:active ,<active
	:visible t
	,(s-- 3)
	,(s-- 4)
	,(s-- 5)
	,(s-- 6)
	,(s-- 7)
	,(s-- 8)
	,(s-- 9)
	))

    ;;; (s-- 3) — Mode toggle
    (easy-menu-add-item
     b:aiplus:monet:menu nil
     (b:aiplus:monet:menuItem:mode|define)
     (s-- 3))

    ;;; (s-- 4) — Server submenu
    (easy-menu-add-item
     b:aiplus:monet:menu nil
     (b:aiplus:monet:menuItem:server|define)
     (s-- 4))

    ;;; (s-- 5) — Interact submenu
    (easy-menu-add-item
     b:aiplus:monet:menu nil
     (b:aiplus:monet:menuItem:interact|define)
     (s-- 5))

    ;;; (s-- 6) — Logging submenu
    (easy-menu-add-item
     b:aiplus:monet:menu nil
     (b:aiplus:monet:menuItem:logging|define)
     (s-- 6))

    ;;; (s-- 7) — (reserved)
    ;;; (s-- 8) — (reserved)

    ;;; (s-- 9) — Help Sub-Menu (bxblee.blee-libs@b:menu)
    (easy-menu-add-item
     b:aiplus:monet:menu nil
     (b:menu:panelAndHelp|define
      :panelName "/bisos/panels/blee-core/AI/monet/_nodeBase_"
      :funcName $thisFuncName
      :pkgRepoUrl "https://github.com/stevemolitor/monet"
      )
     (s-- 9))

    'b:aiplus:monet:menu
    ))

;;; Mode toggle

(defun b:aiplus:monet:menuItem:mode|define ()
  (car `(
         [,(if monet-mode
               "Disable Monet Mode  -- monet-mode"
             "Enable Monet Mode  -- monet-mode")
          (monet-mode 'toggle)
          :help "Enable or disable Monet minor mode (MCP websocket integration)"
          ]
         )))

;;; Server submenu

(defun b:aiplus:monet:menuItem:server|define ()
  (list "Server"
        ["Start Server  -- monet-start-server"
         (monet-start-server)
         :help "Start a Monet MCP websocket server for Claude Code"]
        ["Start Server in Directory  -- monet-start-server (C-u)"
         (call-interactively 'monet-start-server)
         :help "Prompt for a directory then start a Monet MCP websocket server"]
        "--"
        ["Stop Server  -- monet-stop-server"
         (call-interactively 'monet-stop-server)
         :help "Stop a specific Monet websocket server session"]
        ["Stop All Servers  -- monet-stop-all-servers"
         (monet-stop-all-servers)
         :help "Stop all running Monet websocket servers"]
        "--"
        ["List Sessions  -- monet-list-sessions"
         (monet-list-sessions)
         :help "Display all active Monet MCP sessions with status"]
        ))

;;; Interact submenu

(defun b:aiplus:monet:menuItem:interact|define ()
  (list "Interact"
        ["Mention Region/Line  -- monet-mention-region"
         (monet-mention-region)
         :help "Send selected region or current line as @-mentioned context to Claude"]
        ))

;;; Logging submenu

(defun b:aiplus:monet:menuItem:logging|define ()
  (list "Logging"
        ["Enable Logging  -- monet-enable-logging"
         (monet-enable-logging)
         :help "Enable logging of Claude MCP communication to *Monet Log* buffer"]
        ["Disable Logging  -- monet-disable-logging"
         (monet-disable-logging)
         :help "Disable logging of Claude MCP communication"]
        ["Show Logs  -- display-buffer monet-log-buffer-name"
         (display-buffer monet-log-buffer-name)
         :help "Show the Monet Log buffer"]
        ))

(provide 'b:aiplus::monet:menu)
