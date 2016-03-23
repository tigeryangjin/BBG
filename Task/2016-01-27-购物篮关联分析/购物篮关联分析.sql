
--VIEW
SELECT *
  FROM RABATCHER.BBG_RA_SLS_MBA_LC_DY_FV T
 WHERE T.DT_WID = 120160301000;

--CREATE TABLE 
--BBG_RA_SLS_MBA_LC_DY_TMP
CREATE TABLE RABATCHER.BBG_RA_SLS_MBA_LC_DY_TMP AS
  SELECT *
    FROM RABATCHER.BBG_RA_SLS_MBA_LC_DY_FV T
   WHERE T.DT_WID = 120160301000;
--BBG_RA_SLS_MBA_LC_DY_A
CREATE TABLE RADM.BBG_RA_SLS_MBA_LC_DY_A AS
  SELECT * FROM RABATCHER.BBG_RA_SLS_MBA_LC_DY_TMP;
--sequence
create sequence BBG_RA_SLS_MBA_LC_DY_A_SEQ minvalue 1 maxvalue 9999999999999999999999999999 start
  with 1 increment by 1 cache 20;

--BBG_RA_SLS_MBA_DY_A
CREATE TABLE RADM.BBG_RA_SLS_MBA_DY_A AS
  SELECT T.DT_WID,
         T.A_PROD_NUM,
         T.A_PROD_NAME,
         T.B_PROD_NUM,
         T.B_PROD_NAME,
         SUM(T.A_CNT) A_CNT,
         SUM(T.B_CNT) B_CNT,
         SUM(T.AB_CNT) AB_CNT,
         SUM(T.LOC_CNT) LOC_CNT
    FROM RABATCHER.BBG_RA_SLS_MBA_LC_DY_TMP T
   GROUP BY T.DT_WID,
            T.A_PROD_NUM,
            T.A_PROD_NAME,
            T.B_PROD_NUM,
            T.B_PROD_NAME;
--sequence
create sequence BBG_RA_SLS_MBA_DY_A_SEQ minvalue 1 maxvalue 9999999999999999999999999999 start
  with 1 increment by 1 cache 20;

--ODI
--interface1:source：RABATCHER.BBG_RA_SLS_MBA_LC_DY_FV           target:RABATCHER.BBG_RA_SLS_MBA_LC_DY_TMP   done
--interface2:source：RABATCHER.BBG_RA_SLS_MBA_LC_DY_TMP          target:RADM.BBG_RA_SLS_MBA_LC_DY_A          done
--interface3:source：RABATCHER.BBG_RA_SLS_MBA_LC_DY_TMP          target:RADM.BBG_RA_SLS_MBA_DY_A             done

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

SELECT *
  FROM RADM.W_LOCALIZED_STRING_G T
 WHERE T.MSG_NUM LIKE '%Retail_As-Was_BBG_VIP_RFM_Analysis'
   FOR UPDATE;

--***************************************************************************************************************
--历史数据补入
--数据从2016.1.1开始
--***************************************************************************************************************
--BBG_RA_SLS_MBA_LC_DY_TMP
/* DETECTION_STRATEGY = NOT_EXISTS */
insert into RABATCHER.BBG_RA_SLS_MBA_LC_DY_TMP T
  (DT_WID,
   ORG_WID,
   ORG_DH_WID,
   ORG_SCD1_WID,
   A_PROD_NUM,
   A_PROD_NAME,
   B_PROD_NUM,
   B_PROD_NAME,
   A_CNT,
   B_CNT,
   AB_CNT,
   LOC_CNT)
  select BBG_RA_SLS_MBA_LC_DY_FV.DT_WID,
         BBG_RA_SLS_MBA_LC_DY_FV.ORG_WID,
         BBG_RA_SLS_MBA_LC_DY_FV.ORG_DH_WID,
         BBG_RA_SLS_MBA_LC_DY_FV.ORG_SCD1_WID,
         BBG_RA_SLS_MBA_LC_DY_FV.A_PROD_NUM,
         BBG_RA_SLS_MBA_LC_DY_FV.A_PROD_NAME,
         BBG_RA_SLS_MBA_LC_DY_FV.B_PROD_NUM,
         BBG_RA_SLS_MBA_LC_DY_FV.B_PROD_NAME,
         BBG_RA_SLS_MBA_LC_DY_FV.A_CNT,
         BBG_RA_SLS_MBA_LC_DY_FV.B_CNT,
         BBG_RA_SLS_MBA_LC_DY_FV.AB_CNT,
         BBG_RA_SLS_MBA_LC_DY_FV.LOC_CNT
    from RABATCHER.BBG_RA_SLS_MBA_LC_DY_FV BBG_RA_SLS_MBA_LC_DY_FV
   where (1 = 1)
     And (BBG_RA_SLS_MBA_LC_DY_FV.DT_WID BETWEEN &B_DTWID AND &E_DTWID);
