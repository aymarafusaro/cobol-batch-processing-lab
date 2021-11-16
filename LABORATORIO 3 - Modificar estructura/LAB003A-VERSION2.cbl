      *-----------------------------------------------------------------
       IDENTIFICATION DIVISION.
      *-----------------------------------------------------------------
       PROGRAM-ID.                     'LAB003A-VERSION2'.
       AUTHOR.                         AYMARA M FUSARO.
      *-----------------------------------------------------------------
       DATA DIVISION.
      *-----------------------------------------------------------------
       WORKING-STORAGE SECTION.
       01 WSC-CONSTANTES.
          05 WSC-TIT-1.
             10 WSC-NOMBRE             PIC X(06) VALUE 'NOMBRE'.
             10 FILLER                 PIC X(16) VALUE SPACES. 
             10 WSC-DIPLOM             PIC X(07) VALUE 'DIPLOMA'.
             10 FILLER                 PIC X(02) VALUE SPACES.
             10 WSC-ANIO               PIC X(04) VALUE 'AÑO'.
             10 FILLER                 PIC X(03) VALUE SPACES.
             10 WSC-PRESTAMO           PIC X(08) VALUE 'PRESTAMO'.
             10 FILLER                 PIC X(02) VALUE SPACES.
             10 WSC-PAGO1              PIC X(05) VALUE 'PAGO1'.
             10 FILLER                 PIC X(04) VALUE SPACES.
             10 WSC-PAGO2              PIC X(05) VALUE 'PAGO2'.
             10 FILLER                 PIC X(04) VALUE SPACES.
             10 WSC-PAGO3              PIC X(05) VALUE 'PAGO3'.
             10 FILLER                 PIC X(04) VALUE SPACES.
             10 WSC-PAGO4              PIC X(05) VALUE 'PAGO4'.
             10 FILLER                 PIC X(04) VALUE SPACES.
             10 WSC-TOTPAGO            PIC X(08) VALUE 'TOT PAGO'.
             10 FILLER                 PIC X(03) VALUE SPACES.
             10 WSC-BALANCE            PIC X(07) VALUE 'BALANCE'.
      *
          05 WSC-GUIONES.
             10 WSC-NOMBRE-G           PIC X(20) VALUE ALL '-'.
             10 FILLER                 PIC X(02) VALUE SPACES. 
             10 WSC-DIPLOM-G           PIC X(07) VALUE ALL '-'.
             10 FILLER                 PIC X(02) VALUE SPACES.
             10 WSC-ANIO-G             PIC X(04) VALUE ALL '-'.
             10 FILLER                 PIC X(02) VALUE SPACES.
             10 WSC-PRESTAMO-G         PIC X(08) VALUE ALL '-'.
             10 FILLER                 PIC X(02) VALUE SPACES.
             10 WSC-PAGO1-G            PIC X(07) VALUE ALL '-'.
             10 FILLER                 PIC X(02) VALUE SPACES.
             10 WSC-PAGO2-G            PIC X(07) VALUE ALL '-'.
             10 FILLER                 PIC X(02) VALUE SPACES.
             10 WSC-PAGO3-G            PIC X(07) VALUE ALL '-'.
             10 FILLER                 PIC X(02) VALUE SPACES.
             10 WSC-PAGO4-G            PIC X(07) VALUE ALL '-'.
             10 FILLER                 PIC X(02) VALUE SPACES.
             10 WSC-TOTPAGO-G          PIC X(08) VALUE ALL '-'.
             10 FILLER                 PIC X(02) VALUE SPACES.
             10 WSC-BALANCE-G          PIC X(08) VALUE ALL '-'. 
      *
       01 WSV-VARIABLES.
          05 WSV-POSTULANTES.
             10 WSV-POSTU1.
                15 WSV-NOMBRE-1        PIC X(20) VALUE 
                                       'VICKI HAMPTON'.
                15 WSV-DIPLOMA-1       PIC X(04) VALUE 'MBA'. 
                15 WSV-ANIO-1          PIC 9(04) VALUE 1950.
                15 WSV-PRESTAMO-1      PIC 9(05)V99 VALUE 15000.00.
                15 WSV-PAGO1-1         PIC 9(04)V99 VALUE 2000.00.
                15 WSV-PAGO2-1         PIC 9(04)V99 VALUE 2500.00.
                15 WSV-PAGO3-1         PIC 9(04)V99 VALUE 3000.00.
                15 WSV-PAGO4-1         PIC 9(04)V99 VALUE 7500.00.
      *
             10 WSV-POSTU2.
                15 WSV-NOMBRE-2        PIC X(20) VALUE 
                                       'GEORGE WASHINGTON'.
                15 WSV-DIPLOMA-2       PIC X(04) VALUE 'BA'. 
                15 WSV-ANIO-2          PIC 9(04) VALUE 1920.
                15 WSV-PRESTAMO-2      PIC 9(05)V99 VALUE 00500.00.
                15 WSV-PAGO1-2         PIC 9(04)V99 VALUE 0050.00.
                15 WSV-PAGO2-2         PIC 9(04)V99 VALUE 0050.00.
                15 WSV-PAGO3-2         PIC 9(04)V99 VALUE 0100.00.
                15 WSV-PAGO4-2         PIC 9(04)V99 VALUE 0000.00.
      *
             10 WSV-POSTU3.
                15 WSV-NOMBRE-3        PIC X(20) VALUE 
                                       'IVAN ISGREAT'.
                15 WSV-DIPLOMA-3       PIC X(04) VALUE 'BS'. 
                15 WSV-ANIO-3          PIC 9(04) VALUE 1999.
                15 WSV-PRESTAMO-3      PIC 9(05)V99 VALUE 25000.00.
                15 WSV-PAGO1-3         PIC 9(04)V99 VALUE 5000.00.
                15 WSV-PAGO2-3         PIC 9(04)V99 VALUE 5000.00.
                15 WSV-PAGO3-3         PIC 9(04)V99 VALUE 9000.00.
                15 WSV-PAGO4-3         PIC 9(04)V99 VALUE 0000.00.
      *
          05 WSV-POSTULANTE-AUX.
             10 WSV-NOMBRE-AUX          PIC X(20).
             10 WSV-DIPLOMA-AUX         PIC X(04).
             10 WSV-ANIO-AUX            PIC 9(04).
             10 WSV-PRESTAMO-AUX        PIC 9(05)V99.
             10 WSV-PAGO1-AUX           PIC 9(04)V99.
             10 WSV-PAGO2-AUX           PIC 9(04)V99.
             10 WSV-PAGO3-AUX           PIC 9(04)V99.
             10 WSV-PAGO4-AUX           PIC 9(04)V99.
             10 WSV-TOT-PAGO            PIC 9(05)V99.
             10 WSV-BALANCE             PIC 9(05)V99.
      *-----------------------------------------------------------------
       PROCEDURE DIVISION.
      *----------------------------------------------------------------- 
       00-CONTROL.
            PERFORM 10-INICIO.
            PERFORM 20-PROCESO.
            STOP RUN.
       00-END. EXIT.
      * 
       10-INICIO.
            PERFORM 50-TITULOS THRU 50-END.
            INITIALIZE WSV-POSTULANTE-AUX.
       10-END. EXIT.
      * 
       20-PROCESO.
            MOVE WSV-POSTU1 TO WSV-POSTULANTE-AUX.
            PERFORM 25-CALCULAR-TOTAL.
            PERFORM 30-CALCULAR-BALANCE.
      *  
            MOVE WSV-POSTU2 TO WSV-POSTULANTE-AUX.
            PERFORM 25-CALCULAR-TOTAL.
            PERFORM 30-CALCULAR-BALANCE.
      * 
            MOVE WSV-POSTU3 TO WSV-POSTULANTE-AUX.
            PERFORM 25-CALCULAR-TOTAL.
            PERFORM 30-CALCULAR-BALANCE.
       20-END. EXIT.
      * 
       25-CALCULAR-TOTAL.
            COMPUTE WSV-TOT-PAGO  =
                    WSV-PAGO1-AUX +
                    WSV-PAGO2-AUX +
                    WSV-PAGO3-AUX +
                    WSV-PAGO4-AUX.
       25-END. EXIT.
      * 
       30-CALCULAR-BALANCE.
            COMPUTE WSV-BALANCE =
                    WSV-PRESTAMO-AUX -
                    WSV-TOT-PAGO.
            PERFORM 60-FINAL THRU 60-END.
       30-END. EXIT.
      * 
       50-TITULOS.
             DISPLAY WSC-TIT-1.
             DISPLAY WSC-GUIONES.
       50-END. EXIT.
      *
       60-FINAL.
           DISPLAY WSV-NOMBRE-AUX  '  '
                  WSV-DIPLOMA-AUX  '     '
                  WSV-ANIO-AUX     '  '
                  WSV-PRESTAMO-AUX '  '
                  WSV-PAGO1-AUX    '  '
                  WSV-PAGO2-AUX    '  '
                  WSV-PAGO3-AUX    '  '
                  WSV-PAGO4-AUX    '  '
                  WSV-TOT-PAGO     '  '
                  WSV-BALANCE.  
       60-END. EXIT.
