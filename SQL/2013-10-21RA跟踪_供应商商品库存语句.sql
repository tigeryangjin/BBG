--1
select distinct 0 as c1,
     D1.c2 as c2,
     D1.c3 as c3,
     D1.c1 as c4,
     D1.c4 as c5
from 
     (select sum(D1.c1) over (partition by D1.c4, D1.c3)  as c1,
               D1.c2 as c2,
               D1.c3 as c3,
               D1.c4 as c4
          from 
               (select sum(case D1.c10 when 1 then D1.c5 else NULL end ) as c1,
                         D1.c2 as c2,
                         D1.c3 as c3,
                         D1.c4 as c4
                    from 
                         (select D1.c2 as c2,
                                   D1.c3 as c3,
                                   D1.c4 as c4,
                                   D1.c5 as c5,
                                   D1.c6 as c6,
                                   D1.c7 as c7,
                                   D1.c8 as c8,
                                   D1.c9 as c9,
                                   ROW_NUMBER() OVER (PARTITION BY D1.c4, D1.c3, D1.c6, D1.c7, D1.c8, D1.c9 ORDER BY D1.c4 DESC, D1.c3 DESC, D1.c6 DESC, D1.c7 DESC, D1.c8 DESC, D1.c9 DESC) as c10
                              from 
                                   (select distinct T14449.PROD_NUM as c2,
                                             T954755.SUPPLIER_NUM as c3,
                                             T14449.ROW_WID as c4,
                                             LAST_VALUE(T1010716.SUPP_INV_QTY) OVER (PARTITION BY T14449.ROW_WID, T954755.ROW_WID, T964463.ROW_WID, T1009437.ROW_WID, T1010474.ROW_WID ORDER BY NVL2(T1010716.SUPP_INV_QTY, 1, 0) , T14449.ROW_WID NULLS FIRST, T954755.ROW_WID NULLS FIRST, T964463.ROW_WID NULLS FIRST, T1009437.ROW_WID NULLS FIRST, T1010474.ROW_WID NULLS FIRST, T960506.ROW_WID NULLS FIRST ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as c5,
                                             T954755.ROW_WID as c6,
                                             T964463.ROW_WID as c7,
                                             T1009437.ROW_WID as c8,
                                             T1010474.ROW_WID as c9
                                        from 
                                             BBG_RA_ITEM_LOC_SUPP_D T1010474 /* Dim_BBG_RA_ITEM_LOC_SUPP_D */ ,
                                             BBG_RA_ITEM_LOC_D T1009437 /* Dim_BBG_ITEM_LOC */ ,
                                             W_INT_ORG_DH T964333 /* Dim_W_INT_ORG_DH_Retail_As_Was */ ,
                                             W_INT_ORG_D T964463 /* Dim_W_INT_ORG_D_Retail_As_Was */ ,
                                             W_MCAL_DAY_DV T960506 /* Dim_W_MCAL_DAY_D_Retail_Gregorian_Calendar */ ,
                                             W_PARTY_ORG_D T954755 /* Dim_W_PARTY_ORG_D_Retail_Supplier */ ,
                                             (SELECT T.*
  FROM W_PRODUCT_D T, W_PRODUCT_ATTR_D A
 WHERE T.SCD1_WID = A.SCD1_WID
   AND A.PRODUCT_ATTR12_NAME = A.PRODUCT_ATTR11_NAME) T14449,
                                             BBG_RA_SUPP_INV_IT_LC_DY_FV T1010716 /* Fact_BBG_RA_SUPP_INV_IT_LC_DY_F */ 
                                        where  ( T1009437.ROW_WID = T1010716.BBG_ITEM_LOC_WID and T964463.ROW_WID = T1010716.ORG_WID and T960506.ROW_WID = T1010716.DT_WID and T954755.ROW_WID = T1010716.SUPPLIER_WID and T14449.ROW_WID = T1010716.PROD_WID and T14449.PROD_NUM = '800003525' and T960506.MCAL_CAL_WID = 1.0 and T1010474.ROW_WID = T1010716.BBG_ITEM_LOC_SUPP_WID and T964333.ROW_WID = T1010716.ORG_DH_WID and T964333.SCD1_WID = T964463.SCD1_WID and '2010' < T960506.CAL_YEAR AND T964463.ORG_NUM='120168') 
                                   ) D1
                         ) D1
                    group by D1.c2, D1.c3, D1.c4
               ) D1
     ) D1
order by c3, c2;

--2
--商品编码\地点编码\供应商编码\供应商期末库存数量
select distinct 0 as c1,
     D1.c2 as c2,
     D1.c3 as c3,
     D1.c4 as c4,
     D1.c1 as c5,
     D1.c5 as c6,
     D1.c6 as c7
from 
     (select sum(D1.c1) over (partition by D1.c6, D1.c5, D1.c4)  as c1,
               D1.c2 as c2,
               D1.c3 as c3,
               D1.c4 as c4,
               D1.c5 as c5,
               D1.c6 as c6
          from 
               (select sum(case D1.c11 when 1 then D1.c7 else NULL end ) as c1,
                         D1.c2 as c2,
                         D1.c3 as c3,
                         D1.c4 as c4,
                         D1.c5 as c5,
                         D1.c6 as c6
                    from 
                         (select D1.c2 as c2,
                                   D1.c3 as c3,
                                   D1.c4 as c4,
                                   D1.c5 as c5,
                                   D1.c6 as c6,
                                   D1.c7 as c7,
                                   D1.c8 as c8,
                                   D1.c9 as c9,
                                   D1.c10 as c10,
                                   ROW_NUMBER() OVER (PARTITION BY D1.c6, D1.c5, D1.c4, D1.c8, D1.c9, D1.c10 ORDER BY D1.c6 DESC, D1.c5 DESC, D1.c4 DESC, D1.c8 DESC, D1.c9 DESC, D1.c10 DESC) as c11
                              from 
                                   (select distinct T14449.PROD_NUM as c2,
                                             cast(T964463.ORG_NUM as  INTEGER  ) as c3,
                                             T954755.SUPPLIER_NUM as c4,
                                             T964463.ROW_WID as c5,
                                             T14449.ROW_WID as c6,
                                             LAST_VALUE(T1010716.SUPP_INV_QTY) OVER (PARTITION BY T14449.ROW_WID, T954755.ROW_WID, T964463.ROW_WID, T1009437.ROW_WID, T1010474.ROW_WID ORDER BY NVL2(T1010716.SUPP_INV_QTY, 1, 0) , T14449.ROW_WID NULLS FIRST, T954755.ROW_WID NULLS FIRST, T964463.ROW_WID NULLS FIRST, T1009437.ROW_WID NULLS FIRST, T1010474.ROW_WID NULLS FIRST, T960506.ROW_WID NULLS FIRST ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as c7,
                                             T954755.ROW_WID as c8,
                                             T1009437.ROW_WID as c9,
                                             T1010474.ROW_WID as c10
                                        from 
                                             BBG_RA_ITEM_LOC_SUPP_D T1010474 /* Dim_BBG_RA_ITEM_LOC_SUPP_D */ ,
                                             BBG_RA_ITEM_LOC_D T1009437 /* Dim_BBG_ITEM_LOC */ ,
                                             W_INT_ORG_DH T964333 /* Dim_W_INT_ORG_DH_Retail_As_Was */ ,
                                             W_INT_ORG_D T964463 /* Dim_W_INT_ORG_D_Retail_As_Was */ ,
                                             W_MCAL_DAY_DV T960506 /* Dim_W_MCAL_DAY_D_Retail_Gregorian_Calendar */ ,
                                             W_PARTY_ORG_D T954755 /* Dim_W_PARTY_ORG_D_Retail_Supplier */ ,
                                             (SELECT T.*
  FROM W_PRODUCT_D T, W_PRODUCT_ATTR_D A
 WHERE T.SCD1_WID = A.SCD1_WID
   AND A.PRODUCT_ATTR12_NAME = A.PRODUCT_ATTR11_NAME) T14449,
                                             BBG_RA_SUPP_INV_IT_LC_DY_FV T1010716 /* Fact_BBG_RA_SUPP_INV_IT_LC_DY_F */ 
                                        where  ( T1009437.ROW_WID = T1010716.BBG_ITEM_LOC_WID and T964463.ROW_WID = T1010716.ORG_WID and T960506.ROW_WID = T1010716.DT_WID and T954755.ROW_WID = T1010716.SUPPLIER_WID and T14449.ROW_WID = T1010716.PROD_WID and T14449.PROD_NUM = '800003525' and T960506.MCAL_CAL_WID = 1.0 and T1010474.ROW_WID = T1010716.BBG_ITEM_LOC_SUPP_WID and cast(T964463.ORG_NUM as  INTEGER  ) = 120168 and T964333.ROW_WID = T1010716.ORG_DH_WID and T964333.SCD1_WID = T964463.SCD1_WID and '2010' < T960506.CAL_YEAR ) 
                                   ) D1
                         ) D1
                    group by D1.c2, D1.c3, D1.c4, D1.c5, D1.c6
               ) D1
     ) D1
order by c2, c3, c4;
