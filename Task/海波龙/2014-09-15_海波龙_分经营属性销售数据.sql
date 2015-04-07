--RA分经营属性的销售数据
--2015.3.25正确的应该是关联RADM.W_PROD_CAT_DH,而不是关联RABATCHER.W_PRODUCT_D_RTL_TMP
--1.促销销售--------------------------------------------------------------------------------------------
--当期数
SELECT 'RET11' AS PKEY,
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
               SUM((NVL(A.SLS_AMT_LCL, 0) - NVL(A.RET_AMT_LCL, 0)) -
                   (NVL(A.SLS_TAX_AMT_LCL, 0) - NVL(A.RET_TAX_AMT_LCL, 0))) COST,
               B.ORG_NUM,
               D.LVL6ANC_PRODCAT_ID DEPT,
               D.LVL8ANC_PRODCAT_ID DV
          FROM RADM.W_RTL_SLS_DP_LC_MN_A A,
               RADM.W_INT_ORG_D          B,
               RADM.W_PROD_CAT_DH        D
         WHERE A.ORG_WID = B.ROW_WID
           AND EXISTS (SELECT 1
                  FROM RADM.BBG_RA_RETAIL_TYPE_D R
                 WHERE A.BBG_RETAIL_TYPE_WID = R.ROW_WID
                   AND R.RETAIL_GROUP_ID = 5)
           AND A.PROD_DH_WID = D.ROW_WID
           and A.MN_WID = 201404
         GROUP BY SUBSTR(A.MN_WID, 1, 4),
                  SUBSTR(A.MN_WID, 5, 2),
                  B.ORG_NUM,
                  D.LVL6ANC_PRODCAT_ID,
                  D.LVL8ANC_PRODCAT_ID);

--累计数
SELECT 'RET11' AS PKEY,
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
               SUM((NVL(A.SLS_AMT_LCL, 0) - NVL(A.RET_AMT_LCL, 0)) -
                   (NVL(A.SLS_TAX_AMT_LCL, 0) - NVL(A.RET_TAX_AMT_LCL, 0))) COST,
               B.ORG_NUM,
               D.LVL6ANC_PRODCAT_ID DEPT,
               D.LVL8ANC_PRODCAT_ID DV
          FROM W_RTL_SLS_DP_LC_MN_A A, W_INT_ORG_D B, RADM.W_PROD_CAT_DH D
         WHERE A.ORG_WID = B.ROW_WID
           AND EXISTS (SELECT 1
                  FROM RADM.BBG_RA_RETAIL_TYPE_D R
                 WHERE A.BBG_RETAIL_TYPE_WID = R.ROW_WID
                   AND R.RETAIL_GROUP_ID = 5)
           AND A.PROD_DH_WID = D.ROW_WID
           and A.MN_WID BETWEEN 201401 AND 201404
         GROUP BY B.ORG_NUM, D.LVL6ANC_PRODCAT_ID, D.LVL8ANC_PRODCAT_ID);

--2.出清销售------------------------------------------------------------------------------------------
--当期数
SELECT 'RET12' AS PKEY,
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
               SUM((NVL(A.SLS_AMT_LCL, 0) - NVL(A.RET_AMT_LCL, 0)) -
                   (NVL(A.SLS_TAX_AMT_LCL, 0) - NVL(A.RET_TAX_AMT_LCL, 0))) COST,
               B.ORG_NUM,
               D.LVL6ANC_PRODCAT_ID DEPT,
               D.LVL8ANC_PRODCAT_ID DV
          FROM W_RTL_SLS_DP_LC_MN_A A, W_INT_ORG_D B, RADM.W_PROD_CAT_DH D
         WHERE A.ORG_WID = B.ROW_WID
           AND EXISTS (SELECT 1
                  FROM RADM.BBG_RA_RETAIL_TYPE_D R
                 WHERE A.BBG_RETAIL_TYPE_WID = R.ROW_WID
                   AND R.RETAIL_TYPE_ID = 21)
           AND A.PROD_DH_WID = D.ROW_WID
           and A.MN_WID = 201404
         GROUP BY SUBSTR(A.MN_WID, 1, 4),
                  SUBSTR(A.MN_WID, 5, 2),
                  B.ORG_NUM,
                  D.LVL6ANC_PRODCAT_ID,
                  D.LVL8ANC_PRODCAT_ID);

