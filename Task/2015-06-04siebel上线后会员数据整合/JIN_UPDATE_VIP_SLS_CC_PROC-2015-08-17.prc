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
SELECT C.PROD_SC_WID PROD_DH_WID, B.ORG_WID, B.DT_WID, COUNT(DISTINCT B.SLS_TRX_ID) CNT
  FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_F_BAK B, RABATCHER.W_PRODUCT_D_RTL_TMP C
 WHERE B.PROD_WID = C.PROD_IT_WID
 GROUP BY C.PROD_SC_WID, B.ORG_WID, B.DT_WID';
      EXECUTE IMMEDIATE 'CREATE UNIQUE INDEX PK_CUST_TMP1 ON CUST_TMP1(PROD_DH_WID,
                                            ORG_WID,
                                            DT_WID)';
      UPDATE RADM.BBG_RA_CUST_SC_LC_DY_A A
         SET A.VIP_BBG_CUSTOMER_COUNT = NVL((SELECT D.CNT
                                              FROM CUST_TMP1 D
                                             WHERE D.PROD_DH_WID =
                                                   A.PROD_DH_WID
                                               AND D.ORG_WID = A.ORG_WID
                                               AND D.DT_WID = A.DT_WID),
                                            0)
       WHERE EXISTS (SELECT 1
                FROM CUST_TMP1 D
               WHERE D.PROD_DH_WID = A.PROD_DH_WID
                 AND D.ORG_WID = A.ORG_WID
                 AND D.DT_WID = A.DT_WID)
         AND A.VIP_BBG_CUSTOMER_COUNT IS NULL;
      COMMIT;
      UPDATE RADM.BBG_RA_CUST_SC_LC_DY_A A
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
      SELECT COUNT(1)
        INTO CNT
        FROM ALL_ALL_TABLES
       WHERE TABLE_NAME = 'CUST_TMP2';
      IF CNT = 1 THEN
        EXECUTE IMMEDIATE 'DROP TABLE RADM.CUST_TMP2';
      END IF;
      EXECUTE IMMEDIATE 'CREATE TABLE RADM.CUST_TMP2 AS
