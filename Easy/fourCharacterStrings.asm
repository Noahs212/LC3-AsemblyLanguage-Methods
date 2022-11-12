

;; Pseudocode (see PDF for explanation)
;;
;; int count = 0;
;; int chars = 0;
;; int i = 0;
;;
;;  while(str[i] != '\0') {
;;      if (str[i] != ' ')
;;          chars++;
;;
;;      else {
;;          if (chars == 4)
;;              count++;
;;          chars = 0;
;;      }
;;      i++;
;;  }
;; ***IMPORTANT***
;; - Assume that all strings provided will end with a space (' ').
;; - Special characters do not have to be treated differently. For instance, strings like "it's" and "But," are considered 4 character strings.
;;

.orig x3000
	;; YOUR CODE HERE
	;int count = 0; use R1
	AND R1, R1, 0
	;; int chars = 0; use R2
	AND R2, R2, 0
	;; int i = 0; use R0
	AND R0, R0, 0

	;;while(str[i] != '\0') {
	w1 LD R3, STRING
	   ADD R3, R3, R0
		 LDR R3, R3, 0
		 BRz ENDw1

		 ;;  if (str[i] != ' ')
		 ;;     chars++;
		 LD R4, SPACE
		 ADD R4, R3, R4
		 BRz ELSE
		 ADD R2, R2, 1
		 BR ENDIF1

		 ELSE
		     ;;if (chars == 4)
				 AND R5, R5, 0
				 ADD R5, R5, R2
				 ADD R5, R5, -4
				 BRnp ENDIF2
		     ;;count++;
				 ADD R1, R1, 1

				 ENDIF2
				 ;;chars = 0;
				 AND R2, R2, 0

		 ENDIF1

		 ;;i++;
		 ADD R0, R0, 1
		 BR w1
	ENDw1
	LEA R7, ANSWER
	STR R1, R7, 0
	HALT


SPACE 	.fill #-32
STRING	.fill x4000
ANSWER .blkw 1

.end


.orig x4000

.stringz "I love CS 2110 and assembly is very fun! "

.end
