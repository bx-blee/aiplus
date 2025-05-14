;;; gptelDefine.el --- Description -*- lexical-binding: t; -*-

;;; Was taken from
;;; https://github.com/benjisimon/elisp/blob/main/bs-fns.el
;;; and adapted for Blee.

(require 'gptel)

(defvar b:aiplus:gptel:prompt:wordDefine
  "Please give a short definition of this word or phrase. Then, provide 3 usage examples, synonyms and antyonyms"
  "The ChatGPT style prompt used define a word.")

(setq  b:aiplus:gptel:prompt:wordDefine
  "Please give a short definition of this word or phrase. Then, provide 3 usage examples, synonyms and antyonyms also translate to farsi and french"
  )

(defun b:aiplus:gptel:canned|responseProcess (buffer prompt response)
  "Store a response in a well known buffer we can look at if we want"
  (let ((buffer (get-buffer-create buffer)))
    (with-current-buffer buffer
      (erase-buffer)
      (insert prompt)
      (insert "\n\n-->\n\n")
      (insert response))))

(defun b:aiplus:gptel:canned/regionWithPrompt (start end <prompt)
  "Use ChatGPT to define the current word of the region."
  (interactive "r")
  (unless (region-active-p)
    (error "you must have a region set"))
  (let ((input (buffer-substring-no-properties (region-beginning) (region-end))))
    (gptel-request nil
      :callback (lambda (response info)
                  (b:aiplus:gptel:canned|responseProcess "*Last Definition*" (plist-get info :context) response)
                  (message response))
      :system <prompt
      :context input)))

(defun b:aiplus:gptel:canned/regionDefine (start end)
  "Use ChatGPT to define the current word of the region."
  (interactive "r")
  (b:aiplus:gptel:canned/regionWithPrompt start end b:aiplus:gptel:prompt:wordDefine))

(provide 'b:aiplus::gptel:canned)
;;; gptelDefine.el ends here
