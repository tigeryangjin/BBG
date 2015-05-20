--2.出清毛利额------------------------------------------------------------------------------------------
--当期数
SELECT 'RET18' AS PKEY,
       'RET' AS CORP_CODE,
       ORG_NUM AS SHOP_CODE,
       '当期数' AS ACCOUNT_CODE,
       DV AS BRANCH_CODE,
       DEPT AS SEG01_CODE,
       NULL AS SEG02_CODE,
       NULL AS SEG03_CODE,
       YEAR,
       PERIOD,
       COST AS BUSINESSDATA,
       SYSDATE AS MODIFYTIME
  FROM (SELECT SUBSTR(A.MN_WID, 1, 4) YEAR,
               SUBSTR(A.MN_WID, 5, 2) PERIOD,
               SUM(NVL(A.SLS_PROFIT_AMT_LCL, 0) - NVL(A.RET_PROFIT_AMT_LCL, 0)) COST,
               B.ORG_NUM,
               D.LVL6ANC_PRODCAT_ID DEPT,
               D.LVL8ANC_PRODCAT_ID DV
          FROM W_RTL_SLS_DP_LC_MN_A A, W_INT_ORG_D B, RADM.W_PROD_CAT_DH D
         WHERE A.ORG_WID = B.ROW_WID
           AND EXISTS (SELECT 1
                  FROM RADM.BBG_RA_RETAIL_TYPE_D R
                 WHERE A.BBG_RETAIL_TYPE_WID = R.ROW_WID
                   AND R.RETAIL_TYPE_ID = (9,21,25))
           AND A.PROD_DH_WID = D.ROW_WID
           and A.MN_WID = 201501
         GROUP BY SUBSTR(A.MN_WID, 1, 4),
                  SUBSTR(A.MN_WID, 5, 2),
                  B.ORG_NUM,
                  D.LVL6ANC_PRODCAT_ID,
                  D.LVL8ANC_PRODCAT_ID);

--累计数
SELECT 'RET18' AS PKEY,
       'RET' AS CORP_CODE,
       ORG_NUM AS SHOP_CODE,
       '累计数' AS ACCOUNT_CODE,
       DV AS BRANCH_CODE,
       DEPT AS SEG01_CODE,
       NULL AS SEG02_CODE,
       NULL AS SEG03_CODE,
       YEAR,
       PERIOD,
       COST AS BUSINESSDATA,
       SYSDATE AS MODIFYTIME
  FROM (SELECT MAX(SUBSTR(A.MN_WID, 1, 4)) YEAR,
               MAX(SUBSTR(A.MN_WID, 5, 2)) PERIOD,
               SUM(NVL(A.SLS_PROFIT_AMT_LCL, 0) - NVL(A.RET_PROFIT_AMT_LCL, 0)) COST,
               B.ORG_NUM,
               D.LVL6ANC_PRODCAT_ID DEPT,
               D.LVL8ANC_PRODCAT_ID DV
          FROM W_RTL_SLS_DP_LC_MN_A A, W_INT_ORG_D B, RADM.W_PROD_CAT_DH D
         WHERE A.ORG_WID = B.ROW_WID
           AND EXISTS (SELECT 1
                  FROM RADM.BBG_RA_RETAIL_TYPE_D R
                 WHERE A.BBG_RETAIL_TYPE_WID = R.ROW_WID
                   AND R.RETAIL_TYPE_ID = (9,21,25))
           AND A.PROD_DH_WID = D.ROW_WID
           and A.MN_WID BETWEEN 201501 AND 201502
         GROUP BY B.ORG_NUM, D.LVL6ANC_PRODCAT_ID, D.LVL8ANC_PRODCAT_ID);
