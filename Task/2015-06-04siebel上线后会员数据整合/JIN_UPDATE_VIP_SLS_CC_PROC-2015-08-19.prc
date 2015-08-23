CREATE OR REPLACE PROCEDURE JIN_UPDATE_VIP_SLS_CC_PROC(DTWID INT) AS

  CNT INT;

BEGIN
  --CREATE BAK TABLE
  BEGIN
    BEGIN
      EXECUTE IMMEDIATE 'TRUNCATE TABLE RADM.W_RTL_SLS_TRX_IT_LC_DY_F_BAK';
      INSERT /*+PARALLEL(16)*/
      INTO RADM.W_RTL_SLS_TRX_IT_LC_DY_F_BAK
        SELECT * FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_F WHERE DT_WID = DTWID;
      COMMIT;
    END;
  
    --5.1.BBG_RA_CUST_SC_LC_DY_A
    BEGIN
      EXECUTE IMMEDIATE 'ALTER TABLE RADM.BBG_RA_CUST_SC_LC_DY_A NOLOGGING';
      EXECUTE IMMEDIATE 'ALTER SESSION ENABLE PARALLEL DML';
      SELECT COUNT(1)
        INTO CNT
        FROM ALL_ALL_TABLES
       WHERE TABLE_NAME = 'CUST_TMP1';
      IF CNT = 1 THEN
        EXECUTE IMMEDIATE 'DROP TABLE RADM.CUST_TMP1';
      END IF;
      EXECUTE IMMEDIATE 'CREATE TABLE RADM.CUST_TMP1 AS
