 SELECT /*+parallel(T 20)*/  TO_DATE (TO_CHAR (SYSDATE - 1, 'YYYY-MM-DD'), 'YYYY-MM-DD'),
          'W_RTL_PRICE_IT_LC_DY_FV',
          SUM (T.BASE_COST_AMT_LCL) COST_AMT,
          SUM (T.STANDARD_UNIT_RTL_AMT_LCL) STANDARD_UNIT_RTL_AMT_LCL,
          SUM (T.SELLING_UNIT_RTL_AMT_LCL) SELLING_UNIT_RTL_AMT_LCL,
          'SUM',
          SYSDATE,
          18
     FROM W_RTL_PRICE_IT_LC_DY_FV T
    WHERE T.DT_WID = '1' || TO_CHAR (SYSDATE - 1, 'YYYYMMDD') || '000'
   UNION ALL
   SELECT /*+parallel(T 20)*/  TO_DATE (TO_CHAR (SYSDATE - 1, 'YYYY-MM-DD'), 'YYYY-MM-DD'),
          'W_RTL_PRICE_IT_LC_G',
          SUM (T.BASE_COST_AMT_LCL) COST_AMT,
          SUM (T.STANDARD_UNIT_RTL_AMT_LCL) STANDARD_UNIT_RTL_AMT_LCL,
          SUM (T.SELLING_UNIT_RTL_AMT_LCL) SELLING_UNIT_RTL_AMT_LCL,
          'SUM',
          SYSDATE,
          19
     FROM W_RTL_PRICE_IT_LC_G T
   UNION ALL
   SELECT TO_DATE (TO_CHAR (SYSDATE - 1, 'YYYY-MM-DD'), 'YYYY-MM-DD'),
          'W_RTL_PRICE_IT_DY_A',
          SUM (T.BASE_COST_AMT_LCL) COST_AMT,
          SUM (T.STANDARD_UNIT_RTL_AMT_LCL) STANDARD_UNIT_RTL_AMT_LCL,
          SUM (T.SELLING_UNIT_RTL_AMT_LCL) SELLING_UNIT_RTL_AMT_LCL,
          'SUM',
          SYSDATE,
          20
     FROM W_RTL_PRICE_IT_DY_A T
    WHERE T.DT_WID = '1' || TO_CHAR (SYSDATE - 1, 'YYYYMMDD') || '000'
   UNION ALL
   SELECT /*+parallel(X 20)*/  TO_DATE (TO_CHAR (SYSDATE - 1, 'YYYY-MM-DD'), 'YYYY-MM-DD'),
          'W_RTL_PRICE_IT_LC_G',
          SUM (COST_AMT),
          SUM (STANDARD_UNIT_RTL_AMT_LCL),
          SUM (SELLING_UNIT_RTL_AMT_LCL),
          'SUM',
          SYSDATE,
          21
     FROM (  SELECT T.PROD_WID,
                    ROUND (AVG (T.BASE_COST_AMT_LCL), 4) COST_AMT,
                    ROUND (AVG (T.STANDARD_UNIT_RTL_AMT_LCL), 4)
                       STANDARD_UNIT_RTL_AMT_LCL,
                    ROUND (AVG (T.SELLING_UNIT_RTL_AMT_LCL), 4)
                       SELLING_UNIT_RTL_AMT_LCL
               FROM W_RTL_PRICE_IT_LC_G T
           GROUP BY T.PROD_WID
           ORDER BY T.PROD_WID) X
   UNION ALL
   SELECT /*+parallel(T 20)*/  TO_DATE (TO_CHAR (SYSDATE - 1, 'YYYY-MM-DD'), 'YYYY-MM-DD'),
          'W_RTL_INV_IT_LC_DY_FV',
          SUM (T.INV_SOH_QTY) INV_SOH_QTY,
          SUM (T.INV_SOH_COST_AMT_LCL),
          NULL COST_AMT,
          'SUM',
          SYSDATE,
          22
     FROM W_RTL_INV_IT_LC_DY_FV T
    WHERE T.DT_WID = '1' || TO_CHAR (SYSDATE - 1, 'YYYYMMDD') || '000'
   UNION ALL
   SELECT /*+parallel(T 20)*/  TO_DATE (TO_CHAR (SYSDATE - 1, 'YYYY-MM-DD'), 'YYYY-MM-DD'),
          'W_RTL_INV_IT_LC_G',
          SUM (T.INV_SOH_QTY) INV_SOH_QTY,
          SUM (T.INV_SOH_COST_AMT_LCL),
          NULL COST_AMT,
          'SUM',
          SYSDATE,
          23
     FROM W_RTL_INV_IT_LC_G T
   UNION ALL
   SELECT /*+parallel(T 20)*/  TO_DATE (TO_CHAR (SYSDATE - 1, 'YYYY-MM-DD'), 'YYYY-MM-DD'),
          'W_RTL_INV_CL_LC_DY_A',
          SUM (T.INV_SOH_QTY),
          SUM (T.INV_SOH_RTL_AMT_LCL),
          SUM (T.INV_IN_TRAN_RTL_AMT_LCL),
          'SUM',
          SYSDATE,
          24
     FROM W_RTL_INV_CL_LC_DY_A T
    WHERE T.DT_WID = '1' || TO_CHAR (SYSDATE - 1, 'YYYYMMDD') || '000'
   UNION ALL
   SELECT /*+parallel(T 20)*/  TO_DATE (TO_CHAR (SYSDATE - 1, 'YYYY-MM-DD'), 'YYYY-MM-DD'),
          'W_RTL_INV_IT_LC_G',
          SUM (QTY),
          SUM (AMT),
          SUM (AMT1),
          'SUM',
          SYSDATE,
          25
     FROM (  SELECT /*+parallel(T 20)*/  T.PROD_SC_WID,
                    T.ORG_DH_WID,
                    SUM (T.INV_SOH_QTY) QTY,
                    SUM (T.INV_SOH_RTL_AMT_LCL) AMT,
                    SUM (T.INV_IN_TRAN_RTL_AMT_LCL) AMT1
               FROM W_RTL_INV_IT_LC_G T
           GROUP BY T.PROD_SC_WID, T.ORG_DH_WID) T
   UNION ALL
   SELECT /*+parallel(T 20)*/  TO_DATE (TO_CHAR (SYSDATE - 1, 'YYYY-MM-DD'), 'YYYY-MM-DD'),
          'W_RTL_INV_DP_LC_DY_A',
          SUM (T.INV_SOH_QTY),
          SUM (T.INV_SOH_RTL_AMT_LCL),
          SUM (T.INV_IN_TRAN_RTL_AMT_LCL),
          'SUM',
          SYSDATE,
          26
     FROM W_RTL_INV_DP_LC_DY_A T
    WHERE T.DT_WID = '1' || TO_CHAR (SYSDATE - 1, 'YYYYMMDD') || '000'
   UNION ALL
   SELECT /*+parallel(T 20)*/  TO_DATE (TO_CHAR (SYSDATE - 1, 'YYYY-MM-DD'), 'YYYY-MM-DD'),
          'W_RTL_INV_IT_LC_G',
          SUM (QTY),
          SUM (AMT),
          SUM (AMT1),
          'SUM',
          SYSDATE,
          27
     FROM (  SELECT /*+parallel(T 20)*/  T.PROD_SC_WID,
                    T.ORG_DH_WID,
                    SUM (T.INV_SOH_QTY) QTY,
                    SUM (T.INV_SOH_RTL_AMT_LCL) AMT,
                    SUM (T.INV_IN_TRAN_RTL_AMT_LCL) AMT1
               FROM W_RTL_INV_IT_LC_G T
           GROUP BY T.PROD_SC_WID, T.ORG_DH_WID) T
   UNION ALL
   SELECT /*+parallel(T 20)*/  TO_DATE (TO_CHAR (SYSDATE - 1, 'YYYY-MM-DD'), 'YYYY-MM-DD'),
          'W_RTL_INV_SC_LC_DY_A',
          SUM (T.INV_SOH_QTY),
          SUM (T.INV_SOH_RTL_AMT_LCL),
          SUM (T.INV_IN_TRAN_RTL_AMT_LCL),
          'SUM',
          SYSDATE,
          28
     FROM W_RTL_INV_SC_LC_DY_A T
    WHERE T.DT_WID = '1' || TO_CHAR (SYSDATE - 1, 'YYYYMMDD') || '000'
   UNION ALL
   SELECT /*+parallel(T 20)*/  TO_DATE (TO_CHAR (SYSDATE - 1, 'YYYY-MM-DD'), 'YYYY-MM-DD'),
          'W_RTL_INV_IT_LC_G',
          SUM (QTY),
          SUM (AMT),
          SUM (AMT1),
          'SUM',
          SYSDATE,
          29
     FROM (  SELECT /*+parallel(T 20)*/  T.PROD_SC_WID,
                    T.ORG_DH_WID,
                    SUM (T.INV_SOH_QTY) QTY,
                    SUM (T.INV_SOH_RTL_AMT_LCL) AMT,
                    SUM (T.INV_IN_TRAN_RTL_AMT_LCL) AMT1
               FROM W_RTL_INV_IT_LC_G T 
           GROUP BY T.PROD_SC_WID, T.ORG_DH_WID) T
   UNION ALL
   SELECT /*+parallel(T 20)*/  TO_DATE (TO_CHAR (SYSDATE - 1, 'YYYY-MM-DD'), 'YYYY-MM-DD'),
          'W_RTL_INV_IT_DY_A',
          SUM (T.INV_SOH_QTY),
          SUM (T.INV_SOH_RTL_AMT_LCL),
          SUM (T.INV_IN_TRAN_RTL_AMT_LCL),
          'SUM',
          SYSDATE,
          30
     FROM W_RTL_INV_IT_DY_A T
    WHERE T.DT_WID = '1' || TO_CHAR (SYSDATE - 1, 'YYYYMMDD') || '000'
   UNION ALL
   SELECT /*+parallel(T 20)*/  TO_DATE (TO_CHAR (SYSDATE - 1, 'YYYY-MM-DD'), 'YYYY-MM-DD'),
          'W_RTL_INV_IT_LC_G',
          SUM (T.INV_SOH_QTY) QTY,
          SUM (T.INV_SOH_RTL_AMT_LCL) AMT,
          SUM (T.INV_IN_TRAN_RTL_AMT_LCL) AMT1,
          'SUM',
          SYSDATE,
          31
     FROM W_RTL_INV_IT_LC_G T
   UNION ALL
   SELECT /*+parallel(T 20)*/  TO_DATE (TO_CHAR (SYSDATE - 1, 'YYYY-MM-DD'), 'YYYY-MM-DD'),
          'W_RTL_INV_SC_DY_CUR_A',
          SUM (T.INV_SOH_QTY),
          SUM (T.INV_SOH_RTL_AMT_LCL),
          SUM (T.INV_IN_TRAN_RTL_AMT_LCL),
          'SUM',
          SYSDATE,
          32
     FROM W_RTL_INV_SC_DY_CUR_A T
    WHERE T.DT_WID = '1' || TO_CHAR (SYSDATE - 1, 'YYYYMMDD') || '000'
   UNION ALL
   SELECT /*+parallel(T 20)*/  TO_DATE (TO_CHAR (SYSDATE - 1, 'YYYY-MM-DD'), 'YYYY-MM-DD'),
          'W_RTL_INV_IT_LC_G',
          SUM (QTY),
          SUM (AMT),
          SUM (AMT1),
          'SUM',
          SYSDATE,
          33
     FROM (SELECT /*+parallel(T 20)*/   SUM (T.INV_SOH_QTY) QTY,
                  SUM (T.INV_SOH_RTL_AMT_LCL) AMT,
                  SUM (T.INV_IN_TRAN_RTL_AMT_LCL) AMT1
             FROM W_RTL_INV_IT_LC_G T) T
   UNION ALL
   SELECT /*+parallel(T 20)*/  TO_DATE (TO_CHAR (SYSDATE - 1, 'YYYY-MM-DD'), 'YYYY-MM-DD'),
          'W_RTL_INV_SC_DY_A',
          SUM (T.INV_SOH_QTY),
          SUM (T.INV_SOH_RTL_AMT_LCL),
          SUM (T.INV_IN_TRAN_RTL_AMT_LCL),
          'SUM',
          SYSDATE,
          34
     FROM W_RTL_INV_SC_DY_A T
    WHERE T.DT_WID = '1' || TO_CHAR (SYSDATE - 1, 'YYYYMMDD') || '000'
   UNION ALL
   SELECT /*+parallel(T 20)*/  TO_DATE (TO_CHAR (SYSDATE - 1, 'YYYY-MM-DD'), 'YYYY-MM-DD'),
          'W_RTL_INV_IT_LC_G',
          SUM (QTY),
          SUM (AMT),
          SUM (AMT1),
          'SUM',
          SYSDATE,
          35
     FROM (SELECT /*+parallel(T 20)*/  SUM (T.INV_SOH_QTY) QTY,
                  SUM (T.INV_SOH_RTL_AMT_LCL) AMT,
                  SUM (T.INV_IN_TRAN_RTL_AMT_LCL) AMT1
             FROM W_RTL_INV_IT_LC_G T) T