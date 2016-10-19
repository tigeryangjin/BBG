SELECT TRX.ORG_NUM �ŵ����,
       TRX.DAYS ����,
       COUNT(TRX.SLS_TRX_ID) ������,
       SUM(TRX.AMT) ��˰���۶�,
       ROUND(SUM(TRX.AMT) / COUNT(TRX.SLS_TRX_ID), 2) �͵���
  FROM (SELECT /*+PARALLEL(16)*/
         O.ORG_NUM,
         SUBSTR(S.DT_WID, 2, 8) DAYS,
         S.SLS_TRX_ID,
         SUM(S.SLS_AMT_LCL - S.RET_AMT_LCL) AMT
          FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_F S,
               RABATCHER.W_PRODUCT_D_RTL_TMP P,
               RADM.W_INT_ORG_D              O
         WHERE S.PROD_WID = P.PROD_IT_WID
           AND S.ORG_WID = O.ROW_WID
              --�ֲ�LVL8ANC_PRODCAT_ID(1λ)PROD_DV_WID
              --����LVL6ANC_PRODCAT_ID(2λ)PROD_DP_WID
              --����LVL5ANC_PRODCAT_ID(3λ)PROD_CL_WID
              --С��LVL4ANC_PRODCAT_ID(4λ)PROD_SC_WID
           AND P.PROD_DP_NUM IN
               (31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43)
           AND O.ORG_NUM = 120056
           AND S.DT_WID BETWEEN '120161001000' AND '120161016000' --��������
         GROUP BY O.ORG_NUM, S.SLS_TRX_ID, SUBSTR(S.DT_WID, 2, 8)) TRX
 GROUP BY TRX.ORG_NUM, TRX.DAYS
 ORDER BY TRX.DAYS;
