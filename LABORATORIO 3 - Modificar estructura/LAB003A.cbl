      *-----------------------------------------------------------------
       IDENTIFICATION DIVISION. 
      *-----------------------------------------------------------------
       PROGRAM-ID.                     LAB003A.
       AUTHOR.                         AYMARA M FUSARO.
      *-----------------------------------------------------------------
       ENVIRONMENT DIVISION.
      *-----------------------------------------------------------------
       CONFIGURATION SECTION.
      *
       INPUT-OUTPUT SECTION. 
      *
       FILE-CONTROL. 
           SELECT ACCT-REC     ASSIGN  TO ACCTREC
                  ORGANIZATION         IS SEQUENTIAL.
           SELECT PRINT-LINE   ASSIGN  TO PRTLINE
                  ORGANIZATION         IS SEQUENTIAL.
      *
      *-----------------------------------------------------------------
       DATA DIVISION. 
      *-----------------------------------------------------------------
       FILE SECTION.
      *
       FD  ACCT-REC RECORDING MODE F.
       01  REGISTRO-ENTRADA.
           05 IN-NOMBRE                PIC X(20).
           05 IN-DIPLOMA               PIC 9(4).
           05 IN-ANIO                  PIC 9(4).
           05 IN-PRESTAMO              PIC 9(5)V99.
           05 IN-PAGO1                 PIC 9(4)V99.
           05 IN-PAGO2                 PIC 9(4)V99.
           05 IN-PAGO3                 PIC 9(4)V99.
           05 IN-PAGO4                 PIC 9(4)V99.
           05 FILLER                   PIC X(21).
      *
       FD PRINT-LINE RECORDING MODE F. 
       01  REGISTRO-SALIDA.
           05 OUT-NOMBRE               PIC X(20).
           05 OUT-DIPLOMA              PIC 9(4).
           05 OUT-ANIO                 PIC 9(4).
           05 OUT-PRESTAMO             PIC 9(5)V99.
           05 OUT-PAGO1                PIC 9(4)V99.
           05 OUT-PAGO2                PIC 9(4)V99.
           05 OUT-PAGO3                PIC 9(4)V99.
           05 OUT-PAGO4                PIC 9(4)V99.
           05 OUT-TOT-PAGO             PIC 9(5)V99.
           05 OUT-BALANCE              PIC 9(5)V99.
           05 FILLER                   PIC X(11).
      *
       WORKING-STORAGE SECTION. 
       01  FLAGS.
           05 LASTREC                  PIC X VALUE SPACE.
              88 LAST-REC                    VALUE 'N'.
       01  WSV-TOT-CALCULO.
           05 WSV-TOT-PAGO             PIC 9(5)V99 VALUE ZEROS.
           05 WSV-BALANCE              PIC 9(5)V99 VALUE ZEROS.
       01  CONT-RENG                   PIC 9(2).
       01  LIN-SALIDA                  PIC X(132).
      *
      *-----------------------------------------------------------------
       PROCEDURE DIVISION.
      *-----------------------------------------------------------------
       00-OPEN-FILES.
           OPEN INPUT                  ACCT-REC.
           OPEN OUTPUT                 PRINT-LINE.
      *
       10-READ-NEXT-RECORD.
           PERFORM UNTIL LAST-REC
                   PERFORM 20-READ-RECORD    THRU 20-END
                   PERFORM 30-WRITE-RECORD   THRU 30-END
           END-PERFORM.
      *
       20-READ-RECORD.
           READ ACCT-REC
           AT END SET LAST-REC TO TRUE
           PERFORM 40-CLOSE-STOP
           END-READ.
       20-END. EXIT.
      *
       30-WRITE-RECORD.
           COMPUTE OUT-TOT-PAGO = 
                   (IN-PAGO1 + 
                    IN-PAGO2 + 
                    IN-PAGO3 + 
                    IN-PAGO4).
           COMPUTE OUT-BALANCE = 
                   (IN-PRESTAMO - 
                    OUT-TOT-PAGO).
           WRITE REGISTRO-SALIDA.
       30-END. EXIT.
      *
       40-CLOSE-STOP.
           CLOSE ACCT-REC.
           CLOSE PRINT-LINE.
           STOP RUN.
      *
       50-RUTINA-IMPRESION.
            IF CONT-RENG = 66
              PERFORM 50-RUTINA-IMPRESION    THRU 50-END
              MOVE REGISTRO-ENTRADA          TO   REGISTRO-SALIDA 
              MOVE WSV-TOT-CALCULO           TO   REGISTRO-SALIDA
              WRITE REGISTRO-SALIDA          FROM LIN-SALIDA
                 AFTER ADVANCING 1 LINE 
                 ADD 1 TO CONT-RENG
            END-IF.
       50-END. EXIT.
      *
       60-RUT-ENC.
           MOVE ZEROS TO CONT-RENG.
           WRITE REGISTRO-SALIDA             FROM LIN-SALIDA
                 BEFORE ADVANCING PAGE 
           ADD 3 TO CONT-RENG.
       60-END. EXIT.
