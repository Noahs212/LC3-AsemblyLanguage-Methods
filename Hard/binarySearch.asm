

;; Pseudocode:

;; Nodes are blocks of size 3 in memory:

;; The data is located in the 1st memory location
;; The node's left child address is located in the 2nd memory location
;; The node's right child address is located in the 3rd memory location

;; Binary Search

;;    binarySearch(Node root (addr), int data) {
;;        if (root == 0) {
;;            return 0;
;;        }
;;        if (data == root.data) {
;;            return root;
;;        }
;;        if (data < root.data) {
;;            return binarySearch(root.left, data);
;;        }
;;        return binarySearch(root.right, data);
;;    }

.orig x3000
    ;; you do not need to write anything here
HALT

binary_search   ;; please do not change the name of your subroutine
    ;; insert your implementation for binarySearch subroutine
    ;; always -4
ADD R6, R6, -4 ; Allocate space
STR R7, R6, 2 ; Save Ret Addr
STR R5, R6, 1 ; Save Old FP
ADD R5, R6, 0 ; Copy SP to FP
ADD R6, R6, -5 ; Make room for saved regs & l.v. 1-n ;; subtract 5 + (n-1) n is num local vars
STR  R0, R5, -1 ; Save R0
STR  R1, R5, -2 ; Save R1
STR  R2, R5, -3 ; Save R2
STR  R3, R5, -4 ; Save R3
STR  R4, R5, -5 ; Save R4

;; EXTRACT ARGUMENTS argument n = R5 + 4 in order
LDR R0, R5, 4 ;; root adr
LDR R1, R5, 5 ;; int data

;; PERFORM Subroutine
;; STORE Locals at R5, 0 + n
;;if (root == 0) {
;;return 0;
;;}
ADD R0, R0, 0
BRnp ENDIF1
    STR R0, R5, 3
    BR END
ENDIF1

;;if (data == root.data) {
;;return root;
;;}
LDR R2, R0, 0
AND R3, R3, 0
NOT R3, R2
ADD R3, R3, 1
ADD R3, R3, R1
BRnp ENDIF2
    STR R0, R5, 3
    BR END
ENDIF2


;;if (data < root.data) {
;;return binarySearch(root.left, data);
;;}
AND R3, R3, 0
NOT R3, R2
ADD R3, R3, 1
ADD R3, R3, R1
BRzp ENDIF3
    ;;return binarySearch(root.left, data);
    ADD R6, R6, -1
    STR R1, R6, 0
    ADD R6, R6, -1
    LDR R4, R0, 1 ;; 1 for left 2 for right
    STR R4, R6, 0

    JSR binary_search

    ;; load return into r4 and pop 2 args off
    LDR R4, R6, 0
    ADD R6, R6, 2
    STR R4, R5, 3

    BR END
ENDIF3
;;return binarySearch(root.right, data);
ADD R6, R6, -1
STR R1, R6, 0
ADD R6, R6, -1
LDR R4, R0, 2 ;; 1 for left 2 for right
STR R4, R6, 0

JSR binary_search

;; load return into r4 and pop 2 args off
LDR R4, R6, 0
ADD R6, R6, 2
STR R4, R5, 3

END

;; STACK TEARDOWN AND RETURN
LDR R4, R5, -5 ; restore R4  adjust for local vars -(5 + (n - 1))
LDR R3, R5, -4 ; restore R3     ^same above
LDR R2, R5, -3 ; restore R2     ^same above
LDR R1, R5, -2 ; restore R1     ^same above
LDR R0, R5, -1 ; restore R0     ^same above
ADD R6, R5, 0   ; pop saved regs, ; and local vars
LDR R7, R5, 2 ; R7 = ret addr
LDR R5, R5, 1 ; FP = Old FP
ADD R6, R6, 3 ; pop off 1st local var old Fp old RA
RET

;; END SUBROUTINE CODE
STACK .fill xF000
.end

;; Assuming the tree starts at address x4000, here's how the tree (see below and in the pdf) represents in memory
;;
;;              4
;;            /   \
;;           2     8
;;         /   \
;;        1     3
;;
;; Memory address           Data
;; x4000                    4
;; x4001                    x4004
;; x4002                    x4008
;; x4003                    Don't Know
;; x4004                    2
;; x4005                    x400C
;; x4006                    x4010
;; x4007                    Don't Know
;; x4008                    8
;; x4009                    0(NULL)
;; x400A                    0(NULL)
;; x400B                    Don't Know
;; x400C                    1
;; x400D                    0(NULL)
;; x400E                    0(NULL)
;; x400F                    Dont't Know
;; x4010                    3
;; x4011                    0(NULL)
;; x4012                    0(NULL)
;; x4013                    Dont't Know
;;
;; *note: 0 is equivalent to NULL in assembly
