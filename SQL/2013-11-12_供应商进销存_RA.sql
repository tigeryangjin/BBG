/*[2013-11-12T19:02:31.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-0] [] [ecid: 117010e66f1dee37:42802f3e:141a84af92c:-8000-0000000000b4d8cf] [tid: 4580a940] [requestid: 7d320001] [sessionid: 7d320000] [username: RAADMIN] ############################################## [[
-------------------- SQL Request, logical request hash:
6a2f513c
SET VARIABLE QUERY_SRC_CD='Report',SAW_SRC_PATH='/users/raadmin/YJ/äŸåºåè¿éå­æ¥è¡š';*/
/*SELECT
   0 s_0,
   "Retail As-Was"."Gregorian Calendar"."Month" s_1,
   "Retail As-Was"."Item As Was"."BBG Item Brand" s_2,
   "Retail As-Was"."Item As Was"."Item Name" s_3,
   "Retail As-Was"."Item As Was"."Item Number" s_4,
   "Retail As-Was"."Organization As Was"."Loc Name" s_5,
   "Retail As-Was"."Organization As Was"."Loc Number" s_6,
   SORTKEY("Retail As-Was"."Item As Was"."Item Name") s_7,
   "Retail As-Was"."BBG Supplier Inventory Position"."EOH Cost" s_8,
   "Retail As-Was"."BBG Supplier Inventory Position"."EOH Qty" s_9,
   "Retail As-Was"."BBG Supplier Sales"."Sales Amt" s_10,
   "Retail As-Was"."BBG Supplier Sales"."Sales Amt"-"Retail As-Was"."BBG Supplier Sales"."Sales Cost" s_11,
   "Retail As-Was"."BBG Supplier Sales"."Sales Qty" s_12,
   "Retail As-Was"."Supplier Compliance"."Ordered Amount" s_13,
   "Retail As-Was"."Supplier Compliance"."Ordered Qty" s_14,
   "Retail As-Was"."Supplier Compliance"."Received Amount" s_15,
   "Retail As-Was"."Supplier Compliance"."Received Qty" s_16
FROM "Retail As-Was"
WHERE
(("Supplier"."Supplier Number" = '29000580') AND ("Gregorian Calendar"."Month" IN ('2013 / 05', '2013 / 06', '2013 / 07', '2013 / 08', '2013 / 09', '2013 / 10')))
ORDER BY 1, 5 ASC NULLS LAST, 8 ASC NULLS LAST, 3 ASC NULLS LAST, 2 ASC NULLS LAST, 7 ASC NULLS LAST, 6 ASC NULLS LAST
FETCH FIRST 10000000 ROWS ONLY


]]
[2013-11-12T19:02:31.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-23] [] [ecid: 117010e66f1dee37:42802f3e:141a84af92c:-8000-0000000000b4d8cf] [tid: 4580a940] [requestid: 7d320001] [sessionid: 7d320000] [username: RAADMIN] -------------------- General Query Info: [[
Repository: Star, Subject Area: RA, Presentation: Retail As-Was

]]
[2013-11-12T19:02:31.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-21] [] [ecid: 117010e66f1dee37:42802f3e:141a84af92c:-8000-0000000000b4d8cf] [tid: 4580a940] [requestid: 7d320001] [sessionid: 7d320000] [username: RAADMIN] -------------------- Cache Hit on query: [[
Matching Query:  
RqList 
    Received Qty:[DAggr(Fact - Retail Supplier Compliance.Received Qty by [ Dim - Item.Product Key, Dim â Retail Organization As Was.ROW_WID, Dim â Retail Organization As Was.Loc Number, Dim â Retail Organization As Was.Loc, Dim - Item.Item Number, Dim - Item.Item, Dim - Date Retail Gregorian Calendar.Month, Dim - Date Retail Gregorian Calendar.Month Wid, Dim - Item.BBG Item Brand] )] as c1,
    Received Amount:[DAggr(Fact - Retail Supplier Compliance.Received Amount by [ Dim - Item.Product Key, Dim â Retail Organization As Was.ROW_WID, Dim â Retail Organization As Was.Loc Number, Dim â Retail Organization As Was.Loc, Dim - Item.Item Number, Dim - Item.Item, Dim - Date Retail Gregorian Calendar.Month, Dim - Date Retail Gregorian Calendar.Month Wid, Dim - Item.BBG Item Brand] )] as c2,
    Ordered Qty:[DAggr(Fact - Retail Supplier Compliance.Ordered Qty by [ Dim - Item.Product Key, Dim â Retail Organization As Was.ROW_WID, Dim â Retail Organization As Was.Loc Number, Dim â Retail Organization As Was.Loc, Dim - Item.Item Number, Dim - Item.Item, Dim - Date Retail Gregorian Calendar.Month, Dim - Date Retail Gregorian Calendar.Month Wid, Dim - Item.BBG Item Brand] )] as c3,
    Ordered Amount:[DAggr(Fact - Retail Supplier Compliance.Ordered Amount by [ Dim - Item.Product Key, Dim â Retail Organization As Was.ROW_WID, Dim â Retail Organization As Was.Loc Number, Dim â Retail Organization As Was.Loc, Dim - Item.Item Number, Dim - Item.Item, Dim - Date Retail Gregorian Calendar.Month, Dim - Date Retail Gregorian Calendar.Month Wid, Dim - Item.BBG Item Brand] )] as c4,
    Dim - Date Retail Gregorian Calendar.Month as c5,
    Dim - Item.BBG Item Brand as c6,
    Dim - Item.Item as c7,
    Dim - Item.Item Number as c8,
    Dim â Retail Organization As Was.Loc as c9,
    Dim â Retail Organization As Was.Loc Number as c10,
    Dim â Retail Organization As Was.ROW_WID as c11,
    Dim - Item.Product Key as c12,
    Dim - Date Retail Gregorian Calendar.Month Wid as c13
DetailFilter: Dim - Supplier.Supplier Number = '29000580' and (Dim - Date Retail Gregorian Calendar.Month = '2013 / 05' or Dim - Date Retail Gregorian Calendar.Month = '2013 / 06' or Dim - Date Retail Gregorian Calendar.Month = '2013 / 07' or Dim - Date Retail Gregorian Calendar.Month = '2013 / 08' or Dim - Date Retail Gregorian Calendar.Month = '2013 / 09' or Dim - Date Retail Gregorian Calendar.Month = '2013 / 10')
Created by:  RAADMIN

]]
[2013-11-12T19:02:31.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-18] [] [ecid: 117010e66f1dee37:42802f3e:141a84af92c:-8000-0000000000b4d8cf] [tid: 4580a940] [requestid: 7d320001] [sessionid: 7d320000] [username: RAADMIN] -------------------- Sending query to database named BBG_ANALIZE (id: <<543561>>), connection pool named Oracle Data Warehouse Connection Pool, logical request hash 6a2f513c, physical request hash 66ad0039: [[
*/
select D1.c3 as 月份,
       
     D1.c8 as 地点编码,
		 D1.c7 as 地点名称,
		 D1.c6 as 商品编码,
		 D1.c5 as 商品名称,
		 D1.c4 as 品牌,
     D1.c1 as 库数量,
     D1.c2 as 库存成本
     
     
     
     
     /*,
     D1.c9 as c9,
     D1.c10 as c10,
     D1.c11 as c11*/
