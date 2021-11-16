1. Modifique las estructuras de entrada, las estrucuturas de impresión y el código para producir la siguiente salida: (sus nombres pueden ser diferentes según lo que utilizó en laboratorios anteriores).

   NOMBRE             Diploma    AÑO

   VICKI HAMPTON      MBA        1950
   GEORGE WASHINGTON  BA         1920
   IVAN ISGREAT       BS         1999
   IGOR ISBETTER      BSB        2000
   IVANA GOHOME       BA         1995
   COB OL             BS         1976
   HUGH LESS          MBA        1975
   GARY MORE          BA         2001
   PAULA PANTHER      MBA        2002



2. Diseño ACTUAL de Archivo de INPUT
Longitud del registro de INPUT es 80 bytes.

NOMBRE             es 20
DIPLOMA            es 4
AÑO                es 4
Resto              es FILLER



3. El archivo INPUT file necesita ser modificado para que coincida con lo siguiente:
Lalongitud del registro de INPUT es de 80 bytes.

NOMBRE                           es 20
Diploma                          es 4
AÑO                              es 4
El monto del préstamo            es 99999.99
El monto del pago 1              es 9999.99
El monto del pago 2              es 9999.99
El monto del pago 3              es 9999.99
El monto del pago 4              es 9999.99
El resto                         es FILLER



4. Acontinuación, se muestra una muestra de los datos de ENTRADA reales

//GO.INPUT DD *
VICKI HAMPTON      MBA 19501500000200000250000300000750000
GEORGE WASHINGTON  BA  19200050000005000005000010000000000
IVAN ISGREAT       BS  19992500000500000500000900000000000
IGOR ISBETTER      BSB 20000000000000000000000000000000000
IVANA GOHOME       BA  19955000000900000900000900000900000
COB OL             BS  19760450000200000050000100000000000
HUGH LESS          MBA 19750100000005000025000002500000000
GARY MORE          BA  20016124500900000999900999900000000
PAULA PANTHER      MBA 20020545000200000200000000000000000



5. Se requiere:
- Cree un diseño de impresora que producirá la salida como se muestra a continuación.
- Con este diseño, modifique la estructura de datos de impresión y la línea de WS.
- Crear un nuevo procedimiento que tenga la responsabilidad de calcular el monto total pagado y el saldo adeudado (monto del préstamo - monto total pagado). Estos nuevos totales deben imprimirse.



6. Diseño de OUTPUT impreso:

NOMBRE                DIPLOM    AÑO    PREST.      PAGO1     PAGO2     PAGO3     PAGO4    TOT PAGO      BALANCE

VICKI HAMPTON         MBA       1950   15000.00   2000.00   2500.00   3000.00   7500.00   15000.00         0.00
GEORGE WASHINGTON     BA        1920   00500.00   0050.00   0050.00   0100.00   0000.00   00200.00       300.00
IVAN ISGREAT          BS        1999   25000.00   5000.00   5000.00   9000.00   0000.00   19000.00      6000.00
IGOR ISBETTER         BSB       2000   00000.00   0000.00   0000.00   0000.00   0000.00   00000.00         0.00
IVANA GOHOME          BA        1995   50000.00   9000.00   9000.00   9000.00   9000.00   36000.00     14000.00
COB OL                BS        1976   04500.00   2000.00   0500.00   1000.00   0000.00   03500.00      1000.00
HUGH LESS             MBA       1975   01000.00   0050.00   0250.00   0025.00   0000.00   00325.00       675.00
GARY MORE             BA        2001   61245.00   9000.00   9999.00   9999.00   0000.00   28998.00     32247.00
PAULA PANTHER         MBA       2002   05450.00   2000.00   2000.00   0000.00   0000.00   04000.00      1450.00