--累计数
SELECT 'RET12' AS PKEY,
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
               SUM((NVL(A.SLS_AMT_LCL, 0) - NVL(A.RET_AMT_LCL, 0)) -
                   (NVL(A.SLS_TAX_AMT_LCL, 0) - NVL(A.RET_TAX_AMT_LCL, 0))) COST,
               B.ORG_NUM,
               D.LVL6ANC_PRODCAT_ID DEPT,
               D.LVL8ANC_PRODCAT_ID DV
          FROM W_RTL_SLS_DP_LC_MN_A A, W_INT_ORG_D B, RADM.W_PROD_CAT_DH D
         WHERE A.ORG_WID = B.ROW_WID
           AND EXISTS (SELECT 1
                  FROM RADM.BBG_RA_RETAIL_TYPE_D R
                 WHERE A.BBG_RETAIL_TYPE_WID = R.ROW_WID
                   AND R.RETAIL_TYPE_ID = 21)
           AND A.PROD_DH_WID = D.ROW_WID
           and A.MN_WID BETWEEN 201401 AND 201404
         GROUP BY B.ORG_NUM, D.LVL6ANC_PRODCAT_ID, D.LVL8ANC_PRODCAT_ID);

--3.大宗销售------------------------------------------------------------------------------------------    
--当期数
SELECT 'RET13' AS PKEY,
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
               SUM((NVL(A.SLS_AMT_LCL, 0) - NVL(A.RET_AMT_LCL, 0)) -
                   (NVL(A.SLS_TAX_AMT_LCL, 0) - NVL(A.RET_TAX_AMT_LCL, 0))) COST,
               B.ORG_NUM,
               D.LVL6ANC_PRODCAT_ID DEPT,
               D.LVL8ANC_PRODCAT_ID DV
          FROM W_RTL_SLS_DP_LC_MN_A A, W_INT_ORG_D B, RADM.W_PROD_CAT_DH D
         WHERE A.ORG_WID = B.ROW_WID
           AND EXISTS (SELECT 1
                  FROM RADM.BBG_RA_RETAIL_TYPE_D R
                 WHERE A.BBG_RETAIL_TYPE_WID = R.ROW_WID
                   AND R.RETAIL_GROUP_ID = 2)
           AND A.PROD_DH_WID = D.ROW_WID
           and A.MN_WID = 201404
         GROUP BY SUBSTR(A.MN_WID, 1, 4),
                  SUBSTR(A.MN_WID, 5, 2),
                  B.ORG_NUM,
                  D.LVL6ANC_PRODCAT_ID,
                  D.LVL8ANC_PRODCAT_ID);

--累计数
SELECT 'RET13' AS PKEY,
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
               SUM((NVL(A.SLS_AMT_LCL, 0) - NVL(A.RET_AMT_LCL, 0)) -
                   (NVL(A.SLS_TAX_AMT_LCL, 0) - NVL(A.RET_TAX_AMT_LCL, 0))) COST,
               B.ORG_NUM,
               D.LVL6ANC_PRODCAT_ID DEPT,
               D.LVL8ANC_PRODCAT_ID DV
          FROM W_RTL_SLS_DP_LC_MN_A A, W_INT_ORG_D B, RADM.W_PROD_CAT_DH D
         WHERE A.ORG_WID = B.ROW_WID
           AND EXISTS (SELECT 1
                  FROM RADM.BBG_RA_RETAIL_TYPE_D R
                 WHERE A.BBG_RETAIL_TYPE_WID = R.ROW_WID
                   AND R.RETAIL_GROUP_ID = 2)
           AND A.PROD_DH_WID = D.ROW_WID
           and A.MN_WID BETWEEN 201401 AND 201404
         GROUP BY B.ORG_NUM, D.LVL6ANC_PRODCAT_ID, D.LVL8ANC_PRODCAT_ID);

