--BASE COST
SELECT 'ROW','W_RTL_BCOST_IT_LC_DY_F',COUNT(*) FROM W_RTL_BCOST_IT_LC_DY_F T WHERE T.FROM_DT_WID = 120130627000
 UNION ALL
SELECT 'ROW','W_RTL_BCOST_IT_LC_DY_FS',COUNT(*) FROM W_RTL_BCOST_IT_LC_DY_FS T
 UNION ALL
SELECT 'SUM','BASE_COST_AMT_LCL',SUM(T.BASE_COST_AMT_LCL) BASE_COST_AMT_LCL FROM W_RTL_BCOST_IT_LC_DY_FV T WHERE T.DT_WID = 120130627000
 UNION ALL
SELECT 'SUM','BASE_COST_AMT_LCL',SUM(T.BASE_COST_AMT_LCL) BASE_COST_AMT_LCL FROM W_RTL_BCOST_IT_LC_G T
 UNION ALL
SELECT 'SUM','BASE_COST_AMT_LCL',SUM(T.BASE_COST_AMT_LCL)
  FROM (SELECT T.PROD_WID,
               T.SUPPLIER_WID,
               SUM(T.BASE_COST_AMT_LCL) BASE_COST_AMT_LCL
          FROM W_RTL_BCOST_IT_DY_A T
         WHERE T.DT_WID = 120130627000
         GROUP BY T.PROD_WID, T.SUPPLIER_WID
         ORDER BY T.PROD_WID, T.SUPPLIER_WID) T
 UNION ALL
SELECT 'SUM','BASE_COST_AMT_LCL',SUM(T.BASE_COST_AMT_LCL)
  FROM (SELECT T.PROD_WID,
               T.SUPPLIER_WID,
               MAX(T.ORG_WID),
               ROUND(AVG(T.BASE_COST_AMT_LCL), 4) BASE_COST_AMT_LCL
          FROM W_RTL_BCOST_IT_LC_DY_FV T
         WHERE T.DT_WID = 120130627000
         GROUP BY T.PROD_WID, T.SUPPLIER_WID
         ORDER BY T.PROD_WID, T.SUPPLIER_WID) T
 UNION ALL
------------------------------------------------------------
--NCOST
SELECT 'ROW','W_RTL_NCOST_IT_LC_DY_F',COUNT(*) FROM W_RTL_NCOST_IT_LC_DY_F T WHERE T.FROM_DT_WID = 120130627000
 UNION ALL
SELECT 'ROW','W_RTL_NCOST_IT_LC_DY_FS',COUNT(*) FROM W_RTL_NCOST_IT_LC_DY_FS T;
-----------------------------------------------------------------------------------------------
SELECT 'SUM','W_RTL_NCOST_IT_LC_DY_FV',SUM(T.BASE_COST_AMT_LCL) BASE_COST_AMT_LCL,
       SUM(T.NET_COST_AMT_LCL) NET_COST_AMT_LCL,
       SUM(T.NET_NET_COST_AMT_LCL) NET_NET_COST_AMT_LCL,
       SUM(T.DEAD_NET_COST_AMT_LCL) DEAD_NET_COST_AMT_LCL
  FROM W_RTL_NCOST_IT_LC_DY_FV T
 WHERE T.DT_WID = 120130627000
 UNION ALL
SELECT 'SUM','W_RTL_NCOST_IT_LC_G',SUM(T.BASE_COST_AMT_LCL) BASE_COST_AMT_LCL,
       SUM(T.NET_COST_AMT_LCL) NET_COST_AMT_LCL,
       SUM(T.NET_NET_COST_AMT_LCL) NET_NET_COST_AMT_LCL,
       SUM(T.DEAD_NET_COST_AMT_LCL) DEAD_NET_COST_AMT_LCL
  FROM W_RTL_NCOST_IT_LC_G T
 UNION ALL 
  ---------------------------------------------
