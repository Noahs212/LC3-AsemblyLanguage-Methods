

;; Pseudocode (see PDF for explanation)
;;
;;	int A[] = {1,2,3};
;;	int B[] = {-1, 7, 8};
;;	int C[3];
;;
;;	int i = 0;
;;
;;	while (i < A.length) {
;;		if (A[i] < B[i])
;;			C[i] = B[i];
;;		else
;;			C[i] = A[i];
;;
;;		i += 1;
;;	}


.orig x3000
	;; YOUR CODE HERE

	;;int A[] = {1,2,3};
	;LD R0, A
	;AND R1, R1, 0
	;ADD R1, R1, 1
	;STR R1, R0, 0
	;AND R2, R2, 0
	;ADD R2, R2, 2
	;STR R2, R0, 1
;	AND R3, R3, 0
	;ADD R3, R3, 3
	;STR R3, R0, 2

	;;int B[] = {-1, 7, 8};
	;LD R0, B
	;AND R1, R1, 0
	;ADD R1, R1, -1
;	STR R1, R0, 0
	; R2, R2, 0
;	ADD R2, R2, 7
	;STR R2, R0, 1
;	AND R3, R3, 0
;	ADD R3, R3, 8
;	STR R3, R0, 2

	;int C[3];
;	LD R0, C
	;AND R1, R1, 0
	;ADD R1, R1, 3
;	STR R1, R0, 0

	;;int i = 0; i is R1
	AND R1, R1, 0

	;;while (i < A.length) { switch to i - a.length < 0
	W1 LD R2, LEN
	   NOT R2, R2
		 ADD R2, R2, 1
		 ADD R2, R2, R1
		 BRzp ENDW1
		 ;;		if (A[i] < B[i]) R3 is arr A R4 is arr B
		 LD R0, A
		 ADD R0, R0, R1
		 LDR R3, R0, 0
		 LD R0, B
		 ADD R0, R0, R1
		 LDR R4, R0, 0
		 ;; negate B[i]
		 NOT R4, R4
		 ADD R4, R4, 1
		 ;; add A[i] and -B[1]
		 ADD R3, R3, R4
		 BRzp ELSE1


		 ;;			C[i] = B[i];
		 LD R5, C
		 LD R0, B
		 ADD R5, R5, R1
		 ADD R0, R0, R1
		 LDR R4, R0, 0
		 STR R4, R5, 0
		 BR ENDIF1
		 ;;		else
		 ;;			C[i] = A[i];
		 ELSE1
		 		LD R5, C
				LD R0, A
			  ADD R5, R5, R1
	 		  ADD R0, R0, R1
	 		  LDR R4, R0, 0
	 		  STR R4, R5, 0
		 ENDIF1
		 ;; i += 1
		 ADD R1, R1, 1
		 BR W1

  ENDW1




	HALT


A 	.fill x3200
B 	.fill x3300
C 	.fill x3400
LEN .fill 4

.end

.orig x3200
	.fill -1
	.fill 2
	.fill 7
	.fill -3
.end

.orig x3300
	.fill 3
	.fill 6
	.fill 0
	.fill 5
.end

.orig x3400
	.blkw 4
.end
