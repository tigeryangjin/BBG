/*
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
*/

--VIEW
--RADM.BBG_RA_SLS_MBA_LC_DY_FV 

--   
SELECT * FROM RADM.BBG_RA_SLS_MBA_LC_DY_FV T WHERE T.DT_WID = 120160127000;
SELECT *
  FROM (SELECT T.DT_WID,
               T.A_PROD,
               T.B_PROD,
               SUM(T.AB_CNT) AB_CNT,
               SUM(T.CNT) CNT
          FROM RADM.BBG_RA_MBA_VIEW T
         WHERE T.DT_WID = 120160127000
         GROUP BY T.DT_WID, T.A_PROD, T.B_PROD)
 ORDER BY AB_CNT DESC;

SELECT *
  FROM RADM.BBG_RA_MBA_VIEW T
 WHERE T.DT_WID = 120160127000
   AND T.A_PROD IN (351893, 288576)
   AND T.B_PROD IN (351893, 288576);

SELECT *
  FROM (SELECT T.DT_WID,
               T.A_PROD,
               T.B_PROD,
               SUM(T.AB_CNT) AB_CNT,
               SUM(T.CNT) CNT
          FROM RADM.BBG_RA_MBA_VIEW T
         WHERE T.DT_WID = 120160127000
           AND T.A_PROD IN (351893, 288576)
           AND T.B_PROD IN (351893, 288576)
         GROUP BY T.DT_WID, T.A_PROD, T.B_PROD)
 ORDER BY AB_CNT DESC;
 
--有重复记录，需要修复。
SELECT *
  FROM RADM.BBG_RA_SLS_MBA_LC_DY_FV T
 WHERE T.DT_WID = 120160127000
   AND T.A_PROD_NUM = '800220788'
   AND T.B_PROD_NUM = '800399780';
	 
SELECT *
  FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_F T
 WHERE T.DT_WID = 120160127000
   AND T.ORG_WID = 31
   AND EXISTS (SELECT 1
          FROM RADM.W_PRODUCT_D P
         WHERE T.PROD_WID = P.ROW_WID
           AND P.PROD_NUM IN ('800220788', '800399780'));
--------------------
--CN_Retail_As-Was_BBG_Sales_Market_Basket_Analysis
--CD_Retail_As-Was_BBG_Sales_Market_Basket_Analysis
--CN_Retail_As-Was_BBG_Sales_Market_Basket_Analysis_A_PROD_NUM
--CD_Retail_As-Was_BBG_Sales_Market_Basket_Analysis_A_PROD_NUM
--CN_Retail_As-Was_BBG_Sales_Market_Basket_Analysis_A_PROD_NAME
--CD_Retail_As-Was_BBG_Sales_Market_Basket_Analysis_A_PROD_NAME
--CN_Retail_As-Was_BBG_Sales_Market_Basket_Analysis_B_PROD_NUM
--CD_Retail_As-Was_BBG_Sales_Market_Basket_Analysis_B_PROD_NUM
--CN_Retail_As-Was_BBG_Sales_Market_Basket_Analysis_B_PROD_NAME
--CD_Retail_As-Was_BBG_Sales_Market_Basket_Analysis_B_PROD_NAME
--CN_Retail_As-Was_BBG_Sales_Market_Basket_Analysis_A_CNT
--CD_Retail_As-Was_BBG_Sales_Market_Basket_Analysis_A_CNT
--CN_Retail_As-Was_BBG_Sales_Market_Basket_Analysis_B_CNT
--CD_Retail_As-Was_BBG_Sales_Market_Basket_Analysis_B_CNT
--CN_Retail_As-Was_BBG_Sales_Market_Basket_Analysis_AB_CNT
--CD_Retail_As-Was_BBG_Sales_Market_Basket_Analysis_AB_CNT
--CN_Retail_As-Was_BBG_Sales_Market_Basket_Analysis_LOC_CNT
--CD_Retail_As-Was_BBG_Sales_Market_Basket_Analysis_LOC_CNT

SELECT * FROM RADM.W_LOCALIZED_STRING_G T WHERE T.MSG_NUM LIKE '%Retail_As-Was_BBG_VIP_RFM_Analysis' FOR UPDATE;
