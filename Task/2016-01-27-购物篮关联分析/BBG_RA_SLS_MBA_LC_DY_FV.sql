CREATE OR REPLACE VIEW BBG_RA_SLS_MBA_LC_DY_FV AS
WITH TRX_A AS
--购物篮A
 (SELECT T.SLS_TRX_ID,
         T.DT_WID,
         T.ORG_WID,
         T.ORG_DH_WID,
         T.ORG_SCD1_WID,
         T.PROD_WID,
         T.PROD_SCD1_WID
    FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_F T),
TRX_B AS
--购物篮B
 (SELECT T.SLS_TRX_ID,
         T.DT_WID,
         T.ORG_WID,
         T.ORG_DH_WID,
         T.ORG_SCD1_WID,
         T.PROD_WID,
         T.PROD_SCD1_WID
    FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_F T),
ALL_TRX AS
--全部交易笔数
 (SELECT T.DT_WID,
         T.ORG_WID,
         T.ORG_DH_WID,
         T.ORG_SCD1_WID,
         COUNT(T.SLS_TRX_ID) CNT
    FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_F T
   GROUP BY T.DT_WID, T.ORG_WID, T.ORG_DH_WID, T.ORG_SCD1_WID),
A_TABLE AS
--包含A的交易笔数
 (SELECT T.DT_WID,
         T.PROD_WID,
         T.PROD_SCD1_WID,
         T.ORG_WID,
         T.ORG_DH_WID,
         T.ORG_SCD1_WID,
         COUNT(T.SLS_TRX_ID) A_CNT
    FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_F T
   GROUP BY T.DT_WID,
            T.PROD_WID,
            T.PROD_SCD1_WID,
            T.ORG_WID,
            T.ORG_DH_WID,
            T.ORG_SCD1_WID
  HAVING COUNT(T.SLS_TRX_ID) > 1),
B_TABLE AS
--包含B的交易笔数
 (SELECT T.DT_WID,
         T.PROD_WID,
         T.PROD_SCD1_WID,
         T.ORG_WID,
         T.ORG_DH_WID,
         T.ORG_SCD1_WID,
         COUNT(T.SLS_TRX_ID) B_CNT
    FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_F T
   GROUP BY T.DT_WID,
            T.PROD_WID,
            T.PROD_SCD1_WID,
            T.ORG_WID,
            T.ORG_DH_WID,
            T.ORG_SCD1_WID
  HAVING COUNT(T.SLS_TRX_ID) > 1)
--
SELECT TT1.DT_WID,
       TT1.ORG_WID,
       TT1.ORG_DH_WID,
       TT1.ORG_SCD1_WID,
       TT1.A_PROD_WID,
       TT1.A_PROD_SCD1_WID,
       TT1.B_PROD_WID,
       TT1.B_PROD_SCD1_WID,
       TT1.A_CNT,
       TT1.B_CNT,
       TT1.AB_CNT,
       ATR.CNT
  FROM (SELECT AB.DT_WID,
               AB.ORG_WID,
               AB.ORG_DH_WID,
               AB.ORG_SCD1_WID,
               AB.A_PROD_WID,
               AB.A_PROD_SCD1_WID,
               AB.B_PROD_WID,
               AB.B_PROD_SCD1_WID,
               AB.A_CNT,
               AB.B_CNT,
               COUNT(AB.SLS_TRX_ID) AB_CNT
          FROM --购物篮AB关联
               (SELECT A.DT_WID,
                       A.ORG_WID,
                       A.ORG_DH_WID,
                       A.ORG_SCD1_WID,
                       A.SLS_TRX_ID,
                       A.PROD_WID      A_PROD_WID,
                       A.PROD_SCD1_WID A_PROD_SCD1_WID,
                       B.PROD_WID      B_PROD_WID,
                       B.PROD_SCD1_WID B_PROD_SCD1_WID,
                       A.A_CNT,
                       B.B_CNT
                  FROM (SELECT A1.SLS_TRX_ID,
                               A1.PROD_WID,
                               A1.PROD_SCD1_WID,
                               A1.DT_WID,
                               A1.ORG_WID,
                               A1.ORG_DH_WID,
                               A1.ORG_SCD1_WID,
                               NVL(A2.A_CNT, 0) A_CNT
                          FROM TRX_A A1, A_TABLE A2
                         WHERE A1.DT_WID = A2.DT_WID(+)
                           AND A1.PROD_WID = A2.PROD_WID(+)
                           AND A1.ORG_WID = A2.ORG_WID(+)
                           AND A1.ORG_DH_WID = A2.ORG_DH_WID(+)
                           AND A1.ORG_SCD1_WID = A2.ORG_SCD1_WID(+)) A,
                       (SELECT B1.SLS_TRX_ID,
                               B1.PROD_WID,
                               B1.PROD_SCD1_WID,
                               B1.DT_WID,
                               B1.ORG_WID,
                               B1.ORG_DH_WID,
                               B1.ORG_SCD1_WID,
                               NVL(B2.B_CNT, 0) B_CNT
                          FROM TRX_B B1, B_TABLE B2
                         WHERE B1.DT_WID = B2.DT_WID(+)
                           AND B1.PROD_WID = B2.PROD_WID(+)
                           AND B1.ORG_WID = B2.ORG_WID(+)
                           AND B1.ORG_DH_WID = B2.ORG_DH_WID(+)
                           AND B1.ORG_SCD1_WID = B2.ORG_SCD1_WID(+)) B
                 WHERE A.SLS_TRX_ID = B.SLS_TRX_ID
                   AND A.DT_WID = B.DT_WID
                   AND A.ORG_WID = B.ORG_WID
                   AND A.ORG_DH_WID = B.ORG_DH_WID
                   AND A.ORG_SCD1_WID = B.ORG_SCD1_WID
                   AND A.PROD_WID <> B.PROD_WID) AB
         GROUP BY AB.DT_WID,
                  AB.ORG_WID,
                  AB.ORG_DH_WID,
                  AB.ORG_SCD1_WID,
                  AB.A_PROD_WID,
                  AB.A_PROD_SCD1_WID,
                  AB.B_PROD_WID,
                  AB.B_PROD_SCD1_WID,
                  AB.A_CNT,
                  AB.B_CNT
        HAVING COUNT(AB.SLS_TRX_ID) > 1) TT1,
       ALL_TRX ATR
 WHERE TT1.DT_WID = ATR.DT_WID
   AND TT1.ORG_WID = ATR.ORG_WID
   AND TT1.ORG_DH_WID = ATR.ORG_DH_WID
   AND TT1.ORG_SCD1_WID = ATR.ORG_SCD1_WID
 ORDER BY TT1.AB_CNT DESC;