COMMIT;
--BBG_RA_SLS_MBA_LC_DY_A
merge /*+ APPEND */
into RADM.BBG_RA_SLS_MBA_LC_DY_A T
using (Select /*+ APPEND */
        BBG_RA_SLS_MBA_LC_DY_TMP.DT_WID DT_WID,
        BBG_RA_SLS_MBA_LC_DY_TMP.ORG_WID ORG_WID,
        BBG_RA_SLS_MBA_LC_DY_TMP.ORG_DH_WID ORG_DH_WID,
        BBG_RA_SLS_MBA_LC_DY_TMP.ORG_SCD1_WID ORG_SCD1_WID,
        BBG_RA_SLS_MBA_LC_DY_TMP.A_PROD_NUM A_PROD_NUM,
        BBG_RA_SLS_MBA_LC_DY_TMP.A_PROD_NAME A_PROD_NAME,
        BBG_RA_SLS_MBA_LC_DY_TMP.B_PROD_NUM B_PROD_NUM,
        BBG_RA_SLS_MBA_LC_DY_TMP.B_PROD_NAME B_PROD_NAME,
        BBG_RA_SLS_MBA_LC_DY_TMP.A_CNT A_CNT,
        BBG_RA_SLS_MBA_LC_DY_TMP.B_CNT B_CNT,
        BBG_RA_SLS_MBA_LC_DY_TMP.AB_CNT AB_CNT,
        BBG_RA_SLS_MBA_LC_DY_TMP.LOC_CNT LOC_CNT,
        SYSDATE W_INSERT_DT,
        SYSDATE W_UPDATE_DT,
        BBG_RA_SLS_MBA_LC_DY_TMP.DT_WID || '~' ||
        BBG_RA_SLS_MBA_LC_DY_TMP.ORG_WID || '~' ||
        BBG_RA_SLS_MBA_LC_DY_TMP.A_PROD_NUM || '~' ||
        BBG_RA_SLS_MBA_LC_DY_TMP.B_PROD_NUM INTEGRATION_ID,
        '1' DATASOURCE_NUM_ID
         From RABATCHER.BBG_RA_SLS_MBA_LC_DY_TMP BBG_RA_SLS_MBA_LC_DY_TMP
        Where (1 = 1)) S
on (T.DT_WID = S.DT_WID and T.ORG_WID = S.ORG_WID and T.A_PROD_NUM = S.A_PROD_NUM and T.B_PROD_NUM = S.B_PROD_NUM)
when matched then
  update
     set T.A_PROD_NAME       = S.A_PROD_NAME,
         T.B_PROD_NAME       = S.B_PROD_NAME,
         T.A_CNT             = S.A_CNT,
         T.B_CNT             = S.B_CNT,
         T.AB_CNT            = S.AB_CNT,
         T.LOC_CNT           = S.LOC_CNT,
         T.W_UPDATE_DT       = S.W_UPDATE_DT,
         T.INTEGRATION_ID    = S.INTEGRATION_ID,
         T.DATASOURCE_NUM_ID = S.DATASOURCE_NUM_ID
when not matched then
  insert
    (T.ROW_WID,
     T.DT_WID,
     T.ORG_WID,
     T.ORG_DH_WID,
     T.ORG_SCD1_WID,
     T.A_PROD_NUM,
     T.A_PROD_NAME,
     T.B_PROD_NUM,
     T.B_PROD_NAME,
     T.A_CNT,
     T.B_CNT,
     T.AB_CNT,
     T.LOC_CNT,
     T.W_INSERT_DT,
     T.W_UPDATE_DT,
     T.INTEGRATION_ID,
     T.DATASOURCE_NUM_ID)
  values
    (RADM.BBG_RA_SLS_MBA_LC_DY_A_SEQ.nextval,
     S.DT_WID,
     S.ORG_WID,
     S.ORG_DH_WID,
     S.ORG_SCD1_WID,
     S.A_PROD_NUM,
     S.A_PROD_NAME,
     S.B_PROD_NUM,
     S.B_PROD_NAME,
     S.A_CNT,
     S.B_CNT,
     S.AB_CNT,
     S.LOC_CNT,
     S.W_INSERT_DT,
     S.W_UPDATE_DT,
     S.INTEGRATION_ID,
     S.DATASOURCE_NUM_ID);
