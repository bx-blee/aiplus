;;; gptelDefine.el --- Description -*- lexical-binding: t; -*-

;;;
;;; Was taken from
;;; https://github.com/benjisimon/elisp/blob/main/bs-fns.el
;;; and adapted for Blee.
;;; Then more code was taken from Gavin Jaeger-Freeborn
;;; 

(require 'gptel)

(defvar b:aiplus:gptel:prompt:wordDefine
  "Please give a short definition of this word or phrase. Then, provide 3 usage examples, synonyms and antyonyms"
  "The ChatGPT style prompt used define a word.")

(setq  b:aiplus:gptel:prompt:wordDefine
  "Give a short definition of this word or phrase. Then, provide 3 usage examples, synonyms and antyonyms also translate to farsi and french"
  )

(defvar chatgpt-buffer "*ChatGPT*"
  "Title of the buffer used to store the results of an OpenAI API query.")

(defun b:aiplus/gptel ()
  (interactive)
  (gptel chatgpt-buffer)
  )


(cl-defun b:aiplus:gptel:canned:region/withPrompt (
                                                   <start
                                                <end
                                                <prompt
                                                &key
                                                (dontSend nil)
                                                )
  "Use ChatGPT to define the current word of the region."
  (interactive "r")
  (unless (region-active-p)
    (error "you must have a region set"))

  (let (($input (buffer-substring-no-properties <start <end))
        ($buffer (get-buffer chatgpt-buffer))
        ($gptWin (get-buffer-window chatgpt-buffer 'visible))
        ($here)
        )
    (unless $buffer
      (call-interactively 'b:aiplus/gptel))
    (unless $gptWin
      (display-buffer chatgpt-buffer))
    (with-selected-window $gptWin
      (with-current-buffer $buffer
        (unless dontSend
          (goto-char (point-max))
          (insert <prompt)
          (insert ":")
          (insert $input)
          (goto-char (point-max))
          (gptel-send)
          (goto-char (point-max))
          (recenter)
          )
        (when dontSend
          (setq $here (point-max))
          (goto-char $here)
          (insert $input)
          (goto-char $here)
          (recenter)
          )
        ))
   ))

(defun b:aiplus:gptel:canned:region/Prompt (<start <end)
  "Put prompt in GPTEL buffer."
  (interactive "r")
  (b:aiplus:gptel:canned:region/withPrompt <start <end nil :dontSend t))

(defun b:aiplus:gptel:canned:region/Define (<start <end)
  "Use ChatGPT to define the current word of the region."
  (interactive "r")
  (b:aiplus:gptel:canned:region/withPrompt <start <end b:aiplus:gptel:prompt:wordDefine))

(defun b:aiplus:gptel:canned:region/SpellCheck (<start <end)
  "Takes a region BEG to END asks ChatGPT to rewrite the region.
The answer in the displays in `chatgpt-buffer'."
  (interactive "r")
  (b:aiplus:gptel:canned:region/withPrompt <start <end "Spell check only, don't change otherwise, enumerate mistakes"))

(defun b:aiplus:gptel:canned:region/GrammarCheck (<start <end)
  "Takes a region BEG to END asks ChatGPT to Grammar Check the region.
The answer in the displays in `chatgpt-buffer'."
  (interactive "r")
  (b:aiplus:gptel:canned:region/withPrompt <start <end "Grammar and spelling check:"))

(defun b:aiplus:gptel:canned:region/Proofread (<start <end)
  "Takes a region BEG to END asks ChatGPT to proofread the region.
The answer in the displays in `chatgpt-buffer'."
  (interactive "r")
  (b:aiplus:gptel:canned:region/withPrompt <start <end "proofread:"))

(defun b:aiplus:gptel:canned:region/Rewrite (<start <end)
  "Takes a region BEG to END asks ChatGPT to rewrite the region.
The answer in the displays in `chatgpt-buffer'."
  (interactive "r")
  (b:aiplus:gptel:canned:region/withPrompt <start <end "Rewrite"))


(defun b:aiplus:gptel:canned:region/CodeFix (<start <end)
  "Takes a region BEG to END asks ChatGPT to explain whats wrong with it.
It then displays the answer in the `chatgpt-buffer'."
  (interactive "r")
  (b:aiplus:gptel:canned:region/withPrompt <start <end "Why doesn't this code work?"))


(defun b:aiplus:gptel:canned:region/CodeExplain (<start <end)
  "Takes a region BEG to END asks ChatGPT to explain what it does.
The answer in the displays in `chatgpt-buffer'."
  (interactive "r")
  (b:aiplus:gptel:canned:region/withPrompt <start <end "What does this code do?"))

(defun b:aiplus:gptel:canned:region/CodeTestCase (<start <end)
  "Takes a region BEG to END asks ChatGPT to write a test for it.
It then displays the answer in the `chatgpt-buffer'."
  (interactive "r")
  (b:aiplus:gptel:canned:region/withPrompt <start <end "Write me a tests for this code"))

;;;
;;; Human Language Translations
;;;

(defun b:aiplus:gptel:translate:region/EnglishToFrench (<start <end)
  (interactive "r")
  (b:aiplus:gptel:canned:region/withPrompt <start <end "Translate From English to French."))

(defun b:aiplus:gptel:translate:region/FrenchToEnglish (<start <end)
  (interactive "r")
  (b:aiplus:gptel:canned:region/withPrompt <start <end "Translate From French to English."))

(defun b:aiplus:gptel:translate:region/EnglishToFarsi (<start <end)
  (interactive "r")
  (b:aiplus:gptel:canned:region/withPrompt <start <end "Translate From English to Farsi."))

(defun b:aiplus:gptel:translate:region/FarsiToEnglish (<start <end)
  (interactive "r")
  (b:aiplus:gptel:canned:region/withPrompt <start <end "Translate From Farsi to English."))



(provide 'b:aiplus::gptel:canned)
;;; gptelDefine.el ends here
