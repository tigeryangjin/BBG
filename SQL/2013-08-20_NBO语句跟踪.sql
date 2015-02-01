SET VARIABLE QUERY_SRC_CD='Report';SELECT
   0 s_0,
   "Retail As-Was"."BBG NBO Item Count by Loc"."NBO_INV_SKU" s_1,
   "Retail As-Was"."Organization As Was"."Loc Number" s_2
FROM "Retail As-Was"
ORDER BY 1, 3 ASC NULLS LAST, 2 ASC NULLS LAST
FETCH FIRST 10000000 ROWS ONLY

select distinct 0 as c1,
     D1.c1 as c2,
     D1.c2 as c3
from 
     (select distinct T1033279.NBO_INV_SKU as c1,
               cast(T964463.ORG_NUM as  INTEGER  ) as c2
          from 
               W_INT_ORG_D T964463 /* Dim_W_INT_ORG_D_Retail_As_Was */ ,
               BBG_RA_NBOSTORECOUNTOFITEM_A T1033279 /* Fact_BBG_RA_NBOSTORECOUNTOFITEM_A */ 
          where  ( T964463.ROW_WID = T1033279.LOC ) 
     ) D1
order by c3, c2;

SELECT * FROM W_INT_ORG_D ;
SELECT * FROM BBG_RA_NBOSTORECOUNTOFITEM_A;

--门店的NBO商品数统计
select distinct 0 as c1,
     D1.c1 as c2,
     D1.c2 as c3
from 
     (select distinct T1033279.NBO_INV_SKU as c1,
               cast(T964463.ORG_NUM as  INTEGER  ) as c2
          from 
               W_INT_ORG_D T964463 /* Dim_W_INT_ORG_D_Retail_As_Was */ ,
               BBG_RA_NBOSTORECOUNTOFITEM_A T1033279 /* Fact_BBG_RA_NBOSTORECOUNTOFITEM_A */ 
          where  ( T964463.ORG_NUM = T1033279.LOC ) 
     ) D1
order by c3, c2
