# Cobol-Batch-Processing-Lab

Laboratorio de procesamiento batch desarrollado en COBOL, basado en conceptos y patrones habituales de entornos Mainframe.

El proyecto simula un proceso batch de procesamiento de cuentas de préstamos, utilizando archivos secuenciales de entrada y salida, archivos de control, validaciones, códigos de rechazo, generación de reportes y una segunda etapa de validación del reporte.

## Tecnologías

* COBOL / GnuCOBOL 3.2
* JCL — representación de ejecución batch en IBM Z
* Archivos secuenciales
* Procesamiento batch
* Validación de datos
* Manejo de errores y códigos de rechazo
* Estructuración mediante párrafos COBOL
* macOS para desarrollo y pruebas locales

## Estructura del proyecto

```text
Diplo-COBOL/
├── copybooks/
├── data/
│   ├── input/
│   └── output/
├── docs/
├── jcl/
├── programs/
├── tests/
├── LABORATORIO 1 - Archivo de Trabajo/
├── LABORATORIO 3 - Modificar estructura/
└── README.md
```

## Programas principales

### EMPLOYEE-RECORD

`programs/employee-record.cbl`

Ejemplo de definición y utilización de una estructura de registro COBOL mediante un copybook.

Utiliza:

```text
copybooks/EMPLOYEE-RECORD.CPY
```

El programa carga datos de un empleado y muestra:

* Identificación del empleado
* Nombre y apellido
* Fecha de pago
* Horas trabajadas

### LOAN-PAYMENT-PROCESSING

`programs/loan-payment-processing.cbl`

Programa principal de procesamiento batch.

El flujo general es:

```text
CONTROL FILE
     |
     v
VALIDACIÓN DEL CONTROL
     |
     v
LOAN INPUT FILE
     |
     v
VALIDACIÓN DE CADA REGISTRO
     |
     +----> REGISTRO VÁLIDO
     |          |
     |          v
     |      PROCESAMIENTO
     |          |
     |          v
     |      LOAN REPORT
     |
     +----> REGISTRO INVÁLIDO
                |
                v
           ERROR REPORT
```

El programa:

1. Lee un archivo de control.
2. Valida la fecha de proceso y el monto máximo permitido.
3. Lee las cuentas de préstamos.
4. Valida los datos numéricos.
5. Verifica el límite máximo del préstamo.
6. Calcula el total pagado.
7. Calcula el saldo.
8. Genera un reporte de préstamos procesados.
9. Genera un archivo de registros rechazados.
10. Informa contadores del procesamiento batch.

## Archivo de control

```text
data/input/loan-control.dat
```

Formato:

```text
PROCESS-DATE|MAX-LOAN
```

Ejemplo:

```text
2026-09-27|20000.00
```

El procesamiento se aborta si el archivo de control contiene datos inválidos.

## Validaciones

El programa utiliza códigos de rechazo centralizados:

```text
E001 - INVALID NUMERIC DATA
E002 - MAX LOAN EXCEEDED
```

Ejemplos:

* Datos numéricos inválidos → `E001`
* Préstamo superior al máximo permitido → `E002`

Esto permite mantener una identificación consistente de los errores durante el procesamiento.

## Archivos de salida

### Loan report

```text
data/output/loan-report.txt
```

Contiene:

* Fecha de proceso
* Monto máximo permitido
* Registros procesados
* Total pagado
* Saldo
* Contadores del procesamiento

### Error report

```text
data/output/errors.txt
```

Contiene los registros rechazados y su motivo.

Ejemplo:

```text
REJECTED - E002 - MAX LOAN EXCEEDED
REJECTED - E001 - INVALID NUMERIC DATA
```

## REPORT-CHECK

`programs/report-check.cbl`

Programa utilizado como segunda etapa de validación del procesamiento batch.

El programa lee:

```text
data/output/loan-report.txt
```

y verifica la presencia de los principales componentes del reporte:

* `LOAN PAYMENT PROCESSING REPORT`
* `PROCESS DATE:`
* `MAX LOAN:`
* `RECORDS READ:`
* `RECORDS PROCESSED:`
* `RECORDS REJECTED:`

El resultado puede ser:

```text
REPORT STATUS: VALID
```

o:

```text
REPORT STATUS: INVALID
```

## Escenarios de prueba

Se probaron diferentes situaciones para verificar la validación del reporte.

### Reporte válido

Resultado:

```text
REPORT STATUS: VALID
```

### Encabezado ausente

Se eliminó temporalmente:

```text
LOAN PAYMENT PROCESSING REPORT
```

Resultado:

```text
REPORT STATUS: INVALID
```

### Contador ausente

Se eliminó temporalmente:

```text
RECORDS REJECTED:
```

Resultado:

```text
REPORT STATUS: INVALID
```

Después de las pruebas, el reporte original fue restaurado y nuevamente validado correctamente.

## JCL

```text
jcl/LOANPAY.jcl
```

El archivo representa una ejecución batch equivalente a un entorno IBM Z.

El flujo definido contiene:

```text
STEP01 - LOAN PAYMENT PROCESSING
STEP02 - REPORT VALIDATION
```

El segundo paso utiliza `REPORTCHK` para validar el reporte generado por el primer paso.

## Ejecución local

Para compilar el procesamiento de préstamos:

```bash
cobc -x -free -o loan-payment-processing programs/loan-payment-processing.cbl
```

Ejecutar:

```bash
./loan-payment-processing
```

Para compilar el validador:

```bash
cobc -x -free -o report-check programs/report-check.cbl
```

Ejecutar:

```bash
./report-check
```

## Conceptos Mainframe representados

Este laboratorio practica conceptos aplicables a entornos Mainframe:

* COBOL Batch
* Procesamiento secuencial de archivos
* Validación de registros
* Control de ejecución
* Archivos de control
* Códigos de error
* Reportes batch
* Contadores de procesamiento
* Separación entre procesamiento y validación
* Estructuración mediante párrafos
* JCL
* Flujo de múltiples pasos batch

## Objetivo del laboratorio

El objetivo es practicar el diseño de un flujo batch estructurado en COBOL, desde la recepción y validación de datos hasta la generación y posterior validación de resultados.

El proyecto fue desarrollado y probado localmente utilizando GnuCOBOL, manteniendo una estructura y nomenclatura orientadas a conceptos utilizados en proyectos Mainframe.
