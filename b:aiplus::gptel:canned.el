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

(defvar chatgpt-buffer "*AIPlus-Transcript*"
  "Title of the buffer used to store the results of an OpenAI API query.")


(defmacro chatgpt-show-results-buffer-if-active ()
  "Show the results in other window if necessary."
  `(if (and (not ;; visible
             (get-buffer-window chatgpt-buffer))
	    (called-interactively-p 'interactive))
       (lambda (&optional buf) (ignore buf)
         (with-current-buffer buf
           (save-excursion (fill-region (point-min) (point-max)))
           (view-mode t))
         (switch-to-buffer-other-window chatgpt-buffer))
     #'identity))


(defun display-buffer-and-recenter (buffer)
  "Display BUFFER, move point to end, and recenter the buffer's window."
  (let ((win (display-buffer buffer)))
    (when (window-live-p win)
      (with-selected-window win
        (with-current-buffer buffer
          (goto-char (point-max))
          (recenter))))))


(defun b:aiplus:gptel:canned|responseProcess (buffer prompt response)
  "Store a response in a well known buffer we can look at if we want"
  (let ((buffer (get-buffer-create buffer)))
    (with-current-buffer buffer
      ;;(erase-buffer)

      (goto-char (point-max))
      (insert "\n\n==================\n\n")
      (insert prompt)
      (insert "\n\n-->\n\n")
      (insert response)
      (goto-char (point-max))
      )
    (chatgpt-show-results-buffer-if-active)
    (display-buffer-and-recenter buffer)
    )
  )

(defun b:aiplus:gptel:canned:region/withPrompt (<start <end <prompt)
  "Use ChatGPT to define the current word of the region."
  (interactive "r")
  (unless (region-active-p)
    (error "you must have a region set"))
  (let ((input (buffer-substring-no-properties <start <end)))
    (gptel-request nil
      :callback (lambda (response info)
                  (b:aiplus:gptel:canned|responseProcess chatgpt-buffer (plist-get info :context) response)
                  ;;(message response)
                  )
      :system <prompt
      :context input)))

(defun b:aiplus:gptel:canned:region/Define (<start <end)
  "Use ChatGPT to define the current word of the region."
  (interactive "r")
  (b:aiplus:gptel:canned:region/withPrompt <start <end b:aiplus:gptel:prompt:wordDefine))

(defun b:aiplus:gptel:canned:region/Rewrite (<start <end)
  "Takes a region BEG to END asks ChatGPT to rewrite the region.
The answer in the displays in `chatgpt-buffer'."
  (interactive "r")
  (b:aiplus:gptel:canned:region/withPrompt <start <end "Rewrite"))


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
