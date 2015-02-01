--
select D1.c1 as c1,
     D1.c2 as c2,
     D1.c3 as c3
from 
     (select sum(T1030932.INV_SOH_QTY) as c1,
               T14449.PROD_NUM as c2,
               T14449.ROW_WID as c3,
               ROW_NUMBER() OVER (PARTITION BY T14449.ROW_WID ORDER BY T14449.ROW_WID ASC) as c4
          from 
               (SELECT T.*
  FROM W_PRODUCT_D T, W_PRODUCT_ATTR_D A
 WHERE T.SCD1_WID = A.SCD1_WID
   AND A.PRODUCT_ATTR12_NAME = A.PRODUCT_ATTR11_NAME) T14449,
               W_RTL_INV_IT_LC_GV T1030932 /* Fact_W_RTL_INV_IT_LC_G */ 
          where  ( T14449.ROW_WID = T1030932.PROD_WID ) 
          group by T14449.ROW_WID, T14449.PROD_NUM
     ) D1
where  ( D1.c4 = 1 )
--
select distinct 0 as c1,
     D1.c2 as c2,
     cast(NULL as  DOUBLE PRECISION  ) as c3,
     D1.c1 as c4,
     D1.c3 as c5
from 
     (select sum(T1030932.INV_SOH_QTY) as c1,
               T14449.PROD_NUM as c2,
               T14449.ROW_WID as c3
          from 
               BBG_RA_ITEM_LOC_D T1009437 /* Dim_BBG_ITEM_LOC */ ,
               (SELECT T.*
  FROM W_PRODUCT_D T, W_PRODUCT_ATTR_D A
 WHERE T.SCD1_WID = A.SCD1_WID
   AND A.PRODUCT_ATTR12_NAME = A.PRODUCT_ATTR11_NAME) T14449,
               W_RTL_INV_IT_LC_GV T1030932 /* Fact_W_RTL_INV_IT_LC_G */ 
          where  ( T14449.ROW_WID = T1030932.PROD_WID and T1009437.CURRENT_FLG = 'Y' and T1009437.NBO = 'Y' and T1009437.ROW_WID = T1030932.BBG_ITEM_LOC_WID ) 
          group by T14449.ROW_WID, T14449.PROD_NUM
     ) D1
order by c2
