--原SQL
select distinct 0 as c1,
                D1.c3 as c2,
                D1.c4 as c3,
                D1.c2 - D1.c1 as c4,
                D1.c5 as c5
  from (select sum(nvl(T956321.SLS_TAX_AMT_LCL, 0) -
                   nvl(T956321.RET_TAX_AMT_LCL, 0)) as c1,
               sum(nvl(T956321.SLS_AMT_LCL, 0) - nvl(T956321.RET_AMT_LCL, 0)) as c2,
               TRUNC(T960506.MCAL_DAY_DT) as c3,
               T14449.BBG_ITEM_BRAND as c4,
               T960506.ROW_WID as c5
          from W_MCAL_DAY_DV T960506 /* Dim_W_MCAL_DAY_D_Retail_Gregorian_Calendar */,
               (SELECT T.*
                  FROM W_PRODUCT_D T, W_PRODUCT_ATTR_D A
                 WHERE T.SCD1_WID = A.SCD1_WID
                   AND A.PRODUCT_ATTR12_NAME = A.PRODUCT_ATTR11_NAME) T14449,
               W_RTL_ITEM_GRP1_D T961779 /* Dim_W_RTL_ITEM_GRP1_D_UDA */,
               W_RTL_SLS_IT_DY_A T956321 /* Fact_W_RTL_SLS_IT_DY_A */
         where (T14449.ROW_WID = T956321.PROD_WID and
               T14449.ROW_WID = T961779.PROD_WID and
               T956321.DT_WID = T960506.ROW_WID and
               T960506.MCAL_CAL_WID = 1.0 and
               T961779.PROD_GRP_TYPE = 'ITEMUDA' and
               TRUNC(T960506.MCAL_DAY_DT) =
               TO_DATE('2014-05-03', 'YYYY-MM-DD') and
               '2010' < T960506.CAL_YEAR and
               (T14449.BBG_ITEM_BRAND in ('农夫', '银鹭')))
         group by T14449.BBG_ITEM_BRAND,
                  T960506.ROW_WID,
                  TRUNC(T960506.MCAL_DAY_DT)) D1
 order by c3, c2;
 
 --
 select distinct 0 as c1,
                D1.c3 as c2,
                D1.c4 as c3,
                D1.c2 - D1.c1 as c4,
                D1.c5 as c5
  from (select sum(nvl(T956321.SLS_TAX_AMT_LCL, 0) -
                   nvl(T956321.RET_TAX_AMT_LCL, 0)) as c1,
               sum(nvl(T956321.SLS_AMT_LCL, 0) - nvl(T956321.RET_AMT_LCL, 0)) as c2,
               TRUNC(T960506.MCAL_DAY_DT) as c3,
               T14449.BBG_ITEM_BRAND as c4,
               T960506.ROW_WID as c5
          from W_MCAL_DAY_DV T960506 /* Dim_W_MCAL_DAY_D_Retail_Gregorian_Calendar */,
               (SELECT T.*
                  FROM W_PRODUCT_D T, W_PRODUCT_ATTR_D A
                 WHERE T.SCD1_WID = A.SCD1_WID
                   AND A.PRODUCT_ATTR12_NAME = A.PRODUCT_ATTR11_NAME) T14449,
               --W_RTL_ITEM_GRP1_D T961779 /* Dim_W_RTL_ITEM_GRP1_D_UDA */,
               W_RTL_SLS_IT_DY_A T956321 /* Fact_W_RTL_SLS_IT_DY_A */
         where (T14449.ROW_WID = T956321.PROD_WID and
               --T14449.ROW_WID = T961779.PROD_WID and
               T956321.DT_WID = T960506.ROW_WID and
               T960506.MCAL_CAL_WID = 1.0 and
               --T961779.PROD_GRP_TYPE = 'ITEMUDA' and
               TRUNC(T960506.MCAL_DAY_DT) =
               TO_DATE('2014-05-03', 'YYYY-MM-DD') and
               '2010' < T960506.CAL_YEAR and
               (T14449.BBG_ITEM_BRAND in ('农夫', '银鹭')))
         group by T14449.BBG_ITEM_BRAND,
                  T960506.ROW_WID,
                  TRUNC(T960506.MCAL_DAY_DT)) D1
 order by c3, c2;
 
 SELECT * FROM RADM.W_RTL_ITEM_GRP1_D T WHERE T.PROD_GRP_TYPE='ITEMUDA' AND T.PROD_WID=292191 AND T.FLEX_ATTRIB_1_CHAR=1;
 
 SELECT TO_CHAR(T.W_INSERT_DT,'YYYYMMDD') W_INSERT_DT,COUNT(*)
FROM RADM.W_RTL_ITEM_GRP1_D T
GROUP BY TO_CHAR(T.W_INSERT_DT,'YYYYMMDD')
ORDER BY TO_CHAR(T.W_INSERT_DT,'YYYYMMDD');
