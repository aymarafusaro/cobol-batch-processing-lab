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

       01  WS-REPORT-VALID    PIC X VALUE "N".
           88  REPORT-VALID   VALUE "Y".

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
                           SET REPORT-VALID TO TRUE
                       END-IF
               END-READ

           END-PERFORM

           CLOSE REPORT-INPUT

           DISPLAY "========================================"
           DISPLAY "        REPORT VALIDATION"
           DISPLAY "========================================"
           DISPLAY "REPORT RECORDS READ: " WS-RECORDS-READ
           IF REPORT-VALID
               DISPLAY "REPORT STATUS: VALID"
           ELSE
               DISPLAY "REPORT STATUS: INVALID"
           END-IF
           DISPLAY "REPORT VALIDATION COMPLETED."
           DISPLAY "========================================"

           STOP RUN.
