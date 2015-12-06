CREATE OR REPLACE PROCEDURE BBG_RA_VIP_RFM_AGG(DAYS DATE) AS
BEGIN
  --BBG_RA_RFM_VIP_MN_A
  MERGE /*+APPEND*/
  INTO RADM.BBG_RA_RFM_VIP_MN_A T
  USING (SELECT /*+PARALLEL(16)*/
          A.HYK_NO,
          TO_CHAR(DAYS, 'YYYYMM') MN_WID,
          MAX(A.DATASOURCE_NUM_ID) DATASOURCE_NUM_ID,
          MAX(A.ETL_THREAD_VAL) ETL_THREAD_VAL,
          A.HYK_NO || '~' || TO_CHAR(DAYS, 'YYYYMM') INTEGRATION_ID,
          MAX(TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD')) VIP_RECENCY,
          COUNT(CASE
                  WHEN TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') BETWEEN
                       TRUNC(DAYS, 'MM') AND LAST_DAY(TRUNC(DAYS)) THEN
                   1
                  ELSE
                   NULL
                END) VIP_MONTH_FREQ,
          SUM(CASE
                WHEN TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') BETWEEN
                     TRUNC(DAYS, 'MM') AND LAST_DAY(TRUNC(DAYS)) THEN
                 A.SLS_QTY
                ELSE
                 NULL
              END) VIP_MONTH_SLS_QTY,
          SUM(CASE
                WHEN TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') BETWEEN
                     TRUNC(DAYS, 'MM') AND LAST_DAY(TRUNC(DAYS)) THEN
                 A.SLS_AMT_LCL
                ELSE
                 NULL
              END) VIP_MONTH_SLS_AMT_LCL,
          SUM(CASE
                WHEN TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') BETWEEN
                     TRUNC(DAYS, 'MM') AND LAST_DAY(TRUNC(DAYS)) THEN
                 A.SLS_PROFIT_AMT_LCL
                ELSE
                 NULL
              END) VIP_MONTH_SLS_PROFIT_AMT_LCL,
          SUM(CASE
                WHEN TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') BETWEEN
                     TRUNC(DAYS, 'MM') AND LAST_DAY(TRUNC(DAYS)) THEN
                 A.SLS_TAX_AMT_LCL
                ELSE
                 NULL
              END) VIP_MONTH_SLS_TAX_AMT_LCL,
          SUM(CASE
                WHEN TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') BETWEEN
                     TRUNC(DAYS, 'MM') AND LAST_DAY(TRUNC(DAYS)) THEN
                 A.RET_QTY
                ELSE
                 NULL
              END) VIP_MONTH_RET_QTY,
          SUM(CASE
                WHEN TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') BETWEEN
                     TRUNC(DAYS, 'MM') AND LAST_DAY(TRUNC(DAYS)) THEN
                 A.RET_AMT_LCL
                ELSE
                 NULL
              END) VIP_MONTH_RET_AMT_LCL,
          SUM(CASE
                WHEN TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') BETWEEN
                     TRUNC(DAYS, 'MM') AND LAST_DAY(TRUNC(DAYS)) THEN
                 A.RET_PROFIT_AMT_LCL
                ELSE
                 NULL
              END) VIP_MONTH_RET_PROFIT_AMT_LCL,
          SUM(CASE
                WHEN TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') BETWEEN
                     TRUNC(DAYS, 'MM') AND LAST_DAY(TRUNC(DAYS)) THEN
                 A.RET_TAX_AMT_LCL
                ELSE
                 NULL
              END) VIP_MONTH_RET_TAX_AMT_LCL,
          ----------------------------------------------------------------------
          COUNT(CASE
                  WHEN TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') BETWEEN
                       TRUNC(DAYS, 'YY') AND ADD_MONTHS(TRUNC(DAYS, 'yyyy'), 12) - 1 THEN
                   1
                  ELSE
                   NULL
                END) VIP_YEAR_FREQ,
          SUM(CASE
                WHEN TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') BETWEEN
                     TRUNC(DAYS, 'YY') AND ADD_MONTHS(TRUNC(DAYS, 'yyyy'), 12) - 1 THEN
                 A.SLS_QTY
                ELSE
                 NULL
              END) VIP_YEAR_SLS_QTY,
          SUM(CASE
                WHEN TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') BETWEEN
                     TRUNC(DAYS, 'YY') AND ADD_MONTHS(TRUNC(DAYS, 'yyyy'), 12) - 1 THEN
                 A.SLS_AMT_LCL
                ELSE
                 NULL
              END) VIP_YEAR_SLS_AMT_LCL,
          SUM(CASE
                WHEN TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') BETWEEN
                     TRUNC(DAYS, 'YY') AND ADD_MONTHS(TRUNC(DAYS, 'yyyy'), 12) - 1 THEN
                 A.SLS_PROFIT_AMT_LCL
                ELSE
                 NULL
              END) VIP_YEAR_SLS_PROFIT_AMT_LCL,
          SUM(CASE
                WHEN TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') BETWEEN
                     TRUNC(DAYS, 'YY') AND ADD_MONTHS(TRUNC(DAYS, 'yyyy'), 12) - 1 THEN
                 A.SLS_TAX_AMT_LCL
                ELSE
                 NULL
              END) VIP_YEAR_SLS_TAX_AMT_LCL,
          SUM(CASE
                WHEN TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') BETWEEN
                     TRUNC(DAYS, 'YY') AND ADD_MONTHS(TRUNC(DAYS, 'yyyy'), 12) - 1 THEN
                 A.RET_QTY
                ELSE
                 NULL
              END) VIP_YEAR_RET_QTY,
          SUM(CASE
                WHEN TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') BETWEEN
                     TRUNC(DAYS, 'YY') AND ADD_MONTHS(TRUNC(DAYS, 'yyyy'), 12) - 1 THEN
                 A.RET_AMT_LCL
                ELSE
                 NULL
              END) VIP_YEAR_RET_AMT_LCL,
          SUM(CASE
                WHEN TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') BETWEEN
                     TRUNC(DAYS, 'YY') AND ADD_MONTHS(TRUNC(DAYS, 'yyyy'), 12) - 1 THEN
                 A.RET_PROFIT_AMT_LCL
                ELSE
                 NULL
              END) VIP_YEAR_RET_PROFIT_AMT_LCL,
          SUM(CASE
                WHEN TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') BETWEEN
                     TRUNC(DAYS, 'YY') AND ADD_MONTHS(TRUNC(DAYS, 'yyyy'), 12) - 1 THEN
                 A.RET_TAX_AMT_LCL
                ELSE
                 NULL
              END) VIP_YEAR_RET_TAX_AMT_LCL
           FROM RADM.BBG_RA_RFM_VIP_F A
          GROUP BY A.HYK_NO) S
  ON (T.HYK_NO = S.HYK_NO AND T.MN_WID = S.MN_WID)
  WHEN MATCHED THEN
    UPDATE
       SET T.VIP_RECENCY                  = S.VIP_RECENCY,
           T.VIP_MONTH_FREQ               = S.VIP_MONTH_FREQ,
           T.VIP_YEAR_FREQ                = S.VIP_YEAR_FREQ,
           T.VIP_MONTH_SLS_QTY            = S.VIP_MONTH_SLS_QTY,
           T.VIP_MONTH_SLS_AMT_LCL        = S.VIP_MONTH_SLS_AMT_LCL,
           T.VIP_MONTH_SLS_PROFIT_AMT_LCL = S.VIP_MONTH_SLS_PROFIT_AMT_LCL,
           T.VIP_MONTH_SLS_TAX_AMT_LCL    = S.VIP_MONTH_SLS_TAX_AMT_LCL,
           T.VIP_MONTH_RET_QTY            = S.VIP_MONTH_RET_QTY,
           T.VIP_MONTH_RET_AMT_LCL        = S.VIP_MONTH_RET_AMT_LCL,
           T.VIP_MONTH_RET_PROFIT_AMT_LCL = S.VIP_MONTH_RET_PROFIT_AMT_LCL,
           T.VIP_MONTH_RET_TAX_AMT_LCL    = S.VIP_MONTH_RET_TAX_AMT_LCL,
           T.VIP_YEAR_SLS_QTY             = S.VIP_YEAR_SLS_QTY,
           T.VIP_YEAR_SLS_AMT_LCL         = S.VIP_YEAR_SLS_AMT_LCL,
           T.VIP_YEAR_SLS_PROFIT_AMT_LCL  = S.VIP_YEAR_SLS_PROFIT_AMT_LCL,
           T.VIP_YEAR_SLS_TAX_AMT_LCL     = S.VIP_YEAR_SLS_TAX_AMT_LCL,
           T.VIP_YEAR_RET_QTY             = S.VIP_YEAR_RET_QTY,
           T.VIP_YEAR_RET_AMT_LCL         = S.VIP_YEAR_RET_AMT_LCL,
           T.VIP_YEAR_RET_PROFIT_AMT_LCL  = S.VIP_YEAR_RET_PROFIT_AMT_LCL,
           T.VIP_YEAR_RET_TAX_AMT_LCL     = S.VIP_YEAR_RET_TAX_AMT_LCL,
           T.W_UPDATE_DT                  = SYSDATE
  WHEN NOT MATCHED THEN
    INSERT
      (T.ROW_WID,
       T.HYK_NO,
       T.MN_WID,
       T.DATASOURCE_NUM_ID,
       T.INTEGRATION_ID,
       T.W_INSERT_DT,
       T.W_UPDATE_DT,
       T.VIP_RECENCY,
       T.VIP_MONTH_FREQ,
       T.VIP_YEAR_FREQ,
       T.VIP_MONTH_SLS_QTY,
       T.VIP_MONTH_SLS_AMT_LCL,
       T.VIP_MONTH_SLS_PROFIT_AMT_LCL,
       T.VIP_MONTH_SLS_TAX_AMT_LCL,
       T.VIP_MONTH_RET_QTY,
       T.VIP_MONTH_RET_AMT_LCL,
       T.VIP_MONTH_RET_PROFIT_AMT_LCL,
       T.VIP_MONTH_RET_TAX_AMT_LCL,
       T.VIP_YEAR_SLS_QTY,
       T.VIP_YEAR_SLS_AMT_LCL,
       T.VIP_YEAR_SLS_PROFIT_AMT_LCL,
       T.VIP_YEAR_SLS_TAX_AMT_LCL,
       T.VIP_YEAR_RET_QTY,
       T.VIP_YEAR_RET_AMT_LCL,
       T.VIP_YEAR_RET_PROFIT_AMT_LCL,
       T.VIP_YEAR_RET_TAX_AMT_LCL,
       T.BBG_REFERENCE_DO1,
       T.BBG_REFERENCE_DO2,
       T.BBG_REFERENCE_DO3,
       T.BBG_REFERENCE_DO4,
       T.BBG_REFERENCE_DO5,
       T.BBG_REFERENCE_FO1,
       T.BBG_REFERENCE_FO2,
       T.BBG_REFERENCE_FO3,
       T.BBG_REFERENCE_FO4,
       T.BBG_REFERENCE_FO5,
       T.BBG_REFERENCE_FO6,
       T.BBG_REFERENCE_FO7,
       T.BBG_REFERENCE_FO8,
       T.BBG_REFERENCE_FO9,
       T.BBG_REFERENCE_FO10)
    VALUES
      (RADM.BBG_RA_RFM_VIP_MN_A_SEQ.NEXTVAL,
       S.HYK_NO,
       S.MN_WID,
       S.DATASOURCE_NUM_ID,
       S.INTEGRATION_ID,
       SYSDATE,
       SYSDATE,
       S.VIP_RECENCY,
       S.VIP_MONTH_FREQ,
       S.VIP_YEAR_FREQ,
       S.VIP_MONTH_SLS_QTY,
       S.VIP_MONTH_SLS_AMT_LCL,
       S.VIP_MONTH_SLS_PROFIT_AMT_LCL,
       S.VIP_MONTH_SLS_TAX_AMT_LCL,
       S.VIP_MONTH_RET_QTY,
       S.VIP_MONTH_RET_AMT_LCL,
       S.VIP_MONTH_RET_PROFIT_AMT_LCL,
       S.VIP_MONTH_RET_TAX_AMT_LCL,
       S.VIP_YEAR_SLS_QTY,
       S.VIP_YEAR_SLS_AMT_LCL,
       S.VIP_YEAR_SLS_PROFIT_AMT_LCL,
       S.VIP_YEAR_SLS_TAX_AMT_LCL,
       S.VIP_YEAR_RET_QTY,
       S.VIP_YEAR_RET_AMT_LCL,
       S.VIP_YEAR_RET_PROFIT_AMT_LCL,
       S.VIP_YEAR_RET_TAX_AMT_LCL,
       NULL,
       NULL,
       NULL,
       NULL,
       NULL,
       NULL,
       NULL,
       NULL,
       NULL,
       NULL,
       NULL,
       NULL,
       NULL,
       NULL,
       NULL);
  COMMIT;
END;
/
