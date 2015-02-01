select D1.c1 as c1,
     D1.c2 as c2,
     D1.c3 as c3,
     D1.c4 as c4
from 
     (select sum(T1014905.SUPP_SALES_COST) as c1,
               sum(T1014905.SUPP_SALES_AMT) as c2,
                TRUNC(T960506.MCAL_DAY_DT) as c3,
               T960506.ROW_WID as c4,
               ROW_NUMBER() OVER (PARTITION BY T960506.ROW_WID ORDER BY T960506.ROW_WID ASC) as c5
          from 
               W_INT_ORG_ATTR_D T957687 /* Dim_W_INT_ORG_ATTR_D_Retail */ ,
               W_INT_ORG_D T964463 /* Dim_W_INT_ORG_D_Retail_As_Was */ ,
               W_MCAL_DAY_DV T960506 /* Dim_W_MCAL_DAY_D_Retail_Gregorian_Calendar */ ,
               BBG_RA_SLS_LC_DY_A T1014905 /* Fact_BBG_RA_SLS_LC_DY_A */ 
          where  ( T957687.SCD1_WID = T964463.SCD1_WID and T960506.ROW_WID = T1014905.DT_WID and T957687.ORG_ATTR2_NAME = '01' and T960506.MCAL_CAL_WID = 1.0 and T964463.ROW_WID = T1014905.ORG_WID and '2010' < T960506.CAL_YEAR ) 
          group by T960506.ROW_WID,  TRUNC(T960506.MCAL_DAY_DT)
     ) D1
where  ( D1.c5 = 1 );
select D1.c1 as c1,
     D1.c2 as c2,
     D1.c3 as c3,
     D1.c4 as c4,
     D1.c5 as c5
from 
     (select sum(nvl(T961218.SLS_PROFIT_AMT_LCL , 0) - nvl(T961218.RET_PROFIT_AMT_LCL , 0)) as c1,
               sum(nvl(T961218.SLS_TAX_AMT_LCL , 0) - nvl(T961218.RET_TAX_AMT_LCL , 0)) as c2,
               sum(nvl(T961218.SLS_AMT_LCL , 0) - nvl(T961218.RET_AMT_LCL , 0)) as c3,
                TRUNC(T960506.MCAL_DAY_DT) as c4,
               T960506.ROW_WID as c5,
               ROW_NUMBER() OVER (PARTITION BY T960506.ROW_WID ORDER BY T960506.ROW_WID ASC) as c6
          from 
               W_INT_ORG_ATTR_D T957687 /* Dim_W_INT_ORG_ATTR_D_Retail */ ,
               W_INT_ORG_D T964463 /* Dim_W_INT_ORG_D_Retail_As_Was */ ,
               W_MCAL_DAY_DV T960506 /* Dim_W_MCAL_DAY_D_Retail_Gregorian_Calendar */ ,
               W_RTL_SLS_LC_DY_A T961218 /* Fact_W_RTL_SLS_LC_DY_A */ 
          where  ( T957687.SCD1_WID = T964463.SCD1_WID and T960506.ROW_WID = T961218.DT_WID and T957687.ORG_ATTR2_NAME = '01' and T960506.MCAL_CAL_WID = 1.0 and T961218.ORG_SCD1_WID = T964463.SCD1_WID and '2010' < T960506.CAL_YEAR ) 
          group by T960506.ROW_WID,  TRUNC(T960506.MCAL_DAY_DT)
     ) D1
where  ( D1.c6 = 1 ) ;