--4.正常销售------------------------------------------------------------------------------------------
SELECT 'RET14' AS PKEY,
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
               SUM((NVL(A.SLS_AMT_LCL, 0) - NVL(A.RET_AMT_LCL, 0)) -
                   (NVL(A.SLS_TAX_AMT_LCL, 0) - NVL(A.RET_TAX_AMT_LCL, 0)) ) COST,
               B.ORG_NUM,
               D.LVL6ANC_PRODCAT_ID DEPT,
               D.LVL8ANC_PRODCAT_ID DV
          FROM W_RTL_SLS_DP_LC_MN_A A, W_INT_ORG_D B, RADM.W_PROD_CAT_DH D
         WHERE A.ORG_WID = B.ROW_WID
           AND EXISTS (SELECT 1
                  FROM RADM.BBG_RA_RETAIL_TYPE_D R
                 WHERE A.BBG_RETAIL_TYPE_WID = R.ROW_WID
                   AND R.RETAIL_GROUP_ID = 1)
           AND A.PROD_DH_WID = D.ROW_WID
           and A.MN_WID = 201408
         GROUP BY SUBSTR(A.MN_WID, 1, 4),
                  SUBSTR(A.MN_WID, 5, 2),
                  B.ORG_NUM,
                  D.LVL6ANC_PRODCAT_ID,
                  D.LVL8ANC_PRODCAT_ID);

--累计数
SELECT 'RET14' AS PKEY,
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
               SUM((NVL(A.SLS_AMT_LCL, 0) - NVL(A.RET_AMT_LCL, 0)) -
                   (NVL(A.SLS_TAX_AMT_LCL, 0) - NVL(A.RET_TAX_AMT_LCL, 0))) COST,
               B.ORG_NUM,
               D.LVL6ANC_PRODCAT_ID DEPT,
               D.LVL8ANC_PRODCAT_ID DV
          FROM W_RTL_SLS_DP_LC_MN_A A, W_INT_ORG_D B, RADM.W_PROD_CAT_DH D
         WHERE A.ORG_WID = B.ROW_WID
           AND EXISTS (SELECT 1
                  FROM RADM.BBG_RA_RETAIL_TYPE_D R
                 WHERE A.BBG_RETAIL_TYPE_WID = R.ROW_WID
                   AND R.RETAIL_GROUP_ID = 1)
           AND A.PROD_DH_WID = D.ROW_WID
           and A.MN_WID BETWEEN 201401 AND 201404
         GROUP BY B.ORG_NUM, D.LVL6ANC_PRODCAT_ID, D.LVL8ANC_PRODCAT_ID);

--2015.2.5修改
--RA分经营属性的销售数据
--1.促销销售--------------------------------------------------------------------------------------------
--当期数