COMMIT;
--BBG_RA_SLS_MBA_DY_A
merge /*+ APPEND */
into RADM.BBG_RA_SLS_MBA_DY_A T
using (Select /*+ APPEND */
        BBG_RA_SLS_MBA_LC_DY_TMP.DT_WID DT_WID,
        BBG_RA_SLS_MBA_LC_DY_TMP.A_PROD_NUM A_PROD_NUM,
        BBG_RA_SLS_MBA_LC_DY_TMP.A_PROD_NAME A_PROD_NAME,
        BBG_RA_SLS_MBA_LC_DY_TMP.B_PROD_NUM B_PROD_NUM,
        BBG_RA_SLS_MBA_LC_DY_TMP.B_PROD_NAME B_PROD_NAME,
        SUM(BBG_RA_SLS_MBA_LC_DY_TMP.A_CNT) A_CNT,
        SUM(BBG_RA_SLS_MBA_LC_DY_TMP.B_CNT) B_CNT,
        SUM(BBG_RA_SLS_MBA_LC_DY_TMP.AB_CNT) AB_CNT,
        SUM(BBG_RA_SLS_MBA_LC_DY_TMP.LOC_CNT) LOC_CNT,
        SYSDATE W_INSERT_DT,
        SYSDATE W_UPDATE_DT,
        BBG_RA_SLS_MBA_LC_DY_TMP.DT_WID || '~' ||
        BBG_RA_SLS_MBA_LC_DY_TMP.A_PROD_NUM || '~' ||
        BBG_RA_SLS_MBA_LC_DY_TMP.B_PROD_NUM INTEGRATION,
        1 DATASOURCE_NUM_ID
         From RABATCHER.BBG_RA_SLS_MBA_LC_DY_TMP BBG_RA_SLS_MBA_LC_DY_TMP
        Where (1 = 1)
        Group By BBG_RA_SLS_MBA_LC_DY_TMP.DT_WID,
                 BBG_RA_SLS_MBA_LC_DY_TMP.A_PROD_NUM,
                 BBG_RA_SLS_MBA_LC_DY_TMP.A_PROD_NAME,
                 BBG_RA_SLS_MBA_LC_DY_TMP.B_PROD_NUM,
                 BBG_RA_SLS_MBA_LC_DY_TMP.B_PROD_NAME,
                 BBG_RA_SLS_MBA_LC_DY_TMP.DT_WID || '~' ||
                 BBG_RA_SLS_MBA_LC_DY_TMP.A_PROD_NUM || '~' ||
                 BBG_RA_SLS_MBA_LC_DY_TMP.B_PROD_NUM
       ) S
on (T.DT_WID = S.DT_WID and T.A_PROD_NUM = S.A_PROD_NUM and T.B_PROD_NUM = S.B_PROD_NUM)
when matched then
  update
     set T.A_CNT       = S.A_CNT,
         T.B_CNT       = S.B_CNT,
         T.AB_CNT      = S.AB_CNT,
         T.LOC_CNT     = S.LOC_CNT,
         T.W_UPDATE_DT = S.W_UPDATE_DT
when not matched then
  insert
    (
     T.ROW_WID,
     T.DT_WID,
     T.A_PROD_NUM,
     T.A_PROD_NAME,
     T.B_PROD_NUM,
     T.B_PROD_NAME,
     T.A_CNT,
     T.B_CNT,
     T.AB_CNT,
     T.LOC_CNT,
     T.W_INSERT_DT,
     T.W_UPDATE_DT,
     T.INTEGRATION,
     T.DATASOURCE_NUM_ID
     )
  values
    (
     RADM.BBG_RA_SLS_MBA_DY_A_SEQ.nextval,
     S.DT_WID,
     S.A_PROD_NUM,
     S.A_PROD_NAME,
     S.B_PROD_NUM,
     S.B_PROD_NAME,
     S.A_CNT,
     S.B_CNT,
     S.AB_CNT,
     S.LOC_CNT,
     S.W_INSERT_DT,
     S.W_UPDATE_DT,
     S.INTEGRATION,
     S.DATASOURCE_NUM_ID
     );
COMMIT;
