WITH TRX_A AS
 (SELECT T.SLS_TRX_ID, T.PROD_WID
    FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_F T
   WHERE T.DT_WID BETWEEN 120151101000 AND 120151130000),
TRX_B AS
 (SELECT T.SLS_TRX_ID, T.PROD_WID
    FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_F T
   WHERE T.DT_WID BETWEEN 120151101000 AND 120151130000)
SELECT TT.A_PROD, TT.B_PROD, COUNT(TT.SLS_TRX_ID)
  FROM (SELECT A.PROD_WID A_PROD, A.SLS_TRX_ID, B.PROD_WID B_PROD
          FROM TRX_A A, TRX_B B
         WHERE A.SLS_TRX_ID = B.SLS_TRX_ID
           AND A.PROD_WID <> B.PROD_WID) TT
 GROUP BY TT.A_PROD, TT.B_PROD
HAVING COUNT (TT.SLS_TRX_ID) > 1
 ORDER BY COUNT(TT.SLS_TRX_ID) DESC;

--VIEW
CREATE OR REPLACE VIEW RADM.BBG_RA_MBA_VIEW AS
  WITH TRX_A AS
   (SELECT T.SLS_TRX_ID,
           T.DT_WID,
           T.ORG_WID,
           T.ORG_DH_WID,
           T.ORG_SCD1_WID,
           T.PROD_WID
      FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_F T),
  TRX_B AS
   (SELECT T.SLS_TRX_ID,
           T.DT_WID,
           T.ORG_WID,
           T.ORG_DH_WID,
           T.ORG_SCD1_WID,
           T.PROD_WID
      FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_F T),
  ALL_TRX AS
   (SELECT T.DT_WID,
           T.ORG_WID,
           T.ORG_DH_WID,
           T.ORG_SCD1_WID,
           COUNT(T.SLS_TRX_ID) CNT
      FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_F T
     GROUP BY T.DT_WID, T.ORG_WID, T.ORG_DH_WID, T.ORG_SCD1_WID)
  -- 
  SELECT TT1.DT_WID,
         TT1.ORG_WID,
         TT1.ORG_DH_WID,
         TT1.ORG_SCD1_WID,
         TT1.A_PROD,
         TT1.B_PROD,
         TT1.AB_CNT,
         ATR.CNT
    FROM (SELECT AB.DT_WID,
                 AB.ORG_WID,
                 AB.ORG_DH_WID,
                 AB.ORG_SCD1_WID,
                 AB.A_PROD,
                 AB.B_PROD,
                 COUNT(AB.SLS_TRX_ID) AB_CNT
            FROM (SELECT A.DT_WID,
                         A.ORG_WID,
                         A.ORG_DH_WID,
                         A.ORG_SCD1_WID,
                         A.SLS_TRX_ID,
                         A.PROD_WID     A_PROD,
                         B.PROD_WID     B_PROD
                    FROM TRX_A A, TRX_B B
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
                    AB.A_PROD,
                    AB.B_PROD
          HAVING COUNT(AB.SLS_TRX_ID) > 1) TT1,
         ALL_TRX ATR
   WHERE TT1.DT_WID = ATR.DT_WID
     AND TT1.ORG_WID = ATR.ORG_WID
     AND TT1.ORG_DH_WID = ATR.ORG_DH_WID
     AND TT1.ORG_SCD1_WID = ATR.ORG_SCD1_WID
   ORDER BY TT1.AB_CNT DESC;

--   
SELECT * FROM RADM.BBG_RA_MBA_VIEW T WHERE T.DT_WID = 120160127000;
SELECT T.DT_WID, T.A_PROD, T.B_PROD, SUM(T.AB_CNT) AB_CNT, SUM(T.CNT) CNT
  FROM RADM.BBG_RA_MBA_VIEW T
 WHERE T.DT_WID = 120160127000
 GROUP BY T.DT_WID, T.A_PROD, T.B_PROD;
