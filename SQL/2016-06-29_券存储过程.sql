UPDATE /*+PARALLEL(16)*/ RA_RMS.W_RTL_SLS_TRX_TMP_A T
   SET T.TRX_AMT =
       (SELECT S.TRX_AMT
          FROM (SELECT V.DAY_DT,
                       V.SLS_TRX_ID,
                       V.IT_SEQ_NUM,
                       MAX(V.TRX_AMT) TRX_AMT
                  FROM RA_RMS.W_RTL_SLS_TRX_TMP_A V
                 WHERE V.PROMO_TYPE IN ('50', '51', '52')
                 GROUP BY V.DAY_DT, V.SLS_TRX_ID, V.IT_SEQ_NUM) S
         WHERE T.DAY_DT = S.DAY_DT
           AND T.SLS_TRX_ID = S.SLS_TRX_ID
           AND T.IT_SEQ_NUM = S.IT_SEQ_NUM
           AND T.ETL_THREAD_VAL = 1 --'#RA_SRC_THREAD_VAL'
        )
 WHERE EXISTS (SELECT 1
          FROM (SELECT V.DAY_DT,
                       V.SLS_TRX_ID,
                       V.IT_SEQ_NUM,
                       MAX(V.TRX_AMT) TRX_AMT
                  FROM RA_RMS.W_RTL_SLS_TRX_TMP_A V
                 WHERE V.PROMO_TYPE IN ('50', '51', '52')
                 GROUP BY V.DAY_DT, V.SLS_TRX_ID, V.IT_SEQ_NUM) S
         WHERE T.DAY_DT = S.DAY_DT
           AND T.SLS_TRX_ID = S.SLS_TRX_ID
           AND T.IT_SEQ_NUM = S.IT_SEQ_NUM
           AND T.PROMO_TYPE NOT IN ('50', '51', '52')
           AND T.ETL_THREAD_VAL = 1 --'#RA_SRC_THREAD_VAL'
        );
