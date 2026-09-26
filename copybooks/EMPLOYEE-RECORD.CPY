       01  EMPLOYEE-RECORD.
           05  EMPLOYEE-NAME.
               10  FIRST-NAME        PIC X(20).
               10  SECOND-NAME       PIC X(10).
               10  LAST-NAME         PIC X(30).

           05  EMPLOYEE-ID           PIC 9(9).

           05  PAYMENT-DATE.
               10  PAYMENT-MONTH     PIC 9(2).
               10  PAYMENT-DAY       PIC 9(2).
               10  PAYMENT-YEAR      PIC 9(4).

           05  HOURS-WORKED          PIC 9(3)V9.
           