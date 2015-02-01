select distinct 0 as c1,
                D1.c3 as 日期,
                D1.c7 as 门店编码,
                D1.c6 as 门店名称,
                D1.c5 as 商品编码,
                D1.c4 as 商品名称,
                D1.c9 as 供应商编码,  
                D1.c8 as 供应商名称,
                D1.c2 as 库存成本,
                D1.c1 as 库存数量
from 
     (select    sum(T1010716.SUPP_INV_QTY) as c1,
                sum(T1010716.SUPP_INV_COST) as c2,
                TRUNC(T960506.MCAL_DAY_DT) as c3,
                T18745.PRODUCT_NAME as c4,
                T14449.PROD_NUM as c5,
                T953980.ORG_NAME as c6,
                cast(T964463.ORG_NUM as  INTEGER  ) as c7,
                T954755.ORG_NAME as c8,
                T954755.SUPPLIER_NUM as c9,
                T964463.ROW_WID as c10,
                T14449.ROW_WID as c11,
                T954755.ROW_WID as c12,
                T960506.ROW_WID as c13
        from 
               (SELECT
                        DATASOURCE_NUM_ID,
                        INTEGRATION_ID,
                        ORG_DESCR,
                        ORG_NAME,
                        LANGUAGE_CODE
                  FROM  W_INT_ORG_D_TL
                  WHERE LANGUAGE_CODE = 'ZHS'
              ) T953980,/*门店名称*/
               W_INT_ORG_DH T964333 /* Dim_W_INT_ORG_DH_Retail_As_Was */ ,
               W_INT_ORG_D T964463 /* Dim_W_INT_ORG_D_Retail_As_Was */ ,
               W_MCAL_DAY_DV T960506 /* Dim_W_MCAL_DAY_D_Retail_Gregorian_Calendar */ ,
               W_PARTY_ORG_D T954755 /* Dim_W_PARTY_ORG_D_Retail_Supplier */ ,
               (SELECT T.*
                  FROM  W_PRODUCT_D T, W_PRODUCT_ATTR_D A
                  WHERE T.SCD1_WID = A.SCD1_WID
                        AND A.PRODUCT_ATTR12_NAME = A.PRODUCT_ATTR11_NAME
              ) T14449,/*商品编码*/
               (SELECT  DATASOURCE_NUM_ID,
                        INTEGRATION_ID,
                        PRODUCT_DESCR,
                        PRODUCT_NAME,
                        LANGUAGE_CODE
                  FROM  W_PRODUCT_D_TL
                  WHERE LANGUAGE_CODE = 'ZHS'
                ) T18745,/*商品名称*/
               BBG_RA_SUPP_INV_IT_LC_DY_FV T1010716 /* Fact_BBG_RA_SUPP_INV_IT_LC_DY_F */ 
         where  ( 
                 T953980.DATASOURCE_NUM_ID    = T964463.DATASOURCE_NUM_ID 
                 and T953980.INTEGRATION_ID   = T964463.INTEGRATION_ID 
                 and T960506.ROW_WID          = T1010716.DT_WID 
                 and T954755.ROW_WID          = T1010716.SUPPLIER_WID 
                 and T14449.DATASOURCE_NUM_ID = T18745.DATASOURCE_NUM_ID 
                 and T14449.INTEGRATION_ID    = T18745.INTEGRATION_ID 
                 and T14449.ROW_WID           = T1010716.PROD_WID 
                 and T960506.MCAL_CAL_WID     = 1.0 
                 and T964463.ROW_WID          = T1010716.ORG_WID 
                 and cast(T964463.ORG_NUM as  INTEGER  ) = 120001 /*门店编码条件*/
                 and TRUNC(T960506.MCAL_DAY_DT)=TO_DATE('2013-10-31','YYYY-MM-DD') /*日期条件*/ 
                 and T964333.ROW_WID = T1010716.ORG_DH_WID 
                 and T964333.SCD1_WID = T964463.SCD1_WID and '2010' < T960506.CAL_YEAR ) 
          group by T14449.ROW_WID, 
                   T14449.PROD_NUM, 
                   T18745.PRODUCT_NAME, 
                   T953980.ORG_NAME, 
                   T954755.ROW_WID, 
                   T954755.ORG_NAME, 
                   T954755.SUPPLIER_NUM, 
                   T960506.ROW_WID, 
                   T964463.ROW_WID, 
                   cast(T964463.ORG_NUM as  INTEGER  ),  
                   TRUNC(T960506.MCAL_DAY_DT)
     ) D1
order by c2, c4, c6, c5, c8, c7;




	 
	 
