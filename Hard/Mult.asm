.orig x3000

LD R0, A
LD R1, B
;; ret = 0
AND R3, R3, 0
;;int copyB = b;
AND R4, R4, 0
ADD R4, R4, R1
;;while (copyB > 0):
W1 ADD R4, R4, 0
BRnz ENDW1
;;ret += a;
ADD R3, R0, R3
;;copyB--;
ADD R4, R4, -1
BR W1
ENDW1
;;return ret;

HALT

A .fill 2
B .fill 3

.end
