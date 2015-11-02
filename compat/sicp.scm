;;;
;;;  compat.sicp - some compatibility routines for those learning SICP
;;;

(define-module compat.sicp
  (export nil false get put get-coercion put-coercion
          cons-stream))

;; This doesn't make nil as a boolean false, but in SICP nil is exclusively
;; used to denote an empty list, so it's ok.
(define nil '())

;; Section 2.3
;; Boolean false
(define false #f)

;; Section 2.4
;; Symbol properties - a naive implementation
(define *properties* (make-hash-table 'eq?))

(define (put op type item)
  (hash-table-update! *properties* op (^p (assoc-set! p type item)) '()))
(define (get op type)
  (assoc-ref (hash-table-get *properties* op '()) type #f))

;; Section 2.5

(define *coercions* (make-hash-table 'equal?))

(define (put-coercion from to proc)
  (hash-table-put! *coercions* (cons from to) proc))
(define (get-coercion from to)
  (hash-table-get *coercions* (cons from to) #f))

;; Section 3.5.1

(define-syntax cons-stream
  (syntax-rules ()
    [(_ a d) (cons a (delay d))]))
