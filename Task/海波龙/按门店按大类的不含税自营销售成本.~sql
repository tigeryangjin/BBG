--RAÓï¾ä
select distinct 0 as c1,
                D1.c4 as c2,
                D1.c1 as c3,
                D1.c3 - D1.c2 as c4,
                D1.c3 - D1.c2 - D1.c1 as c5,
                D1.c5 as c6
  from (select sum(nvl(T1027135.SLS_PROFIT_AMT_LCL, 0) -
                   nvl(T1027135.RET_PROFIT_AMT_LCL, 0)) as c1,
               sum(nvl(T1027135.SLS_TAX_AMT_LCL, 0) -
                   nvl(T1027135.RET_TAX_AMT_LCL, 0)) as c2,
               sum(nvl(T1027135.SLS_AMT_LCL, 0) -
                   nvl(T1027135.RET_AMT_LCL, 0)) as c3,
               T960458.PER_NAME_MONTH as c4,
               T960458.ROW_WID as c5
          from W_MONTH_D         T960458 /* Dim_W_MONTH_D_Retail_Gregorian_Calendar */,
               W_RTL_SLS_SC_MN_A T1027135 /* Fact_W_RTL_SLS_SC_MN_A */
         where (T960458.ROW_WID = T1027135.MN_WID and
               T960458.PER_NAME_MONTH = '2014 / 04' and
               '2010' < T960458.CAL_YEAR)
         group by T960458.ROW_WID, T960458.PER_NAME_MONTH) D1
 order by c2;

--W_RTL_SLS_SC_MN_A
SELECT SUM(A.SLS_AMT_LCL),
       SUM(A.RET_AMT_LCL),
       SUM(A.SLS_TAX_AMT_LCL),
       SUM(A.RET_TAX_AMT_LCL),
       SUM(A.SLS_PROFIT_AMT_LCL),
       SUM(A.RET_PROFIT_AMT_LCL)
  FROM RADM.W_RTL_SLS_SC_MN_A A
 WHERE A.MN_WID = 201404;

--W_RTL_SLS_IT_LC_DY_A
SELECT SUM(A.SLS_AMT_LCL),
       SUM(A.RET_AMT_LCL),
       SUM(A.SLS_TAX_AMT_LCL),
       SUM(A.RET_TAX_AMT_LCL),
       SUM(A.SLS_PROFIT_AMT_LCL),
       SUM(A.RET_PROFIT_AMT_LCL)
  FROM RADM.W_RTL_SLS_IT_LC_DY_A A
 WHERE SUBSTR(A.DT_WID, 2, 6) = 201404;

--W_RTL_SLS_SC_DY_A
SELECT SUM(A.SLS_AMT_LCL),
       SUM(A.RET_AMT_LCL),
       SUM(A.SLS_TAX_AMT_LCL),
       SUM(A.RET_TAX_AMT_LCL),
       SUM(A.SLS_PROFIT_AMT_LCL),
       SUM(A.RET_PROFIT_AMT_LCL)
  FROM RADM.W_RTL_SLS_SC_DY_A A
 WHERE SUBSTR(A.DT_WID, 2, 6) = 201404;

SELECT 435216328.7668 - 434641447.656 FROM DUAL;
--ÐÞ¸Äºó
SELECT NULL AS PKEY,
       'RET' AS CORP_CODE,
       ORG_NUM AS SHOP_CODE,
       'RET0009' AS ACCOUNT_CODE,
       DEPT AS BRANCH_CODE,
       NULL AS SEG01_CODE,
       NULL AS SEG02_CODE,
       NULL AS SEG03_CODE,
       YEAR,
       PERIOD,
       COST AS BUSINESSDATA,
       SYSDATE AS MODIFYTIME
  FROM (SELECT SUBSTR(A.DT_WID, 2, 4) YEAR,
               SUBSTR(A.DT_WID, 6, 2) PERIOD,
               SUM((NVL(A.SLS_AMT_LCL,0) - NVL(A.RET_AMT_LCL,0)) -
                   (NVL(A.SLS_TAX_AMT_LCL,0) - NVL(A.RET_TAX_AMT_LCL,0)) -
                   (NVL(A.SLS_PROFIT_AMT_LCL,0) - NVL(A.RET_PROFIT_AMT_LCL,0))) COST,
               B.ORG_NUM,
               D.PROD_DP_NUM DEPT
          FROM W_RTL_SLS_IT_LC_DY_A          A,
               W_INT_ORG_D                   B,
               BBG_RA_ITEM_LOC_D             C,
               RABATCHER.W_PRODUCT_D_RTL_TMP D
         WHERE A.ORG_WID = B.ROW_WID
           AND A.BBG_ITEM_LOC_WID = C.ROW_WID
           AND C.BUSINESS_MODE IN ('JX', 'DX')
           AND A.PROD_WID = D.PROD_IT_WID
           and a.dt_wid = 120140401000
         GROUP BY SUBSTR(A.DT_WID, 2, 4),
                  SUBSTR(A.DT_WID, 6, 2),
                  B.ORG_NUM,
                  D.PROD_DP_NUM);

--
SELECT NULL AS PKEY,
       'RET' AS CORP_CODE,
       ORG_NUM AS SHOP_CODE,
       'RET0009' AS ACCOUNT_CODE,
       DEPT AS BRANCH_CODE,
       NULL AS SEG01_CODE,
       NULL AS SEG02_CODE,
       NULL AS SEG03_CODE,
       YEAR,
       PERIOD,
       COST AS BUSINESSDATA,
       SYSDATE AS MODIFYTIME
  FROM (SELECT SUBSTR(A.DT_WID, 2, 4) YEAR,
               SUBSTR(A.DT_WID, 6, 2) PERIOD,
               SUM((NVL(A.SLS_AMT_LCL,0) - NVL(A.RET_AMT_LCL,0)) -
                   (NVL(A.SLS_TAX_AMT_LCL,0) - NVL(A.RET_TAX_AMT_LCL,0)) -
                   (NVL(A.SLS_PROFIT_AMT_LCL,0) - NVL(A.RET_PROFIT_AMT_LCL,0))) COST,
               B.ORG_NUM,
               D.PROD_DP_NUM DEPT
          FROM W_RTL_SLS_IT_LC_DY_A          A,
               W_INT_ORG_D                   B,
               BBG_RA_ITEM_LOC_D             C,
               RABATCHER.W_PRODUCT_D_RTL_TMP D
         WHERE A.ORG_WID = B.ROW_WID
           AND A.BBG_ITEM_LOC_WID = C.ROW_WID
              --AND C.BUSINESS_MODE IN ('JX', 'DX')
           AND A.PROD_WID = D.PROD_IT_WID
           and SUBSTR(a.dt_wid, 2, 6) = 201404
         GROUP BY SUBSTR(A.DT_WID, 2, 4),
                  SUBSTR(A.DT_WID, 6, 2),
                  B.ORG_NUM,
                  D.PROD_DP_NUM);
