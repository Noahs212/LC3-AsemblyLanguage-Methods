;;=============================================================
;; Name: Noah Statton
;;============================================================

;; In this file, you must implement the 'factorial' and "mult" subroutines.

;; Little reminder from your friendly neighborhood 2110 TA staff: don't run
;; this directly by pressing 'RUN' in complx, since there is nothing put at
;; address x3000. Instead, load it and use 'Debug' -> 'Simulate
;; Subroutine Call' and choose the 'factorial' or 'mult' label.

;; Pseudocode

;; Factorial

;;    factorial(int n) {
;;        int ret = 1;
;;        for (int x = 2; x < n+1; x++) {
;;            ret = mult(ret, x);
;;        }
;;        return ret;
;;    }

;; Multiply

;;    mult(int a, int b) {
;;        int ret = 0;
;;        int copyB = b;
;;        while (copyB > 0):
;;            ret += a;
;;            copyB--;
;;        return ret;
;;    }


.orig x3000
    ;; you do not need to write anything here
HALT

factorial   ;; please do not change the name of your subroutine
    ;; insert your implementation for factorial subroutine
    ;; STACK SETUP

                    ;; for 2 args 1 local variable and 1 Rv
    ADD R6, R6, -4 ; Allocate space
    STR R7, R6, 2 ; Save Ret Addr
    STR R5, R6, 1 ; Save Old FP
    ADD R5, R6, 0 ; Copy SP to FP
    ADD R6, R6, -6 ; Make room for saved regs & l.v. 1-n ;; subtract 5 + (n-1) n is num local vars
    STR  R0, R5, -2 ; Save R0
    STR  R1, R5, -3 ; Save R1
    STR  R2, R5, -4 ; Save R2
    STR  R3, R5, -5 ; Save R3
    STR  R4, R5, -6 ; Save R4

    ;; EXTRACT ARGUMENTS argument n = R5 + 4
    LDR R0, R5, 4
    ;; PERFORM FACTORIAL
      ;;int ret = 1
      AND R3, R3, 0
      ADD R3, R3, 1
      STR R3, R5, 0
      ;;int x = 2
      AND R4, R4, 0
      ADD R4, R4, 2
      STR R4, R5, -1
      ;;for (int x = 2; x < n+1; x++) {
      W1 AND R2, R2, 0
         ADD R2, R0, 1
         NOT R1, R2
         ADD R1, R1, 1
         ADD R1, R4, R1
         BRzp endW1
          ;;ret = mult(ret, x);
          ADD R6, R6, -1
          STR R4, R6, 0
          ADD R6, R6, -1
          STR R3, R6, 0

          JSR mult
          ;; R2 is return value from subroutine call
          LDR R3, R6, 0
          ADD R6, R6, 1
          STR R3, R5, 0 ;;restore ret value
          ADD R6, R6, 2 ;;pop 2 args off

          ;;x++
          ADD R4, R4, 1
         BR W1
      endW1



    ;; STORE RETURN VALUE
    STR R3, R5, 3

    ;; STACK TEARDOWN AND RETURN
    LDR R4, R5, -6 ; restore R4  adjust for local vars -(5 + (n - 1))
    LDR R3, R5, -5 ; restore R3     ^same above
    LDR R2, R5, -4 ; restore R2     ^same above
    LDR R1, R5, -3 ; restore R1     ^same above
    LDR R0, R5, -2 ; restore R0     ^same above
    ADD R6, R5, 0   ; pop saved regs, ; and local vars
    LDR R7, R5, 2 ; R7 = ret addr
    LDR R5, R5, 1 ; FP = Old FP
    ADD R6, R6, 3 ; pop off 1st local var old Fp old RA
    RET

mult        ;; please do not change the name of your subroutine
    ;; insert your implementation for mult subroutine
    ;; STACK SETUP
                  ;; for 2 args 1 local variable and 1 Rv
    ADD R6, R6, -4 ; Allocate space
    STR R7, R6, 2 ; Save Ret Addr
    STR R5, R6, 1 ; Save Old FP
    ADD R5, R6, 0 ; Copy SP to FP
    ADD R6, R6, -6 ; Make room for saved regs & l.v. 1-n ;; subtract 5 + (n-1) n is num local vars
    STR  R0, R5, -2 ; Save R0
    STR  R1, R5, -3 ; Save R1
    STR  R2, R5, -4 ; Save R2
    STR  R3, R5, -5 ; Save R3
    STR  R4, R5, -6 ; Save R4

    ;; EXTRACT ARGUMENTS argument n = R5 + 4
    LDR R0, R5, 4
    LDR R1, R5, 5

    ;; PERFORM MULT

    AND R3, R3, 0
    STR R3, R5, 0
    ;;int copyB = b;
    AND R4, R4, 0
    ADD R4, R4, R1
    STR R4, R5, -1
    ;;while (copyB > 0):
    W2 ADD R4, R4, 0
    BRnz ENDW2
    ;;ret += a;
    ADD R3, R0, R3
    ;;copyB--;
    ADD R4, R4, -1
    BR W2
    ENDW2
    ;; STORE RETURN VALUE
    STR R3, R5, 3

    ;; STACK TEARDOWN AND RETURN
    LDR R4, R5, -6 ; restore R4  adjust for local vars -(5 + (n - 1))
    LDR R3, R5, -5 ; restore R3     ^same above
    LDR R2, R5, -4 ; restore R2     ^same above
    LDR R1, R5, -3 ; restore R1     ^same above
    LDR R0, R5, -2 ; restore R0     ^same above
    ADD R6, R5, 0   ; pop saved regs, ; and local vars
    LDR R7, R5, 2 ; R7 = ret addr
    LDR R5, R5, 1 ; FP = Old FP
    ADD R6, R6, 3 ; pop off 1st local var old Fp old RA
    RET

STACK .fill xF000
.end
