/* 98507acc */
select distinct 0      as c1,
                D1.c9  as c2,
                D1.c4  as c3,
                D1.c3  as c4,
                D1.c2  as c5,
                D1.c1  as c6,
                D1.c5  as c7,
                D1.c6  as c8,
                D1.c7  as c9,
                D1.c8  as c10,
                D1.c10 as c11
  from (select sum(nvl(T1051709.VIP_SLS_AMT_LCL, 0) -
                   nvl(T1051709.VIP_RET_AMT_LCL, 0)) as c1,
               count(case
                       when not T1051709.HYK_NO is null then
                        T1051709.SLS_TRX_ID
                       else
                        NULL
                     end) as c2,
               sum(nvl(T1051709.SLS_AMT_LCL, 0) -
                   nvl(T1051709.RET_AMT_LCL, 0)) as c3,
               count(distinct T1051709.SLS_TRX_ID) as c4,
               count(distinct case
                       when not nvl(T1051709.SLS_AMT_LCL, 0) -
                             nvl(T1051709.RET_AMT_LCL, 0) < 188 then
                        T1051709.SLS_TRX_ID
                     end) as c5,
               sum(case
                     when not nvl(T1051709.SLS_AMT_LCL, 0) -
                           nvl(T1051709.RET_AMT_LCL, 0) < 188 then
                      nvl(T1051709.SLS_AMT_LCL, 0) - nvl(T1051709.RET_AMT_LCL, 0)
                   end) as c6,
               count(case
                       when not nvl(T1051709.SLS_AMT_LCL, 0) -
                             nvl(T1051709.RET_AMT_LCL, 0) < 188 then
                        case
                          when not T1051709.HYK_NO is null then
                           T1051709.SLS_TRX_ID
                          else
                           NULL
                        end
                     end) as c7,
               sum(case
                     when not nvl(T1051709.SLS_AMT_LCL, 0) -
                           nvl(T1051709.RET_AMT_LCL, 0) < 188 then
                      nvl(T1051709.VIP_SLS_AMT_LCL, 0) -
                      nvl(T1051709.VIP_RET_AMT_LCL, 0)
                   end) as c8,
               TRUNC(T960506.MCAL_DAY_DT) as c9,
               T960506.ROW_WID as c10
          from W_MCAL_DAY_DV            T960506 /* Dim_W_MCAL_DAY_D_Retail_Gregorian_Calendar */,
               W_PROD_CAT_DH            T956667 /* Dim_W_PROD_CAT_DH_Department_As_Was */,
               W_RTL_SLS_TRX_DP_LC_DY_A T1051709 /* Fact_W_RTL_SLS_TRX_DP_LC_DY_A */
         where (T956667.ROW_WID = T1051709.PROD_DH_WID and
               T956667.LEVEL_NAME = 'DEPT' and
               T960506.ROW_WID = T1051709.DT_WID and
               T960506.MCAL_CAL_WID = 1.0 and
               cast(T956667.LVL6ANC_PRODCAT_ID as INTEGER) <> 72 and
               cast(T956667.LVL6ANC_PRODCAT_ID as INTEGER) <> 73 and
               cast(T956667.LVL6ANC_PRODCAT_ID as INTEGER) <> 74 and
               cast(T956667.LVL6ANC_PRODCAT_ID as INTEGER) <> 75 and
               cast(T956667.LVL6ANC_PRODCAT_ID as INTEGER) <> 76 and
               cast(T956667.LVL6ANC_PRODCAT_ID as INTEGER) <> 70 and
               cast(T956667.LVL6ANC_PRODCAT_ID as INTEGER) <> 71 and
               cast(T956667.LVL6ANC_PRODCAT_ID as INTEGER) <> 77 and
               cast(T956667.LVL6ANC_PRODCAT_ID as INTEGER) <> 78 and
               cast(T956667.LVL6ANC_PRODCAT_ID as INTEGER) <> 79 and
               cast(T956667.LVL6ANC_PRODCAT_ID as INTEGER) <> 99 and
               cast(T956667.LVL6ANC_PRODCAT_ID as INTEGER) <> 9101 and
               cast(T956667.LVL6ANC_PRODCAT_ID as INTEGER) <> 9103 and
               '2010' < T960506.CAL_YEAR and
               TRUNC(T960506.MCAL_DAY_DT) between
               TO_DATE('2015-05-01', 'YYYY-MM-DD') and
               TO_DATE('2015-05-15', 'YYYY-MM-DD'))
         group by T960506.ROW_WID, TRUNC(T960506.MCAL_DAY_DT)) D1
 order by c2
