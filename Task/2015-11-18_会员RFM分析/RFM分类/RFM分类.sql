--R
SELECT A.DAYS R, COUNT(1) CNT
  FROM (SELECT T.HYK_NO, TRUNC(&DAYS) - T.VIP_RECENCY_DATE DAYS
          FROM (SELECT /*+PARALLEL(16)*/
                 A.HYK_NO,
                 TO_CHAR(&DAYS, 'YYYYMM') MN_WID,
                 MAX(A.DATASOURCE_NUM_ID) DATASOURCE_NUM_ID,
                 MAX(A.ETL_THREAD_VAL) ETL_THREAD_VAL,
                 A.HYK_NO || '~' || TO_CHAR(&DAYS, 'YYYYMM') INTEGRATION_ID,
                 MAX(TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD')) VIP_RECENCY_DATE,
                 COUNT(CASE
                         WHEN TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') BETWEEN
                              TRUNC(&DAYS, 'MM') AND LAST_DAY(TRUNC(&DAYS)) THEN
                          1
                         ELSE
                          NULL
                       END) VIP_MONTH_FREQ,
                 SUM(CASE
                       WHEN TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') BETWEEN
                            TRUNC(&DAYS, 'MM') AND LAST_DAY(TRUNC(&DAYS)) THEN
                        A.SLS_QTY
                       ELSE
                        NULL
                     END) VIP_MONTH_SLS_QTY,
                 SUM(CASE
                       WHEN TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') BETWEEN
                            TRUNC(&DAYS, 'MM') AND LAST_DAY(TRUNC(&DAYS)) THEN
                        A.SLS_AMT_LCL
                       ELSE
                        NULL
                     END) VIP_MONTH_SLS_AMT_LCL,
                 SUM(CASE
                       WHEN TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') BETWEEN
                            TRUNC(&DAYS, 'MM') AND LAST_DAY(TRUNC(&DAYS)) THEN
                        A.SLS_PROFIT_AMT_LCL
                       ELSE
                        NULL
                     END) VIP_MONTH_SLS_PROFIT_AMT_LCL,
                 SUM(CASE
                       WHEN TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') BETWEEN
                            TRUNC(&DAYS, 'MM') AND LAST_DAY(TRUNC(&DAYS)) THEN
                        A.SLS_TAX_AMT_LCL
                       ELSE
                        NULL
                     END) VIP_MONTH_SLS_TAX_AMT_LCL,
                 SUM(CASE
                       WHEN TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') BETWEEN
                            TRUNC(&DAYS, 'MM') AND LAST_DAY(TRUNC(&DAYS)) THEN
                        A.RET_QTY
                       ELSE
                        NULL
                     END) VIP_MONTH_RET_QTY,
                 SUM(CASE
                       WHEN TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') BETWEEN
                            TRUNC(&DAYS, 'MM') AND LAST_DAY(TRUNC(&DAYS)) THEN
                        A.RET_AMT_LCL
                       ELSE
                        NULL
                     END) VIP_MONTH_RET_AMT_LCL,
                 SUM(CASE
                       WHEN TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') BETWEEN
                            TRUNC(&DAYS, 'MM') AND LAST_DAY(TRUNC(&DAYS)) THEN
                        A.RET_PROFIT_AMT_LCL
                       ELSE
                        NULL
                     END) VIP_MONTH_RET_PROFIT_AMT_LCL,
                 SUM(CASE
                       WHEN TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') BETWEEN
                            TRUNC(&DAYS, 'MM') AND LAST_DAY(TRUNC(&DAYS)) THEN
                        A.RET_TAX_AMT_LCL
                       ELSE
                        NULL
                     END) VIP_MONTH_RET_TAX_AMT_LCL,
                 ----------------------------------------------------------------------
                 COUNT(CASE
                         WHEN TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') BETWEEN
                              TRUNC(&DAYS, 'YY') AND
                              ADD_MONTHS(TRUNC(&DAYS, 'yyyy'), 12) - 1 THEN
                          1
                         ELSE
                          NULL
                       END) VIP_YEAR_FREQ,
                 SUM(CASE
                       WHEN TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') BETWEEN
                            TRUNC(&DAYS, 'YY') AND
                            ADD_MONTHS(TRUNC(&DAYS, 'yyyy'), 12) - 1 THEN
                        A.SLS_QTY
                       ELSE
                        NULL
                     END) VIP_YEAR_SLS_QTY,
                 SUM(CASE
                       WHEN TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') BETWEEN
                            TRUNC(&DAYS, 'YY') AND
                            ADD_MONTHS(TRUNC(&DAYS, 'yyyy'), 12) - 1 THEN
                        A.SLS_AMT_LCL
                       ELSE
                        NULL
                     END) VIP_YEAR_SLS_AMT_LCL,
                 SUM(CASE
                       WHEN TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') BETWEEN
                            TRUNC(&DAYS, 'YY') AND
                            ADD_MONTHS(TRUNC(&DAYS, 'yyyy'), 12) - 1 THEN
                        A.SLS_PROFIT_AMT_LCL
                       ELSE
                        NULL
                     END) VIP_YEAR_SLS_PROFIT_AMT_LCL,
                 SUM(CASE
                       WHEN TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') BETWEEN
                            TRUNC(&DAYS, 'YY') AND
                            ADD_MONTHS(TRUNC(&DAYS, 'yyyy'), 12) - 1 THEN
                        A.SLS_TAX_AMT_LCL
                       ELSE
                        NULL
                     END) VIP_YEAR_SLS_TAX_AMT_LCL,
                 SUM(CASE
                       WHEN TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') BETWEEN
                            TRUNC(&DAYS, 'YY') AND
                            ADD_MONTHS(TRUNC(&DAYS, 'yyyy'), 12) - 1 THEN
                        A.RET_QTY
                       ELSE
                        NULL
                     END) VIP_YEAR_RET_QTY,
                 SUM(CASE
                       WHEN TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') BETWEEN
                            TRUNC(&DAYS, 'YY') AND
                            ADD_MONTHS(TRUNC(&DAYS, 'yyyy'), 12) - 1 THEN
                        A.RET_AMT_LCL
                       ELSE
                        NULL
                     END) VIP_YEAR_RET_AMT_LCL,
                 SUM(CASE
                       WHEN TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') BETWEEN
                            TRUNC(&DAYS, 'YY') AND
                            ADD_MONTHS(TRUNC(&DAYS, 'yyyy'), 12) - 1 THEN
                        A.RET_PROFIT_AMT_LCL
                       ELSE
                        NULL
                     END) VIP_YEAR_RET_PROFIT_AMT_LCL,
                 SUM(CASE
                       WHEN TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') BETWEEN
                            TRUNC(&DAYS, 'YY') AND
                            ADD_MONTHS(TRUNC(&DAYS, 'yyyy'), 12) - 1 THEN
                        A.RET_TAX_AMT_LCL
                       ELSE
                        NULL
                     END) VIP_YEAR_RET_TAX_AMT_LCL
                  FROM RADM.BBG_RA_RFM_VIP_F A
                 WHERE A.DT_WID <= &DT_WID
                 GROUP BY A.HYK_NO) T) A
 WHERE A.DAYS <= 300
 GROUP BY A.DAYS
 ORDER BY A.DAYS;

--F
SELECT A.FREQ F, COUNT(1) CNT
  FROM (SELECT T.HYK_NO, T.VIP_MONTH_FREQ FREQ
          FROM (SELECT /*+PARALLEL(16)*/
                 A.HYK_NO,
                 TO_CHAR(&DAYS, 'YYYYMM') MN_WID,
                 MAX(A.DATASOURCE_NUM_ID) DATASOURCE_NUM_ID,
                 MAX(A.ETL_THREAD_VAL) ETL_THREAD_VAL,
                 A.HYK_NO || '~' || TO_CHAR(&DAYS, 'YYYYMM') INTEGRATION_ID,
                 MAX(TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD')) VIP_RECENCY_DATE,
                 COUNT(CASE
                         WHEN TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') BETWEEN
                              TRUNC(&DAYS, 'MM') AND LAST_DAY(TRUNC(&DAYS)) THEN
                          1
                         ELSE
                          NULL
                       END) VIP_MONTH_FREQ,
                 SUM(CASE
                       WHEN TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') BETWEEN
                            TRUNC(&DAYS, 'MM') AND LAST_DAY(TRUNC(&DAYS)) THEN
                        A.SLS_QTY
                       ELSE
                        NULL
                     END) VIP_MONTH_SLS_QTY,
                 SUM(CASE
                       WHEN TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') BETWEEN
                            TRUNC(&DAYS, 'MM') AND LAST_DAY(TRUNC(&DAYS)) THEN
                        A.SLS_AMT_LCL
                       ELSE
                        NULL
                     END) VIP_MONTH_SLS_AMT_LCL,
                 SUM(CASE
                       WHEN TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') BETWEEN
                            TRUNC(&DAYS, 'MM') AND LAST_DAY(TRUNC(&DAYS)) THEN
                        A.SLS_PROFIT_AMT_LCL
                       ELSE
                        NULL
                     END) VIP_MONTH_SLS_PROFIT_AMT_LCL,
                 SUM(CASE
                       WHEN TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') BETWEEN
                            TRUNC(&DAYS, 'MM') AND LAST_DAY(TRUNC(&DAYS)) THEN
                        A.SLS_TAX_AMT_LCL
                       ELSE
                        NULL
                     END) VIP_MONTH_SLS_TAX_AMT_LCL,
                 SUM(CASE
                       WHEN TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') BETWEEN
                            TRUNC(&DAYS, 'MM') AND LAST_DAY(TRUNC(&DAYS)) THEN
                        A.RET_QTY
                       ELSE
                        NULL
                     END) VIP_MONTH_RET_QTY,
                 SUM(CASE
                       WHEN TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') BETWEEN
                            TRUNC(&DAYS, 'MM') AND LAST_DAY(TRUNC(&DAYS)) THEN
                        A.RET_AMT_LCL
                       ELSE
                        NULL
                     END) VIP_MONTH_RET_AMT_LCL,
                 SUM(CASE
                       WHEN TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') BETWEEN
                            TRUNC(&DAYS, 'MM') AND LAST_DAY(TRUNC(&DAYS)) THEN
                        A.RET_PROFIT_AMT_LCL
                       ELSE
                        NULL
                     END) VIP_MONTH_RET_PROFIT_AMT_LCL,
                 SUM(CASE
                       WHEN TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') BETWEEN
                            TRUNC(&DAYS, 'MM') AND LAST_DAY(TRUNC(&DAYS)) THEN
                        A.RET_TAX_AMT_LCL
                       ELSE
                        NULL
                     END) VIP_MONTH_RET_TAX_AMT_LCL,
                 ----------------------------------------------------------------------
                 COUNT(CASE
                         WHEN TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') BETWEEN
                              TRUNC(&DAYS, 'YY') AND
                              ADD_MONTHS(TRUNC(&DAYS, 'yyyy'), 12) - 1 THEN
                          1
                         ELSE
                          NULL
                       END) VIP_YEAR_FREQ,
                 SUM(CASE
                       WHEN TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') BETWEEN
                            TRUNC(&DAYS, 'YY') AND
                            ADD_MONTHS(TRUNC(&DAYS, 'yyyy'), 12) - 1 THEN
                        A.SLS_QTY
                       ELSE
                        NULL
                     END) VIP_YEAR_SLS_QTY,
                 SUM(CASE
                       WHEN TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') BETWEEN
                            TRUNC(&DAYS, 'YY') AND
                            ADD_MONTHS(TRUNC(&DAYS, 'yyyy'), 12) - 1 THEN
                        A.SLS_AMT_LCL
                       ELSE
                        NULL
                     END) VIP_YEAR_SLS_AMT_LCL,
                 SUM(CASE
                       WHEN TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') BETWEEN
                            TRUNC(&DAYS, 'YY') AND
                            ADD_MONTHS(TRUNC(&DAYS, 'yyyy'), 12) - 1 THEN
                        A.SLS_PROFIT_AMT_LCL
                       ELSE
                        NULL
                     END) VIP_YEAR_SLS_PROFIT_AMT_LCL,
                 SUM(CASE
                       WHEN TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') BETWEEN
                            TRUNC(&DAYS, 'YY') AND
                            ADD_MONTHS(TRUNC(&DAYS, 'yyyy'), 12) - 1 THEN
                        A.SLS_TAX_AMT_LCL
                       ELSE
                        NULL
                     END) VIP_YEAR_SLS_TAX_AMT_LCL,
                 SUM(CASE
                       WHEN TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') BETWEEN
                            TRUNC(&DAYS, 'YY') AND
                            ADD_MONTHS(TRUNC(&DAYS, 'yyyy'), 12) - 1 THEN
                        A.RET_QTY
                       ELSE
                        NULL
                     END) VIP_YEAR_RET_QTY,
                 SUM(CASE
                       WHEN TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') BETWEEN
                            TRUNC(&DAYS, 'YY') AND
                            ADD_MONTHS(TRUNC(&DAYS, 'yyyy'), 12) - 1 THEN
                        A.RET_AMT_LCL
                       ELSE
                        NULL
                     END) VIP_YEAR_RET_AMT_LCL,
                 SUM(CASE
                       WHEN TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') BETWEEN
                            TRUNC(&DAYS, 'YY') AND
                            ADD_MONTHS(TRUNC(&DAYS, 'yyyy'), 12) - 1 THEN
                        A.RET_PROFIT_AMT_LCL
                       ELSE
                        NULL
                     END) VIP_YEAR_RET_PROFIT_AMT_LCL,
                 SUM(CASE
                       WHEN TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') BETWEEN
                            TRUNC(&DAYS, 'YY') AND
                            ADD_MONTHS(TRUNC(&DAYS, 'yyyy'), 12) - 1 THEN
                        A.RET_TAX_AMT_LCL
                       ELSE
                        NULL
                     END) VIP_YEAR_RET_TAX_AMT_LCL
                  FROM RADM.BBG_RA_RFM_VIP_F A
                 WHERE A.DT_WID <= &DT_WID
                 GROUP BY A.HYK_NO) T) A
 WHERE A.FREQ <= 200
   AND A.FREQ > 0
 GROUP BY A.FREQ
 ORDER BY A.FREQ;

--M
SELECT A.AMT M, COUNT(1) CNT
  FROM (SELECT T.HYK_NO, ROUND(NVL(T.VIP_MONTH_SLS_AMT_LCL, 0), 0) AMT
          FROM (SELECT /*+PARALLEL(16)*/
                 A.HYK_NO,
                 TO_CHAR(&DAYS, 'YYYYMM') MN_WID,
                 MAX(A.DATASOURCE_NUM_ID) DATASOURCE_NUM_ID,
                 MAX(A.ETL_THREAD_VAL) ETL_THREAD_VAL,
                 A.HYK_NO || '~' || TO_CHAR(&DAYS, 'YYYYMM') INTEGRATION_ID,
                 MAX(TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD')) VIP_RECENCY_DATE,
                 COUNT(CASE
                         WHEN TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') BETWEEN
                              TRUNC(&DAYS, 'MM') AND LAST_DAY(TRUNC(&DAYS)) THEN
                          1
                         ELSE
                          NULL
                       END) VIP_MONTH_FREQ,
                 SUM(CASE
                       WHEN TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') BETWEEN
                            TRUNC(&DAYS, 'MM') AND LAST_DAY(TRUNC(&DAYS)) THEN
                        A.SLS_QTY
                       ELSE
                        NULL
                     END) VIP_MONTH_SLS_QTY,
                 SUM(CASE
                       WHEN TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') BETWEEN
                            TRUNC(&DAYS, 'MM') AND LAST_DAY(TRUNC(&DAYS)) THEN
                        A.SLS_AMT_LCL
                       ELSE
                        NULL
                     END) VIP_MONTH_SLS_AMT_LCL,
                 SUM(CASE
                       WHEN TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') BETWEEN
                            TRUNC(&DAYS, 'MM') AND LAST_DAY(TRUNC(&DAYS)) THEN
                        A.SLS_PROFIT_AMT_LCL
                       ELSE
                        NULL
                     END) VIP_MONTH_SLS_PROFIT_AMT_LCL,
                 SUM(CASE
                       WHEN TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') BETWEEN
                            TRUNC(&DAYS, 'MM') AND LAST_DAY(TRUNC(&DAYS)) THEN
                        A.SLS_TAX_AMT_LCL
                       ELSE
                        NULL
                     END) VIP_MONTH_SLS_TAX_AMT_LCL,
                 SUM(CASE
                       WHEN TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') BETWEEN
                            TRUNC(&DAYS, 'MM') AND LAST_DAY(TRUNC(&DAYS)) THEN
                        A.RET_QTY
                       ELSE
                        NULL
                     END) VIP_MONTH_RET_QTY,
                 SUM(CASE
                       WHEN TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') BETWEEN
                            TRUNC(&DAYS, 'MM') AND LAST_DAY(TRUNC(&DAYS)) THEN
                        A.RET_AMT_LCL
                       ELSE
                        NULL
                     END) VIP_MONTH_RET_AMT_LCL,
                 SUM(CASE
                       WHEN TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') BETWEEN
                            TRUNC(&DAYS, 'MM') AND LAST_DAY(TRUNC(&DAYS)) THEN
                        A.RET_PROFIT_AMT_LCL
                       ELSE
                        NULL
                     END) VIP_MONTH_RET_PROFIT_AMT_LCL,
                 SUM(CASE
                       WHEN TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') BETWEEN
                            TRUNC(&DAYS, 'MM') AND LAST_DAY(TRUNC(&DAYS)) THEN
                        A.RET_TAX_AMT_LCL
                       ELSE
                        NULL
                     END) VIP_MONTH_RET_TAX_AMT_LCL,
                 ----------------------------------------------------------------------
                 COUNT(CASE
                         WHEN TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') BETWEEN
                              TRUNC(&DAYS, 'YY') AND
                              ADD_MONTHS(TRUNC(&DAYS, 'yyyy'), 12) - 1 THEN
                          1
                         ELSE
                          NULL
                       END) VIP_YEAR_FREQ,
                 SUM(CASE
                       WHEN TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') BETWEEN
                            TRUNC(&DAYS, 'YY') AND
                            ADD_MONTHS(TRUNC(&DAYS, 'yyyy'), 12) - 1 THEN
                        A.SLS_QTY
                       ELSE
                        NULL
                     END) VIP_YEAR_SLS_QTY,
                 SUM(CASE
                       WHEN TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') BETWEEN
                            TRUNC(&DAYS, 'YY') AND
                            ADD_MONTHS(TRUNC(&DAYS, 'yyyy'), 12) - 1 THEN
                        A.SLS_AMT_LCL
                       ELSE
                        NULL
                     END) VIP_YEAR_SLS_AMT_LCL,
                 SUM(CASE
                       WHEN TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') BETWEEN
                            TRUNC(&DAYS, 'YY') AND
                            ADD_MONTHS(TRUNC(&DAYS, 'yyyy'), 12) - 1 THEN
                        A.SLS_PROFIT_AMT_LCL
                       ELSE
                        NULL
                     END) VIP_YEAR_SLS_PROFIT_AMT_LCL,
                 SUM(CASE
                       WHEN TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') BETWEEN
                            TRUNC(&DAYS, 'YY') AND
                            ADD_MONTHS(TRUNC(&DAYS, 'yyyy'), 12) - 1 THEN
                        A.SLS_TAX_AMT_LCL
                       ELSE
                        NULL
                     END) VIP_YEAR_SLS_TAX_AMT_LCL,
                 SUM(CASE
                       WHEN TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') BETWEEN
                            TRUNC(&DAYS, 'YY') AND
                            ADD_MONTHS(TRUNC(&DAYS, 'yyyy'), 12) - 1 THEN
                        A.RET_QTY
                       ELSE
                        NULL
                     END) VIP_YEAR_RET_QTY,
                 SUM(CASE
                       WHEN TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') BETWEEN
                            TRUNC(&DAYS, 'YY') AND
                            ADD_MONTHS(TRUNC(&DAYS, 'yyyy'), 12) - 1 THEN
                        A.RET_AMT_LCL
                       ELSE
                        NULL
                     END) VIP_YEAR_RET_AMT_LCL,
                 SUM(CASE
                       WHEN TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') BETWEEN
                            TRUNC(&DAYS, 'YY') AND
                            ADD_MONTHS(TRUNC(&DAYS, 'yyyy'), 12) - 1 THEN
                        A.RET_PROFIT_AMT_LCL
                       ELSE
                        NULL
                     END) VIP_YEAR_RET_PROFIT_AMT_LCL,
                 SUM(CASE
                       WHEN TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') BETWEEN
                            TRUNC(&DAYS, 'YY') AND
                            ADD_MONTHS(TRUNC(&DAYS, 'yyyy'), 12) - 1 THEN
                        A.RET_TAX_AMT_LCL
                       ELSE
                        NULL
                     END) VIP_YEAR_RET_TAX_AMT_LCL
                  FROM RADM.BBG_RA_RFM_VIP_F A
                 WHERE A.DT_WID <= &DT_WID
                 GROUP BY A.HYK_NO) T) A
 WHERE A.AMT > 0
 GROUP BY A.AMT
 ORDER BY A.AMT;