SELECT 'SUM','W_RTL_NCOST_IT_DY_A',SUM(T.BASE_COST_AMT_LCL),
       SUM(T.NET_COST_AMT_LCL),
       SUM(T.NET_NET_COST_AMT_LCL),
       SUM(T.DEAD_NET_COST_AMT_LCL)
  FROM (SELECT T.PROD_WID,
               T.SUPPLIER_WID,
               SUM(T.BASE_COST_AMT_LCL) BASE_COST_AMT_LCL,
               SUM(T.NET_COST_AMT_LCL) NET_COST_AMT_LCL,
               SUM(T.NET_NET_COST_AMT_LCL) NET_NET_COST_AMT_LCL,
               SUM(T.DEAD_NET_COST_AMT_LCL) DEAD_NET_COST_AMT_LCL
          FROM W_RTL_NCOST_IT_DY_A T
         WHERE T.DT_WID = 120130627000
         GROUP BY T.PROD_WID, T.SUPPLIER_WID
         ORDER BY T.PROD_WID, T.SUPPLIER_WID) T
 UNION ALL
 ------------------------------------------
SELECT 'SUM','W_RTL_NCOST_IT_LC_DY_FV',SUM(T.BASE_COST_AMT_LCL),
       SUM(T.NET_COST_AMT_LCL),
       SUM(T.NET_NET_COST_AMT_LCL),
       SUM(T.DEAD_NET_COST_AMT_LCL)
  FROM (SELECT T.PROD_WID,
               T.SUPPLIER_WID,
               MAX(T.ORG_WID),
               ROUND(AVG(T.BASE_COST_AMT_LCL), 4) BASE_COST_AMT_LCL,
               ROUND(AVG(T.NET_COST_AMT_LCL), 4) NET_COST_AMT_LCL,
               ROUND(AVG(T.NET_NET_COST_AMT_LCL), 4) NET_NET_COST_AMT_LCL,
               ROUND(AVG(T.DEAD_NET_COST_AMT_LCL), 4) DEAD_NET_COST_AMT_LCL
          FROM W_RTL_NCOST_IT_LC_DY_FV T
         WHERE T.DT_WID = 120130627000
         GROUP BY T.PROD_WID, T.SUPPLIER_WID
         ORDER BY T.PROD_WID, T.SUPPLIER_WID) T;
         ------------------------------------------------------
--PRICE
SELECT 'ROW','W_RTL_PRICE_IT_LC_DY_F',COUNT(*) FROM W_RTL_PRICE_IT_LC_DY_F T WHERE T.FROM_DT_WID = 120130627000
 UNION ALL
SELECT 'ROW','W_RTL_PRICE_IT_LC_DY_FS',COUNT(*) FROM W_RTL_PRICE_IT_LC_DY_FS T;
------------------------------------------------------------------------------------
SELECT 'SUM','W_RTL_PRICE_IT_LC_DY_FV',SUM(T.BASE_COST_AMT_LCL) COST_AMT,
       SUM(T.STANDARD_UNIT_RTL_AMT_LCL) STANDARD_UNIT_RTL_AMT_LCL,
       SUM(T.SELLING_UNIT_RTL_AMT_LCL) SELLING_UNIT_RTL_AMT_LCL
  FROM W_RTL_PRICE_IT_LC_DY_FV T
 WHERE T.DT_WID = 120130627000
 UNION ALL
SELECT 'SUM','W_RTL_PRICE_IT_LC_G',SUM(T.BASE_COST_AMT_LCL) COST_AMT,
       SUM(T.STANDARD_UNIT_RTL_AMT_LCL) STANDARD_UNIT_RTL_AMT_LCL,
       SUM(T.SELLING_UNIT_RTL_AMT_LCL) SELLING_UNIT_RTL_AMT_LCL
  FROM W_RTL_PRICE_IT_LC_G T
 UNION ALL
