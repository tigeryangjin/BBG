select distinct 0 as c1,
     D1.c1 as c2,
     D1.c2 as c3
from 
     (select distinct cast(T955085.LVL6ANC_PRODCAT_ID as  INTEGER  ) as c1,
               T14449.PROD_NUM as c2
          from 
               (SELECT T.*
  FROM W_PRODUCT_D T, W_PRODUCT_ATTR_D A
 WHERE T.SCD1_WID = A.SCD1_WID
   AND A.PRODUCT_ATTR12_NAME = A.PRODUCT_ATTR11_NAME) T14449,
               W_PROD_CAT_DH T955085 /* Dim_W_PROD_CAT_DH_As_Was */ 
          where  ( T14449.PROD_CAT5_WID_AS_WAS = T955085.ROW_WID ) 
     ) D1
order by c2, c3
