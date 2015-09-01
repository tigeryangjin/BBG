CREATE OR REPLACE PROCEDURE W_RTL_SLS_TRX_LC_DY_A_UPD IS

BEGIN

  EXECUTE IMMEDIATE 'ALTER TABLE RADM.W_RTL_SLS_TRX_LC_DY_A NOLOGGING';
  EXECUTE IMMEDIATE 'ALTER SESSION ENABLE PARALLEL DML';

  UPDATE /*+PARALLEL(16)*/ RADM.W_RTL_SLS_TRX_LC_DY_A A 
     SET A.VIP_N69_NET_SALES_AMT = A.N69_NET_SALES_AMT
   WHERE A.HYK_NO IS NOT NULL
     AND A.VIP_N69_NET_SALES_AMT IS NULL;
  COMMIT;

  UPDATE /*+PARALLEL(16)*/ RADM.W_RTL_SLS_TRX_LC_DY_A A 
     SET A.VIP_N69_NET_SALES_AMT = 0
   WHERE A.HYK_NO IS NULL
     AND A.VIP_N69_NET_SALES_AMT IS NULL;
  COMMIT;

  UPDATE /*+PARALLEL(16)*/ RADM.W_RTL_SLS_TRX_LC_DY_A A 
     SET A.VIP_N69_NET_SALES_AMT_INC_TAX = A.N69_NET_SALES_AMT_INC_TAX
   WHERE A.HYK_NO IS NOT NULL
     AND A.VIP_N69_NET_SALES_AMT_INC_TAX IS NULL;
  COMMIT;

  UPDATE /*+PARALLEL(16)*/ RADM.W_RTL_SLS_TRX_LC_DY_A A 
     SET A.VIP_N69_NET_SALES_AMT_INC_TAX = 0
   WHERE A.HYK_NO IS NULL
     AND A.VIP_N69_NET_SALES_AMT_INC_TAX IS NULL;
  COMMIT;
  EXECUTE IMMEDIATE 'ALTER TABLE RADM.W_RTL_SLS_TRX_LC_DY_A LOGGING';
END;
/