SELECT 'SUM','W_RTL_PRICE_IT_DY_A',SUM(T.BASE_COST_AMT_LCL) COST_AMT,
       SUM(T.STANDARD_UNIT_RTL_AMT_LCL) STANDARD_UNIT_RTL_AMT_LCL,
       SUM(T.SELLING_UNIT_RTL_AMT_LCL) SELLING_UNIT_RTL_AMT_LCL
  FROM W_RTL_PRICE_IT_DY_A T
 WHERE T.DT_WID = 120130627000
 UNION ALL
SELECT 'SUM','W_RTL_PRICE_IT_LC_G',SUM(COST_AMT),
       SUM(STANDARD_UNIT_RTL_AMT_LCL),
       SUM(SELLING_UNIT_RTL_AMT_LCL)
  FROM (SELECT T.PROD_WID,
               ROUND(AVG(T.BASE_COST_AMT_LCL), 4) COST_AMT,
               ROUND(AVG(T.STANDARD_UNIT_RTL_AMT_LCL), 4) STANDARD_UNIT_RTL_AMT_LCL,
               ROUND(AVG(T.SELLING_UNIT_RTL_AMT_LCL), 4) SELLING_UNIT_RTL_AMT_LCL
          FROM W_RTL_PRICE_IT_LC_G T
         GROUP BY T.PROD_WID
         ORDER BY T.PROD_WID) X;
--INV                                                                                                                       
SELECT 'ROW','W_RTL_INV_IT_LC_DY_F',COUNT(*) FROM W_RTL_INV_IT_LC_DY_F T WHERE T.FROM_DT_WID = 120130627000
 UNION ALL
SELECT 'ROW','W_RTL_INV_IT_LC_DY_FS',COUNT(*) FROM W_RTL_INV_IT_LC_DY_FS T;
----------------------------------------------------------------------
SELECT 'SUM','W_RTL_INV_IT_LC_DY_FV',SUM(T.INV_SOH_QTY) INV_SOH_QTY, SUM(T.INV_SOH_COST_AMT_LCL),NULL COST_AMT
  FROM W_RTL_INV_IT_LC_DY_FV T
 WHERE T.DT_WID = 120130627000
 UNION ALL
SELECT 'SUM','W_RTL_INV_IT_LC_G',SUM(T.INV_SOH_QTY) INV_SOH_QTY, SUM(T.INV_SOH_COST_AMT_LCL),NULL COST_AMT
  FROM W_RTL_INV_IT_LC_G T
 UNION ALL
SELECT 'SUM','W_RTL_INV_CL_LC_DY_A',SUM(T.INV_SOH_QTY),
       SUM(T.INV_SOH_RTL_AMT_LCL),
       SUM(T.INV_IN_TRAN_RTL_AMT_LCL)
  FROM W_RTL_INV_CL_LC_DY_A T
 WHERE T.DT_WID = 120130627000
 UNION ALL 
SELECT 'SUM','W_RTL_INV_IT_LC_G',SUM(QTY), SUM(AMT), SUM(AMT1)
  FROM (SELECT T.PROD_SC_WID,
               T.ORG_DH_WID,
               SUM(T.INV_SOH_QTY) QTY,
               SUM(T.INV_SOH_RTL_AMT_LCL) AMT,
               SUM(T.INV_IN_TRAN_RTL_AMT_LCL) AMT1
          FROM W_RTL_INV_IT_LC_G T
         GROUP BY T.PROD_SC_WID, T.ORG_DH_WID)
 UNION ALL
SELECT 'SUM','W_RTL_INV_DP_LC_DY_A',SUM(T.INV_SOH_QTY),
       SUM(T.INV_SOH_RTL_AMT_LCL),
       SUM(T.INV_IN_TRAN_RTL_AMT_LCL)
  FROM W_RTL_INV_DP_LC_DY_A T
 WHERE T.DT_WID = 120130627000
 UNION ALL