insert into bbg_ys_t_businessdata_retek
  (corp_code,
   shop_code,
   account_code,
   branch_code,
   SEG01_CODE,
   SEG02_CODE,
   SEG03_CODE,
   year,
   period,
   businessdata)
  SELECT 'RET' AS CORP_CODE,
         ORG_NUM AS SHOP_CODE,
         'RET011当期数' AS ACCOUNT_CODE,
         DEPT AS BRANCH_CODE,
         DV AS SEG01_CODE,
         NULL AS SEG02_CODE,
         NULL AS SEG03_CODE,
         YEAR,
         PERIOD,
         COST AS BUSINESSDATA
  
    FROM (SELECT SUBSTR(A.MN_WID, 1, 4) YEAR,
                 SUBSTR(A.MN_WID, 5, 2) PERIOD,
                 SUM((NVL(A.SLS_AMT_LCL, 0) - NVL(A.RET_AMT_LCL, 0)) -
                     (NVL(A.SLS_TAX_AMT_LCL, 0) - NVL(A.RET_TAX_AMT_LCL, 0)) ) COST,
                 B.ORG_NUM,
                 D.PROD_DP_NUM DEPT,
                 D.PROD_DV_NUM DV
            FROM W_RTL_SLS_DP_LC_MN_A          A,
                 W_INT_ORG_D                   B,
                 RABATCHER.W_PRODUCT_D_RTL_TMP D
           WHERE A.ORG_WID = B.ROW_WID
             AND EXISTS (SELECT 1
                    FROM RADM.BBG_RA_RETAIL_TYPE_D R
                   WHERE A.BBG_RETAIL_TYPE_WID = R.ROW_WID
                     AND R.RETAIL_GROUP_ID = 5)
             AND A.PROD_DH_WID = D.PROD_DP_WID
             and A.MN_WID = ls_year || ls_period
           GROUP BY SUBSTR(A.MN_WID, 1, 4),
                    SUBSTR(A.MN_WID, 5, 2),
                    B.ORG_NUM,
                    D.PROD_DP_NUM,
                    D.PROD_DV_NUM);

commit;

--累计数
insert into bbg_ys_t_businessdata_retek
  (corp_code,
   shop_code,
   account_code,
   branch_code,
   SEG01_CODE,
   SEG02_CODE,
   SEG03_CODE,
   year,
   period,
   businessdata)
  SELECT 'RET' AS CORP_CODE,
         ORG_NUM AS SHOP_CODE,
         'RET011累计数' AS ACCOUNT_CODE,
         DEPT AS BRANCH_CODE,
         DV AS SEG01_CODE,
         NULL AS SEG02_CODE,
         NULL AS SEG03_CODE,
         YEAR,
         PERIOD,
         COST AS BUSINESSDATA
    FROM (SELECT MAX(SUBSTR(A.MN_WID, 1, 4)) YEAR,
                 MAX(SUBSTR(A.MN_WID, 5, 2)) PERIOD,
                 SUM((NVL(A.SLS_AMT_LCL, 0) - NVL(A.RET_AMT_LCL, 0)) -
                     (NVL(A.SLS_TAX_AMT_LCL, 0) - NVL(A.RET_TAX_AMT_LCL, 0))) COST,
                 B.ORG_NUM,
                 D.PROD_DP_NUM DEPT,
                 D.PROD_DV_NUM DV
            FROM W_RTL_SLS_DP_LC_MN_A          A,
                 W_INT_ORG_D                   B,
                 RABATCHER.W_PRODUCT_D_RTL_TMP D
           WHERE A.ORG_WID = B.ROW_WID
             AND EXISTS
           (SELECT 1
                    FROM RADM.BBG_RA_RETAIL_TYPE_D R
                   WHERE A.BBG_RETAIL_TYPE_WID = R.ROW_WID
                     AND R.RETAIL_GROUP_ID = 5)
             AND A.PROD_DH_WID = D.PROD_DP_WID
             and A.MN_WID BETWEEN ls_year || '01' AND ls_year || ls_period
           GROUP BY B.ORG_NUM, D.PROD_DP_NUM, D.PROD_DV_NUM);

commit;

