; racket 05b.rkt

#lang racket

(define (check-one-rule rule update)
  (define i (index-of update (first rule)))
  (define j (index-of update (second rule)))
  (or (or (not i) (not j)) (< i j)))

(define (check-rules rules update)
  (if (empty? rules)
    #t
    (and (check-one-rule (car rules) update) (check-rules (cdr rules) update))))

(define (sort-by-rules rules update)
  (define (less-by-rules x y)
    (member (list x y) rules))
  (sort update less-by-rules))

(define (solve rules updates)
  (define (middle-or-zero update)
    (if (check-rules rules update)
      0
      (list-ref (sort-by-rules rules update) (quotient (length update) 2))))
  (apply + (map middle-or-zero updates)))

(define (parse-number-list line)
  (map string->number (string-split line #rx"\\||,")))

(define (parse-input part)
  (define line (read-line))
  (if (eof-object? line)
    (cons empty empty)
    (if (string=? line "")
      (parse-input 2)
      (let* ([rest (parse-input part)] [rules (car rest)] [updates (cdr rest)])
        (if (equal? part 1)
          (cons (cons (parse-number-list line) rules) updates)
          (cons rules (cons (parse-number-list line) updates)))))))

(define input (parse-input 1))
(solve (car input) (cdr input))
