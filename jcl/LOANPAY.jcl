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
//*