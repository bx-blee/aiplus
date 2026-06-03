;;;-*- mode: Emacs-Lisp; lexical-binding: t ; -*-
;;;
;;;

(require 'easymenu)
(require 'b:menu::panelAndHelp)

;; (b:aiplus:claude-code:menu:plugin|install modes:menu:global (s-- 6))
(defun b:aiplus:claude-code:menu:plugin|install (<menuLabel <menuDelimiter)
  "Adds this as a submenu to menu labeled <menuLabel at specified delimited <menuDelimiter."

  (easy-menu-add-item
   <menuLabel
   nil
   (b:aiplus:claude-code:menu|define :active t)
   <menuDelimiter
   )

  (add-hook 'menu-bar-update-hook 'b:aiplus:claude-code:menu|update-hook)
  )

(defun b:aiplus:claude-code:menu|update-hook ()
  "This is to be added to menu-bar-update-hook.
It runs everytime any menu is invoked.
As such what happens below should be exactly what is necessary and no more."
  ;;(modes:menu:global|define)
  )

;;
;; (b:aiplus:claude-code:menu|define :active nil)
;; (popup-menu (symbol-value (b:aiplus:claude-code:menu|define)))
;;
(defun b:aiplus:claude-code:menu|define (&rest <namedArgs)
  "Returns b:aiplus:claude-code:menu.
:active can be specified as <namedArgs.
"
  (let (
	(<active (get-arg <namedArgs :active t))
	($thisFuncName (compile-time-function-name))
	)

    (easy-menu-define
      b:aiplus:claude-code:menu
      nil
      (format "Claude Code Menu")
      `(
	,(format "AI-Plus :: Claude Code Menu")
	:help "claude-code menu"
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

    ;;; (s-- 3) — Transient menu trigger
    (easy-menu-add-item
     b:aiplus:claude-code:menu nil
     (b:aiplus:claude-code:menuItem:transit-menu|define)
     (s-- 3))

    ;;; (s-- 4) — Launch submenu
    (easy-menu-add-item
     b:aiplus:claude-code:menu nil
     (b:aiplus:claude-code:menuItem:launch|define)
     (s-- 4))

    ;;; (s-- 5) — Navigate submenu
    (easy-menu-add-item
     b:aiplus:claude-code:menu nil
     (b:aiplus:claude-code:menuItem:navigate|define)
     (s-- 5))

    ;;; (s-- 6) — Interact submenu
    (easy-menu-add-item
     b:aiplus:claude-code:menu nil
     (b:aiplus:claude-code:menuItem:interact|define)
     (s-- 6))

    ;;; (s-- 7) — Slash Commands submenu
    (easy-menu-add-item
     b:aiplus:claude-code:menu nil
     (b:aiplus:claude-code:menuItem:slash|define)
     (s-- 7))

    ;;; (s-- 8) — Terminal submenu
    (easy-menu-add-item
     b:aiplus:claude-code:menu nil
     (b:aiplus:claude-code:menuItem:terminal|define)
     (s-- 8))

    ;;; (s-- 9) — Help Sub-Menu (bxblee.blee-libs@b:menu)
    (easy-menu-add-item
     b:aiplus:claude-code:menu nil
     (b:menu:panelAndHelp|define
      :panelName "/bisos/panels/blee-core/AI/claude-code/_nodeBase_"
      :funcName $thisFuncName
      :pkgRepoUrl "https://github.com/stevemolitor/claude-code.el"
      )
     (s-- 9))

    'b:aiplus:claude-code:menu
    ))

;;; Transient menu trigger

(defun b:aiplus:claude-code:menuItem:transit-menu|define ()
  (car `(
         [,(format "Full Transient Menu  -- claude-code-transient")
          (claude-code-transient)
          :help "Open the full claude-code transient menu"
          ]
         )))

;;; Launch submenu

(defun b:aiplus:claude-code:menuItem:launch|define ()
  (list "Launch"
        ["Start Claude  -- claude-code"
         (claude-code)
         :help "Start Claude Code in a terminal"]
        ["Start Sandboxed  -- claude-code-sandbox"
         (claude-code-sandbox)
         :help "Start Claude Code in a sandboxed environment"]
        ["Start in Directory  -- claude-code-start-in-directory"
         (call-interactively 'claude-code-start-in-directory)
         :help "Prompt for a directory then start Claude Code"]
        "--"
        ["Continue Previous Conversation  -- claude-code-continue"
         (claude-code-continue)
         :help "Resume previous conversation with --continue flag"]
        ["Resume Specific Session  -- claude-code-resume"
         (claude-code-resume)
         :help "Resume a specific session with --resume flag"]
        ["New Named Instance  -- claude-code-new-instance"
         (call-interactively 'claude-code-new-instance)
         :help "Create a new Claude Code instance with a prompted name"]
        "--"
        ["Kill Current Instance  -- claude-code-kill"
         (claude-code-kill)
         :help "Kill the current Claude Code instance"]
        ["Kill All Instances  -- claude-code-kill-all"
         (claude-code-kill-all)
         :help "Kill all Claude Code instances"]
        ))

;;; Navigate submenu

(defun b:aiplus:claude-code:menuItem:navigate|define ()
  (list "Navigate"
        ["Toggle Window Visibility  -- claude-code-toggle"
         (claude-code-toggle)
         :help "Show or hide the Claude Code window"]
        ["Switch to Claude Buffer  -- claude-code-switch-to-buffer"
         (claude-code-switch-to-buffer)
         :help "Switch to the Claude Code buffer"]
        ["Select Claude Buffer  -- claude-code-select-buffer"
         (claude-code-select-buffer)
         :help "Select a Claude Code buffer from all instances"]
        ))

;;; Interact submenu

(defun b:aiplus:claude-code:menuItem:interact|define ()
  (list "Interact"
        ["Send Command from Minibuffer  -- claude-code-send-command"
         (call-interactively 'claude-code-send-command)
         :help "Read a command from the minibuffer and send it to Claude Code"]
        ["Send Command with File/Line Context  -- claude-code-send-command-with-context"
         (call-interactively 'claude-code-send-command-with-context)
         :help "Send a command with current file and line number context"]
        ["Send Region/Buffer  -- claude-code-send-region"
         (call-interactively 'claude-code-send-region)
         :help "Send the active region or buffer to Claude Code"]
        ["Send Current File  -- claude-code-send-buffer-file"
         (claude-code-send-buffer-file)
         :help "Send the current buffer's file to Claude Code with @ prefix"]
        ["Paste Image from Clipboard  -- claude-code-yank-media"
         (claude-code-yank-media)
         :help "Paste an image from the clipboard into Claude Code (Emacs 29+)"]
        ["Fix Error at Point  -- claude-code-fix-error-at-point"
         (claude-code-fix-error-at-point)
         :help "Ask Claude Code to fix the error at the cursor position"]
        ["Jump to Previous Conversation  -- claude-code-fork"
         (claude-code-fork)
         :help "Jump to a previous conversation branch"]
        ))

;;; Slash Commands submenu

(defun b:aiplus:claude-code:menuItem:slash|define ()
  (list "Slash"
        ;; Core
        ["/help  -- Help and Documentation"
         (claude-code-send-command "/help")
         :help "Send /help slash command"]
        ["/clear  -- Clear Conversation"
         (claude-code-send-command "/clear")
         :help "Send /clear slash command"]
        ["/compact  -- Compact Conversation"
         (claude-code-send-command "/compact")
         :help "Send /compact slash command"]
        ["/status  -- Show Status"
         (claude-code-send-command "/status")
         :help "Send /status slash command"]
        ["/doctor  -- Run Diagnostics"
         (claude-code-send-command "/doctor")
         :help "Send /doctor slash command"]
        "--"
        ;; Config/Setup
        ["/config  -- Configuration"
         (claude-code-send-command "/config")
         :help "Send /config slash command"]
        ["/init  -- Initialize Project"
         (claude-code-send-command "/init")
         :help "Send /init slash command"]
        ["/memory  -- Memory Management"
         (claude-code-send-command "/memory")
         :help "Send /memory slash command"]
        ["/add-dir  -- Add Directory"
         (claude-code-send-command "/add-dir")
         :help "Send /add-dir slash command"]
        ["/terminal-setup  -- Terminal Setup"
         (claude-code-send-command "/terminal-setup")
         :help "Send /terminal-setup slash command"]
        "--"
        ;; Account/Model
        ["/login  -- Login"
         (claude-code-send-command "/login")
         :help "Send /login slash command"]
        ["/logout  -- Logout"
         (claude-code-send-command "/logout")
         :help "Send /logout slash command"]
        ["/model  -- Select Model"
         (claude-code-send-command "/model")
         :help "Send /model slash command"]
        ["/permissions  -- Manage Permissions"
         (claude-code-send-command "/permissions")
         :help "Send /permissions slash command"]
        ["/cost  -- Show Cost"
         (claude-code-send-command "/cost")
         :help "Send /cost slash command"]
        "--"
        ;; Dev Tools
        ["/review  -- Code Review"
         (claude-code-send-command "/review")
         :help "Send /review slash command"]
        ["/pr_comments  -- PR Comments"
         (claude-code-send-command "/pr_comments")
         :help "Send /pr_comments slash command"]
        ["/agents  -- Manage Agents"
         (claude-code-send-command "/agents")
         :help "Send /agents slash command"]
        ["/vim  -- Vim Mode"
         (claude-code-send-command "/vim")
         :help "Send /vim slash command"]
        ["/mcp  -- MCP Tools"
         (claude-code-send-command "/mcp")
         :help "Send /mcp slash command"]
        "--"
        ;; Support
        ["/bug  -- Report Bug"
         (claude-code-send-command "/bug")
         :help "Send /bug slash command"]
        ))

;;; Terminal submenu

(defun b:aiplus:claude-code:menuItem:terminal|define ()
  (list "Terminal"
        ["Confirm (Send Return)  -- claude-code-send-return"
         (claude-code-send-return)
         :help "Send Return key to confirm a Claude Code action"]
        ["Deny (Send Escape)  -- claude-code-send-escape"
         (claude-code-send-escape)
         :help "Send Escape key to deny a Claude Code action"]
        ["Send Menu Option 1  -- claude-code-send-1"
         (claude-code-send-1)
         :help "Send \"1\" for menu option selection"]
        ["Send Menu Option 2  -- claude-code-send-2"
         (claude-code-send-2)
         :help "Send \"2\" for menu option selection"]
        ["Send Menu Option 3  -- claude-code-send-3"
         (claude-code-send-3)
         :help "Send \"3\" for menu option selection"]
        "--"
        ["Cycle Claude Modes  -- claude-code-cycle-mode"
         (claude-code-cycle-mode)
         :help "Cycle through Claude Code modes via Shift-Tab: Default, Auto-accept edits, Plan"]
        ["Toggle Read-Only Mode  -- claude-code-toggle-read-only-mode"
         (claude-code-toggle-read-only-mode)
         :help "Toggle read-only mode for the Claude Code buffer"]
        ))

(provide 'b:aiplus::claude-code:menu)
