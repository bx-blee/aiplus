;;;-*- mode: Emacs-Lisp; lexical-binding: t ; -*-
;;;
;;; Author: Mohsen BANAN --- 2023 --- Part Of Blee

(require 'easymenu)
(require 's)
(require 'bcf-general)

(require 'b:aiplus::gptel:canned)

;; (b:aiplus:gptel:canned:menu:plugin|install modes:menu:global (s-- 3))
(defun b:aiplus:gptel:canned:menu:plugin|install (<menuLabel <menuDelimiter)
  "Adds this as a submenu to menu labeled <menuLabel at specified delimited <menuDelimiter."

  (easy-menu-add-item
   <menuLabel
   nil
   (b:aiplus:gptel:canned:menu:select|define :active t)
   <menuDelimiter
   )
  )

;; (b:aiplus:gptel:translate:menu:plugin|install modes:menu:global (s-- 3))
(defun b:aiplus:gptel:translate:menu:plugin|install (<menuLabel <menuDelimiter)
  "Adds this as a submenu to menu labeled <menuLabel at specified delimited <menuDelimiter."

  (easy-menu-add-item
   <menuLabel
   nil
   (b:aiplus:gptel:translate:menu:select|define :active t)
   <menuDelimiter
   )
  )


;;
;; [[elisp:(popup-menu (symbol-value (browsers:menu:help|define)))][This Menu]]
;; (popup-menu (symbol-value (b:aiplus:gptel:canned:menu:select|define)))
;;
(defun b:aiplus:gptel:canned:menu:select|define (&rest <namedArgs)
  "Provide for control of CHATGPT related parameters, Returnb:aiplus:gptel:canned:menu:select menu.
:active and :visible can be specified as <namedArgs.
"
  (let (
	(<visible (get-arg <namedArgs :visible t))
	(<active (get-arg <namedArgs :active t))
	($thisFuncName (compile-time-function-name))
	)

    (easy-menu-define
     b:aiplus:gptel:canned:menu:select
      nil
      "Global Menu For GPTEL related facilities."
      `("AI-Plus :: GPTEL Canned Prompts on Region Menu"
	:help "Invoke GPTEL on region with prompt"
	,(s-- 3)
	,(s-- 4)
        [
	 "GPTEL Canned Prompt: Prompt (text)"
	 (call-interactively 'b:aiplus:gptel:canned:region/Prompt)
         :help "Put prompt in GPTEL buffer."
	 ]
	 [
	  "GPTEL Canned Prompt: Define Region (text)"
	  (call-interactively 'b:aiplus:gptel:canned:region/Define)
	  :help "asks GPTEL Canned Prompt: to Define the region."
	  ]
	 [
	  "GPTEL Canned Prompt: Spell Check Region (text)"
	  (call-interactively 'b:aiplus:gptel:canned:region/SpellCheck)
	  :help "asks GPTEL Canned Prompt: Spell Check the region."
	  ]
	 [
	  "GPTEL Canned Prompt: Proofread Region (text)"
	  (call-interactively 'b:aiplus:gptel:canned:region/Proofread)
	  :help "asks GPTEL Canned Prompt: to proofread  the region."
	  ]
	 [
	  "GPTEL Canned Prompt: Grammar Check Region (text)"
	  (call-interactively 'b:aiplus:gptel:canned:region/GrammarCheck)
	  :help "asks GPTEL Canned Prompt: to rewrite the region."
	  ]
	 [
	  "GPTEL Canned Prompt: Rewrite Region (text)"
	  (call-interactively 'b:aiplus:gptel:canned:region/Rewrite)
	  :help "asks GPTEL Canned Prompt: to rewrite the region."
	  ]
	 [
	  "GPTEL Canned Prompt: Fix Region (code)"
	  (call-interactively 'b:aiplus:gptel:canned:region/CodeFix)
	  :help "asks GPTEL Canned Prompt: to explain whats wrong with region."
	  ]
	 [
	  "GPTEL Canned Prompt: Explain Region (code)"
	  (call-interactively 'b:aiplus:gptel:canned:region/CodeExplain)
	  :help "asks GPTEL Canned Prompt: to explain what it does."
	  ]
	 [
	  "GPTEL Canned Prompt: Tests For Region (code)"
	  (call-interactively 'b:aiplus:gptel:canned:region/CodeTestCase)
	  :help "asks GPTEL Canned Prompt: to to write tests for region."
	  ]
	 [
	  "GPTEL Canned Prompt: Refactor Region (code)"
	  (call-interactively 'chatgpt-refactor-region)
	  :help "asks GPTEL Canned Prompt: to refactor region."
	  ]
	 [
	  "GPTEL Canned Prompt: Prompt Region (Any)"
	  (call-interactively 'chatgpt-prompt-region)
	  :help "asks GPTEL Canned Prompt: to prompt region."
	  ]
	 [
	  "GPTEL Canned Prompt: Prompt Region And Replace (Any)"
	  (call-interactively 'chatgpt-prompt-region-and-replace)
	  :help "Replace region with the response from the GPTEL Canned Prompt:."
	  ]

	 ,(s-- 7)
	 ,(s-- 8)
	 ))

    ;;;  "/bisos/git/auth/bxRepos/blee-binders/non-libre-halaal/GPTEL Canned Prompt:/_nodeBase_"

    (easy-menu-add-item
      b:aiplus:gptel:canned:menu:select nil
     (b:menu:panelAndHelp|define
      :panelName "/bisos/panels/blee-core/AI/gptel/_nodeBase_"
      :funcName $thisFuncName
      :pkgRepoUrl "https://github.com/karthink/gptel"
      )
     (s-- 8))
    
    'b:aiplus:gptel:canned:menu:select
    ))



;;
;; [[elisp:(popup-menu (symbol-value (browsers:menu:help|define)))][This Menu]]
;; (popup-menu (symbol-value (b:aiplus:gptel:translate:menu:select|define)))
;;
(defun b:aiplus:gptel:translate:menu:select|define (&rest <namedArgs)
  "Provide for control of CHATGPT related parameters, Returnb:aiplus:gptel:translate:menu:select menu.
:active and :visible can be specified as <namedArgs.
"
  (let (
	(<visible (get-arg <namedArgs :visible t))
	(<active (get-arg <namedArgs :active t))
	($thisFuncName (compile-time-function-name))
	)

    (easy-menu-define
     b:aiplus:gptel:translate:menu:select
      nil
      "Global Menu For GPTEL related facilities."
      `("AI-Plus :: GPTEL Prompts: Translate Region Menu"
	:help "Invoke ChatGpt Commands and Show And Set CHATGPT Related Parameters"
	,(s-- 3)
	,(s-- 4)
        [
	 "GPTEL Translate Region: English to French"
	 (call-interactively 'b:aiplus:gptel:translate:region/EnglishToFrench)
         :help "Query OpenAI with PROMPT calling the CALLBACK function on the resulting buffer."
	 ]
	 [
	  "GPTEL Translate Region: French to English"
	  (call-interactively 'b:aiplus:gptel:translate:region/FrenchToEnglish)
	  :help "asks GPTEL Translate Prompt: to Define the region."
	  ]
	 [
	  "GPTEL Translate Region: English to Farsi"
	  (call-interactively 'b:aiplus:gptel:translate:region/EnglishToFarsi)
	  :help "asks GPTEL Translate Prompt: to rewrite the region."
	  ]
	 [
	  "GPTEL Translate Region: Farsi to English"
	  (call-interactively 'b:aiplus:gptel:translate:region/FarsiToEnglish)
	  :help "asks GPTEL Translate Prompt: to proofread  the region."
	  ]

	 ,(s-- 7)
	 ,(s-- 8)
	 ))

    ;;;  "/bisos/git/auth/bxRepos/blee-binders/non-libre-halaal/GPTEL Translate Prompt:/_nodeBase_"

    (easy-menu-add-item
     b:aiplus:gptel:translate:menu:select nil
     (b:menu:panelAndHelp|define
      :panelName "/bisos/panels/blee-core/AI/gptel/_nodeBase_"
      :funcName $thisFuncName
      :pkgRepoUrl "https://github.com/karthink/gptel"
      )
     (s-- 8))

    'b:aiplus:gptel:translate:menu:select
    ))

(provide 'b:aiplus::gptel:canned:menu)
