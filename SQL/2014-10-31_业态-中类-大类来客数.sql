--2013-05-8之后W_RTL_SLS_TRX_IT_LC_DY_F
--CREATE TABLE RADM.JIN_RMS_ST_TMP AS
INSERT INTO RADM.JIN_RMS_ST_TMP
SELECT /*+parallel(TRX,20) PARALLEL(V,20)*/
 TRX.ORG_NUM LOC,
 V.REGION,
 V.REGION_NAME,
 V.CHAIN,
 V.CHAIN_NAME,
 TRX.MONTH,
 TRX.PROD_CL_NUM CLASS,
 TRX.PROD_DP_NUM DEPT,
 COUNT(TRX.SLS_TRX_ID) TRX_CNT,
 SUM(TRX.AMT) AMT
  FROM (SELECT /*+parallel(S,20) parallel(P,20) parallel(O,20)*/
         O.ORG_NUM,
         SUBSTR(S.DT_WID, 2, 6) MONTH,
         P.PROD_CL_NUM,
         P.PROD_DP_NUM,
         S.SLS_TRX_ID,
         SUM(S.SLS_AMT_LCL - S.RET_AMT_LCL) AMT
          FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_F S,
               RABATCHER.W_PRODUCT_D_RTL_TMP P,
               RADM.W_INT_ORG_D              O
         WHERE S.PROD_WID = P.PROD_IT_WID
           AND S.ORG_WID = O.ROW_WID
           AND S.DT_WID > 120130508000
        --分部LVL8ANC_PRODCAT_ID(1位)PROD_DV_WID
        --大类LVL6ANC_PRODCAT_ID(2位)PROD_DP_WID
        --中类LVL5ANC_PRODCAT_ID(3位)PROD_CL_WID
        --小类LVL4ANC_PRODCAT_ID(4位)PROD_SC_WID
        --AND P.PROD_DV_NUM NOT IN (6,7,8,9)
         GROUP BY O.ORG_NUM,
                  SUBSTR(S.DT_WID, 2, 6),
                  P.PROD_CL_NUM,
                  P.PROD_DP_NUM,
                  S.SLS_TRX_ID) TRX,
       RMS.V_LOC@RA_RMS_DBLINK V
 WHERE TRX.ORG_NUM = V.STORE
 GROUP BY TRX.ORG_NUM,
          V.REGION,
          V.REGION_NAME,
          V.CHAIN,
          V.CHAIN_NAME,
          TRX.MONTH,
          TRX.PROD_CL_NUM,
          TRX.PROD_DP_NUM
 ORDER BY TRX.ORG_NUM,
          V.REGION,
          V.REGION_NAME,
          V.CHAIN,
          V.CHAIN_NAME,
          TRX.MONTH,
          TRX.PROD_CL_NUM,
          TRX.PROD_DP_NUM;
COMMIT;
					

--2013.5.7之前SALEDETAIL------------------------------------------------------------------------------
CREATE TABLE RADM.JIN_SALEDETAIL_ST_TMP AS				
SELECT /*+parallel(TRX,20) PARALLEL(V,20)*/
 TRX.ORG_NUM LOC,
 V.REGION,
 V.REGION_NAME,
 V.CHAIN,
 V.CHAIN_NAME,
 TRX.MONTH,
 TRX.CLASS,
 TRX.DEPT,
 COUNT(TRX.SLS_TRX_ID) TRX_CNT,
 SUM(TRX.AMT) AMT
  FROM (SELECT /*+parallel(T,20)*/
         SUBSTR(T.SHOPID, 2, 2) || SUBSTR(T.SHOPID, 1, 1) ||
         SUBSTR(T.SHOPID, 4, 3) ORG_NUM,
         SUBSTR(T.SD0101, 1, 6) MONTH,
         SUBSTR(T.CATEID, 1, 3) CLASS,
         SUBSTR(T.CATEID, 1, 2) DEPT,
         T.SHOPID || '|' || T.SD0101 || '|' || T.SD0109 || '|' || T.SD0106 SLS_TRX_ID,
         SUM(T.AMT) AMT
          FROM RADM.SALEDETAIL T
         WHERE T.SD0101 BETWEEN '20130101' AND '20130507' --销售日期
        --AND T.SHOPID='012045'
         GROUP BY T.SHOPID,
                  SUBSTR(T.SD0101, 1, 6),
                  SUBSTR(T.CATEID, 1, 3),
                  SUBSTR(T.CATEID, 1, 2),
                  T.SHOPID || '|' || T.SD0101 || '|' || T.SD0109 || '|' ||
                  T.SD0106) TRX,
       RMS.V_LOC@RA_RMS_DBLINK V
 WHERE TRX.ORG_NUM = V.STORE
 GROUP BY TRX.ORG_NUM,
          V.REGION,
          V.REGION_NAME,
          V.CHAIN,
          V.CHAIN_NAME,
          TRX.MONTH,
          TRX.CLASS,
          TRX.DEPT
 ORDER BY TRX.ORG_NUM,
          V.REGION,
          V.REGION_NAME,
          V.CHAIN,
          V.CHAIN_NAME,
          TRX.MONTH,
          TRX.CLASS,
          TRX.DEPT;
					
					
--合并
SELECT T.LOC,
       T.REGION,
       T.REGION_NAME,
       T.CHAIN,
       T.CHAIN_NAME,
       T.MONTH,
       T.CLASS,
       T.DEPT,
       SUM(T.TRX_CNT) TRX_CNT,
       SUM(T.AMT) AMT
  FROM (SELECT A.LOC,
               A.REGION,
               A.REGION_NAME,
               A.CHAIN,
               A.CHAIN_NAME,
               A.MONTH,
               A.CLASS,
               A.DEPT,
               A.TRX_CNT,
               A.AMT
          FROM RADM.JIN_RMS_ST_TMP A
        UNION ALL
        SELECT B.LOC,
               B.REGION,
               B.REGION_NAME,
               B.CHAIN,
               B.CHAIN_NAME,
               B.MONTH,
               B.CLASS,
               B.DEPT,
               B.TRX_CNT,
               B.AMT
          FROM RADM.JIN_SALEDETAIL_ST_TMP B) T
 GROUP BY T.LOC,
          T.REGION,
          T.REGION_NAME,
          T.CHAIN,
          T.CHAIN_NAME,
          T.MONTH,
          T.CLASS,
          T.DEPT;