SELECT 'SUM','W_RTL_INV_IT_LC_G',SUM(QTY), SUM(AMT), SUM(AMT1)
  FROM (SELECT T.PROD_SC_WID,
               T.ORG_DH_WID,
               SUM(T.INV_SOH_QTY) QTY,
               SUM(T.INV_SOH_RTL_AMT_LCL) AMT,
               SUM(T.INV_IN_TRAN_RTL_AMT_LCL) AMT1
          FROM W_RTL_INV_IT_LC_G T
         GROUP BY T.PROD_SC_WID, T.ORG_DH_WID)
 UNION ALL
SELECT 'SUM','W_RTL_INV_SC_LC_DY_A',SUM(T.INV_SOH_QTY),
       SUM(T.INV_SOH_RTL_AMT_LCL),
       SUM(T.INV_IN_TRAN_RTL_AMT_LCL)
  FROM W_RTL_INV_SC_LC_DY_A T
 WHERE T.DT_WID = 120130627000
 UNION ALL
SELECT 'SUM','W_RTL_INV_IT_LC_G',SUM(QTY), SUM(AMT), SUM(AMT1)
  FROM (SELECT T.PROD_SC_WID,
               T.ORG_DH_WID,
               SUM(T.INV_SOH_QTY) QTY,
               SUM(T.INV_SOH_RTL_AMT_LCL) AMT,
               SUM(T.INV_IN_TRAN_RTL_AMT_LCL) AMT1
          FROM W_RTL_INV_IT_LC_G T
         GROUP BY T.PROD_SC_WID, T.ORG_DH_WID)
 UNION ALL
SELECT 'SUM','W_RTL_INV_IT_DY_A',SUM(T.INV_SOH_QTY),
       SUM(T.INV_SOH_RTL_AMT_LCL),
       SUM(T.INV_IN_TRAN_RTL_AMT_LCL)
  FROM W_RTL_INV_IT_DY_A T
 WHERE T.DT_WID = 120130627000
 UNION ALL
SELECT 'SUM','W_RTL_INV_IT_LC_G',SUM(T.INV_SOH_QTY) QTY,
       SUM(T.INV_SOH_RTL_AMT_LCL) AMT,
       SUM(T.INV_IN_TRAN_RTL_AMT_LCL) AMT1
  FROM W_RTL_INV_IT_LC_G T
  UNION ALL
SELECT 'SUM','W_RTL_INV_SC_DY_CUR_A',SUM(T.INV_SOH_QTY),
       SUM(T.INV_SOH_RTL_AMT_LCL),
       SUM(T.INV_IN_TRAN_RTL_AMT_LCL)
  FROM W_RTL_INV_SC_DY_CUR_A T
 WHERE T.DT_WID = 120130627000
 UNION ALL
SELECT 'SUM','W_RTL_INV_IT_LC_G',SUM(QTY), SUM(AMT), SUM(AMT1)
  FROM (SELECT SUM(T.INV_SOH_QTY) QTY,
               SUM(T.INV_SOH_RTL_AMT_LCL) AMT,
               SUM(T.INV_IN_TRAN_RTL_AMT_LCL) AMT1
          FROM W_RTL_INV_IT_LC_G T)
 UNION ALL 
SELECT 'SUM','W_RTL_INV_SC_DY_A',SUM(T.INV_SOH_QTY),
       SUM(T.INV_SOH_RTL_AMT_LCL),
       SUM(T.INV_IN_TRAN_RTL_AMT_LCL)
  FROM W_RTL_INV_SC_DY_A T
 WHERE T.DT_WID = 120130627000
 UNION ALL
SELECT 'SUM','W_RTL_INV_IT_LC_G',SUM(QTY), SUM(AMT), SUM(AMT1)
  FROM (SELECT SUM(T.INV_SOH_QTY) QTY,
               SUM(T.INV_SOH_RTL_AMT_LCL) AMT,
               SUM(T.INV_IN_TRAN_RTL_AMT_LCL) AMT1
          FROM W_RTL_INV_IT_LC_G T);
