# Plan: Rewrite b:aiplus::claude-code:menu.el for claude-code.el

## Context

The user is switching from the `claude-code-ide` Emacs package to `claude-code.el` (https://github.com/stevemolitor/claude-code.el). The file `b:aiplus::claude-code:menu.el` currently contains a verbatim copy of the `claude-code-ide` menu and must be completely rewritten to expose all commands from the new package as easymenu drop-down menus, following the established codebase pattern.

## Target File

`/bisos/git/auth/bxRepos/blee/aiplus/b:aiplus::claude-code:menu.el`

## Namespace

All `claude-ide` references become `claude-code`:
- Functions: `b:aiplus:claude-code:menu:plugin|install`, `b:aiplus:claude-code:menu|define`, `b:aiplus:claude-code:menu|update-hook`, `b:aiplus:claude-code:menuItem:*|define`
- Menu symbol: `b:aiplus:claude-code:menu`
- Provide: `(provide 'b:aiplus::claude-code:menu)`
- Titles: `"Claude Code Menu"` / `"AI-Plus :: Claude Code Menu"`

## Slot Assignment

| Slot | Content |
|------|---------|
| `(s-- 3)` | Transient trigger: `claude-code-transient` |
| `(s-- 4)` | Start/Stop group (8 items) |
| `(s-- 5)` | Send Commands group (7 items) |
| `(s-- 6)` | Manage (5 items) + Quick Responses (5 items) |
| `(s-- 7)` | Slash Commands nested submenu |
| `(s-- 8)` | Help: `b:menu:panelAndHelp|define` |

## Functions to Write (30 total)

### Infrastructure
1. `b:aiplus:claude-code:menu:plugin|install (<menuLabel <menuDelimiter)`
2. `b:aiplus:claude-code:menu|update-hook ()`
3. `b:aiplus:claude-code:menu|define (&rest <namedArgs)` — skeleton via `easy-menu-define`, then populate all slots

### (s-- 3) Transient trigger
4. `b:aiplus:claude-code:menuItem:transit-menu|define` → `(claude-code-transient)`

### (s-- 4) Start/Stop — use `dolist`
5. `menuItem:start|define` → `(claude-code)`
6. `menuItem:sandbox|define` → `(claude-code-sandbox)`
7. `menuItem:start-in-directory|define` → `(call-interactively 'claude-code-start-in-directory)`
8. `menuItem:continue|define` → `(claude-code-continue)`
9. `menuItem:resume|define` → `(claude-code-resume)`
10. `menuItem:new-instance|define` → `(call-interactively 'claude-code-new-instance)`
11. `menuItem:kill|define` → `(claude-code-kill)`
12. `menuItem:kill-all|define` → `(claude-code-kill-all)`

### (s-- 5) Send Commands — use `dolist`
13. `menuItem:send-command|define` → `(call-interactively 'claude-code-send-command)`
14. `menuItem:send-command-with-context|define` → `(call-interactively 'claude-code-send-command-with-context)`
15. `menuItem:send-region|define` → `(call-interactively 'claude-code-send-region)`
16. `menuItem:send-buffer-file|define` → `(claude-code-send-buffer-file)`
17. `menuItem:yank-media|define` → `(claude-code-yank-media)`
18. `menuItem:fix-error-at-point|define` → `(claude-code-fix-error-at-point)`
19. `menuItem:fork|define` → `(claude-code-fork)`

### (s-- 6) Manage + Quick Responses — use `dolist`
20. `menuItem:toggle|define` → `(claude-code-toggle)`
21. `menuItem:switch-to-buffer|define` → `(claude-code-switch-to-buffer)`
22. `menuItem:select-buffer|define` → `(claude-code-select-buffer)`
23. `menuItem:toggle-read-only-mode|define` → `(claude-code-toggle-read-only-mode)`
24. `menuItem:cycle-mode|define` → `(claude-code-cycle-mode)`
25. `menuItem:send-return|define` → `(claude-code-send-return)`
26. `menuItem:send-escape|define` → `(claude-code-send-escape)`
27. `menuItem:send-1|define` → `(claude-code-send-1)`
28. `menuItem:send-2|define` → `(claude-code-send-2)`
29. `menuItem:send-3|define` → `(claude-code-send-3)`

### (s-- 7) Slash Commands submenu
30. `b:aiplus:claude-code:menuItem:slash-commands|define` — returns a **list** (not `car` of vector), structured as:
```elisp
(list "Slash Commands -- /cmd"
  ["claude-code-slash-commands  -- Full Slash Commands Transient Menu"
   (claude-code-slash-commands) :help "..."]
  "--"
  ;; Core: /help /clear /compact /status /doctor
  ["/ help  -- Help" (claude-code-send-command "/help") :help "..."]
  ...
  "--"
  ;; Config: /config /init /memory /add-dir /terminal-setup
  "--"
  ;; Account: /login /logout /model /permissions /cost
  "--"
  ;; Dev Tools: /review /pr_comments /agents /vim /mcp
  "--"
  ;; Support: /bug
  )
```
This function returns a `list` (not a vector) so `easy-menu-add-item` registers it as a nested submenu.

### (s-- 8) Help — inline in `menu|define`
```elisp
(b:menu:panelAndHelp|define
 :panelName "/bisos/panels/blee-core/AI/claude-code/_nodeBase_"
 :funcName $thisFuncName
 :pkgRepoUrl "https://github.com/stevemolitor/claude-code.el")
```

## Key Implementation Notes

- `call-interactively` is used for commands that prompt (read from minibuffer, prompt for file/dir, detect region). Simple fire-and-forget commands use `(func)` directly.
- Slash command items use `(claude-code-send-command "/cmd")` — calling with a fixed string argument, NOT `call-interactively`.
- The interactive `send-command` menu item at slot 5 uses `call-interactively` so it prompts the user.
- File header: `;;;-*- mode: Emacs-Lisp; lexical-binding: t ; -*-`
- Top requires: `(require 'easymenu)` and `(require 'b:menu::panelAndHelp)`
- Interactive test comments above `plugin|install`: `;; (b:aiplus:claude-code:menu:plugin|install modes:menu:global (s-- 6))`
- Interactive test comments above `menu|define`: `;; (b:aiplus:claude-code:menu|define :active nil)` and `;; (popup-menu (symbol-value (b:aiplus:claude-code:menu|define)))`

## Verification

1. Load the file in Emacs: `M-x load-file RET b:aiplus::claude-code:menu.el`
2. Eval `(b:aiplus:claude-code:menu|define :active nil)` — should return `b:aiplus:claude-code:menu` without error
3. Eval `(popup-menu (symbol-value (b:aiplus:claude-code:menu|define)))` — should display the full menu
4. Install into a parent menu: `(b:aiplus:claude-code:menu:plugin|install modes:menu:global (s-- 6))` — menu should appear in menu bar
5. Verify slash commands submenu appears as a nested sub-menu under the main menu
6. Verify `(provide 'b:aiplus::claude-code:menu)` is the last form
