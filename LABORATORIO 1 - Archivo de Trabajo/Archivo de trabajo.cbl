      *----------------------------------------------------------------- 
       IDENTIFICATION DIVISION.
      *-----------------------------------------------------------------
       PROGRAM-ID.                     ARCHIVO-TRABAJO.
       AUTHOR.                         AYMARA M FUSARO.
      *-----------------------------------------------------------------
       DATA DIVISION.
      *-----------------------------------------------------------------
       WORKING-STORAGE SECTION.
      *
       01  REGISTRO-TRABAJO.
           05 APYN.
              10 NOMBRE                PIC X(20).
              10 NOMBRE-2              PIC X(10).
              10 APELLIDO              PIC X(30).
           05 NUMERO-EMPLEADO          PIC 9(9).
           05 FECHA-PAGO.
              10 MES                   PIC 9(2).
              10 DIA                   PIC 9(2).
              10 ANIO                  PIC 9(4).
           05 HORAS-TRABAJADAS         PIC 9(3)V9.