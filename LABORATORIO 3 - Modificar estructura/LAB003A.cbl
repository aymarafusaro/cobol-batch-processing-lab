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
           SELECT PRINT-LINE   ASSIGN  TO PRTLINE.
           SELECT ACCT-REC     ASSIGN  TO ACCTREC
                  ORGANIZATION         IS SEQUENTIAL.
      *
      *-----------------------------------------------------------------
       DATA DIVISION. 
      *-----------------------------------------------------------------
       FILE SECTION.
       FD PRINT-LINE RECORDING MODE F. 
      *
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



           