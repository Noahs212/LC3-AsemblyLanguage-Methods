

;; Pseudocode 
;;
;;    int result; (to save the summation of x)
;;       store in Register
;;    int x= -9; (given integer)
;;       store in register
;;    int answer = 0;
;;      store in register
;;    while (x > 0) {
;;        answer += x;
;;        x--;
;;    }
;;    result = answer;
.orig x3000
    ;; YOUR CODE HERE

    ;;int x= -9; (given integer)
    ;;       store in register


    ;;    int answer = 0;
    ;;      store in register 0


    ;;    while (x > 0) {
    W1
       LD R1, x
       ADD R1, R1, 0
       BRnz ENDW1

    ;;        answer += x;
    ;;        x--;
       LD R0, answer
       ADD R0, R0, R1
       ADD R1, R1, -1
       ST R1, x
       ST R0, answer

    ;;    }
    BR W1
    ENDW1

    LD R0, answer
    ST R0, result


    HALT

    x .fill -9
    result .blkw 1
    answer .fill 0
.end
