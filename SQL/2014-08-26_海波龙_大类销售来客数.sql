--辉哥发过来的语句
SELECT 'RET',
       SLS.ORG_NUM SHPCODE,
       'RET006',
       SLS.DP_NUM BRANCH_CODE,
       SLS.YEAR,
       SLS.PERIOD,
       SLS.AMT / CUST.CUST BUSINESSDATA
  FROM (SELECT TAL.ORG_NUM,
               SUBSTR(TAL.DAY, 1, 4) YEAR,
               SUBSTR(TAL.DAY, 5, 2) PERIOD,
               TAL.DP_NUM,
               SUM(TAL.CUST) CUST
          FROM (SELECT ORG.ORG_NUM,
                       A.DAY,
                       CATE.LVL6ANC_PRODCAT_ID DP_NUM,
                       A.CUST
                  FROM (SELECT T.ORG_WID,
                               T.PROD_DH_WID,
                               SUBSTR(T.DT_WID, 2, 6) DAY,
                               SUM(T.BBG_CUSTOMER_COUNT) CUST
                          FROM BBG_RA_CUST_DP_LC_DY_A T
                         where SUBSTR(t.DT_WID, 2, 4) = 2011
                           and SUBSTR(t.DT_WID, 6, 2) = 10
                         GROUP BY T.ORG_WID,
                                  T.PROD_DH_WID,
                                  SUBSTR(T.DT_WID, 2, 6)) A,
                       W_INT_ORG_D ORG,
                       W_PROD_CAT_DH CATE
                 WHERE A.ORG_WID = ORG.ROW_WID
                   AND A.PROD_DH_WID = CATE.ROW_WID
                   AND CATE.LEVEL_NAME = 'DEPT') TAL
         GROUP BY TAL.ORG_NUM, TAL.DAY, TAL.DP_NUM) CUST, --大类来客
       (SELECT SUBSTR(S.MN_WID, 1, 4) YEAR,
               SUBSTR(S.MN_WID, 5, 2) PERIOD,
               ORG.ORG_NUM,
               CAT.LVL6ANC_PRODCAT_ID DP_NUM,
               SUM(S.SLS_AMT_LCL - S.RET_AMT_LCL) AMT
          FROM W_RTL_SLS_DP_LC_MN_A S, W_INT_ORG_D ORG, W_PROD_CAT_DH CAT
         WHERE S.ORG_WID = ORG.ROW_WID
           AND S.PROD_DH_WID = CAT.ROW_WID
           AND CAT.LEVEL_NAME = 'DEPT'
           and SUBSTR(S.MN_WID, 1, 4) = 2011
           and SUBSTR(S.MN_WID, 5, 2) = 10
         GROUP BY SUBSTR(S.MN_WID, 1, 4),
                  SUBSTR(S.MN_WID, 5, 2),
                  ORG.ORG_NUM,
                  CAT.LVL6ANC_PRODCAT_ID) SLS --大类销售
 WHERE CUST.ORG_NUM = SLS.ORG_NUM
   AND CUST.YEAR = SLS.YEAR
   AND CUST.PERIOD = SLS.PERIOD
   AND SLS.DP_NUM = CUST.DP_NUM
 ORDER BY SLS.YEAR, SLS.PERIOD, SLS.ORG_NUM, SLS.DP_NUM;

--修改RABATCHER.W_INT_ORG_DH_RTL_TMP的EFFECTIVE_FROM_DT成2011-1-1
UPDATE RABATCHER.W_INT_ORG_DH_RTL_TMP T
   SET T.EFFECTIVE_FROM_DT = DATE '2011-01-01'
 WHERE T.EFFECTIVE_FROM_DT = DATE '2013-05-07';

--2011/10、2011/12大类来客数插入
INSERT INTO RADM.BBG_RA_CUST_DP_LC_DY_A
  SELECT bbg_ra_cust_dp_lc_dy_a_seq.nextval,
         O.ORG_WID,
         OH.ORG_LC_WID ORG_DH_WID,
         O.ORG_SCD1_WID,
         P.PROD_DP_WID PROD_DH_WID,
         '1' || S.SD0101 || '000' DT_WID,
         1 DATASOURCE_NUM_ID,
         SYSDATE W_INSERT_DT,
         SYSDATE W_UPDATE_DT,
         TO_CHAR(TO_DATE(SUBSTR(S.SD0101, 1, 8), 'YYYYMMDD'),
                 'DD-MON-YY',
                 'NLS_DATE_LANGUAGE=AMERICAN') || '~' || O.ORG_NUM || '~' ||
         P.PROD_DP_NUM INTEGRATION_ID,
         S.CNT BBG_CUSTOMER_COUNT,
         0 BBG_SERVICE_SATISFACTION,
         NULL BBG_REFERENCE_DO1,
         NULL BBG_REFERENCE_DO2,
         NULL BBG_REFERENCE_DO3,
         NULL BBG_REFERENCE_DO4,
         NULL BBG_REFERENCE_DO5,
         NULL BBG_REFERENCE_FO1,
         NULL BBG_REFERENCE_FO2,
         NULL BBG_REFERENCE_FO3,
         NULL BBG_REFERENCE_FO4,
         NULL BBG_REFERENCE_FO5,
         NULL BBG_REFERENCE_FO6,
         NULL BBG_REFERENCE_FO7,
         NULL BBG_REFERENCE_FO8,
         NULL BBG_REFERENCE_FO9,
         NULL BBG_REFERENCE_FO10
    FROM (SELECT TRX.SD0101, TRX.SHOPID, TRX.CATEID, SUM(TRX.CNT) CNT
            FROM (SELECT DISTINCT T.SD0101,
                                  T.SHOPID,
                                  SUBSTR(T.CATEID, 1, 2) CATEID,
                                  T.SD0101 || T.SHOPID || T.SD0106 ||
                                  T.SD0109 TRX,
                                  1 CNT
                    FROM RADM.SALEDETAIL T
                   WHERE T.SD0101 BETWEEN 20111001 AND 20111031
                  UNION ALL
                  SELECT DISTINCT T.SD0101,
                                  T.SHOPID,
                                  SUBSTR(T.CATEID, 1, 2) CATEID,
                                  T.SD0101 || T.SHOPID || T.SD0106 ||
                                  T.SD0109 TRX,
                                  1 CNT
                    FROM RADM.SALEDETAIL T
                   WHERE T.SD0101 BETWEEN 20111201 AND 20111231) TRX
           GROUP BY TRX.SD0101, TRX.SHOPID, TRX.CATEID) S,
         RABATCHER.W_INT_ORG_D_RTL_TMP O,
         RABATCHER.W_INT_ORG_DH_RTL_TMP OH,
         (SELECT DISTINCT P1.PROD_DP_WID, P1.PROD_DP_NUM
            FROM RABATCHER.W_PRODUCT_D_RTL_TMP P1) P
   WHERE O.ORG_SCD1_WID = OH.ORG_SCD1_WID
     AND TO_DATE(S.SD0101, 'YYYYMMDD') BETWEEN OH.EFFECTIVE_FROM_DT AND
         OH.EFFECTIVE_TO_DT
     AND P.PROD_DP_NUM = SUBSTR(S.CATEID, 1, 2)
     AND SUBSTR(S.SHOPID, 2, 2) || SUBSTR(S.SHOPID, 1, 1) ||
         SUBSTR(S.SHOPID, 4, 3) = O.ORG_NUM;