SELECT C.PROD_SC_WID PROD_DH_WID,
       B.ORG_WID,
       B.DT_WID,
       (TRUNC(B.MIN_WID / 100) * 100 + (M.QTR_HOUR_NUM - 1) * 15) MIN_WID,
       COUNT(DISTINCT B.SLS_TRX_ID) CNT
  FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_F_BAK B,
       RABATCHER.W_PRODUCT_D_RTL_TMP     C,
       W_MINUTE_OF_DAY_D                 M
 WHERE B.PROD_WID = C.PROD_IT_WID
   AND B.MIN_WID = M.ROW_WID
 GROUP BY C.PROD_SC_WID,
          B.ORG_WID,
          B.DT_WID,
          (TRUNC(B.MIN_WID / 100) * 100 + (M.QTR_HOUR_NUM - 1) * 15)';
      EXECUTE IMMEDIATE 'CREATE UNIQUE INDEX PK_CUST_TMP1 ON CUST_TMP1(PROD_DH_WID,
                                            ORG_WID,
                                            DT_WID,
																						MIN_WID)';
      UPDATE RADM.BBG_RA_CUST_SC_LC_DY_HR_A A
         SET A.VIP_BBG_CUSTOMER_COUNT = NVL((SELECT D.CNT
                                              FROM CUST_TMP2 D
                                             WHERE D.PROD_DH_WID =
                                                   A.PROD_DH_WID
                                               AND D.ORG_WID = A.ORG_WID
                                               AND D.DT_WID = A.DT_WID
                                               AND D.MIN_WID = A.MINUTE_WID),
                                            0)
       WHERE EXISTS (SELECT 1
                FROM CUST_TMP2 D
               WHERE D.PROD_DH_WID = A.PROD_DH_WID
                 AND D.ORG_WID = A.ORG_WID
                 AND D.DT_WID = A.DT_WID
                 AND D.MIN_WID = A.MINUTE_WID)
         AND A.VIP_BBG_CUSTOMER_COUNT IS NULL;
      COMMIT;
      UPDATE RADM.BBG_RA_CUST_SC_LC_DY_HR_A A
         SET A.VIP_BBG_CUSTOMER_COUNT = 0
       WHERE A.DT_WID = DTWID
         AND A.VIP_BBG_CUSTOMER_COUNT IS NULL;
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
SELECT C.PROD_CL_WID PROD_DH_WID, B.ORG_WID, B.DT_WID, COUNT(DISTINCT B.SLS_TRX_ID) CNT
  FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_F_BAK B, RABATCHER.W_PRODUCT_D_RTL_TMP C
 WHERE B.PROD_WID = C.PROD_IT_WID
 GROUP BY C.PROD_CL_WID, B.ORG_WID, B.DT_WID';
      EXECUTE IMMEDIATE 'CREATE UNIQUE INDEX PK_CUST_TMP3 ON CUST_TMP3(PROD_DH_WID,
                                            ORG_WID,
                                            DT_WID)';
      UPDATE RADM.BBG_RA_CUST_CL_LC_DY_A A
         SET A.VIP_BBG_CUSTOMER_COUNT = NVL((SELECT D.CNT
                                              FROM CUST_TMP3 D
                                             WHERE D.PROD_DH_WID =
                                                   A.PROD_DH_WID
                                               AND D.ORG_WID = A.ORG_WID
                                               AND D.DT_WID = A.DT_WID),
                                            0)
       WHERE EXISTS (SELECT 1
                FROM CUST_TMP3 D
               WHERE D.PROD_DH_WID = A.PROD_DH_WID
                 AND D.ORG_WID = A.ORG_WID
                 AND D.DT_WID = A.DT_WID)
         AND A.VIP_BBG_CUSTOMER_COUNT IS NULL;
      COMMIT;
      UPDATE RADM.BBG_RA_CUST_CL_LC_DY_A A
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
      SELECT COUNT(1)
        INTO CNT
        FROM ALL_ALL_TABLES
       WHERE TABLE_NAME = 'CUST_TMP4';
      IF CNT = 1 THEN
        EXECUTE IMMEDIATE 'DROP TABLE RADM.CUST_TMP4';
      END IF;
      EXECUTE IMMEDIATE 'CREATE TABLE RADM.CUST_TMP4 AS
