#lang at-exp racket/base

(require racket/cmdline
         racket/format
         racket/path)

(define rac* (command-line #:args [racket-or-raco] racket-or-raco))
(define local-racket-binary
  (let search-up ([path (current-directory)])
    (define racket-binary-here (build-path path "racket" "bin" rac*))
    (cond [(and (file-exists? racket-binary-here)
                (member 'execute
                        (file-or-directory-permissions racket-binary-here)))
           racket-binary-here]
          [(regexp-match? #rx"^/$" path)
           #f]
          [else
           (search-up (simplify-path (build-path path "..")))])))
(define racket-path
  (or local-racket-binary
      (find-executable-path rac*)))
(displayln (~a (simple-form-path racket-path)))