from 
     (select sum(D1.c1) over (partition by D1.c10, D1.c9, D1.c11)  as c1,
               sum(D1.c2) over (partition by D1.c10, D1.c9, D1.c11)  as c2,
               D1.c3 as c3,
               D1.c4 as c4,
               D1.c5 as c5,
               D1.c6 as c6,
               D1.c7 as c7,
               D1.c8 as c8,
               D1.c9 as c9,
               D1.c10 as c10,
               D1.c11 as c11,
               ROW_NUMBER() OVER (PARTITION BY D1.c9, D1.c10, D1.c11 ORDER BY D1.c9 ASC, D1.c10 ASC, D1.c11 ASC) as c12
          from 
               (select sum(case D1.c16 when 1 then D1.c12 else NULL end ) as c1,
                         sum(case D1.c16 when 1 then D1.c17 else NULL end ) as c2,
                         D1.c3 as c3,
                         D1.c4 as c4,
                         D1.c5 as c5,
                         D1.c6 as c6,
                         D1.c7 as c7,
                         D1.c8 as c8,
                         D1.c9 as c9,
                         D1.c10 as c10,
                         D1.c11 as c11
                    from 
                         (select D1.c3 as c3,
                                   D1.c4 as c4,
                                   D1.c5 as c5,
                                   D1.c6 as c6,
                                   D1.c7 as c7,
                                   D1.c8 as c8,
                                   D1.c9 as c9,
                                   D1.c10 as c10,
                                   D1.c11 as c11,
                                   D1.c12 as c12,
                                   D1.c14 as c13,
                                   D1.c15 as c14,
                                   D1.c16 as c15,
                                   ROW_NUMBER() OVER (PARTITION BY D1.c10, D1.c9, D1.c11, D1.c14, D1.c15, D1.c16 ORDER BY D1.c10 DESC, D1.c9 DESC, D1.c11 DESC, D1.c14 DESC, D1.c15 DESC, D1.c16 DESC) as c16,
                                   D1.c13 as c17
                              from 
                                   (select distinct T960506.PER_NAME_MONTH as c3,
                                             T14449.BBG_ITEM_BRAND as c4,
                                             T18745.PRODUCT_NAME as c5,
                                             T14449.PROD_NUM as c6,
                                             T953980.ORG_NAME as c7,
                                             cast(T964463.ORG_NUM as  INTEGER  ) as c8,
                                             T964463.ROW_WID as c9,
                                             T14449.ROW_WID as c10,
                                             T960506.CAL_MONTH_WID as c11,
                                             LAST_VALUE(T1010716.SUPP_INV_QTY) OVER (PARTITION BY T14449.ROW_WID, T954755.ROW_WID, T964463.ROW_WID, T1009437.ROW_WID, T1010474.ROW_WID, T960506.CAL_MONTH_WID ORDER BY NVL2(T1010716.SUPP_INV_QTY, 1, 0) , T14449.ROW_WID NULLS FIRST, T954755.ROW_WID NULLS FIRST, T964463.ROW_WID NULLS FIRST, T1009437.ROW_WID NULLS FIRST, T1010474.ROW_WID NULLS FIRST, T960506.CAL_MONTH_WID NULLS FIRST, T960506.ROW_WID NULLS FIRST ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as c12,
                                             LAST_VALUE(T1010716.SUPP_INV_COST) OVER (PARTITION BY T14449.ROW_WID, T954755.ROW_WID, T964463.ROW_WID, T1009437.ROW_WID, T1010474.ROW_WID, T960506.CAL_MONTH_WID ORDER BY NVL2(T1010716.SUPP_INV_COST, 1, 0) , T14449.ROW_WID NULLS FIRST, T954755.ROW_WID NULLS FIRST, T964463.ROW_WID NULLS FIRST, T1009437.ROW_WID NULLS FIRST, T1010474.ROW_WID NULLS FIRST, T960506.CAL_MONTH_WID NULLS FIRST, T960506.ROW_WID NULLS FIRST ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as c13,
                                             T954755.ROW_WID as c14,
                                             T1009437.ROW_WID as c15,
                                             T1010474.ROW_WID as c16
                                        from 
                                             BBG_RA_ITEM_LOC_SUPP_D T1010474 /* Dim_BBG_RA_ITEM_LOC_SUPP_D */ ,
                                             BBG_RA_ITEM_LOC_D T1009437 /* Dim_BBG_ITEM_LOC */ ,
                                             (SELECT
  DATASOURCE_NUM_ID,
  INTEGRATION_ID,
  ORG_DESCR,
  ORG_NAME,
  LANGUAGE_CODE

FROM 
  W_INT_ORG_D_TL

WHERE
  LANGUAGE_CODE = 'ZHS') T953980,
                                             W_INT_ORG_DH T964333 /* Dim_W_INT_ORG_DH_Retail_As_Was */ ,
                                             W_INT_ORG_D T964463 /* Dim_W_INT_ORG_D_Retail_As_Was */ ,
                                             W_MCAL_DAY_DV T960506 /* Dim_W_MCAL_DAY_D_Retail_Gregorian_Calendar */ ,
                                             W_PARTY_ORG_D T954755 /* Dim_W_PARTY_ORG_D_Retail_Supplier */ ,
                                             (SELECT T.*
  FROM W_PRODUCT_D T, W_PRODUCT_ATTR_D A
 WHERE T.SCD1_WID = A.SCD1_WID
   AND A.PRODUCT_ATTR12_NAME = A.PRODUCT_ATTR11_NAME) T14449,
                                             (SELECT DATASOURCE_NUM_ID,
       INTEGRATION_ID,
       PRODUCT_DESCR,
       PRODUCT_NAME,
       LANGUAGE_CODE
  FROM W_PRODUCT_D_TL
 WHERE LANGUAGE_CODE = 'ZHS') T18745,
                                             BBG_RA_SUPP_INV_IT_LC_DY_FV T1010716 /* Fact_BBG_RA_SUPP_INV_IT_LC_DY_F */ 
where  ( T1009437.ROW_WID = T1010716.BBG_ITEM_LOC_WID 
     and T953980.DATASOURCE_NUM_ID = T964463.DATASOURCE_NUM_ID 
		 and T953980.INTEGRATION_ID = T964463.INTEGRATION_ID 
		 and T964463.ROW_WID = T1010716.ORG_WID 
		 and T960506.ROW_WID = T1010716.DT_WID 
		 and T954755.ROW_WID = T1010716.SUPPLIER_WID 
		 and T14449.DATASOURCE_NUM_ID = T18745.DATASOURCE_NUM_ID 
		 and T14449.INTEGRATION_ID = T18745.INTEGRATION_ID 
		 and T14449.ROW_WID = T1010716.PROD_WID 
		 and T954755.SUPPLIER_NUM = '29000580' 
		 and T960506.MCAL_CAL_WID = 1.0 
		 and T1010474.CURRENT_FLG = 'Y' 
		 and T1010474.ROW_WID = T1010716.BBG_ITEM_LOC_SUPP_WID 
		 and T964333.ROW_WID = T1010716.ORG_DH_WID 
		 and T964333.SCD1_WID = T964463.SCD1_WID 
		 and '2010' < T960506.CAL_YEAR 
		 and (T960506.PER_NAME_MONTH in ('2013 / 05', '2013 / 06', '2013 / 07', '2013 / 08', '2013 / 09', '2013 / 10')) ) 
                                   ) D1
                         ) D1
                    group by D1.c3, D1.c4, D1.c5, D1.c6, D1.c7, D1.c8, D1.c9, D1.c10, D1.c11
               ) D1
     ) D1
where  ( D1.c12 = 1 ) ;

/*]]
[2013-11-12T19:02:31.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-18] [] [ecid: 117010e66f1dee37:42802f3e:141a84af92c:-8000-0000000000b4d8cf] [tid: 4580a940] [requestid: 7d320001] [sessionid: 7d320000] [username: RAADMIN] -------------------- Sending query to database named BBG_ANALIZE (id: <<544146>>), connection pool named Oracle Data Warehouse Connection Pool, logical request hash 6a2f513c, physical request hash 132562ab: [[*/

select D1.c4 as 月份,
       D1.c9 as 地点编码,
       D1.c8 as 地点名称,
			 D1.c7 as 商品编码,
			 D1.c6 as 商品名称,
			 D1.c5 as 品牌,     
		 D1.c1 as 销售数量,
     D1.c2 as 销售成本,
     D1.c3 as 销售金额/*,
     D1.c10 as c10,
     D1.c11 as c11,
     D1.c12 as c12*/
from 
     (select sum(T1013925.SUPP_SALES_QTY) as c1,
               sum(T1013925.SUPP_SALES_COST) as c2,
               sum(T1013925.SUPP_SALES_AMT) as c3,
               T960506.PER_NAME_MONTH as c4,
               T14449.BBG_ITEM_BRAND as c5,
               T18745.PRODUCT_NAME as c6,
               T14449.PROD_NUM as c7,
               T953980.ORG_NAME as c8,
               cast(T964463.ORG_NUM as  INTEGER  ) as c9,
               T964463.ROW_WID as c10,
               T14449.ROW_WID as c11,
               T960506.CAL_MONTH_WID as c12,
               ROW_NUMBER() OVER (PARTITION BY T14449.ROW_WID, T960506.CAL_MONTH_WID, T964463.ROW_WID ORDER BY T14449.ROW_WID ASC, T960506.CAL_MONTH_WID ASC, T964463.ROW_WID ASC) as c13
          from 
               (SELECT
  DATASOURCE_NUM_ID,
  INTEGRATION_ID,
  ORG_DESCR,
  ORG_NAME,
  LANGUAGE_CODE

FROM 
  W_INT_ORG_D_TL

WHERE
  LANGUAGE_CODE = 'ZHS') T953980,
               W_INT_ORG_DH T964333 /* Dim_W_INT_ORG_DH_Retail_As_Was */ ,
               W_INT_ORG_D T964463 /* Dim_W_INT_ORG_D_Retail_As_Was */ ,
               W_MCAL_DAY_DV T960506 /* Dim_W_MCAL_DAY_D_Retail_Gregorian_Calendar */ ,
               W_PARTY_ORG_D T954755 /* Dim_W_PARTY_ORG_D_Retail_Supplier */ ,
               (SELECT T.*
  FROM W_PRODUCT_D T, W_PRODUCT_ATTR_D A
 WHERE T.SCD1_WID = A.SCD1_WID
   AND A.PRODUCT_ATTR12_NAME = A.PRODUCT_ATTR11_NAME) T14449,
               (SELECT DATASOURCE_NUM_ID,
       INTEGRATION_ID,
       PRODUCT_DESCR,
       PRODUCT_NAME,
       LANGUAGE_CODE
  FROM W_PRODUCT_D_TL
 WHERE LANGUAGE_CODE = 'ZHS') T18745,
               BBG_RA_SLS_IT_LC_DY_A T1013925 /* Fact_BBG_RA_SLS_IT_LC_DY_A */ 
where  ( T953980.DATASOURCE_NUM_ID = T964463.DATASOURCE_NUM_ID 
     and T953980.INTEGRATION_ID = T964463.INTEGRATION_ID 
		 and T960506.ROW_WID = T1013925.DT_WID 
		 and T954755.ROW_WID = T1013925.SUPPLIER_WID 
		 and T14449.DATASOURCE_NUM_ID = T18745.DATASOURCE_NUM_ID 
		 and T14449.INTEGRATION_ID = T18745.INTEGRATION_ID 
		 and T14449.ROW_WID = T1013925.PROD_WID 
		 and T954755.SUPPLIER_NUM = '29000580' 
		 and T960506.MCAL_CAL_WID = 1.0 
		 and T964463.ROW_WID = T1013925.ORG_WID 
		 and T964333.ROW_WID = T1013925.ORG_DH_WID 
		 and T964333.SCD1_WID = T964463.SCD1_WID 
		 and '2010' < T960506.CAL_YEAR 
		 and (T960506.PER_NAME_MONTH in ('2013 / 05', '2013 / 06', '2013 / 07', '2013 / 08', '2013 / 09', '2013 / 10')) ) 
group by T14449.ROW_WID, T14449.PROD_NUM, T14449.BBG_ITEM_BRAND, T18745.PRODUCT_NAME, T953980.ORG_NAME, T960506.CAL_MONTH_WID, T960506.PER_NAME_MONTH, T964463.ROW_WID, cast(T964463.ORG_NUM as  INTEGER  )
     ) D1
where  ( D1.c13 = 1 ) ;

/*]]*/
