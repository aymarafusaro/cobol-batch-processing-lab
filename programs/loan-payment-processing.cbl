       IDENTIFICATION DIVISION.
       PROGRAM-ID. LOAN-PAYMENT-PROCESSING.
       AUTHOR. AYMARA M FUSARO.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.

       FILE-CONTROL.

           SELECT CONTROL-INPUT
               ASSIGN TO "data/input/loan-control.dat"
               ORGANIZATION IS LINE SEQUENTIAL.
           
           SELECT LOAN-INPUT
               ASSIGN TO "data/input/loan-accounts.dat"
               ORGANIZATION IS LINE SEQUENTIAL.

           SELECT LOAN-OUTPUT
               ASSIGN TO "data/output/loan-report.txt"
               ORGANIZATION IS LINE SEQUENTIAL.

           SELECT ERROR-OUTPUT
               ASSIGN TO "data/output/errors.txt"
               ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.

       FD  CONTROL-INPUT.
       01  CONTROL-RECORD          PIC X(30).
       
       FD  LOAN-INPUT.
       01  LOAN-INPUT-RECORD       PIC X(80).

       FD  LOAN-OUTPUT.
       01  LOAN-OUTPUT-RECORD      PIC X(120).

       FD  ERROR-OUTPUT.
       01  ERROR-OUTPUT-RECORD     PIC X(120).

       WORKING-STORAGE SECTION.

       01  WS-CONTROL-FIELDS.
           05  WS-PROCESS-DATE     PIC X(10).
           05  FILLER              PIC X.
           05  WS-MAX-LOAN-TEXT    PIC X(8).

       01  WS-MAX-LOAN             PIC 9(5)V99 VALUE ZERO.
       
       01  WS-INPUT-FIELDS.
           05  WS-NAME             PIC X(20).
           05  FILLER              PIC X.
           05  WS-DIPLOMA          PIC X(4).
           05  FILLER              PIC X.
           05  WS-YEAR             PIC X(4).
           05  FILLER              PIC X.
           05  WS-LOAN-TEXT        PIC X(8).
           05  FILLER              PIC X.
           05  WS-PAYMENT-1-TEXT   PIC X(7).
           05  FILLER              PIC X.
           05  WS-PAYMENT-2-TEXT   PIC X(7).
           05  FILLER              PIC X.
           05  WS-PAYMENT-3-TEXT   PIC X(7).
           05  FILLER              PIC X.
           05  WS-PAYMENT-4-TEXT   PIC X(7).

       01  WS-CALCULATIONS.
           05  WS-LOAN             PIC 9(5)V99 VALUE ZERO.
           05  WS-PAYMENT-1        PIC 9(4)V99 VALUE ZERO.
           05  WS-PAYMENT-2        PIC 9(4)V99 VALUE ZERO.
           05  WS-PAYMENT-3        PIC 9(4)V99 VALUE ZERO.
           05  WS-PAYMENT-4        PIC 9(4)V99 VALUE ZERO.
           05  WS-TOTAL-PAID       PIC 9(5)V99 VALUE ZERO.
           05  WS-BALANCE          PIC 9(5)V99 VALUE ZERO.

       01  WS-PRINT-AMOUNTS.
           05  WS-PRINT-LOAN       PIC ZZ,ZZ9.99.
           05  WS-PRINT-TOTAL      PIC ZZ,ZZ9.99.
           05  WS-PRINT-BALANCE    PIC ZZ,ZZ9.99.

       01  WS-FLAGS.
           05  WS-EOF              PIC X VALUE "N".
               88  END-OF-FILE     VALUE "Y".
           05  WS-VALID-RECORD     PIC X VALUE "N".
           05  WS-CONTROL-VALID    PIC X VALUE "N".
               88  CONTROL-VALID   VALUE "Y".

       01  WS-REJECTION-REASON     PIC X(40).

       01  WS-COUNTERS.
           05  WS-RECORDS-READ     PIC 9(4) VALUE ZERO.
           05  WS-RECORDS-PROCESSED
                                    PIC 9(4) VALUE ZERO.
           05  WS-RECORDS-REJECTED
                                    PIC 9(4) VALUE ZERO.

       01  WS-OUTPUT-LINE          PIC X(120).

       PROCEDURE DIVISION.

       0000-MAIN.
           PERFORM 1000-INITIALIZE

           IF CONTROL-VALID
               PERFORM 2000-PROCESS-FILE
           ELSE
               DISPLAY "ERROR: INVALID CONTROL FILE"
           END-IF

           PERFORM 3000-FINALIZE
           STOP RUN.

       1000-INITIALIZE.

           OPEN INPUT CONTROL-INPUT
                INPUT LOAN-INPUT
                OUTPUT LOAN-OUTPUT
                OUTPUT ERROR-OUTPUT

           READ CONTROL-INPUT
               AT END
                   MOVE SPACES TO WS-CONTROL-FIELDS

               NOT AT END
                   MOVE CONTROL-RECORD TO WS-CONTROL-FIELDS

                   IF WS-PROCESS-DATE NOT = SPACES
                       IF FUNCTION TEST-NUMVAL(WS-MAX-LOAN-TEXT) = 0
                           COMPUTE WS-MAX-LOAN =
                               FUNCTION NUMVAL(WS-MAX-LOAN-TEXT)

                           IF WS-MAX-LOAN > ZERO
                               SET CONTROL-VALID TO TRUE
                           END-IF
                       END-IF
                   END-IF
           END-READ

           MOVE "Y" TO WS-VALID-RECORD

           MOVE SPACES TO WS-OUTPUT-LINE

           MOVE "=============================================="
               TO WS-OUTPUT-LINE
           WRITE LOAN-OUTPUT-RECORD FROM WS-OUTPUT-LINE

           MOVE "LOAN PAYMENT PROCESSING REPORT"
               TO WS-OUTPUT-LINE
           WRITE LOAN-OUTPUT-RECORD FROM WS-OUTPUT-LINE

           MOVE SPACES TO WS-OUTPUT-LINE
           STRING
               "PROCESS DATE: "
               WS-PROCESS-DATE
               DELIMITED BY SIZE
               INTO WS-OUTPUT-LINE
           END-STRING
           WRITE LOAN-OUTPUT-RECORD FROM WS-OUTPUT-LINE

           MOVE SPACES TO WS-OUTPUT-LINE
           MOVE WS-MAX-LOAN
               TO WS-PRINT-LOAN
           STRING
               "MAX LOAN: "
               WS-PRINT-LOAN
               DELIMITED BY SIZE
               INTO WS-OUTPUT-LINE
           END-STRING
           WRITE LOAN-OUTPUT-RECORD FROM WS-OUTPUT-LINE

           MOVE "=============================================="
               TO WS-OUTPUT-LINE
           WRITE LOAN-OUTPUT-RECORD FROM WS-OUTPUT-LINE

           MOVE "INVALID RECORDS"
               TO WS-OUTPUT-LINE
           WRITE ERROR-OUTPUT-RECORD FROM WS-OUTPUT-LINE

           MOVE "=============================================="
               TO WS-OUTPUT-LINE
           WRITE ERROR-OUTPUT-RECORD FROM WS-OUTPUT-LINE
           .

       2000-PROCESS-FILE.

           PERFORM UNTIL END-OF-FILE

               READ LOAN-INPUT
                   AT END
                       SET END-OF-FILE TO TRUE

                   NOT AT END
                       ADD 1 TO WS-RECORDS-READ
                       PERFORM 2100-VALIDATE-RECORD

                       IF WS-VALID-RECORD = "Y"
                           PERFORM 2200-PROCESS-RECORD
                       ELSE
                           PERFORM 2300-REJECT-RECORD
                       END-IF

               END-READ

           END-PERFORM
           .

       2100-VALIDATE-RECORD.
           MOVE "Y" TO WS-VALID-RECORD
           MOVE SPACES TO WS-REJECTION-REASON

           MOVE LOAN-INPUT-RECORD TO WS-INPUT-FIELDS

           IF FUNCTION TEST-NUMVAL(WS-LOAN-TEXT) NOT = 0
               MOVE "N" TO WS-VALID-RECORD
               MOVE "E001 - INVALID NUMERIC DATA"
                   TO WS-REJECTION-REASON
           END-IF

           IF FUNCTION TEST-NUMVAL(WS-PAYMENT-1-TEXT) NOT = 0
               MOVE "N" TO WS-VALID-RECORD
               MOVE "E001 - INVALID NUMERIC DATA"
                   TO WS-REJECTION-REASON
           END-IF

           IF FUNCTION TEST-NUMVAL(WS-PAYMENT-2-TEXT) NOT = 0
               MOVE "N" TO WS-VALID-RECORD
               MOVE "E001 - INVALID NUMERIC DATA"
                   TO WS-REJECTION-REASON
           END-IF

           IF FUNCTION TEST-NUMVAL(WS-PAYMENT-3-TEXT) NOT = 0
               MOVE "N" TO WS-VALID-RECORD
               MOVE "E001 - INVALID NUMERIC DATA"
                   TO WS-REJECTION-REASON
           END-IF

           IF FUNCTION TEST-NUMVAL(WS-PAYMENT-4-TEXT) NOT = 0
               MOVE "N" TO WS-VALID-RECORD
               MOVE "E001 - INVALID NUMERIC DATA"
                   TO WS-REJECTION-REASON
           END-IF

           IF WS-VALID-RECORD = "Y"
               COMPUTE WS-LOAN =
                   FUNCTION NUMVAL(WS-LOAN-TEXT)

               IF WS-LOAN > WS-MAX-LOAN
                   MOVE "N" TO WS-VALID-RECORD
                   MOVE "E002 - MAX LOAN EXCEEDED"
                       TO WS-REJECTION-REASON
               END-IF
           END-IF
           .

       2200-PROCESS-RECORD.

           COMPUTE WS-LOAN =
               FUNCTION NUMVAL(WS-LOAN-TEXT)

           COMPUTE WS-PAYMENT-1 =
               FUNCTION NUMVAL(WS-PAYMENT-1-TEXT)

           COMPUTE WS-PAYMENT-2 =
               FUNCTION NUMVAL(WS-PAYMENT-2-TEXT)

           COMPUTE WS-PAYMENT-3 =
               FUNCTION NUMVAL(WS-PAYMENT-3-TEXT)

           COMPUTE WS-PAYMENT-4 =
               FUNCTION NUMVAL(WS-PAYMENT-4-TEXT)

           COMPUTE WS-TOTAL-PAID =
               WS-PAYMENT-1
             + WS-PAYMENT-2
             + WS-PAYMENT-3
             + WS-PAYMENT-4

           COMPUTE WS-BALANCE =
               WS-LOAN - WS-TOTAL-PAID

           ADD 1 TO WS-RECORDS-PROCESSED

           PERFORM 2210-WRITE-RESULT
           .

       2210-WRITE-RESULT.

           MOVE WS-LOAN
               TO WS-PRINT-LOAN

           MOVE WS-TOTAL-PAID
               TO WS-PRINT-TOTAL

           MOVE WS-BALANCE
               TO WS-PRINT-BALANCE

           MOVE SPACES TO WS-OUTPUT-LINE

           STRING
               WS-NAME
               " | "
               WS-DIPLOMA
               " | "
               WS-YEAR
               " | LOAN: "
               WS-PRINT-LOAN
               " | TOTAL PAID: "
               WS-PRINT-TOTAL
               " | BALANCE: "
               WS-PRINT-BALANCE
               DELIMITED BY SIZE
               INTO WS-OUTPUT-LINE
           END-STRING

           WRITE LOAN-OUTPUT-RECORD FROM WS-OUTPUT-LINE
           .

       2300-REJECT-RECORD.
           ADD 1 TO WS-RECORDS-REJECTED

           MOVE SPACES TO WS-OUTPUT-LINE

           STRING
               "REJECTED - "
               WS-REJECTION-REASON
               " | "
               LOAN-INPUT-RECORD
               DELIMITED BY SIZE
               INTO WS-OUTPUT-LINE
           END-STRING

           WRITE ERROR-OUTPUT-RECORD FROM WS-OUTPUT-LINE
           .

       3000-FINALIZE.

           CLOSE CONTROL-INPUT

           IF NOT CONTROL-VALID
               MOVE SPACES TO WS-OUTPUT-LINE
               MOVE "BATCH ABORTED - INVALID CONTROL FILE"
                   TO WS-OUTPUT-LINE
               WRITE LOAN-OUTPUT-RECORD FROM WS-OUTPUT-LINE
           END-IF
           
           MOVE SPACES TO WS-OUTPUT-LINE

           MOVE "----------------------------------------------"
               TO WS-OUTPUT-LINE
           WRITE LOAN-OUTPUT-RECORD FROM WS-OUTPUT-LINE

           MOVE SPACES TO WS-OUTPUT-LINE

           STRING
               "RECORDS READ:       "
               WS-RECORDS-READ
               DELIMITED BY SIZE
               INTO WS-OUTPUT-LINE
           END-STRING

           WRITE LOAN-OUTPUT-RECORD FROM WS-OUTPUT-LINE

           MOVE SPACES TO WS-OUTPUT-LINE

           STRING
               "RECORDS PROCESSED:  "
               WS-RECORDS-PROCESSED
               DELIMITED BY SIZE
               INTO WS-OUTPUT-LINE
           END-STRING

           WRITE LOAN-OUTPUT-RECORD FROM WS-OUTPUT-LINE

           MOVE SPACES TO WS-OUTPUT-LINE

           STRING
               "RECORDS REJECTED:   "
               WS-RECORDS-REJECTED
               DELIMITED BY SIZE
               INTO WS-OUTPUT-LINE
           END-STRING

           WRITE LOAN-OUTPUT-RECORD FROM WS-OUTPUT-LINE

           CLOSE LOAN-INPUT
                 LOAN-OUTPUT
                 ERROR-OUTPUT

           DISPLAY "BATCH PROCESSING COMPLETED."
           DISPLAY "RECORDS READ:       " WS-RECORDS-READ
           DISPLAY "RECORDS PROCESSED:  " WS-RECORDS-PROCESSED
           DISPLAY "RECORDS REJECTED:   " WS-RECORDS-REJECTED
           .

