       IDENTIFICATION DIVISION.
       PROGRAM-ID. REPORT-CHECK.
       AUTHOR. AYMARA M FUSARO.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

           SELECT REPORT-INPUT
               ASSIGN TO "data/output/loan-report.txt"
               ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.

       FD  REPORT-INPUT.
       01  REPORT-RECORD PIC X(200).

       WORKING-STORAGE SECTION.

       01  WS-EOF              PIC X VALUE "N".
           88  END-OF-FILE     VALUE "Y".

       01  WS-RECORDS-READ    PIC 9(4) VALUE ZERO.

       01  WS-VALIDATION-FLAGS.
           05  WS-HEADER-FOUND       PIC X VALUE "N".
           05  WS-DATE-FOUND         PIC X VALUE "N".
           05  WS-MAX-LOAN-FOUND     PIC X VALUE "N".
           05  WS-READ-FOUND         PIC X VALUE "N".
           05  WS-PROCESSED-FOUND    PIC X VALUE "N".
           05  WS-REJECTED-FOUND     PIC X VALUE "N".

       PROCEDURE DIVISION.

       0000-MAIN.

           OPEN INPUT REPORT-INPUT

           PERFORM UNTIL END-OF-FILE

               READ REPORT-INPUT
                   AT END
                       SET END-OF-FILE TO TRUE

                   NOT AT END
                       ADD 1 TO WS-RECORDS-READ

                       IF REPORT-RECORD
                          = "LOAN PAYMENT PROCESSING REPORT"
                           MOVE "Y" TO WS-HEADER-FOUND
                       END-IF

                       IF REPORT-RECORD(1:13)
                          = "PROCESS DATE:"
                           MOVE "Y" TO WS-DATE-FOUND
                       END-IF
                       
                       IF REPORT-RECORD(1:9)
                          = "MAX LOAN:"
                           MOVE "Y" TO WS-MAX-LOAN-FOUND
                       END-IF

                       IF REPORT-RECORD(1:13)
                          = "RECORDS READ:"
                           MOVE "Y" TO WS-READ-FOUND
                       END-IF

                       IF REPORT-RECORD(1:18)
                          = "RECORDS PROCESSED:"
                           MOVE "Y" TO WS-PROCESSED-FOUND
                       END-IF

                       IF REPORT-RECORD(1:18)
                          = "RECORDS REJECTED:"
                           MOVE "Y" TO WS-REJECTED-FOUND
                       END-IF

               END-READ

           END-PERFORM

           CLOSE REPORT-INPUT

           DISPLAY "========================================"
           DISPLAY "        REPORT VALIDATION"
           DISPLAY "========================================"
           DISPLAY "REPORT RECORDS READ: " WS-RECORDS-READ
           
           IF WS-HEADER-FOUND = "Y"
              AND WS-DATE-FOUND = "Y"
              AND WS-MAX-LOAN-FOUND = "Y"
              AND WS-READ-FOUND = "Y"
              AND WS-PROCESSED-FOUND = "Y"
              AND WS-REJECTED-FOUND = "Y"

               DISPLAY "REPORT STATUS: VALID"

           ELSE

               DISPLAY "REPORT STATUS: INVALID"

           END-IF

           STOP RUN.