--2.出清销售------------------------------------------------------------------------------------------
--当期数
insert into bbg_ys_t_businessdata_retek
  (corp_code,
   shop_code,
   account_code,
   branch_code,
   SEG01_CODE,
   SEG02_CODE,
   SEG03_CODE,
   year,
   period,
   businessdata)
  SELECT 'RET' AS CORP_CODE,
         ORG_NUM AS SHOP_CODE,
         'RET012当期数' AS ACCOUNT_CODE,
         DEPT AS BRANCH_CODE,
         DV AS SEG01_CODE,
         NULL AS SEG02_CODE,
         NULL AS SEG03_CODE,
         YEAR,
         PERIOD,
         COST AS BUSINESSDATA
  
    FROM (SELECT SUBSTR(A.MN_WID, 1, 4) YEAR,
                 SUBSTR(A.MN_WID, 5, 2) PERIOD,
                 SUM((NVL(A.SLS_AMT_LCL, 0) - NVL(A.RET_AMT_LCL, 0)) -
                     (NVL(A.SLS_TAX_AMT_LCL, 0) - NVL(A.RET_TAX_AMT_LCL, 0)) ) COST,
                 B.ORG_NUM,
                 D.PROD_DP_NUM DEPT,
                 D.PROD_DV_NUM DV
            FROM W_RTL_SLS_DP_LC_MN_A          A,
                 W_INT_ORG_D                   B,
                 RABATCHER.W_PRODUCT_D_RTL_TMP D
           WHERE A.ORG_WID = B.ROW_WID
             AND EXISTS (SELECT 1
                    FROM RADM.BBG_RA_RETAIL_TYPE_D R
                   WHERE A.BBG_RETAIL_TYPE_WID = R.ROW_WID
                     AND R.RETAIL_TYPE_ID = 21)
             AND A.PROD_DH_WID = D.PROD_DP_WID
             and A.MN_WID = ls_year || ls_period
           GROUP BY SUBSTR(A.MN_WID, 1, 4),
                    SUBSTR(A.MN_WID, 5, 2),
                    B.ORG_NUM,
                    D.PROD_DP_NUM,
                    D.PROD_DV_NUM);
commit;
--累计数

insert into bbg_ys_t_businessdata_retek
  (corp_code,
   shop_code,
   account_code,
   branch_code,
   SEG01_CODE,
   SEG02_CODE,
   SEG03_CODE,
   year,
   period,
   businessdata)
  SELECT 'RET' AS CORP_CODE,
         ORG_NUM AS SHOP_CODE,
         'RET012累计数' AS ACCOUNT_CODE,
         DEPT AS BRANCH_CODE,
         DV AS SEG01_CODE,
         NULL AS SEG02_CODE,
         NULL AS SEG03_CODE,
         YEAR,
         PERIOD,
         COST AS BUSINESSDATA
  
    FROM (SELECT MAX(SUBSTR(A.MN_WID, 1, 4)) YEAR,
                 MAX(SUBSTR(A.MN_WID, 5, 2)) PERIOD,
                 SUM((NVL(A.SLS_AMT_LCL, 0) - NVL(A.RET_AMT_LCL, 0)) -
                     (NVL(A.SLS_TAX_AMT_LCL, 0) - NVL(A.RET_TAX_AMT_LCL, 0))) COST,
                 B.ORG_NUM,
                 D.PROD_DP_NUM DEPT,
                 D.PROD_DV_NUM DV
            FROM W_RTL_SLS_DP_LC_MN_A          A,
                 W_INT_ORG_D                   B,
                 RABATCHER.W_PRODUCT_D_RTL_TMP D
           WHERE A.ORG_WID = B.ROW_WID
             AND EXISTS
           (SELECT 1
                    FROM RADM.BBG_RA_RETAIL_TYPE_D R
                   WHERE A.BBG_RETAIL_TYPE_WID = R.ROW_WID
                     AND R.RETAIL_TYPE_ID = 21)
             AND A.PROD_DH_WID = D.PROD_DP_WID
             and A.MN_WID BETWEEN ls_year || '01' AND ls_year || ls_period
           GROUP BY B.ORG_NUM, D.PROD_DP_NUM, D.PROD_DV_NUM);
commit;

--3.大宗销售------------------------------------------------------------------------------------------   
--当期数