--RA跟踪语句
select distinct 0 as c1,
                D1.c3 as c2,
                D1.c4 as c3,
                D1.c5 as c4,
                D1.c6 as c5,
                D1.c7 as c6,
                D1.c8 as c7,
                D1.c9 as c8,
                D1.c5 as c9,
                D1.c2 as c10,
                D1.c1 as c11,
                D1.c10 as c12,
                D1.c11 as c13,
                D1.c12 as c14,
                D1.c13 as c15
from 
     (select    sum(T1010716.SUPP_INV_QTY) as c1,
                sum(T1010716.SUPP_INV_COST) as c2,
                TRUNC(T960506.MCAL_DAY_DT) as c3,
                T18745.PRODUCT_NAME as c4,
                T14449.PROD_NUM as c5,
                T953980.ORG_NAME as c6,
                cast(T964463.ORG_NUM as  INTEGER  ) as c7,
                T954755.ORG_NAME as c8,
                T954755.SUPPLIER_NUM as c9,
                T964463.ROW_WID as c10,
                T14449.ROW_WID as c11,
                T954755.ROW_WID as c12,
                T960506.ROW_WID as c13
        from 
               (SELECT
                        DATASOURCE_NUM_ID,
                        INTEGRATION_ID,
                        ORG_DESCR,
                        ORG_NAME,
                        LANGUAGE_CODE
                  FROM  W_INT_ORG_D_TL
                  WHERE LANGUAGE_CODE = 'ZHS'
							) T953980,
               W_INT_ORG_DH T964333 /* Dim_W_INT_ORG_DH_Retail_As_Was */ ,
               W_INT_ORG_D T964463 /* Dim_W_INT_ORG_D_Retail_As_Was */ ,
               W_MCAL_DAY_DV T960506 /* Dim_W_MCAL_DAY_D_Retail_Gregorian_Calendar */ ,
               W_PARTY_ORG_D T954755 /* Dim_W_PARTY_ORG_D_Retail_Supplier */ ,
               (SELECT T.*
                  FROM  W_PRODUCT_D T, W_PRODUCT_ATTR_D A
                  WHERE T.SCD1_WID = A.SCD1_WID
                        AND A.PRODUCT_ATTR12_NAME = A.PRODUCT_ATTR11_NAME
							) T14449,
               (SELECT  DATASOURCE_NUM_ID,
                        INTEGRATION_ID,
                        PRODUCT_DESCR,
                        PRODUCT_NAME,
                        LANGUAGE_CODE
                  FROM  W_PRODUCT_D_TL
                  WHERE LANGUAGE_CODE = 'ZHS'
								) T18745,
               BBG_RA_SUPP_INV_IT_LC_DY_FV T1010716 /* Fact_BBG_RA_SUPP_INV_IT_LC_DY_F */ 
         where  ( 
				         T953980.DATASOURCE_NUM_ID = T964463.DATASOURCE_NUM_ID 
								 and T953980.INTEGRATION_ID = T964463.INTEGRATION_ID 
								 and T960506.ROW_WID = T1010716.DT_WID 
								 and T954755.ROW_WID = T1010716.SUPPLIER_WID 
								 and T14449.DATASOURCE_NUM_ID = T18745.DATASOURCE_NUM_ID 
								 and T14449.INTEGRATION_ID = T18745.INTEGRATION_ID 
								 and T14449.ROW_WID = T1010716.PROD_WID 
								 and T960506.MCAL_CAL_WID = 1.0 
								 and T964463.ROW_WID = T1010716.ORG_WID 
								 and cast(T964463.ORG_NUM as  INTEGER  ) = 120001 
								 and  TRUNC(T960506.MCAL_DAY_DT) = TO_DATE('2013-10-31' , 'YYYY-MM-DD') 
								 and T964333.ROW_WID = T1010716.ORG_DH_WID 
								 and T964333.SCD1_WID = T964463.SCD1_WID and '2010' < T960506.CAL_YEAR ) 
          group by T14449.ROW_WID, 
					         T14449.PROD_NUM, 
									 T18745.PRODUCT_NAME, 
									 T953980.ORG_NAME, 
									 T954755.ROW_WID, 
									 T954755.ORG_NAME, 
									 T954755.SUPPLIER_NUM, 
									 T960506.ROW_WID, 
									 T964463.ROW_WID, 
									 cast(T964463.ORG_NUM as  INTEGER  ),  
									 TRUNC(T960506.MCAL_DAY_DT)
     ) D1
order by c2, c4, c6, c5, c8, c7;

