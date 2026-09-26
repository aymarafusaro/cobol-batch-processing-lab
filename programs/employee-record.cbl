       IDENTIFICATION DIVISION.
       PROGRAM-ID. EMPLOYEE-RECORD.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

       COPY "EMPLOYEE-RECORD.CPY".

       PROCEDURE DIVISION.

           INITIALIZE EMPLOYEE-RECORD

           MOVE "AYMARA"       TO FIRST-NAME
           MOVE "MICAELA"      TO SECOND-NAME
           MOVE "FUSARO"       TO LAST-NAME
           MOVE 123456789      TO EMPLOYEE-ID
           MOVE 9              TO PAYMENT-MONTH
           MOVE 24             TO PAYMENT-DAY
           MOVE 2026           TO PAYMENT-YEAR
           MOVE 40.5           TO HOURS-WORKED

           DISPLAY "========================================"
           DISPLAY "        EMPLOYEE RECORD DEMO"
           DISPLAY "========================================"
           DISPLAY "EMPLOYEE ID:    " EMPLOYEE-ID
           DISPLAY "FIRST NAME:     " FIRST-NAME
           DISPLAY "SECOND NAME:    " SECOND-NAME
           DISPLAY "LAST NAME:      " LAST-NAME
           DISPLAY "PAYMENT DATE:   "
                   PAYMENT-MONTH "/"
                   PAYMENT-DAY "/"
                   PAYMENT-YEAR
           DISPLAY "HOURS WORKED:   " HOURS-WORKED
           DISPLAY "========================================"

           STOP RUN.
           