insert into bbg_ys_t_businessdata_retek
  (corp_code,
   shop_code,
   account_code,
   branch_code,
   SEG01_CODE,
   SEG02_CODE,
   SEG03_CODE,
   year,
   period,
   businessdata)
  SELECT 'RET' AS CORP_CODE,
         ORG_NUM AS SHOP_CODE,
         'RET013当期数' AS ACCOUNT_CODE,
         DEPT AS BRANCH_CODE,
         DV AS SEG01_CODE,
         NULL AS SEG02_CODE,
         NULL AS SEG03_CODE,
         YEAR,
         PERIOD,
         COST AS BUSINESSDATA
  
    FROM (SELECT SUBSTR(A.MN_WID, 1, 4) YEAR,
                 SUBSTR(A.MN_WID, 5, 2) PERIOD,
                 SUM((NVL(A.SLS_AMT_LCL, 0) - NVL(A.RET_AMT_LCL, 0)) -
                     (NVL(A.SLS_TAX_AMT_LCL, 0) - NVL(A.RET_TAX_AMT_LCL, 0))) COST,
                 B.ORG_NUM,
                 D.PROD_DP_NUM DEPT,
                 D.PROD_DV_NUM DV
            FROM W_RTL_SLS_DP_LC_MN_A          A,
                 W_INT_ORG_D                   B,
                 RABATCHER.W_PRODUCT_D_RTL_TMP D
           WHERE A.ORG_WID = B.ROW_WID
             AND EXISTS (SELECT 1
                    FROM RADM.BBG_RA_RETAIL_TYPE_D R
                   WHERE A.BBG_RETAIL_TYPE_WID = R.ROW_WID
                     AND R.RETAIL_GROUP_ID = 2)
             AND A.PROD_DH_WID = D.PROD_DP_WID
             and A.MN_WID = ls_year || ls_period
           GROUP BY SUBSTR(A.MN_WID, 1, 4),
                    SUBSTR(A.MN_WID, 5, 2),
                    B.ORG_NUM,
                    D.PROD_DP_NUM,
                    D.PROD_DV_NUM);
commit;
--累计数

insert into bbg_ys_t_businessdata_retek
  (corp_code,
   shop_code,
   account_code,
   branch_code,
   SEG01_CODE,
   SEG02_CODE,
   SEG03_CODE,
   year,
   period,
   businessdata)
  SELECT 'RET' AS CORP_CODE,
         ORG_NUM AS SHOP_CODE,
         'RET013累计数' AS ACCOUNT_CODE,
         DEPT AS BRANCH_CODE,
         DV AS SEG01_CODE,
         NULL AS SEG02_CODE,
         NULL AS SEG03_CODE,
         YEAR,
         PERIOD,
         COST AS BUSINESSDATA
  
    FROM (SELECT MAX(SUBSTR(A.MN_WID, 1, 4)) YEAR,
                 MAX(SUBSTR(A.MN_WID, 5, 2)) PERIOD,
                 SUM((NVL(A.SLS_AMT_LCL, 0) - NVL(A.RET_AMT_LCL, 0)) -
                     (NVL(A.SLS_TAX_AMT_LCL, 0) - NVL(A.RET_TAX_AMT_LCL, 0))) COST,
                 B.ORG_NUM,
                 D.PROD_DP_NUM DEPT,
                 D.PROD_DV_NUM DV
            FROM W_RTL_SLS_DP_LC_MN_A          A,
                 W_INT_ORG_D                   B,
                 RABATCHER.W_PRODUCT_D_RTL_TMP D
           WHERE A.ORG_WID = B.ROW_WID
             AND EXISTS
           (SELECT 1
                    FROM RADM.BBG_RA_RETAIL_TYPE_D R
                   WHERE A.BBG_RETAIL_TYPE_WID = R.ROW_WID
                     AND R.RETAIL_GROUP_ID = 2)
             AND A.PROD_DH_WID = D.PROD_DP_WID
             and A.MN_WID BETWEEN ls_year || '01' AND ls_year || ls_period
           GROUP BY B.ORG_NUM, D.PROD_DP_NUM, D.PROD_DV_NUM);

commit;

