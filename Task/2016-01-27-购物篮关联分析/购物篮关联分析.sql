

--VIEW
SELECT * FROM RADM.BBG_RA_SLS_MBA_LC_DY_FV T WHERE T.DT_WID=120160301000;
SELECT * FROM RADM.BBG_RA_SLS_MBA_DY_FV T WHERE T.DT_WID=120160301000;

--RA
select *
  from RADM.BBG_RA_SLS_MBA_LC_DY_FV A, RADM.W_MCAL_DAY_DV B
 WHERE A.DT_WID = B.ROW_WID
   AND B.MCAL_CAL_WID = 1.0
   AND TRUNC(B.MCAL_DAY_DT) = TO_DATE('2016-03-01', 'YYYY-MM-DD')
   AND '2010' < B.CAL_YEAR;

--CREATE TABLE 
--BBG_RA_SLS_MBA_LC_DY_TMP
CREATE TABLE RABATCHER.BBG_RA_SLS_MBA_LC_DY_TMP AS
SELECT * FROM RABATCHER.BBG_RA_SLS_MBA_LC_DY_FV T WHERE T.DT_WID=120160301000;
--BBG_RA_SLS_MBA_LC_DY_A
CREATE TABLE RADM.BBG_RA_SLS_MBA_LC_DY_A AS
SELECT * FROM RABATCHER.BBG_RA_SLS_MBA_LC_DY_TMP;
--sequence
create sequence BBG_RA_SLS_MBA_LC_DY_A_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

--BBG_RA_SLS_MBA_DY_A
CREATE TABLE RADM.BBG_RA_SLS_MBA_DY_A AS 



--ODI
--interface1:source��RABATCHER.BBG_RA_SLS_MBA_LC_DY_FV           target:RABATCHER.BBG_RA_SLS_MBA_LC_DY_TMP
--interface2:source��RABATCHER.BBG_RA_SLS_MBA_LC_DY_TMP     target:RADM.BBG_RA_SLS_MBA_LC_DY_A
--interface3:source��RABATCHER.BBG_RA_SLS_MBA_LC_DY_TMP     target:RADM.BBG_RA_SLS_MBA_DY_A


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
