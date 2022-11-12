
;; Pseudocode:

;; Partition

;;    partition(int[] arr, int low, int high) {
;;        int pivot = arr[high];
;;        int i = low - 1;
;;        for (j = low; j < high; j++) {
;;            if (arr[j] < pivot) {
;;                i++;
;;                int temp = arr[j];
;;                arr[j] = arr[i];
;;                arr[i] = temp;
;;            }
;;        }
;;        int temp = arr[high];
;;        arr[high] = arr[i + 1];
;;        arr[i + 1] = temp;
;;        return i + 1;
;;    }

;; Quicksort

;;    quicksort(int[] arr, int left, int right) {
;;        if (left < right) {
;;            int pi = partition(arr, left, right);
;;            quicksort(arr, left, pi - 1);
;;            quicksort(arr, pi + 1, right);
;;        }
;;    }


.orig x3000
    ;; you do not need to write anything here
HALT

partition   ;; please do not change the name of your subroutine
    ;; insert your implementation for partition subroutine
    ; WRITE SUBTRACT HERE

    ;; STACK SETUP

    ; build stack frame
      ADD R6,R6,-4 ; allocate space for RV,RA,FP,LV1
      STR R7,R6,2 ; store return address
      STR R5,R6,1 ; save old frame pointer
      ADD R5,R6,0 ; copy SP to FP
      ADD R6,R6,-5 ; make room for saved registers and LV 1-n
      STR R0,R5,-1 ; save R1
      STR R1,R5,-2 ; save R2
      STR R2,R5,-3 ; save R3
      STR R3,R5,-4 ; save R4
      STR R4,R5,-5 ; save R5

      LDR R0,R5,4 ; R0 = arr
      LDR R1,R5,5 ; R1 = low
      LDR R2,R5,6 ; R2 = high

      ADD R3,R0,R2 ; gets the address of arr[high]
      LDR R3,R3,0 ; int pivot = arr[high]

      ADD R4,R1,-1 ; int i = low - 1;

      for1
      LDR R2,R5,6 ; R2 = high
      ADD R1,R1,0 ; j = low
      NOT R3,R1 ; takes the not of j
      ADD R3,R3,1 ; adds 1 to j
      ADD R3,R3,R2 ; checks if j < high
      BRnz endfor1 ; branch if arr[j] >= high

      LDR R2,R5,6 ; R2 = high
      ADD R3,R0,R2 ; gets the address of arr[high]
      LDR R3,R3,0 ; int pivot = arr[high]

      if1
      ADD R2,R0,R1 ; R2 = address of arr[j]
      LDR R2,R2,0 ; R2 = arr[j]
      NOT R2,R2 ; take 2's complement of R2
      ADD R2,R2,1 ; add 1 to get negative of R2
      ADD R2,R3,R2 ; checks if arr[j] < high
      BRnz endif1 ; branch if arr[j] >= high

      ADD R4,R4,1 ; i++

      ADD R2,R0,R1 ; R2 = address of arr[j]
      ADD R3,R0,R4 ; R3 = address of arr[i]
      LDR R0,R2,0 ; int temp = arr[j];

      LDR R3,R3,0 ; loads arr[i] into R3
      STR R3,R2,0; arr[j] = arr[i];

      LDR R3,R5,4 ; R3 = arr
      ADD R3,R3,R4
      STR R0,R3,0; arr[i] = temp;
      LDR R0,R5,4 ; R0 = arr

      endif1
      ADD R1,R1,1 ; j++
      BR for1

      endfor1
      LDR R0,R5,4 ; R0 = arr
      LDR R1,R5,5 ; R1 = low
      LDR R2,R5,6 ; R2 = high

      ADD R2,R2,R0 ; R2 = address of arr[high]
      LDR R1,R2,0 ; int temp = arr[high];

      ADD R2,R4,1 ; R2 = i + 1;
      ADD R2,R2,R0 ; R2 = address of arr[i+1]
      LDR R2,R2,0 ; R2 = vale of arr[i+1]
      LDR R3,R5,6 ; R3 = high
      ADD R3,R3,R0 ; address of arr[high]
      STR R2,R3,0; arr[high] = arr[i + 1];

      ADD R2,R4,1 ; R2 = i + 1;
      ADD R2,R2,R0 ; R2 = address of arr[i+1]
      STR R1,R2,0; arr[i+1] = temp
      ADD R2,R4,1 ; R2 = i + 1;

      STR R2,R5,3 ; set return value to i+1
      LDR R4,R5,-5 ; restore R4
      LDR R3,R5,-4 ; restore R3
      LDR R2,R5,-3 ; restore R2
      LDR R1,R5,-2 ; restore R1
      LDR R0,R5,-1 ; restore R0
      ADD R6,R5,0 ; pop saved registers
      LDR R7,R5,2 ; R7 = return address
      LDR R5,R5,1 ; FP = old FP
      ADD R6,R6,3 ; pop 3 words
      RET

    ;; END SUBROUTINE CODE

quicksort   ;; please do not change the name of your subroutine
    ;; insert your implementation for quicksort subroutine
    ;; STACK SETUP
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
    LDR R0, R5, 4  ;; arr is R0
    LDR R1, R5, 5  ;; left is R1
    LDR R2, R5, 6  ;; right is R2

          ;; PERFORM Subroutine
          ;; STORE Locals at R5, 0 + n
          ;;if (left < right) {
          NOT R3, R2
          ADD R3, R3, 1
          ADD R3, R3, R1
          BRzp endif3
              ;;int pi = partition(arr, left, right);
              ADD R6, R6, -1
              STR R2, R6, 0
              ADD R6, R6, -1
              STR R1, R6, 0
              ADD R6, R6, -1
              STR R0, R6, 0

              JSR partition

              LDR R3, R6, 0
              ADD R6, R6, 3
              STR R3, R5, 0   ;; pi is R3

              ;;quicksort(arr, left, pi - 1);
              ADD R6, R6, -1
              ADD R4, R3, -1
              STR R4, R6, 0
              ADD R6, R6, -1
              STR R1, R6, 0
              ADD R6, R6, -1
              STR R0, R6, 0

              JSR quicksort

              ADD R6, R6, 3

              ;;quicksort(arr, pi + 1, right);
              ADD R6, R6, -1
              STR R2, R6, 0
              ADD R6, R6, -1
              LDR R4, R5, 0
              ADD R4, R4, 1
              STR R4, R6, 0
              ADD R6, R6, -1
              STR R0, R6, 0

              JSR quicksort

              ADD R6, R6, 3

          ;; STORE RETURN VALUE
          ;;STR R3, R5, 3
         endif3

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

STACK .fill xF000


.end

;;.orig x4000
;;.fill 1
  ;;.fill 2
  ;;.fill 3
;;  .fill 5
;;.end


;; Assuming the array starts at address x4000, here's how the array [1,3,2,5] represents in memory
;; Memory address           Data
;; x4000                    1
;; x4001                    3
;; x4002                    2
;; x4003                    5
