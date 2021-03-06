CREATE OR REPLACE PROCEDURE JIN_UPD_CUST_PROC(DTWID INT) AS

BEGIN
  --CREATE BAK TABLE
  BEGIN
    BEGIN
      EXECUTE IMMEDIATE 'TRUNCATE TABLE RADM.W_RTL_SLS_TRX_IT_LC_DY_F_BAK';
      INSERT /*+PARALLEL(16)*/
      INTO RADM.W_RTL_SLS_TRX_IT_LC_DY_F_BAK
        SELECT /*+PARALLEL(16)*/
         *
          FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_F
         WHERE DT_WID = DTWID;
      COMMIT;
    END;
  
    --5.1.BBG_RA_CUST_SC_LC_DY_A
    BEGIN
      EXECUTE IMMEDIATE 'ALTER TABLE RADM.BBG_RA_CUST_SC_LC_DY_A NOLOGGING';
      EXECUTE IMMEDIATE 'ALTER SESSION ENABLE PARALLEL DML';
    
      MERGE /*+APPEND PARALLEL(T,16) PARALLEL(S,16)*/
      INTO RADM.BBG_RA_CUST_SC_LC_DY_A T
      USING (SELECT /*+PARALLEL(16)*/
              D.ORG_WID,
              D.ORG_DH_WID,
              D.ORG_SCD1_WID,
              D.PROD_SC_WID PROD_DH_WID,
              D.DT_WID,
              D.DATASOURCE_NUM_ID,
              SYSDATE W_INSERT_DT,
              SYSDATE W_UPDATE_DT,
              D.INTEGRATION_ID,
              COUNT(DISTINCT D.SLS_TRX_ID) BBG_CUSTOMER_COUNT,
              COUNT(DISTINCT DECODE(D.HYK_NO, '', '', D.SLS_TRX_ID)) VIP_BBG_CUSTOMER_COUNT,
              AVG(D.BBG_SERVICE_SATISFACTION) BBG_SERVICE_SATISFACTION
               FROM (SELECT /*+PARALLEL(16)*/
                      A.PROD_WID,
                      B.PROD_SC_WID,
                      A.ORG_WID,
                      A.ORG_DH_WID,
                      A.ORG_SCD1_WID,
                      A.DT_WID,
                      A.SLS_TRX_ID,
                      C.ORG_NUM || '~' ||
                      TO_CHAR(TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD'),
                              'DD-MON-YY',
                              'NLS_DATE_LANGUAGE = American') || '~' ||
                      TO_CHAR(B.PROD_SC_NUM) INTEGRATION_ID,
                      1 DATASOURCE_NUM_ID,
                      NVL(A.BBG_SERVICE_SATISFACTION, 0) BBG_SERVICE_SATISFACTION,
                      A.HYK_NO
                       FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_F_BAK A,
                            RABATCHER.W_PRODUCT_D_RTL_TMP     B,
                            RADM.W_INT_ORG_D                  C
                      WHERE A.PROD_WID = B.PROD_IT_WID
                        AND A.ORG_WID = C.ROW_WID) D
              GROUP BY D.ORG_WID,
                       D.ORG_DH_WID,
                       D.ORG_SCD1_WID,
                       D.PROD_SC_WID,
                       D.DT_WID,
                       D.DATASOURCE_NUM_ID,
                       D.INTEGRATION_ID) S
      ON (T.PROD_DH_WID = S.PROD_DH_WID AND T.ORG_WID = S.ORG_WID AND T.DT_WID = S.DT_WID)
      WHEN MATCHED THEN
        UPDATE
           SET T.BBG_CUSTOMER_COUNT       = S.BBG_CUSTOMER_COUNT,
               T.VIP_BBG_CUSTOMER_COUNT   = S.VIP_BBG_CUSTOMER_COUNT,
               T.BBG_SERVICE_SATISFACTION = S.BBG_SERVICE_SATISFACTION,
               T.VIP_SLS_INC_AMT_LCL      = 0,
               T.VIP_TAX_AMT_LCL          = 0,
               T.W_UPDATE_DT              = SYSDATE
      WHEN NOT MATCHED THEN
        INSERT
          (T.ROW_WID,
           T.ORG_WID,
           T.ORG_DH_WID,
           T.ORG_SCD1_WID,
           T.PROD_DH_WID,
           T.DT_WID,
           T.DATASOURCE_NUM_ID,
           T.W_INSERT_DT,
           T.W_UPDATE_DT,
           T.INTEGRATION_ID,
           T.BBG_CUSTOMER_COUNT,
           T.VIP_BBG_CUSTOMER_COUNT,
           T.VIP_SLS_INC_AMT_LCL,
           T.VIP_TAX_AMT_LCL,
           T.BBG_SERVICE_SATISFACTION,
           T.BBG_REFERENCE_DO1,
           T.BBG_REFERENCE_DO2,
           T.BBG_REFERENCE_DO3,
           T.BBG_REFERENCE_DO4,
           T.BBG_REFERENCE_DO5,
           T.BBG_REFERENCE_FO1,
           T.BBG_REFERENCE_FO2,
           T.BBG_REFERENCE_FO3,
           T.BBG_REFERENCE_FO4,
           T.BBG_REFERENCE_FO5,
           T.BBG_REFERENCE_FO6,
           T.BBG_REFERENCE_FO7,
           T.BBG_REFERENCE_FO8,
           T.BBG_REFERENCE_FO9,
           T.BBG_REFERENCE_FO10)
        VALUES
          (BBG_RA_CUST_SC_LC_DY_HR_A_SEQ.NEXTVAL,
           S.ORG_WID,
           S.ORG_DH_WID,
           S.ORG_SCD1_WID,
           S.PROD_DH_WID,
           S.DT_WID,
           S.DATASOURCE_NUM_ID,
           S.W_INSERT_DT,
           S.W_UPDATE_DT,
           S.INTEGRATION_ID,
           S.BBG_CUSTOMER_COUNT,
           S.VIP_BBG_CUSTOMER_COUNT,
           0,
           0,
           S.BBG_SERVICE_SATISFACTION,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL);
      COMMIT;
    
      EXECUTE IMMEDIATE 'ALTER TABLE RADM.BBG_RA_CUST_SC_LC_DY_A LOGGING';
    END;
    --5.2.BBG_RA_CUST_SC_LC_DY_HR_A
    BEGIN
      EXECUTE IMMEDIATE 'ALTER TABLE RADM.BBG_RA_CUST_SC_LC_DY_HR_A NOLOGGING';
      EXECUTE IMMEDIATE 'ALTER SESSION ENABLE PARALLEL DML';
    
      MERGE /*+APPEND PARALLEL(T,16) PARALLEL(S,16)*/
      INTO RADM.BBG_RA_CUST_SC_LC_DY_HR_A T
      USING (SELECT /*+PARALLEL(16)*/
              D.ORG_WID,
              D.ORG_DH_WID,
              D.ORG_SCD1_WID,
              D.PROD_SC_WID PROD_DH_WID,
              D.DT_WID,
              D.MIN_WID MINUTE_WID,
              D.DATASOURCE_NUM_ID,
              SYSDATE W_INSERT_DT,
              SYSDATE W_UPDATE_DT,
              D.INTEGRATION_ID,
              COUNT(DISTINCT D.SLS_TRX_ID) BBG_CUSTOMER_COUNT,
              COUNT(DISTINCT DECODE(D.HYK_NO, '', '', D.SLS_TRX_ID)) VIP_BBG_CUSTOMER_COUNT,
              AVG(D.BBG_SERVICE_SATISFACTION) BBG_SERVICE_SATISFACTION
               FROM (SELECT /*+PARALLEL(16)*/
                      A.PROD_WID,
                      B.PROD_SC_WID,
                      A.ORG_WID,
                      A.ORG_DH_WID,
                      A.ORG_SCD1_WID,
                      A.DT_WID,
                      TRUNC(A.MIN_WID / 100) * 100 +
                      LPAD(TRUNC((A.MIN_WID - TRUNC(A.MIN_WID / 100) * 100) / 15) * 15,
                           2,
                           '0') MIN_WID,
                      A.SLS_TRX_ID,
                      C.ORG_NUM || '~' ||
                      TO_CHAR(TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD'),
                              'DD-MON-YY',
                              'NLS_DATE_LANGUAGE = American') || '~' ||
                      TO_CHAR(TRUNC(A.MIN_WID / 100) * 100 +
                              LPAD(TRUNC((A.MIN_WID -
                                         TRUNC(A.MIN_WID / 100) * 100) / 15) * 15,
                                   2,
                                   '0')) || '~' || TO_CHAR(B.PROD_SC_NUM) INTEGRATION_ID,
                      1 DATASOURCE_NUM_ID,
                      NVL(A.BBG_SERVICE_SATISFACTION, 0) BBG_SERVICE_SATISFACTION,
                      A.HYK_NO
                       FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_F_BAK A,
                            RABATCHER.W_PRODUCT_D_RTL_TMP     B,
                            RADM.W_INT_ORG_D                  C
                      WHERE A.PROD_WID = B.PROD_IT_WID
                        AND A.ORG_WID = C.ROW_WID) D
              GROUP BY D.ORG_WID,
                       D.ORG_DH_WID,
                       D.ORG_SCD1_WID,
                       D.PROD_SC_WID,
                       D.DT_WID,
                       D.MIN_WID,
                       D.DATASOURCE_NUM_ID,
                       D.INTEGRATION_ID) S
      ON (T.PROD_DH_WID = S.PROD_DH_WID AND T.ORG_WID = S.ORG_WID AND T.DT_WID = S.DT_WID AND T.MINUTE_WID = S.MINUTE_WID)
      WHEN MATCHED THEN
        UPDATE
           SET T.BBG_CUSTOMER_COUNT       = S.BBG_CUSTOMER_COUNT,
               T.VIP_BBG_CUSTOMER_COUNT   = S.VIP_BBG_CUSTOMER_COUNT,
               T.BBG_SERVICE_SATISFACTION = S.BBG_SERVICE_SATISFACTION,
               T.VIP_SLS_INC_AMT_LCL      = 0,
               T.VIP_TAX_AMT_LCL          = 0,
               T.W_UPDATE_DT              = SYSDATE
      WHEN NOT MATCHED THEN
        INSERT
          (T.ROW_WID,
           T.ORG_WID,
           T.ORG_DH_WID,
           T.ORG_SCD1_WID,
           T.PROD_DH_WID,
           T.DT_WID,
           T.MINUTE_WID,
           T.DATASOURCE_NUM_ID,
           T.W_INSERT_DT,
           T.W_UPDATE_DT,
           T.INTEGRATION_ID,
           T.BBG_CUSTOMER_COUNT,
           T.VIP_BBG_CUSTOMER_COUNT,
           T.VIP_SLS_INC_AMT_LCL,
           T.VIP_TAX_AMT_LCL,
           T.BBG_SERVICE_SATISFACTION,
           T.BBG_REFERENCE_DO1,
           T.BBG_REFERENCE_DO2,
           T.BBG_REFERENCE_DO3,
           T.BBG_REFERENCE_DO4,
           T.BBG_REFERENCE_DO5,
           T.BBG_REFERENCE_FO1,
           T.BBG_REFERENCE_FO2,
           T.BBG_REFERENCE_FO3,
           T.BBG_REFERENCE_FO4,
           T.BBG_REFERENCE_FO5,
           T.BBG_REFERENCE_FO6,
           T.BBG_REFERENCE_FO7,
           T.BBG_REFERENCE_FO8,
           T.BBG_REFERENCE_FO9,
           T.BBG_REFERENCE_FO10)
        VALUES
          (BBG_RA_CUST_SC_LC_DY_HR_A_SEQ.NEXTVAL,
           S.ORG_WID,
           S.ORG_DH_WID,
           S.ORG_SCD1_WID,
           S.PROD_DH_WID,
           S.DT_WID,
           S.MINUTE_WID,
           S.DATASOURCE_NUM_ID,
           S.W_INSERT_DT,
           S.W_UPDATE_DT,
           S.INTEGRATION_ID,
           S.BBG_CUSTOMER_COUNT,
           S.VIP_BBG_CUSTOMER_COUNT,
           0,
           0,
           S.BBG_SERVICE_SATISFACTION,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL);
      COMMIT;
    
      EXECUTE IMMEDIATE 'ALTER TABLE RADM.BBG_RA_CUST_SC_LC_DY_HR_A LOGGING';
    END;
    --5.3.BBG_RA_CUST_CL_LC_DY_A
    BEGIN
      EXECUTE IMMEDIATE 'ALTER TABLE RADM.BBG_RA_CUST_CL_LC_DY_A NOLOGGING';
      EXECUTE IMMEDIATE 'ALTER SESSION ENABLE PARALLEL DML';
    
      MERGE /*+APPEND PARALLEL(T,16) PARALLEL(S,16)*/
      INTO RADM.BBG_RA_CUST_CL_LC_DY_A T
      USING (SELECT /*+PARALLEL(16)*/
              D.ORG_WID,
              D.ORG_DH_WID,
              D.ORG_SCD1_WID,
              D.PROD_CL_WID PROD_DH_WID,
              D.DT_WID,
              D.DATASOURCE_NUM_ID,
              SYSDATE W_INSERT_DT,
              SYSDATE W_UPDATE_DT,
              D.INTEGRATION_ID,
              COUNT(DISTINCT D.SLS_TRX_ID) BBG_CUSTOMER_COUNT,
              COUNT(DISTINCT DECODE(D.HYK_NO, '', '', D.SLS_TRX_ID)) VIP_BBG_CUSTOMER_COUNT,
              AVG(D.BBG_SERVICE_SATISFACTION) BBG_SERVICE_SATISFACTION
               FROM (SELECT /*+PARALLEL(16)*/
                      A.PROD_WID,
                      B.PROD_CL_WID,
                      A.ORG_WID,
                      A.ORG_DH_WID,
                      A.ORG_SCD1_WID,
                      A.DT_WID,
                      A.SLS_TRX_ID,
                      C.ORG_NUM || '~' ||
                      TO_CHAR(TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD'),
                              'DD-MON-YY',
                              'NLS_DATE_LANGUAGE = American') || '~' ||
                      TO_CHAR(B.PROD_CL_NUM) INTEGRATION_ID,
                      1 DATASOURCE_NUM_ID,
                      NVL(A.BBG_SERVICE_SATISFACTION, 0) BBG_SERVICE_SATISFACTION,
                      A.HYK_NO
                       FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_F_BAK A,
                            RABATCHER.W_PRODUCT_D_RTL_TMP     B,
                            RADM.W_INT_ORG_D                  C
                      WHERE A.PROD_WID = B.PROD_IT_WID
                        AND A.ORG_WID = C.ROW_WID) D
              GROUP BY D.ORG_WID,
                       D.ORG_DH_WID,
                       D.ORG_SCD1_WID,
                       D.PROD_CL_WID,
                       D.DT_WID,
                       D.DATASOURCE_NUM_ID,
                       D.INTEGRATION_ID) S
      ON (T.PROD_DH_WID = S.PROD_DH_WID AND T.ORG_WID = S.ORG_WID AND T.DT_WID = S.DT_WID)
      WHEN MATCHED THEN
        UPDATE
           SET T.BBG_CUSTOMER_COUNT       = S.BBG_CUSTOMER_COUNT,
               T.VIP_BBG_CUSTOMER_COUNT   = S.VIP_BBG_CUSTOMER_COUNT,
               T.BBG_SERVICE_SATISFACTION = S.BBG_SERVICE_SATISFACTION,
               T.VIP_SLS_INC_AMT_LCL      = 0,
               T.VIP_TAX_AMT_LCL          = 0,
               T.W_UPDATE_DT              = SYSDATE
      WHEN NOT MATCHED THEN
        INSERT
          (T.ROW_WID,
           T.ORG_WID,
           T.ORG_DH_WID,
           T.ORG_SCD1_WID,
           T.PROD_DH_WID,
           T.DT_WID,
           T.DATASOURCE_NUM_ID,
           T.W_INSERT_DT,
           T.W_UPDATE_DT,
           T.INTEGRATION_ID,
           T.BBG_CUSTOMER_COUNT,
           T.VIP_BBG_CUSTOMER_COUNT,
           T.VIP_SLS_INC_AMT_LCL,
           T.VIP_TAX_AMT_LCL,
           T.BBG_SERVICE_SATISFACTION,
           T.BBG_REFERENCE_DO1,
           T.BBG_REFERENCE_DO2,
           T.BBG_REFERENCE_DO3,
           T.BBG_REFERENCE_DO4,
           T.BBG_REFERENCE_DO5,
           T.BBG_REFERENCE_FO1,
           T.BBG_REFERENCE_FO2,
           T.BBG_REFERENCE_FO3,
           T.BBG_REFERENCE_FO4,
           T.BBG_REFERENCE_FO5,
           T.BBG_REFERENCE_FO6,
           T.BBG_REFERENCE_FO7,
           T.BBG_REFERENCE_FO8,
           T.BBG_REFERENCE_FO9,
           T.BBG_REFERENCE_FO10)
        VALUES
          (BBG_RA_CUST_CL_LC_DY_HR_A_SEQ.NEXTVAL,
           S.ORG_WID,
           S.ORG_DH_WID,
           S.ORG_SCD1_WID,
           S.PROD_DH_WID,
           S.DT_WID,
           S.DATASOURCE_NUM_ID,
           S.W_INSERT_DT,
           S.W_UPDATE_DT,
           S.INTEGRATION_ID,
           S.BBG_CUSTOMER_COUNT,
           S.VIP_BBG_CUSTOMER_COUNT,
           0,
           0,
           S.BBG_SERVICE_SATISFACTION,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL);
      COMMIT;
    
      EXECUTE IMMEDIATE 'ALTER TABLE RADM.BBG_RA_CUST_CL_LC_DY_A LOGGING';
    END;
    --5.4.BBG_RA_CUST_CL_LC_DY_HR_A
    BEGIN
      EXECUTE IMMEDIATE 'ALTER TABLE RADM.BBG_RA_CUST_CL_LC_DY_HR_A NOLOGGING';
      EXECUTE IMMEDIATE 'ALTER SESSION ENABLE PARALLEL DML';
    
      MERGE /*+APPEND PARALLEL(T,16) PARALLEL(S,16)*/
      INTO RADM.BBG_RA_CUST_CL_LC_DY_HR_A T
      USING (SELECT /*+PARALLEL(16)*/
              D.ORG_WID,
              D.ORG_DH_WID,
              D.ORG_SCD1_WID,
              D.PROD_CL_WID PROD_DH_WID,
              D.DT_WID,
              D.MIN_WID MINUTE_WID,
              D.DATASOURCE_NUM_ID,
              SYSDATE W_INSERT_DT,
              SYSDATE W_UPDATE_DT,
              D.INTEGRATION_ID,
              COUNT(DISTINCT D.SLS_TRX_ID) BBG_CUSTOMER_COUNT,
              COUNT(DISTINCT DECODE(D.HYK_NO, '', '', D.SLS_TRX_ID)) VIP_BBG_CUSTOMER_COUNT,
              AVG(D.BBG_SERVICE_SATISFACTION) BBG_SERVICE_SATISFACTION
               FROM (SELECT /*+PARALLEL(16)*/
                      A.PROD_WID,
                      B.PROD_CL_WID,
                      A.ORG_WID,
                      A.ORG_DH_WID,
                      A.ORG_SCD1_WID,
                      A.DT_WID,
                      TRUNC(A.MIN_WID / 100) * 100 +
                      LPAD(TRUNC((A.MIN_WID - TRUNC(A.MIN_WID / 100) * 100) / 15) * 15,
                           2,
                           '0') MIN_WID,
                      A.SLS_TRX_ID,
                      C.ORG_NUM || '~' ||
                      TO_CHAR(TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD'),
                              'DD-MON-YY',
                              'NLS_DATE_LANGUAGE = American') || '~' ||
                      TO_CHAR(TRUNC(A.MIN_WID / 100) * 100 +
                              LPAD(TRUNC((A.MIN_WID -
                                         TRUNC(A.MIN_WID / 100) * 100) / 15) * 15,
                                   2,
                                   '0')) || '~' || TO_CHAR(B.PROD_CL_NUM) INTEGRATION_ID,
                      1 DATASOURCE_NUM_ID,
                      NVL(A.BBG_SERVICE_SATISFACTION, 0) BBG_SERVICE_SATISFACTION,
                      A.HYK_NO
                       FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_F_BAK A,
                            RABATCHER.W_PRODUCT_D_RTL_TMP     B,
                            RADM.W_INT_ORG_D                  C
                      WHERE A.PROD_WID = B.PROD_IT_WID
                        AND A.ORG_WID = C.ROW_WID) D
              GROUP BY D.ORG_WID,
                       D.ORG_DH_WID,
                       D.ORG_SCD1_WID,
                       D.PROD_CL_WID,
                       D.DT_WID,
                       D.MIN_WID,
                       D.DATASOURCE_NUM_ID,
                       D.INTEGRATION_ID) S
      ON (T.PROD_DH_WID = S.PROD_DH_WID AND T.ORG_WID = S.ORG_WID AND T.DT_WID = S.DT_WID AND T.MINUTE_WID = S.MINUTE_WID)
      WHEN MATCHED THEN
        UPDATE
           SET T.BBG_CUSTOMER_COUNT       = S.BBG_CUSTOMER_COUNT,
               T.VIP_BBG_CUSTOMER_COUNT   = S.VIP_BBG_CUSTOMER_COUNT,
               T.BBG_SERVICE_SATISFACTION = S.BBG_SERVICE_SATISFACTION,
               T.VIP_SLS_INC_AMT_LCL      = 0,
               T.VIP_TAX_AMT_LCL          = 0,
               T.W_UPDATE_DT              = SYSDATE
      WHEN NOT MATCHED THEN
        INSERT
          (T.ROW_WID,
           T.ORG_WID,
           T.ORG_DH_WID,
           T.ORG_SCD1_WID,
           T.PROD_DH_WID,
           T.DT_WID,
           T.MINUTE_WID,
           T.DATASOURCE_NUM_ID,
           T.W_INSERT_DT,
           T.W_UPDATE_DT,
           T.INTEGRATION_ID,
           T.BBG_CUSTOMER_COUNT,
           T.VIP_BBG_CUSTOMER_COUNT,
           T.VIP_SLS_INC_AMT_LCL,
           T.VIP_TAX_AMT_LCL,
           T.BBG_SERVICE_SATISFACTION,
           T.BBG_REFERENCE_DO1,
           T.BBG_REFERENCE_DO2,
           T.BBG_REFERENCE_DO3,
           T.BBG_REFERENCE_DO4,
           T.BBG_REFERENCE_DO5,
           T.BBG_REFERENCE_FO1,
           T.BBG_REFERENCE_FO2,
           T.BBG_REFERENCE_FO3,
           T.BBG_REFERENCE_FO4,
           T.BBG_REFERENCE_FO5,
           T.BBG_REFERENCE_FO6,
           T.BBG_REFERENCE_FO7,
           T.BBG_REFERENCE_FO8,
           T.BBG_REFERENCE_FO9,
           T.BBG_REFERENCE_FO10)
        VALUES
          (BBG_RA_CUST_CL_LC_DY_HR_A_SEQ.NEXTVAL,
           S.ORG_WID,
           S.ORG_DH_WID,
           S.ORG_SCD1_WID,
           S.PROD_DH_WID,
           S.DT_WID,
           S.MINUTE_WID,
           S.DATASOURCE_NUM_ID,
           S.W_INSERT_DT,
           S.W_UPDATE_DT,
           S.INTEGRATION_ID,
           S.BBG_CUSTOMER_COUNT,
           S.VIP_BBG_CUSTOMER_COUNT,
           0,
           0,
           S.BBG_SERVICE_SATISFACTION,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL);
      COMMIT;
    
      EXECUTE IMMEDIATE 'ALTER TABLE RADM.BBG_RA_CUST_CL_LC_DY_HR_A LOGGING';
    END;
    --5.5.BBG_RA_CUST_DP_LC_DY_A
    BEGIN
      EXECUTE IMMEDIATE 'ALTER TABLE RADM.BBG_RA_CUST_DP_LC_DY_A NOLOGGING';
      EXECUTE IMMEDIATE 'ALTER SESSION ENABLE PARALLEL DML';
    
      MERGE /*+APPEND PARALLEL(T,16) PARALLEL(S,16)*/
      INTO RADM.BBG_RA_CUST_DP_LC_DY_A T
      USING (SELECT /*+PARALLEL(16)*/
              D.ORG_WID,
              D.ORG_DH_WID,
              D.ORG_SCD1_WID,
              D.PROD_DP_WID PROD_DH_WID,
              D.DT_WID,
              D.DATASOURCE_NUM_ID,
              SYSDATE W_INSERT_DT,
              SYSDATE W_UPDATE_DT,
              D.INTEGRATION_ID,
              COUNT(DISTINCT D.SLS_TRX_ID) BBG_CUSTOMER_COUNT,
              COUNT(DISTINCT DECODE(D.HYK_NO, '', '', D.SLS_TRX_ID)) VIP_BBG_CUSTOMER_COUNT,
              AVG(D.BBG_SERVICE_SATISFACTION) BBG_SERVICE_SATISFACTION
               FROM (SELECT /*+PARALLEL(16)*/
                      A.PROD_WID,
                      B.PROD_DP_WID,
                      A.ORG_WID,
                      A.ORG_DH_WID,
                      A.ORG_SCD1_WID,
                      A.DT_WID,
                      A.SLS_TRX_ID,
                      C.ORG_NUM || '~' ||
                      TO_CHAR(TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD'),
                              'DD-MON-YY',
                              'NLS_DATE_LANGUAGE = American') || '~' ||
                      TO_CHAR(B.PROD_DP_NUM) INTEGRATION_ID,
                      1 DATASOURCE_NUM_ID,
                      NVL(A.BBG_SERVICE_SATISFACTION, 0) BBG_SERVICE_SATISFACTION,
                      A.HYK_NO
                       FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_F_BAK A,
                            RABATCHER.W_PRODUCT_D_RTL_TMP     B,
                            RADM.W_INT_ORG_D                  C
                      WHERE A.PROD_WID = B.PROD_IT_WID
                        AND A.ORG_WID = C.ROW_WID) D
              GROUP BY D.ORG_WID,
                       D.ORG_DH_WID,
                       D.ORG_SCD1_WID,
                       D.PROD_DP_WID,
                       D.DT_WID,
                       D.DATASOURCE_NUM_ID,
                       D.INTEGRATION_ID) S
      ON (T.PROD_DH_WID = S.PROD_DH_WID AND T.ORG_WID = S.ORG_WID AND T.DT_WID = S.DT_WID)
      WHEN MATCHED THEN
        UPDATE
           SET T.BBG_CUSTOMER_COUNT       = S.BBG_CUSTOMER_COUNT,
               T.VIP_BBG_CUSTOMER_COUNT   = S.VIP_BBG_CUSTOMER_COUNT,
               T.BBG_SERVICE_SATISFACTION = S.BBG_SERVICE_SATISFACTION,
               T.VIP_SLS_INC_AMT_LCL      = 0,
               T.VIP_TAX_AMT_LCL          = 0,
               T.W_UPDATE_DT              = SYSDATE
      WHEN NOT MATCHED THEN
        INSERT
          (T.ROW_WID,
           T.ORG_WID,
           T.ORG_DH_WID,
           T.ORG_SCD1_WID,
           T.PROD_DH_WID,
           T.DT_WID,
           T.DATASOURCE_NUM_ID,
           T.W_INSERT_DT,
           T.W_UPDATE_DT,
           T.INTEGRATION_ID,
           T.BBG_CUSTOMER_COUNT,
           T.VIP_BBG_CUSTOMER_COUNT,
           T.VIP_SLS_INC_AMT_LCL,
           T.VIP_TAX_AMT_LCL,
           T.BBG_SERVICE_SATISFACTION,
           T.BBG_REFERENCE_DO1,
           T.BBG_REFERENCE_DO2,
           T.BBG_REFERENCE_DO3,
           T.BBG_REFERENCE_DO4,
           T.BBG_REFERENCE_DO5,
           T.BBG_REFERENCE_FO1,
           T.BBG_REFERENCE_FO2,
           T.BBG_REFERENCE_FO3,
           T.BBG_REFERENCE_FO4,
           T.BBG_REFERENCE_FO5,
           T.BBG_REFERENCE_FO6,
           T.BBG_REFERENCE_FO7,
           T.BBG_REFERENCE_FO8,
           T.BBG_REFERENCE_FO9,
           T.BBG_REFERENCE_FO10)
        VALUES
          (BBG_RA_CUST_DP_LC_DY_HR_A_SEQ.NEXTVAL,
           S.ORG_WID,
           S.ORG_DH_WID,
           S.ORG_SCD1_WID,
           S.PROD_DH_WID,
           S.DT_WID,
           S.DATASOURCE_NUM_ID,
           S.W_INSERT_DT,
           S.W_UPDATE_DT,
           S.INTEGRATION_ID,
           S.BBG_CUSTOMER_COUNT,
           S.VIP_BBG_CUSTOMER_COUNT,
           0,
           0,
           S.BBG_SERVICE_SATISFACTION,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL);
      COMMIT;
    
      EXECUTE IMMEDIATE 'ALTER TABLE RADM.BBG_RA_CUST_DP_LC_DY_A LOGGING';
    END;
  
    --5.6.BBG_RA_CUST_DP_LC_DY_HR_A
    BEGIN
      EXECUTE IMMEDIATE 'ALTER TABLE RADM.BBG_RA_CUST_DP_LC_DY_HR_A NOLOGGING';
      EXECUTE IMMEDIATE 'ALTER SESSION ENABLE PARALLEL DML';
    
      MERGE /*+APPEND PARALLEL(T,16) PARALLEL(S,16)*/
      INTO RADM.BBG_RA_CUST_DP_LC_DY_HR_A T
      USING (SELECT /*+PARALLEL(16)*/
              D.ORG_WID,
              D.ORG_DH_WID,
              D.ORG_SCD1_WID,
              D.PROD_DP_WID PROD_DH_WID,
              D.DT_WID,
              D.MIN_WID MINUTE_WID,
              D.DATASOURCE_NUM_ID,
              SYSDATE W_INSERT_DT,
              SYSDATE W_UPDATE_DT,
              D.INTEGRATION_ID,
              COUNT(DISTINCT D.SLS_TRX_ID) BBG_CUSTOMER_COUNT,
              COUNT(DISTINCT DECODE(D.HYK_NO, '', '', D.SLS_TRX_ID)) VIP_BBG_CUSTOMER_COUNT,
              AVG(D.BBG_SERVICE_SATISFACTION) BBG_SERVICE_SATISFACTION
               FROM (SELECT /*+PARALLEL(16)*/
                      A.PROD_WID,
                      B.PROD_DP_WID,
                      A.ORG_WID,
                      A.ORG_DH_WID,
                      A.ORG_SCD1_WID,
                      A.DT_WID,
                      TRUNC(A.MIN_WID / 100) * 100 +
                      LPAD(TRUNC((A.MIN_WID - TRUNC(A.MIN_WID / 100) * 100) / 15) * 15,
                           2,
                           '0') MIN_WID,
                      A.SLS_TRX_ID,
                      C.ORG_NUM || '~' ||
                      TO_CHAR(TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD'),
                              'DD-MON-YY',
                              'NLS_DATE_LANGUAGE = American') || '~' ||
                      TO_CHAR(TRUNC(A.MIN_WID / 100) * 100 +
                              LPAD(TRUNC((A.MIN_WID -
                                         TRUNC(A.MIN_WID / 100) * 100) / 15) * 15,
                                   2,
                                   '0')) || '~' || TO_CHAR(B.PROD_DP_NUM) INTEGRATION_ID,
                      1 DATASOURCE_NUM_ID,
                      NVL(A.BBG_SERVICE_SATISFACTION, 0) BBG_SERVICE_SATISFACTION,
                      A.HYK_NO
                       FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_F_BAK A,
                            RABATCHER.W_PRODUCT_D_RTL_TMP     B,
                            RADM.W_INT_ORG_D                  C
                      WHERE A.PROD_WID = B.PROD_IT_WID
                        AND A.ORG_WID = C.ROW_WID) D
              GROUP BY D.ORG_WID,
                       D.ORG_DH_WID,
                       D.ORG_SCD1_WID,
                       D.PROD_DP_WID,
                       D.DT_WID,
                       D.MIN_WID,
                       D.DATASOURCE_NUM_ID,
                       D.INTEGRATION_ID) S
      ON (T.PROD_DH_WID = S.PROD_DH_WID AND T.ORG_WID = S.ORG_WID AND T.DT_WID = S.DT_WID AND T.MINUTE_WID = S.MINUTE_WID)
      WHEN MATCHED THEN
        UPDATE
           SET T.BBG_CUSTOMER_COUNT       = S.BBG_CUSTOMER_COUNT,
               T.VIP_BBG_CUSTOMER_COUNT   = S.VIP_BBG_CUSTOMER_COUNT,
               T.BBG_SERVICE_SATISFACTION = S.BBG_SERVICE_SATISFACTION,
               T.VIP_SLS_INC_AMT_LCL      = 0,
               T.VIP_TAX_AMT_LCL          = 0,
               T.W_UPDATE_DT              = SYSDATE
      WHEN NOT MATCHED THEN
        INSERT
          (T.ROW_WID,
           T.ORG_WID,
           T.ORG_DH_WID,
           T.ORG_SCD1_WID,
           T.PROD_DH_WID,
           T.DT_WID,
           T.MINUTE_WID,
           T.DATASOURCE_NUM_ID,
           T.W_INSERT_DT,
           T.W_UPDATE_DT,
           T.INTEGRATION_ID,
           T.BBG_CUSTOMER_COUNT,
           T.VIP_BBG_CUSTOMER_COUNT,
           T.VIP_SLS_INC_AMT_LCL,
           T.VIP_TAX_AMT_LCL,
           T.BBG_SERVICE_SATISFACTION,
           T.BBG_REFERENCE_DO1,
           T.BBG_REFERENCE_DO2,
           T.BBG_REFERENCE_DO3,
           T.BBG_REFERENCE_DO4,
           T.BBG_REFERENCE_DO5,
           T.BBG_REFERENCE_FO1,
           T.BBG_REFERENCE_FO2,
           T.BBG_REFERENCE_FO3,
           T.BBG_REFERENCE_FO4,
           T.BBG_REFERENCE_FO5,
           T.BBG_REFERENCE_FO6,
           T.BBG_REFERENCE_FO7,
           T.BBG_REFERENCE_FO8,
           T.BBG_REFERENCE_FO9,
           T.BBG_REFERENCE_FO10)
        VALUES
          (BBG_RA_CUST_DP_LC_DY_HR_A_SEQ.NEXTVAL,
           S.ORG_WID,
           S.ORG_DH_WID,
           S.ORG_SCD1_WID,
           S.PROD_DH_WID,
           S.DT_WID,
           S.MINUTE_WID,
           S.DATASOURCE_NUM_ID,
           S.W_INSERT_DT,
           S.W_UPDATE_DT,
           S.INTEGRATION_ID,
           S.BBG_CUSTOMER_COUNT,
           S.VIP_BBG_CUSTOMER_COUNT,
           0,
           0,
           S.BBG_SERVICE_SATISFACTION,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL);
      COMMIT;
    
      EXECUTE IMMEDIATE 'ALTER TABLE RADM.BBG_RA_CUST_DP_LC_DY_HR_A LOGGING';
    END;
    --5.7.BBG_RA_CUST_LC_DY_A
    BEGIN
      EXECUTE IMMEDIATE 'ALTER TABLE RADM.BBG_RA_CUST_LC_DY_A NOLOGGING';
      EXECUTE IMMEDIATE 'ALTER SESSION ENABLE PARALLEL DML';
    
      MERGE /*+APPEND PARALLEL(T,16) PARALLEL(S,16)*/
      INTO RADM.BBG_RA_CUST_LC_DY_A T
      USING (SELECT /*+PARALLEL(16)*/
              D.ORG_WID,
              D.ORG_DH_WID,
              D.ORG_SCD1_WID,
              D.DT_WID,
              D.DATASOURCE_NUM_ID,
              SYSDATE W_INSERT_DT,
              SYSDATE W_UPDATE_DT,
              D.INTEGRATION_ID,
              COUNT(DISTINCT D.SLS_TRX_ID) BBG_CUSTOMER_COUNT,
              COUNT(DISTINCT DECODE(D.HYK_NO, '', '', D.SLS_TRX_ID)) VIP_BBG_CUSTOMER_COUNT,
              AVG(D.BBG_SERVICE_SATISFACTION) BBG_SERVICE_SATISFACTION
               FROM (SELECT /*+PARALLEL(16)*/
                      A.PROD_WID,
                      A.ORG_WID,
                      A.ORG_DH_WID,
                      A.ORG_SCD1_WID,
                      A.DT_WID,
                      A.SLS_TRX_ID,
                      C.ORG_NUM || '~' ||
                      TO_CHAR(TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD'),
                              'DD-MON-YY',
                              'NLS_DATE_LANGUAGE = American') INTEGRATION_ID,
                      1 DATASOURCE_NUM_ID,
                      NVL(A.BBG_SERVICE_SATISFACTION, 0) BBG_SERVICE_SATISFACTION,
                      A.HYK_NO
                       FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_F_BAK A,
                            RADM.W_INT_ORG_D                  C
                      WHERE A.ORG_WID = C.ROW_WID) D
              GROUP BY D.ORG_WID,
                       D.ORG_DH_WID,
                       D.ORG_SCD1_WID,
                       D.DT_WID,
                       D.DATASOURCE_NUM_ID,
                       D.INTEGRATION_ID) S
      ON (T.ORG_WID = S.ORG_WID AND T.DT_WID = S.DT_WID)
      WHEN MATCHED THEN
        UPDATE
           SET T.BBG_CUSTOMER_COUNT       = S.BBG_CUSTOMER_COUNT,
               T.VIP_BBG_CUSTOMER_COUNT   = S.VIP_BBG_CUSTOMER_COUNT,
               T.BBG_SERVICE_SATISFACTION = S.BBG_SERVICE_SATISFACTION,
               T.VIP_SLS_INC_AMT_LCL      = 0,
               T.VIP_TAX_AMT_LCL          = 0,
               T.W_UPDATE_DT              = SYSDATE
      WHEN NOT MATCHED THEN
        INSERT
          (T.ROW_WID,
           T.ORG_WID,
           T.ORG_DH_WID,
           T.ORG_SCD1_WID,
           T.DT_WID,
           T.DATASOURCE_NUM_ID,
           T.W_INSERT_DT,
           T.W_UPDATE_DT,
           T.INTEGRATION_ID,
           T.BBG_CUSTOMER_COUNT,
           T.VIP_BBG_CUSTOMER_COUNT,
           T.VIP_SLS_INC_AMT_LCL,
           T.VIP_TAX_AMT_LCL,
           T.BBG_SERVICE_SATISFACTION,
           T.BBG_REFERENCE_DO1,
           T.BBG_REFERENCE_DO2,
           T.BBG_REFERENCE_DO3,
           T.BBG_REFERENCE_DO4,
           T.BBG_REFERENCE_DO5,
           T.BBG_REFERENCE_FO1,
           T.BBG_REFERENCE_FO2,
           T.BBG_REFERENCE_FO3,
           T.BBG_REFERENCE_FO4,
           T.BBG_REFERENCE_FO5,
           T.BBG_REFERENCE_FO6,
           T.BBG_REFERENCE_FO7,
           T.BBG_REFERENCE_FO8,
           T.BBG_REFERENCE_FO9,
           T.BBG_REFERENCE_FO10)
        VALUES
          (BBG_RA_CUST_SC_LC_DY_HR_A_SEQ.NEXTVAL,
           S.ORG_WID,
           S.ORG_DH_WID,
           S.ORG_SCD1_WID,
           S.DT_WID,
           S.DATASOURCE_NUM_ID,
           S.W_INSERT_DT,
           S.W_UPDATE_DT,
           S.INTEGRATION_ID,
           S.BBG_CUSTOMER_COUNT,
           S.VIP_BBG_CUSTOMER_COUNT,
           0,
           0,
           S.BBG_SERVICE_SATISFACTION,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL);
      COMMIT;
    
      EXECUTE IMMEDIATE 'ALTER TABLE RADM.BBG_RA_CUST_LC_DY_A LOGGING';
    END;
    --5.8.BBG_RA_CUST_LC_DY_HR_A
    BEGIN
      EXECUTE IMMEDIATE 'ALTER TABLE RADM.BBG_RA_CUST_LC_DY_HR_A NOLOGGING';
      EXECUTE IMMEDIATE 'ALTER SESSION ENABLE PARALLEL DML';
    
      MERGE /*+APPEND PARALLEL(T,16) PARALLEL(S,16)*/
      INTO RADM.BBG_RA_CUST_LC_DY_HR_A T
      USING (SELECT /*+PARALLEL(16)*/
              D.ORG_WID,
              D.ORG_DH_WID,
              D.ORG_SCD1_WID,
              D.DT_WID,
              D.MIN_WID MINUTE_WID,
              D.DATASOURCE_NUM_ID,
              SYSDATE W_INSERT_DT,
              SYSDATE W_UPDATE_DT,
              D.INTEGRATION_ID,
              COUNT(DISTINCT D.SLS_TRX_ID) BBG_CUSTOMER_COUNT,
              COUNT(DISTINCT DECODE(D.HYK_NO, '', '', D.SLS_TRX_ID)) VIP_BBG_CUSTOMER_COUNT,
              AVG(D.BBG_SERVICE_SATISFACTION) BBG_SERVICE_SATISFACTION
               FROM (SELECT /*+PARALLEL(16)*/
                      A.PROD_WID,
                      A.ORG_WID,
                      A.ORG_DH_WID,
                      A.ORG_SCD1_WID,
                      A.DT_WID,
                      TRUNC(A.MIN_WID / 100) * 100 +
                      LPAD(TRUNC((A.MIN_WID - TRUNC(A.MIN_WID / 100) * 100) / 15) * 15,
                           2,
                           '0') MIN_WID,
                      A.SLS_TRX_ID,
                      C.ORG_NUM || '~' ||
                      TO_CHAR(TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD'),
                              'DD-MON-YY',
                              'NLS_DATE_LANGUAGE = American') || '~' ||
                      TO_CHAR(TRUNC(A.MIN_WID / 100) * 100 +
                              LPAD(TRUNC((A.MIN_WID -
                                         TRUNC(A.MIN_WID / 100) * 100) / 15) * 15,
                                   2,
                                   '0')) INTEGRATION_ID,
                      1 DATASOURCE_NUM_ID,
                      NVL(A.BBG_SERVICE_SATISFACTION, 0) BBG_SERVICE_SATISFACTION,
                      A.HYK_NO
                       FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_F_BAK A,
                            RADM.W_INT_ORG_D                  C
                      WHERE A.ORG_WID = C.ROW_WID) D
              GROUP BY D.ORG_WID,
                       D.ORG_DH_WID,
                       D.ORG_SCD1_WID,
                       D.DT_WID,
                       D.MIN_WID,
                       D.DATASOURCE_NUM_ID,
                       D.INTEGRATION_ID) S
      ON (T.ORG_WID = S.ORG_WID AND T.DT_WID = S.DT_WID AND T.MINUTE_WID = S.MINUTE_WID)
      WHEN MATCHED THEN
        UPDATE
           SET T.BBG_CUSTOMER_COUNT       = S.BBG_CUSTOMER_COUNT,
               T.VIP_BBG_CUSTOMER_COUNT   = S.VIP_BBG_CUSTOMER_COUNT,
               T.BBG_SERVICE_SATISFACTION = S.BBG_SERVICE_SATISFACTION,
               T.VIP_SLS_INC_AMT_LCL      = 0,
               T.VIP_TAX_AMT_LCL          = 0,
               T.W_UPDATE_DT              = SYSDATE
      WHEN NOT MATCHED THEN
        INSERT
          (T.ROW_WID,
           T.ORG_WID,
           T.ORG_DH_WID,
           T.ORG_SCD1_WID,
           T.DT_WID,
           T.MINUTE_WID,
           T.DATASOURCE_NUM_ID,
           T.W_INSERT_DT,
           T.W_UPDATE_DT,
           T.INTEGRATION_ID,
           T.BBG_CUSTOMER_COUNT,
           T.VIP_BBG_CUSTOMER_COUNT,
           T.VIP_SLS_INC_AMT_LCL,
           T.VIP_TAX_AMT_LCL,
           T.BBG_SERVICE_SATISFACTION,
           T.BBG_REFERENCE_DO1,
           T.BBG_REFERENCE_DO2,
           T.BBG_REFERENCE_DO3,
           T.BBG_REFERENCE_DO4,
           T.BBG_REFERENCE_DO5,
           T.BBG_REFERENCE_FO1,
           T.BBG_REFERENCE_FO2,
           T.BBG_REFERENCE_FO3,
           T.BBG_REFERENCE_FO4,
           T.BBG_REFERENCE_FO5,
           T.BBG_REFERENCE_FO6,
           T.BBG_REFERENCE_FO7,
           T.BBG_REFERENCE_FO8,
           T.BBG_REFERENCE_FO9,
           T.BBG_REFERENCE_FO10)
        VALUES
          (BBG_RA_CUST_SC_LC_DY_HR_A_SEQ.NEXTVAL,
           S.ORG_WID,
           S.ORG_DH_WID,
           S.ORG_SCD1_WID,
           S.DT_WID,
           S.MINUTE_WID,
           S.DATASOURCE_NUM_ID,
           S.W_INSERT_DT,
           S.W_UPDATE_DT,
           S.INTEGRATION_ID,
           S.BBG_CUSTOMER_COUNT,
           S.VIP_BBG_CUSTOMER_COUNT,
           0,
           0,
           S.BBG_SERVICE_SATISFACTION,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL);
      COMMIT;
    
      EXECUTE IMMEDIATE 'ALTER TABLE RADM.BBG_RA_CUST_LC_DY_HR_A LOGGING';
    END;
  
  END;

END;
/
