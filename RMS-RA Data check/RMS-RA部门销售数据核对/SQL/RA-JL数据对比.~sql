select T.DAY_DT,
       SUBSTR(P.PROD_CAT5,
              INSTR(P.PROD_CAT5, '~', 1, 2) + 1,
              INSTR(P.PROD_CAT5, '~', 1, 3) -
              (INSTR(P.PROD_CAT5, '~', 1, 2) + 1)) DEPT,
       SUM(T.SLS_QTY - T.RET_QTY) QTY,
       SUM((T.SLS_AMT_LCL - T.SLS_TAX_AMT_LCL) -
           (T.RET_AMT_LCL - T.RET_TAX_AMT_LCL)) NOTAX_AMT,
       SUM(((T.SLS_AMT_LCL - T.SLS_TAX_AMT_LCL) -
           (T.RET_AMT_LCL - T.RET_TAX_AMT_LCL)) -
           (T.SLS_PROFIT_AMT_LCL - T.RET_PROFIT_AMT_LCL)) COST
  from (SELECT SLS_TRX_ID,
               PROD_IT_NUM,
               ORG_NUM,
               DAY_DT,
               VOUCHER_ID,
               RTL_TYPE_CODE,
               MIN_NUM,
               SLS_QTY,
               SLS_AMT_LCL,
               SLS_PROFIT_AMT_LCL,
               SLS_TAX_AMT_LCL,
               SLS_EMP_DISC_AMT_LCL,
               SLS_MANUAL_COUNT,
               SLS_SCAN_COUNT,
               -RET_QTY RET_QTY,
               -RET_AMT_LCL RET_AMT_LCL,
               -RET_PROFIT_AMT_LCL RET_PROFIT_AMT_LCL,
               -RET_TAX_AMT_LCL RET_TAX_AMT_LCL,
               -RET_EMP_DISC_AMT_LCL RET_EMP_DISC_AMT_LCL,
               -RET_MANUAL_COUNT RET_MANUAL_COUNT,
               -RET_SCAN_COUNT RET_SCAN_COUNT,
               SLS_MANUAL_MKDN_AMT_LCL,
               SLS_MANUAL_MKUP_AMT_LCL,
               -RET_MANUAL_MKDN_AMT_LCL RET_MANUAL_MKDN_AMT_LCL,
               -RET_MANUAL_MKUP_AMT_LCL RET_MANUAL_MKUP_AMT_LCL,
               BBG_RETAIL_TYPE_IDN
          FROM BBG_RA_SLS_TRX_JL_V@RA_JL
         WHERE DAY_DT = &DAY_DT) T,
       (SELECT DISTINCT A.PROD_NUM, A.PROD_CAT5
          FROM BBG_RA_PRODUCT_JL_V@RA_JL A) P
 WHERE T.PROD_IT_NUM = P.PROD_NUM
 GROUP BY T.DAY_DT,
          SUBSTR(P.PROD_CAT5,
                 INSTR(P.PROD_CAT5, '~', 1, 2) + 1,
                 INSTR(P.PROD_CAT5, '~', 1, 3) -
                 (INSTR(P.PROD_CAT5, '~', 1, 2) + 1))
 ORDER BY T.DAY_DT,
          SUBSTR(P.PROD_CAT5,
                 INSTR(P.PROD_CAT5, '~', 1, 2) + 1,
                 INSTR(P.PROD_CAT5, '~', 1, 3) -
                 (INSTR(P.PROD_CAT5, '~', 1, 2) + 1));
