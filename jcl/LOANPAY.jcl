//LOANPAY  JOB
//*--------------------------------------------------
//* LOAN PAYMENT PROCESSING
//* BATCH JOB
//*--------------------------------------------------
//STEP01   EXEC PGM=LOANPAY
//SYSOUT   DD SYSOUT=*
//INPUT    DD DSN=LOAN.ACCOUNTS,DISP=SHR
//REPORT   DD DSN=LOAN.REPORT,DISP=NEW
//ERRORS   DD DSN=LOAN.ERRORS,DISP=NEW
//*--------------------------------------------------
//* STEP 02 - REPORT VALIDATION
//*--------------------------------------------------
//STEP02   EXEC PGM=REPORTCHK
//SYSOUT   DD SYSOUT=*
//REPORT   DD DSN=LOAN.REPORT,DISP=SHR
//ERRORS   DD DSN=LOAN.ERRORS,DISP=SHR
//*