--4.正常销售------------------------------------------------------------------------------------------
insert into bbg_ys_t_businessdata_retek
  (corp_code,
   shop_code,
   account_code,
   branch_code,
   SEG01_CODE,
   SEG02_CODE,
   SEG03_CODE,
   year,
   period,
   businessdata)

  SELECT 'RET' AS CORP_CODE,
         ORG_NUM AS SHOP_CODE,
         'RET014当期数' AS ACCOUNT_CODE,
         DEPT AS BRANCH_CODE,
         DV AS SEG01_CODE,
         NULL AS SEG02_CODE,
         NULL AS SEG03_CODE,
         YEAR,
         PERIOD,
         COST AS BUSINESSDATA
    FROM (SELECT SUBSTR(A.MN_WID, 1, 4) YEAR,
                 SUBSTR(A.MN_WID, 5, 2) PERIOD,
                 SUM((NVL(A.SLS_AMT_LCL, 0) - NVL(A.RET_AMT_LCL, 0)) -
                     (NVL(A.SLS_TAX_AMT_LCL, 0) - NVL(A.RET_TAX_AMT_LCL, 0)) ) COST,
                 B.ORG_NUM,
                 D.PROD_DP_NUM DEPT,
                 D.PROD_DV_NUM DV
            FROM W_RTL_SLS_DP_LC_MN_A          A,
                 W_INT_ORG_D                   B,
                 RABATCHER.W_PRODUCT_D_RTL_TMP D
           WHERE A.ORG_WID = B.ROW_WID
             AND EXISTS (SELECT 1
                    FROM RADM.BBG_RA_RETAIL_TYPE_D R
                   WHERE A.BBG_RETAIL_TYPE_WID = R.ROW_WID
                     AND R.RETAIL_GROUP_ID = 1)
             AND A.PROD_DH_WID = D.PROD_DP_WID
             and A.MN_WID = ls_year || ls_period
           GROUP BY SUBSTR(A.MN_WID, 1, 4),
                    SUBSTR(A.MN_WID, 5, 2),
                    B.ORG_NUM,
                    D.PROD_DP_NUM,
                    D.PROD_DV_NUM);

commit;
--累计数
insert into bbg_ys_t_businessdata_retek
  (corp_code,
   shop_code,
   account_code,
   branch_code,
   SEG01_CODE,
   SEG02_CODE,
   SEG03_CODE,
   year,
   period,
   businessdata)

  SELECT 'RET' AS CORP_CODE,
         ORG_NUM AS SHOP_CODE,
         'RET014累计数' AS ACCOUNT_CODE,
         DEPT AS BRANCH_CODE,
         DV AS SEG01_CODE,
         NULL AS SEG02_CODE,
         NULL AS SEG03_CODE,
         YEAR,
         PERIOD,
         COST AS BUSINESSDATA
  
    FROM (SELECT MAX(SUBSTR(A.MN_WID, 1, 4)) YEAR,
                 MAX(SUBSTR(A.MN_WID, 5, 2)) PERIOD,
                 SUM((NVL(A.SLS_AMT_LCL, 0) - NVL(A.RET_AMT_LCL, 0)) -
                     (NVL(A.SLS_TAX_AMT_LCL, 0) - NVL(A.RET_TAX_AMT_LCL, 0)) ) COST,
                 B.ORG_NUM,
                 D.PROD_DP_NUM DEPT,
                 D.PROD_DV_NUM DV
            FROM W_RTL_SLS_DP_LC_MN_A          A,
                 W_INT_ORG_D                   B,
                 RABATCHER.W_PRODUCT_D_RTL_TMP D
           WHERE A.ORG_WID = B.ROW_WID
             AND EXISTS
           (SELECT 1
                    FROM RADM.BBG_RA_RETAIL_TYPE_D R
                   WHERE A.BBG_RETAIL_TYPE_WID = R.ROW_WID
                     AND R.RETAIL_GROUP_ID = 1)
             AND A.PROD_DH_WID = D.PROD_DP_WID
             and A.MN_WID BETWEEN ls_year || '01' AND ls_year || ls_period
           GROUP BY B.ORG_NUM, D.PROD_DP_NUM, D.PROD_DV_NUM);
