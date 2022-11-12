

;; Pseudocode 
;;
;;    int result = x4000; (given memory address to save the converted value)
;;    String binaryString= "01000000"; (given binary string)
;;    int length = 8; (given length of the above binary string)
;;    int base = 1;
;;    int value = 0;
;;    while (length > 0) {
;;        int y = binaryString.charAt(length - 1) - 48;
;;        if (y == 1) {
;;            value += base;
;;        }
;;            base += base;
;;            length--;
;;    }
;;    mem[result] = value;
.orig x3000
    ;; YOUR CODE HERE
    ;;    int base = 1; use R0
    AND R0, R0, 0
    ADD R0, R0, 1

    ;;int value = 0; use R7
    AND R7, R7, 0


    ;;while (length > 0) { R2 - length
       LD R2, length
    W1 ADD R2, R2, 0
       BRnz ENDW1

       ;;int y = binaryString.charAt(length - 1) - 48; y = R3 R4 = length -1
       AND R4, R4, 0
       ADD R4, R4, R2
       ADD R4, R4, -1
       LD R5, binaryString
       ADD R5, R5, R4
       LDR R3, R5, 0
       ADD R3, R3, -12
       ADD R3, R3, -12
       ADD R3, R3, -12
       ADD R3, R3, -12


       ;;if (y == 1) {
       ADD R3, R3, -1
       BRnp ENDIF1

        ;;value += base;
        ADD R7, R7, R0

       ENDIF1 ADD R0, R0, R0
              ADD R2, R2, -1

       BR W1
    ENDW1
    LD R6, result
    STR R7, R6, 0
    HALT

    binaryString .fill x5000
    length .fill 8
    result .fill x4000
.end

.orig x5000
    .stringz "010010100"
.end