SELECT C.PROD_CL_WID PROD_DH_WID,
       B.ORG_WID,
       B.DT_WID,
       (TRUNC(B.MIN_WID / 100) * 100 + (M.QTR_HOUR_NUM - 1) * 15) MIN_WID,
       COUNT(DISTINCT B.SLS_TRX_ID) CNT
  FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_F_BAK B,
       RABATCHER.W_PRODUCT_D_RTL_TMP     C,
       W_MINUTE_OF_DAY_D                 M
 WHERE B.PROD_WID = C.PROD_IT_WID
   AND B.MIN_WID = M.ROW_WID
 GROUP BY C.PROD_CL_WID,
          B.ORG_WID,
          B.DT_WID,
          (TRUNC(B.MIN_WID / 100) * 100 + (M.QTR_HOUR_NUM - 1) * 15)';
      EXECUTE IMMEDIATE 'CREATE UNIQUE INDEX PK_CUST_TMP4 ON CUST_TMP4(PROD_DH_WID,
                                            ORG_WID,
                                            DT_WID,
                                            MIN_WID)';
      UPDATE RADM.BBG_RA_CUST_CL_LC_DY_HR_A A
         SET A.VIP_BBG_CUSTOMER_COUNT = NVL((SELECT D.CNT
                                              FROM CUST_TMP4 D
                                             WHERE D.PROD_DH_WID =
                                                   A.PROD_DH_WID
                                               AND D.ORG_WID = A.ORG_WID
                                               AND D.DT_WID = A.DT_WID
                                               AND D.MIN_WID = A.MINUTE_WID),
                                            0)
       WHERE EXISTS (SELECT 1
                FROM CUST_TMP4 D
               WHERE D.PROD_DH_WID = A.PROD_DH_WID
                 AND D.ORG_WID = A.ORG_WID
                 AND D.DT_WID = A.DT_WID
                 AND D.MIN_WID = A.MINUTE_WID)
         AND A.VIP_BBG_CUSTOMER_COUNT IS NULL;
      COMMIT;
      UPDATE RADM.BBG_RA_CUST_CL_LC_DY_HR_A A
         SET A.VIP_BBG_CUSTOMER_COUNT = 0
       WHERE A.DT_WID = DTWID
         AND A.VIP_BBG_CUSTOMER_COUNT IS NULL;
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
SELECT C.PROD_DP_WID PROD_DH_WID, B.ORG_WID, B.DT_WID, COUNT(DISTINCT B.SLS_TRX_ID) CNT
  FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_F_BAK B, RABATCHER.W_PRODUCT_D_RTL_TMP C
 WHERE B.PROD_WID = C.PROD_IT_WID
 GROUP BY C.PROD_DP_WID, B.ORG_WID, B.DT_WID';
      EXECUTE IMMEDIATE 'CREATE UNIQUE INDEX PK_CUST_TMP5 ON CUST_TMP5(PROD_DH_WID,
                                            ORG_WID,
                                            DT_WID)';
      UPDATE RADM.BBG_RA_CUST_DP_LC_DY_A A
         SET A.VIP_BBG_CUSTOMER_COUNT = NVL((SELECT D.CNT
                                              FROM CUST_TMP5 D
                                             WHERE D.PROD_DH_WID =
                                                   A.PROD_DH_WID
                                               AND D.ORG_WID = A.ORG_WID
                                               AND D.DT_WID = A.DT_WID),
                                            0)
       WHERE EXISTS (SELECT 1
                FROM CUST_TMP5 D
               WHERE D.PROD_DH_WID = A.PROD_DH_WID
                 AND D.ORG_WID = A.ORG_WID
                 AND D.DT_WID = A.DT_WID)
         AND A.VIP_BBG_CUSTOMER_COUNT IS NULL;
      COMMIT;
      UPDATE RADM.BBG_RA_CUST_DP_LC_DY_A A
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
      SELECT COUNT(1)
        INTO CNT
        FROM ALL_ALL_TABLES
       WHERE TABLE_NAME = 'CUST_TMP6';
      IF CNT = 1 THEN
        EXECUTE IMMEDIATE 'DROP TABLE RADM.CUST_TMP6';
      END IF;
      EXECUTE IMMEDIATE 'CREATE TABLE RADM.CUST_TMP6 AS
