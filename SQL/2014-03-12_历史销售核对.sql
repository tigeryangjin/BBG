select t.day_dt,
       sum(T.sls_amt_lcl),
       sum(t.sls_tax_amt_lcl),
       sum(nvl(t.SLS_AMT_LCL, 0) - nvl(t.RET_AMT_LCL, 0)) -
       sum(nvl(t.SLS_TAX_AMT_LCL, 0) - nvl(t.RET_TAX_AMT_LCL, 0))
  from BBG_RA_SLS_TRX_REF_V t
 WHERE T.day_dt between DATE '2013-01-01' and date '2013-01-31';

select t.dt_wid,
       sum(T.sls_amt_lcl),
       sum(t.sls_tax_amt_lcl),
       sum(nvl(t.SLS_AMT_LCL, 0) - nvl(t.RET_AMT_LCL, 0)) -
       sum(nvl(t.SLS_TAX_AMT_LCL, 0) - nvl(t.RET_TAX_AMT_LCL, 0))
  from w_rtl_sls_trx_it_lc_dy_f t
 where t.dt_wid between '120130101000' and '120130131000';
-----------------------------------------------
select sum(T.sls_amt_lcl), sum(t.sls_tax_amt_lcl)
  from BBG_RA_SLS_TRX_REF_V t
 WHERE T.day_dt = DATE '2013-01-01';

select sum(t.sls_amt_lcl), sum(t.sls_tax_amt_lcl)
  from w_rtl_sls_trx_it_lc_dy_f t
 where t.dt_wid = '120130101000';
-------------------------------------------------------------------
select sum(T.sls_amt_lcl),
       sum(t.sls_tax_amt_lcl),
       sum(nvl(t.SLS_AMT_LCL, 0) - nvl(t.RET_AMT_LCL, 0)) -
       sum(nvl(t.SLS_TAX_AMT_LCL, 0) - nvl(t.RET_TAX_AMT_LCL, 0))
  from BBG_RA_SLS_TRX_REF_V t
 WHERE T.day_dt = DATE '2013-01-01';

select sum(T.sls_amt_lcl),
       sum(t.sls_tax_amt_lcl),
       sum(nvl(t.SLS_AMT_LCL, 0) - nvl(t.RET_AMT_LCL, 0)) -
       sum(nvl(t.SLS_TAX_AMT_LCL, 0) - nvl(t.RET_TAX_AMT_LCL, 0))
  from w_rtl_sls_trx_it_lc_dy_f t
 where t.dt_wid = '120130101000';

--------------------------------------------------------
select sum(T.sls_amt_lcl),
       sum(t.sls_tax_amt_lcl),
       sum(nvl(t.SLS_AMT_LCL, 0) - nvl(t.RET_AMT_LCL, 0)) -
       sum(nvl(t.SLS_TAX_AMT_LCL, 0) - nvl(t.RET_TAX_AMT_LCL, 0))
  from BBG_RA_SLS_TRX_REF_V t
 WHERE T.day_dt between DATE '2013-01-01' and date '2013-01-31';

select sum(T.sls_amt_lcl),
       sum(t.sls_tax_amt_lcl),
       sum(nvl(t.SLS_AMT_LCL, 0) - nvl(t.RET_AMT_LCL, 0)) -
       sum(nvl(t.SLS_TAX_AMT_LCL, 0) - nvl(t.RET_TAX_AMT_LCL, 0))
  from w_rtl_sls_trx_it_lc_dy_f t
 where t.dt_wid between '120130101000' and '120130131000';
------------------------------------------------------------------------------------
select sum(T.sls_amt_lcl),
       sum(t.sls_tax_amt_lcl),
       sum(nvl(t.SLS_AMT_LCL, 0) - nvl(t.RET_AMT_LCL, 0)) -
       sum(nvl(t.SLS_TAX_AMT_LCL, 0) - nvl(t.RET_TAX_AMT_LCL, 0))
  from BBG_RA_SLS_TRX_REF_V t
 WHERE T.day_dt = DATE '2013-01-01'
   and t.org_num = '120110';

select sum(T.sls_amt_lcl),
       sum(t.sls_tax_amt_lcl),
       sum(nvl(t.SLS_AMT_LCL, 0) - nvl(t.RET_AMT_LCL, 0)) -
       sum(nvl(t.SLS_TAX_AMT_LCL, 0) - nvl(t.RET_TAX_AMT_LCL, 0))
  from w_rtl_sls_trx_it_lc_dy_f t
 where t.dt_wid = '120130101000'
   and t.org_wid = 105;

select * from w_int_org_d;
select count(*)
  from BBG_RA_SLS_TRX_REF_V t
 WHERE T.day_dt between DATE '2013-01-01' and date '2013-01-10';
select count(1)
  from BBG_RA_SLS_TRX_REF_V t
 WHERE T.day_dt = DATE '2013-01-01';

select count(1)
  from BBG_RA_SLS_TRX_REF_V t
 WHERE T.day_dt = DATE '2013-01-10';
