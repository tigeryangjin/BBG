--1.
select distinct 0 as c1, D1.c1 as c2, D1.c2 as c3, D1.c3 as c4, D1.c4 as c5
  from (select distinct T961888.PRODUCT_ATTR13_NAME as c1,
                        T961888.PRODUCT_ATTR14_NAME as c2,
                        T961888.PRODUCT_ATTR15_NAME as c3,
                        T14449.PROD_NUM             as c4
          from (SELECT T.*
                  FROM W_PRODUCT_D T, W_PRODUCT_ATTR_D A
                 WHERE T.SCD1_WID = A.SCD1_WID
                /*AND A.PRODUCT_ATTR12_NAME = A.PRODUCT_ATTR11_NAME*/
                ) T14449,
               W_PRODUCT_ATTR_D T961888 /* Dim_W_PRODUCT_ATTR_D_Retail */
         where (T14449.SCD1_WID = T961888.SCD1_WID and
               T961888.W_CATEGORY = 'RETAIL' and
               T961888.PRODUCT_ATTR14_NAME = '800020341')) D1
 order by c2, c3, c4, c5;

--2.
select distinct 0 as c1, D1.c1 as c2, D1.c2 as c3, D1.c3 as c4
  from (select distinct T961888.PRODUCT_ATTR13_NAME as c1,
                        T961888.PRODUCT_ATTR14_NAME as c2,
                        T961888.PRODUCT_ATTR15_NAME as c3
          from W_PRODUCT_ATTR_D T961888 /* Dim_W_PRODUCT_ATTR_D_Retail */
         where (T961888.W_CATEGORY = 'RETAIL' and
               T961888.PRODUCT_ATTR14_NAME = '800020341')) D1
 order by c2, c3, c4;

--3.
select distinct 0 as c1,
                D1.c3 as c2,
                D1.c4 as c3,
                D1.c5 as c4,
                D1.c6 as c5,
                D1.c7 as c6,
                D1.c2 - D1.c1 as c7,
                D1.c8 as c8,
                D1.c9 as c9
  from (select sum(nvl(T956321.SLS_TAX_AMT_LCL, 0) -
                   nvl(T956321.RET_TAX_AMT_LCL, 0)) as c1,
               sum(nvl(T956321.SLS_AMT_LCL, 0) - nvl(T956321.RET_AMT_LCL, 0)) as c2,
               TRUNC(T960506.MCAL_DAY_DT) as c3,
               T961888.PRODUCT_ATTR13_NAME as c4,
               T961888.PRODUCT_ATTR14_NAME as c5,
               T961888.PRODUCT_ATTR15_NAME as c6,
               T14449.PROD_NUM as c7,
               T14449.ROW_WID as c8,
               T960506.ROW_WID as c9
          from W_MCAL_DAY_DV T960506 /* Dim_W_MCAL_DAY_D_Retail_Gregorian_Calendar */,
               (SELECT T.*
                  FROM W_PRODUCT_D T, W_PRODUCT_ATTR_D A
                 WHERE T.SCD1_WID = A.SCD1_WID
                   AND A.PRODUCT_ATTR12_NAME = A.PRODUCT_ATTR11_NAME) T14449,
               W_PRODUCT_ATTR_D T961888 /* Dim_W_PRODUCT_ATTR_D_Retail */,
               W_RTL_SLS_IT_DY_A T956321 /* Fact_W_RTL_SLS_IT_DY_A */
         where (T14449.ROW_WID = T956321.PROD_WID and
               T14449.SCD1_WID = T961888.SCD1_WID and
               T14449.PROD_NUM = '800020341' and
               T956321.DT_WID = T960506.ROW_WID and
               T960506.MCAL_CAL_WID = 1.0 and T961888.W_CATEGORY = 'RETAIL' and
               TRUNC(T960506.MCAL_DAY_DT) =
               TO_DATE('2016-05-30', 'YYYY-MM-DD') and
               '2010' < T960506.CAL_YEAR)
         group by T14449.ROW_WID,
                  T14449.PROD_NUM,
                  T960506.ROW_WID,
                  T961888.PRODUCT_ATTR13_NAME,
                  T961888.PRODUCT_ATTR14_NAME,
                  T961888.PRODUCT_ATTR15_NAME,
                  TRUNC(T960506.MCAL_DAY_DT)) D1
 order by c2, c6, c3, c4, c5;