SELECT C.PROD_DP_WID PROD_DH_WID,
       B.ORG_WID,
       B.DT_WID,
       (TRUNC(B.MIN_WID / 100) * 100 + (M.QTR_HOUR_NUM - 1) * 15) MIN_WID,
       COUNT(DISTINCT B.SLS_TRX_ID) CNT
  FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_F_BAK B,
       RABATCHER.W_PRODUCT_D_RTL_TMP     C,
       W_MINUTE_OF_DAY_D                 M
 WHERE B.PROD_WID = C.PROD_IT_WID
   AND B.MIN_WID = M.ROW_WID
 GROUP BY C.PROD_DP_WID,
          B.ORG_WID,
          B.DT_WID,
          (TRUNC(B.MIN_WID / 100) * 100 + (M.QTR_HOUR_NUM - 1) * 15)';
      EXECUTE IMMEDIATE 'CREATE UNIQUE INDEX PK_CUST_TMP6 ON CUST_TMP6(PROD_DH_WID,
                                            ORG_WID,
                                            DT_WID,
                                            MIN_WID)';
      UPDATE RADM.BBG_RA_CUST_DP_LC_DY_HR_A A
         SET A.VIP_BBG_CUSTOMER_COUNT = NVL((SELECT D.CNT
                                              FROM CUST_TMP6 D
                                             WHERE D.PROD_DH_WID =
                                                   A.PROD_DH_WID
                                               AND D.ORG_WID = A.ORG_WID
                                               AND D.DT_WID = A.DT_WID
                                               AND D.MIN_WID = A.MINUTE_WID),
                                            0)
       WHERE EXISTS (SELECT 1
                FROM CUST_TMP6 D
               WHERE D.PROD_DH_WID = A.PROD_DH_WID
                 AND D.ORG_WID = A.ORG_WID
                 AND D.DT_WID = A.DT_WID
                 AND D.MIN_WID = A.MINUTE_WID)
         AND A.VIP_BBG_CUSTOMER_COUNT IS NULL;
      COMMIT;
      UPDATE RADM.BBG_RA_CUST_DP_LC_DY_HR_A A
         SET A.VIP_BBG_CUSTOMER_COUNT = 0
       WHERE A.DT_WID = DTWID
         AND A.VIP_BBG_CUSTOMER_COUNT IS NULL;
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
SELECT B.ORG_WID, B.DT_WID, COUNT(DISTINCT B.SLS_TRX_ID) CNT
  FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_F_BAK B
 GROUP BY B.ORG_WID, B.DT_WID';
      EXECUTE IMMEDIATE 'CREATE UNIQUE INDEX PK_CUST_TMP7 ON CUST_TMP7(ORG_WID,
                                            DT_WID)';
      UPDATE RADM.BBG_RA_CUST_LC_DY_A A
         SET A.VIP_BBG_CUSTOMER_COUNT = NVL((SELECT D.CNT
                                              FROM CUST_TMP7 D
                                             WHERE D.ORG_WID = A.ORG_WID
                                               AND D.DT_WID = A.DT_WID),
                                            0)
       WHERE EXISTS (SELECT 1
                FROM CUST_TMP7 D
               WHERE D.ORG_WID = A.ORG_WID
                 AND D.DT_WID = A.DT_WID)
         AND A.VIP_BBG_CUSTOMER_COUNT IS NULL;
      COMMIT;
      UPDATE RADM.BBG_RA_CUST_LC_DY_A A
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
      SELECT COUNT(1)
        INTO CNT
        FROM ALL_ALL_TABLES
       WHERE TABLE_NAME = 'CUST_TMP8';
      IF CNT = 1 THEN
        EXECUTE IMMEDIATE 'DROP TABLE RADM.CUST_TMP8';
      END IF;
      EXECUTE IMMEDIATE 'CREATE TABLE RADM.CUST_TMP8 AS
SELECT B.ORG_WID,
       B.DT_WID,
       (TRUNC(B.MIN_WID / 100) * 100 + (M.QTR_HOUR_NUM - 1) * 15) MIN_WID,
       COUNT(DISTINCT B.SLS_TRX_ID) CNT
  FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_F_BAK B,
       RABATCHER.W_PRODUCT_D_RTL_TMP     C,
       W_MINUTE_OF_DAY_D                 M
 WHERE B.PROD_WID = C.PROD_IT_WID
   AND B.MIN_WID = M.ROW_WID
 GROUP BY B.ORG_WID,
          B.DT_WID,
          (TRUNC(B.MIN_WID / 100) * 100 + (M.QTR_HOUR_NUM - 1) * 15)';
      EXECUTE IMMEDIATE 'CREATE UNIQUE INDEX PK_CUST_TMP8 ON CUST_TMP8(ORG_WID,
                                            DT_WID,
                                            MIN_WID)';
      UPDATE RADM.BBG_RA_CUST_LC_DY_HR_A A
         SET A.VIP_BBG_CUSTOMER_COUNT = NVL((SELECT D.CNT
                                              FROM CUST_TMP8 D
                                             WHERE D.ORG_WID = A.ORG_WID
                                               AND D.DT_WID = A.DT_WID
                                               AND D.MIN_WID = A.MINUTE_WID),
                                            0)
       WHERE EXISTS (SELECT 1
                FROM CUST_TMP8 D
               WHERE D.ORG_WID = A.ORG_WID
                 AND D.DT_WID = A.DT_WID
                 AND D.MIN_WID = A.MINUTE_WID)
         AND A.VIP_BBG_CUSTOMER_COUNT IS NULL;
      COMMIT;
      UPDATE RADM.BBG_RA_CUST_LC_DY_HR_A A
         SET A.VIP_BBG_CUSTOMER_COUNT = 0
       WHERE A.DT_WID = DTWID
         AND A.VIP_BBG_CUSTOMER_COUNT IS NULL;
      COMMIT;
    
      EXECUTE IMMEDIATE 'ALTER TABLE RADM.BBG_RA_CUST_LC_DY_HR_A LOGGING';
    END;
  
  END;

END;
/