SELECT C.PROD_SC_WID PROD_DH_WID, B.ORG_WID, B.DT_WID, COUNT(DISTINCT DECODE(B.HYK_NO, '''', '''', B.SLS_TRX_ID)) CNT
  FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_F_BAK B, RABATCHER.W_PRODUCT_D_RTL_TMP C
 WHERE B.PROD_WID = C.PROD_IT_WID
 GROUP BY C.PROD_SC_WID, B.ORG_WID, B.DT_WID';
      EXECUTE IMMEDIATE 'CREATE UNIQUE INDEX PK_CUST_TMP1 ON CUST_TMP1(PROD_DH_WID,
                                            ORG_WID,
                                            DT_WID)';
      UPDATE /*+PARALLEL(16)*/ RADM.BBG_RA_CUST_SC_LC_DY_A A
         SET A.VIP_BBG_CUSTOMER_COUNT = NVL((SELECT /*+PARALLEL(16)*/
                                             D.CNT
                                              FROM CUST_TMP1 D
                                             WHERE D.PROD_DH_WID =
                                                   A.PROD_DH_WID
                                               AND D.ORG_WID = A.ORG_WID
                                               AND D.DT_WID = A.DT_WID),
                                            0)
       WHERE EXISTS (SELECT /*+PARALLEL(16)*/
               1
                FROM CUST_TMP1 D
               WHERE D.PROD_DH_WID = A.PROD_DH_WID
                 AND D.ORG_WID = A.ORG_WID
                 AND D.DT_WID = A.DT_WID)
         AND A.VIP_BBG_CUSTOMER_COUNT IS NULL;
      COMMIT;
      UPDATE /*+PARALLEL(16)*/ RADM.BBG_RA_CUST_SC_LC_DY_A A
         SET A.VIP_BBG_CUSTOMER_COUNT = 0
       WHERE A.DT_WID = DTWID
         AND A.VIP_BBG_CUSTOMER_COUNT IS NULL;
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
               T.VIP_TAX_AMT_LCL          = 0
      WHEN NOT MATCHED THEN
        INSERT
          (T.row_wid,
           T.org_wid,
           T.org_dh_wid,
           T.org_scd1_wid,
           T.prod_dh_wid,
           T.dt_wid,
           T.minute_wid,
           T.datasource_num_id,
           T.w_insert_dt,
           T.w_update_dt,
           T.integration_id,
           T.bbg_customer_count,
           T.vip_bbg_customer_count,
           T.vip_sls_inc_amt_lcl,
           T.vip_tax_amt_lcl,
           T.bbg_service_satisfaction,
           T.bbg_reference_do1,
           T.bbg_reference_do2,
           T.bbg_reference_do3,
           T.bbg_reference_do4,
           T.bbg_reference_do5,
           T.bbg_reference_fo1,
           T.bbg_reference_fo2,
           T.bbg_reference_fo3,
           T.bbg_reference_fo4,
           T.bbg_reference_fo5,
           T.bbg_reference_fo6,
           T.bbg_reference_fo7,
           T.bbg_reference_fo8,
           T.bbg_reference_fo9,
           T.bbg_reference_fo10)
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
      SELECT COUNT(1)
        INTO CNT
        FROM ALL_ALL_TABLES
       WHERE TABLE_NAME = 'CUST_TMP3';
      IF CNT = 1 THEN
        EXECUTE IMMEDIATE 'DROP TABLE RADM.CUST_TMP3';
      END IF;
      EXECUTE IMMEDIATE 'CREATE TABLE RADM.CUST_TMP3 AS
SELECT C.PROD_CL_WID PROD_DH_WID, B.ORG_WID, B.DT_WID, COUNT(DISTINCT DECODE(B.HYK_NO, '''', '''', B.SLS_TRX_ID)) CNT
  FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_F_BAK B, RABATCHER.W_PRODUCT_D_RTL_TMP C
 WHERE B.PROD_WID = C.PROD_IT_WID
 GROUP BY C.PROD_CL_WID, B.ORG_WID, B.DT_WID';
      EXECUTE IMMEDIATE 'CREATE UNIQUE INDEX PK_CUST_TMP3 ON CUST_TMP3(PROD_DH_WID,
                                            ORG_WID,
                                            DT_WID)';
      UPDATE /*+PARALLEL(16)*/ RADM.BBG_RA_CUST_CL_LC_DY_A A
         SET A.VIP_BBG_CUSTOMER_COUNT = NVL((SELECT /*+PARALLEL(16)*/
                                             D.CNT
                                              FROM CUST_TMP3 D
                                             WHERE D.PROD_DH_WID =
                                                   A.PROD_DH_WID
                                               AND D.ORG_WID = A.ORG_WID
                                               AND D.DT_WID = A.DT_WID),
                                            0)
       WHERE EXISTS (SELECT /*+PARALLEL(16)*/
               1
                FROM CUST_TMP3 D
               WHERE D.PROD_DH_WID = A.PROD_DH_WID
                 AND D.ORG_WID = A.ORG_WID
                 AND D.DT_WID = A.DT_WID)
         AND A.VIP_BBG_CUSTOMER_COUNT IS NULL;
      COMMIT;
      UPDATE /*+PARALLEL(16)*/ RADM.BBG_RA_CUST_CL_LC_DY_A A
         SET A.VIP_BBG_CUSTOMER_COUNT = 0
       WHERE A.DT_WID = DTWID
         AND A.VIP_BBG_CUSTOMER_COUNT IS NULL;
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
               T.VIP_TAX_AMT_LCL          = 0
      WHEN NOT MATCHED THEN
        INSERT
          (T.row_wid,
           T.org_wid,
           T.org_dh_wid,
           T.org_scd1_wid,
           T.prod_dh_wid,
           T.dt_wid,
           T.minute_wid,
           T.datasource_num_id,
           T.w_insert_dt,
           T.w_update_dt,
           T.integration_id,
           T.bbg_customer_count,
           T.vip_bbg_customer_count,
           T.vip_sls_inc_amt_lcl,
           T.vip_tax_amt_lcl,
           T.bbg_service_satisfaction,
           T.bbg_reference_do1,
           T.bbg_reference_do2,
           T.bbg_reference_do3,
           T.bbg_reference_do4,
           T.bbg_reference_do5,
           T.bbg_reference_fo1,
           T.bbg_reference_fo2,
           T.bbg_reference_fo3,
           T.bbg_reference_fo4,
           T.bbg_reference_fo5,
           T.bbg_reference_fo6,
           T.bbg_reference_fo7,
           T.bbg_reference_fo8,
           T.bbg_reference_fo9,
           T.bbg_reference_fo10)
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
      SELECT COUNT(1)
        INTO CNT
        FROM ALL_ALL_TABLES
       WHERE TABLE_NAME = 'CUST_TMP5';
      IF CNT = 1 THEN
        EXECUTE IMMEDIATE 'DROP TABLE RADM.CUST_TMP5';
      END IF;
      EXECUTE IMMEDIATE 'CREATE TABLE RADM.CUST_TMP5 AS
SELECT C.PROD_DP_WID PROD_DH_WID, B.ORG_WID, B.DT_WID, COUNT(DISTINCT DECODE(B.HYK_NO, '''', '''', B.SLS_TRX_ID)) CNT
  FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_F_BAK B, RABATCHER.W_PRODUCT_D_RTL_TMP C
 WHERE B.PROD_WID = C.PROD_IT_WID
 GROUP BY C.PROD_DP_WID, B.ORG_WID, B.DT_WID';
      EXECUTE IMMEDIATE 'CREATE UNIQUE INDEX PK_CUST_TMP5 ON CUST_TMP5(PROD_DH_WID,
                                            ORG_WID,
                                            DT_WID)';
      UPDATE /*+PARALLEL(16)*/ RADM.BBG_RA_CUST_DP_LC_DY_A A
         SET A.VIP_BBG_CUSTOMER_COUNT = NVL((SELECT /*+PARALLEL(16)*/
                                             D.CNT
                                              FROM CUST_TMP5 D
                                             WHERE D.PROD_DH_WID =
                                                   A.PROD_DH_WID
                                               AND D.ORG_WID = A.ORG_WID
                                               AND D.DT_WID = A.DT_WID),
                                            0)
       WHERE EXISTS (SELECT /*+PARALLEL(16)*/
               1
                FROM CUST_TMP5 D
               WHERE D.PROD_DH_WID = A.PROD_DH_WID
                 AND D.ORG_WID = A.ORG_WID
                 AND D.DT_WID = A.DT_WID)
         AND A.VIP_BBG_CUSTOMER_COUNT IS NULL;
      COMMIT;
      UPDATE /*+PARALLEL(16)*/ RADM.BBG_RA_CUST_DP_LC_DY_A A
         SET A.VIP_BBG_CUSTOMER_COUNT = 0
       WHERE A.DT_WID = DTWID
         AND A.VIP_BBG_CUSTOMER_COUNT IS NULL;
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
               T.VIP_TAX_AMT_LCL          = 0
      WHEN NOT MATCHED THEN
        INSERT
          (T.row_wid,
           T.org_wid,
           T.org_dh_wid,
           T.org_scd1_wid,
           T.prod_dh_wid,
           T.dt_wid,
           T.minute_wid,
           T.datasource_num_id,
           T.w_insert_dt,
           T.w_update_dt,
           T.integration_id,
           T.bbg_customer_count,
           T.vip_bbg_customer_count,
           T.vip_sls_inc_amt_lcl,
           T.vip_tax_amt_lcl,
           T.bbg_service_satisfaction,
           T.bbg_reference_do1,
           T.bbg_reference_do2,
           T.bbg_reference_do3,
           T.bbg_reference_do4,
           T.bbg_reference_do5,
           T.bbg_reference_fo1,
           T.bbg_reference_fo2,
           T.bbg_reference_fo3,
           T.bbg_reference_fo4,
           T.bbg_reference_fo5,
           T.bbg_reference_fo6,
           T.bbg_reference_fo7,
           T.bbg_reference_fo8,
           T.bbg_reference_fo9,
           T.bbg_reference_fo10)
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
      SELECT COUNT(1)
        INTO CNT
        FROM ALL_ALL_TABLES
       WHERE TABLE_NAME = 'CUST_TMP7';
      IF CNT = 1 THEN
        EXECUTE IMMEDIATE 'DROP TABLE RADM.CUST_TMP7';
      END IF;
      EXECUTE IMMEDIATE 'CREATE TABLE RADM.CUST_TMP7 AS
SELECT B.ORG_WID, B.DT_WID, COUNT(DISTINCT DECODE(B.HYK_NO, '''', '''', B.SLS_TRX_ID)) CNT
  FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_F_BAK B
 GROUP BY B.ORG_WID, B.DT_WID';
      EXECUTE IMMEDIATE 'CREATE UNIQUE INDEX PK_CUST_TMP7 ON CUST_TMP7(ORG_WID,
                                            DT_WID)';
      UPDATE /*+PARALLEL(16)*/ RADM.BBG_RA_CUST_LC_DY_A A
         SET A.VIP_BBG_CUSTOMER_COUNT = NVL((SELECT /*+PARALLEL(16)*/
                                             D.CNT
                                              FROM CUST_TMP7 D
                                             WHERE D.ORG_WID = A.ORG_WID
                                               AND D.DT_WID = A.DT_WID),
                                            0)
       WHERE EXISTS (SELECT /*+PARALLEL(16)*/
               1
                FROM CUST_TMP7 D
               WHERE D.ORG_WID = A.ORG_WID
                 AND D.DT_WID = A.DT_WID)
         AND A.VIP_BBG_CUSTOMER_COUNT IS NULL;
      COMMIT;
      UPDATE /*+PARALLEL(16)*/ RADM.BBG_RA_CUST_LC_DY_A A
         SET A.VIP_BBG_CUSTOMER_COUNT = 0
       WHERE A.DT_WID = DTWID
         AND A.VIP_BBG_CUSTOMER_COUNT IS NULL;
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
               T.VIP_TAX_AMT_LCL          = 0
      WHEN NOT MATCHED THEN
        INSERT
          (T.row_wid,
           T.org_wid,
           T.org_dh_wid,
           T.org_scd1_wid,
           T.dt_wid,
           T.minute_wid,
           T.datasource_num_id,
           T.w_insert_dt,
           T.w_update_dt,
           T.integration_id,
           T.bbg_customer_count,
           T.vip_bbg_customer_count,
           T.vip_sls_inc_amt_lcl,
           T.vip_tax_amt_lcl,
           T.bbg_service_satisfaction,
           T.bbg_reference_do1,
           T.bbg_reference_do2,
           T.bbg_reference_do3,
           T.bbg_reference_do4,
           T.bbg_reference_do5,
           T.bbg_reference_fo1,
           T.bbg_reference_fo2,
           T.bbg_reference_fo3,
           T.bbg_reference_fo4,
           T.bbg_reference_fo5,
           T.bbg_reference_fo6,
           T.bbg_reference_fo7,
           T.bbg_reference_fo8,
           T.bbg_reference_fo9,
           T.bbg_reference_fo10)
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
