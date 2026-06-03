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

    ;;; (s-- 3) — Transient menu trigger
    (easy-menu-add-item
     b:aiplus:claude-ide:menu nil
     (b:aiplus:claude-ide:menuItem:transit-menu|define)
     (s-- 3))

    ;;; (s-- 4) — Session Management
    (dolist (item '(b:aiplus:claude-ide:menuItem:start|define
                    b:aiplus:claude-ide:menuItem:continue|define
                    b:aiplus:claude-ide:menuItem:resume|define
                    b:aiplus:claude-ide:menuItem:stop|define
                    b:aiplus:claude-ide:menuItem:list-sessions|define))
      (easy-menu-add-item
       b:aiplus:claude-ide:menu nil
       (funcall item)
       (s-- 4)))

    ;;; (s-- 5) — Navigation
    (dolist (item '(b:aiplus:claude-ide:menuItem:switch-to-buffer|define
                    b:aiplus:claude-ide:menuItem:toggle-window|define
                    b:aiplus:claude-ide:menuItem:toggle-recent|define))
      (easy-menu-add-item
       b:aiplus:claude-ide:menu nil
       (funcall item)
       (s-- 5)))

    ;;; (s-- 6) — Interaction
    (dolist (item '(b:aiplus:claude-ide:menuItem:insert-at-mentioned|define
                    b:aiplus:claude-ide:menuItem:send-prompt|define
                    b:aiplus:claude-ide:menuItem:send-escape|define
                    b:aiplus:claude-ide:menuItem:insert-newline|define))
      (easy-menu-add-item
       b:aiplus:claude-ide:menu nil
       (funcall item)
       (s-- 6)))

    ;;; (s-- 7) — Config / Debug submenus
    (dolist (item '(b:aiplus:claude-ide:menuItem:config-menu|define
                    b:aiplus:claude-ide:menuItem:debug-menu|define))
      (easy-menu-add-item
       b:aiplus:claude-ide:menu nil
       (funcall item)
       (s-- 7)))

    ;;; (s-- 8) — Help Sub-Menu (bxblee.blee-libs@b:menu)
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

;;; Transient menu trigger

(defun b:aiplus:claude-ide:menuItem:transit-menu|define ()
  (car `(
         [,(format "claude-code-ide-menu  -- Full Transient Menu")
          (claude-code-ide-menu)
          :help "Open the full claude-code-ide transient menu"
          ]
         )))

;;; Session Management

(defun b:aiplus:claude-ide:menuItem:start|define ()
  (car `(
         [,(format "claude-code-ide  -- Start New Session")
          (claude-code-ide--start-if-no-session)
          :help "Start a new Claude Code session (no-op if session already running)"
          ]
         )))

(defun b:aiplus:claude-ide:menuItem:continue|define ()
  (car `(
         [,(format "claude-code-ide-continue  -- Continue Most Recent Conversation")
          (claude-code-ide--continue-if-no-session)
          :help "Continue most recent conversation (no-op if session already running)"
          ]
         )))

(defun b:aiplus:claude-ide:menuItem:resume|define ()
  (car `(
         [,(format "claude-code-ide-resume  -- Resume Previous Session")
          (claude-code-ide--resume-if-no-session)
          :help "Resume session from previous conversation (no-op if session already running)"
          ]
         )))

(defun b:aiplus:claude-ide:menuItem:stop|define ()
  (car `(
         [,(format "claude-code-ide-stop  -- Stop Current Session")
          (claude-code-ide-stop)
          :help "Stop the current Claude Code session"
          ]
         )))

(defun b:aiplus:claude-ide:menuItem:list-sessions|define ()
  (car `(
         [,(format "claude-code-ide-list-sessions  -- List All Sessions")
          (claude-code-ide-list-sessions)
          :help "List all active Claude Code sessions"
          ]
         )))

;;; Navigation

(defun b:aiplus:claude-ide:menuItem:switch-to-buffer|define ()
  (car `(
         [,(format "claude-code-ide-switch-to-buffer  -- Switch to Claude Buffer")
          (claude-code-ide-switch-to-buffer)
          :help "Switch to the Claude Code vterm buffer"
          ]
         )))

(defun b:aiplus:claude-ide:menuItem:toggle-window|define ()
  (car `(
         [,(format "claude-code-ide-toggle-window  -- Toggle Window Visibility")
          (claude-code-ide-toggle-window)
          :help "Toggle visibility of the Claude Code window"
          ]
         )))

(defun b:aiplus:claude-ide:menuItem:toggle-recent|define ()
  (car `(
         [,(format "claude-code-ide-toggle-recent  -- Toggle Recent Window")
          (claude-code-ide-toggle-recent)
          :help "Toggle the most recently used Claude Code window"
          ]
         )))

;;; Interaction

(defun b:aiplus:claude-ide:menuItem:insert-at-mentioned|define ()
  (car `(
         [,(format "claude-code-ide-insert-at-mentioned  -- Insert Selection")
          (claude-code-ide-insert-at-mentioned)
          :help "Insert current selection into Claude Code at the @-mention point"
          ]
         )))

(defun b:aiplus:claude-ide:menuItem:send-prompt|define ()
  (car `(
         [,(format "claude-code-ide-send-prompt  -- Send Prompt from Minibuffer")
          (claude-code-ide-send-prompt)
          :help "Read a prompt from the minibuffer and send it to Claude Code"
          ]
         )))

(defun b:aiplus:claude-ide:menuItem:send-escape|define ()
  (car `(
         [,(format "claude-code-ide-send-escape  -- Send Escape Key")
          (claude-code-ide-send-escape)
          :help "Send an escape key to the Claude Code terminal"
          ]
         )))

(defun b:aiplus:claude-ide:menuItem:insert-newline|define ()
  (car `(
         [,(format "claude-code-ide-insert-newline  -- Insert Newline")
          (claude-code-ide-insert-newline)
          :help "Insert a newline in the Claude Code terminal without sending"
          ]
         )))

;;; Config / Debug submenus

(defun b:aiplus:claude-ide:menuItem:config-menu|define ()
  (car `(
         [,(format "claude-code-ide-config-menu  -- Configuration")
          (claude-code-ide-config-menu)
          :help "Open the Claude Code configuration transient menu"
          ]
         )))

(defun b:aiplus:claude-ide:menuItem:debug-menu|define ()
  (car `(
         [,(format "claude-code-ide-debug-menu  -- Debugging")
          (claude-code-ide-debug-menu)
          :help "Open the Claude Code debug transient menu"
          ]
         )))

(provide 'b:aiplus::claude-ide:menu)