COMMIT;


DROP MATERIALIZED VIEW RADM.JIN_DP_CUST_TMP;
CREATE MATERIALIZED VIEW RADM.JIN_DP_CUST_TMP AS
  SELECT 
         O.ORG_WID,
         OH.ORG_LC_WID ORG_DH_WID,
         O.ORG_SCD1_WID,
         P.PROD_DP_WID PROD_DH_WID,
         '1' || S.SD0101 || '000' DT_WID,
         1 DATASOURCE_NUM_ID,
         SYSDATE W_INSERT_DT,
         SYSDATE W_UPDATE_DT,
         TO_CHAR(TO_DATE(SUBSTR(S.SD0101, 1, 8), 'YYYYMMDD'),
                 'DD-MON-YY',
                 'NLS_DATE_LANGUAGE=AMERICAN') || '~' || O.ORG_NUM || '~' ||
         P.PROD_DP_NUM INTEGRATION_ID,
         S.CNT BBG_CUSTOMER_COUNT,
         0 BBG_SERVICE_SATISFACTION/*,
         NULL BBG_REFERENCE_DO1,
         NULL BBG_REFERENCE_DO2,
         NULL BBG_REFERENCE_DO3,
         NULL BBG_REFERENCE_DO4,
         NULL BBG_REFERENCE_DO5,
         NULL BBG_REFERENCE_FO1,
         NULL BBG_REFERENCE_FO2,
         NULL BBG_REFERENCE_FO3,
         NULL BBG_REFERENCE_FO4,
         NULL BBG_REFERENCE_FO5,
         NULL BBG_REFERENCE_FO6,
         NULL BBG_REFERENCE_FO7,
         NULL BBG_REFERENCE_FO8,
         NULL BBG_REFERENCE_FO9,
         NULL BBG_REFERENCE_FO10*/
    FROM (SELECT TRX.SD0101, TRX.SHOPID, TRX.CATEID, SUM(TRX.CNT) CNT
            FROM (SELECT DISTINCT T.SD0101,
                                  T.SHOPID,
                                  SUBSTR(T.CATEID, 1, 2) CATEID,
                                  T.SD0101 || T.SHOPID || T.SD0106 ||
                                  T.SD0109 TRX,
                                  1 CNT
                    FROM RADM.SALEDETAIL T
                   WHERE T.SD0101 BETWEEN 20111001 AND 20111031
                  UNION ALL
                  SELECT DISTINCT T.SD0101,
                                  T.SHOPID,
                                  SUBSTR(T.CATEID, 1, 2) CATEID,
                                  T.SD0101 || T.SHOPID || T.SD0106 ||
                                  T.SD0109 TRX,
                                  1 CNT
                    FROM RADM.SALEDETAIL T
                   WHERE T.SD0101 BETWEEN 20111201 AND 20111231) TRX
           GROUP BY TRX.SD0101, TRX.SHOPID, TRX.CATEID) S,
         RABATCHER.W_INT_ORG_D_RTL_TMP O,
         RABATCHER.W_INT_ORG_DH_RTL_TMP OH,
         (SELECT DISTINCT P1.PROD_DP_WID, P1.PROD_DP_NUM
            FROM RABATCHER.W_PRODUCT_D_RTL_TMP P1) P
   WHERE O.ORG_SCD1_WID = OH.ORG_SCD1_WID
     AND TO_DATE(S.SD0101, 'YYYYMMDD') BETWEEN OH.EFFECTIVE_FROM_DT AND
         OH.EFFECTIVE_TO_DT
     AND P.PROD_DP_NUM = SUBSTR(S.CATEID, 1, 2)
     AND SUBSTR(S.SHOPID, 2, 2) || SUBSTR(S.SHOPID, 1, 1) ||
         SUBSTR(S.SHOPID, 4, 3) = O.ORG_NUM;

