       IDENTIFICATION DIVISION.
       PROGRAM-ID. LOAN-PAYMENT-PROCESSING.
       AUTHOR. AYMARA M FUSARO.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.

       FILE-CONTROL.

           SELECT LOAN-INPUT
               ASSIGN TO "data/input/loan-accounts.dat"
               ORGANIZATION IS LINE SEQUENTIAL.

           SELECT LOAN-OUTPUT
               ASSIGN TO "data/output/loan-report.txt"
               ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.

       FD  LOAN-INPUT.
       01  LOAN-INPUT-RECORD       PIC X(80).

       FD  LOAN-OUTPUT.
       01  LOAN-OUTPUT-RECORD      PIC X(120).

       WORKING-STORAGE SECTION.

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

       01  WS-FLAGS.
           05  WS-EOF              PIC X VALUE "N".
               88  END-OF-FILE     VALUE "Y".

       01  WS-RECORD-COUNT         PIC 9(4) VALUE ZERO.

       01  WS-OUTPUT-LINE          PIC X(120).

       01  WS-PRINT-AMOUNTS.
           05  WS-PRINT-LOAN       PIC ZZ,ZZ9.99.
           05  WS-PRINT-PAYMENT-1  PIC ZZ,ZZ9.99.
           05  WS-PRINT-PAYMENT-2  PIC ZZ,ZZ9.99.
           05  WS-PRINT-PAYMENT-3  PIC ZZ,ZZ9.99.
           05  WS-PRINT-PAYMENT-4  PIC ZZ,ZZ9.99.
           05  WS-PRINT-TOTAL      PIC ZZ,ZZ9.99.
           05  WS-PRINT-BALANCE    PIC ZZ,ZZ9.99.

       PROCEDURE DIVISION.

       0000-MAIN.

           PERFORM 1000-INITIALIZE
           PERFORM 2000-PROCESS-FILE
           PERFORM 3000-FINALIZE

           STOP RUN.

       1000-INITIALIZE.

           OPEN INPUT LOAN-INPUT
                OUTPUT LOAN-OUTPUT

           MOVE SPACES TO WS-OUTPUT-LINE

           MOVE "==============================================" 
               TO WS-OUTPUT-LINE
           WRITE LOAN-OUTPUT-RECORD FROM WS-OUTPUT-LINE

           MOVE "LOAN PAYMENT PROCESSING REPORT"
               TO WS-OUTPUT-LINE
           WRITE LOAN-OUTPUT-RECORD FROM WS-OUTPUT-LINE

           MOVE "=============================================="
               TO WS-OUTPUT-LINE
           WRITE LOAN-OUTPUT-RECORD FROM WS-OUTPUT-LINE
           .

       2000-PROCESS-FILE.

           PERFORM UNTIL END-OF-FILE

               READ LOAN-INPUT
                   AT END
                       SET END-OF-FILE TO TRUE
                   NOT AT END
                       PERFORM 2100-PROCESS-RECORD
               END-READ

           END-PERFORM
           .

       2100-PROCESS-RECORD.

           MOVE LOAN-INPUT-RECORD TO WS-INPUT-FIELDS

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

           ADD 1 TO WS-RECORD-COUNT

           PERFORM 2200-WRITE-RESULT
           .

       2200-WRITE-RESULT.

           MOVE WS-LOAN
               TO WS-PRINT-LOAN

           MOVE WS-PAYMENT-1
               TO WS-PRINT-PAYMENT-1

           MOVE WS-PAYMENT-2
               TO WS-PRINT-PAYMENT-2

           MOVE WS-PAYMENT-3
               TO WS-PRINT-PAYMENT-3

           MOVE WS-PAYMENT-4
               TO WS-PRINT-PAYMENT-4

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

       3000-FINALIZE.

           MOVE SPACES TO WS-OUTPUT-LINE

           MOVE "----------------------------------------------"
               TO WS-OUTPUT-LINE
           WRITE LOAN-OUTPUT-RECORD FROM WS-OUTPUT-LINE

           MOVE "APPLICANTS PROCESSED: " TO WS-OUTPUT-LINE

           STRING
               "APPLICANTS PROCESSED: "
               WS-RECORD-COUNT
               DELIMITED BY SIZE
               INTO WS-OUTPUT-LINE
           END-STRING

           WRITE LOAN-OUTPUT-RECORD FROM WS-OUTPUT-LINE

           CLOSE LOAN-INPUT
                 LOAN-OUTPUT

           DISPLAY "BATCH PROCESSING COMPLETED."
           DISPLAY "RECORDS PROCESSED: " WS-RECORD-COUNT
           .
