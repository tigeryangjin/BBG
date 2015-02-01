--**********************************************************
--历史销售（第二次导入）
--**********************************************************

--A.delete sales data
declare
  job number;
begin
  sys.dbms_job.submit(job, 'BBG_RA_DEL_SLS_DT;', sysdate, 'sysdate+900');
end;

--1.导入--------------------------------------------------------------------
--修改历史数据源视图
SELECT * FROM BBG_RA_SLS_TRX_REF_V;
--修改RABATCHER.W_INT_ORG_DH_RTL_TMP的EFFECTIVE_FROM_DT成2011-1-1
UPDATE RABATCHER.W_INT_ORG_DH_RTL_TMP T
   SET T.EFFECTIVE_FROM_DT = DATE '2011-01-01'
 WHERE T.EFFECTIVE_FROM_DT = DATE '2013-05-07';
--检查历史数据源视图日期
SELECT DISTINCT DAY_DT FROM BBG_RA_SLS_TRX_REF_V ORDER BY DAY_DT;
--检查历史数据源视图行数
SELECT COUNT(*) FROM BBG_RA_SLS_TRX_REF_V;
--清除日志
TRUNCATE TABLE RA_RMS.C_LOAD_DATES;
TRUNCATE TABLE RADM.C_LOAD_DATES;

--拆分导入
TRUNCATE TABLE RADM.W_RTL_SLS_TRX_IT_LC_DY_FS_BAK;

INSERT INTO RADM.W_RTL_SLS_TRX_IT_LC_DY_FS_BAK
  SELECT * FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_FS;
COMMIT;

TRUNCATE TABLE RADM.W_RTL_SLS_TRX_IT_LC_DY_FS;

INSERT INTO RADM.W_RTL_SLS_TRX_IT_LC_DY_FS
  SELECT *
    FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_FS_BAK
   --WHERE DAY_DT = DATE '2012-07-24';
WHERE DAY_DT BETWEEN DATE '2011-12-24' AND DATE '2011-12-31';
COMMIT;

SELECT DISTINCT DAY_DT FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_FS_BAK;

SELECT DISTINCT DAY_DT FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_FS;

SELECT * FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_F T WHERE T.DT_WID BETWEEN 120111224000 AND 120111231000;
--2.核对---------------------------------------------------------------------
--源表
select t.day_dt,
       sum(T.sls_amt_lcl),
       sum(t.sls_tax_amt_lcl),
       SUM(T.sls_profit_amt_lcl),
       sum(nvl(t.SLS_AMT_LCL, 0) - nvl(t.RET_AMT_LCL, 0)) -
       sum(nvl(t.SLS_TAX_AMT_LCL, 0) - nvl(t.RET_TAX_AMT_LCL, 0))
  from BBG_RA_SLS_TRX_REF_201301 t
--WHERE T.day_dt between DATE '2013-04-21' and date '2013-04-30'
 GROUP BY t.day_dt
 ORDER BY T.DAY_DT;

--BBG_RA_SLS_TRX_REF_V
select t.day_dt,
       sum(T.sls_amt_lcl),
       sum(t.sls_tax_amt_lcl),
       SUM(T.sls_profit_amt_lcl),
       sum(nvl(t.SLS_AMT_LCL, 0) - nvl(t.RET_AMT_LCL, 0)) -
       sum(nvl(t.SLS_TAX_AMT_LCL, 0) - nvl(t.RET_TAX_AMT_LCL, 0))
  from BBG_RA_SLS_TRX_REF_V t
--WHERE T.day_dt between DATE '2013-04-21' and date '2013-04-30'
 GROUP BY t.day_dt
 ORDER BY T.DAY_DT;

--w_rtl_sls_trx_it_lc_dy_fS
select t.day_dt,
       sum(T.sls_amt_lcl),
       sum(t.sls_tax_amt_lcl),
       SUM(T.sls_profit_amt_lcl),
       sum(nvl(t.SLS_AMT_LCL, 0) - nvl(t.RET_AMT_LCL, 0)) -
       sum(nvl(t.SLS_TAX_AMT_LCL, 0) - nvl(t.RET_TAX_AMT_LCL, 0))
  from w_rtl_sls_trx_it_lc_dy_fs t
--where t.day_dt between DATE '2013-02-21' and DATE '2013-02-28'
 GROUP BY t.day_dt
 ORDER BY T.day_dt;

--w_rtl_sls_trx_it_lc_dy_f
select to_date(substr(t.dt_wid, 2, 8), 'YYYYMMDD') day_dt,
       sum(T.sls_amt_lcl),
       sum(t.sls_tax_amt_lcl),
       SUM(T.sls_profit_amt_lcl),
       sum(nvl(t.SLS_AMT_LCL, 0) - nvl(t.RET_AMT_LCL, 0)) -
       sum(nvl(t.SLS_TAX_AMT_LCL, 0) - nvl(t.RET_TAX_AMT_LCL, 0))
  from w_rtl_sls_trx_it_lc_dy_f t
 where to_date(substr(t.dt_wid, 2, 8), 'YYYYMMDD') between DATE
 '2012-09-01'
   and DATE '2012-09-30'
 GROUP BY t.dt_wid
 ORDER BY T.DT_WID;

--w_rtl_sls_it_lc_dy_A
select to_date(substr(t.dt_wid, 2, 8), 'YYYYMMDD') day_dt,
       sum(T.sls_amt_lcl),
       sum(t.sls_tax_amt_lcl),
       SUM(T.sls_profit_amt_lcl),
       sum(nvl(t.SLS_AMT_LCL, 0) - nvl(t.RET_AMT_LCL, 0)) -
       sum(nvl(t.SLS_TAX_AMT_LCL, 0) - nvl(t.RET_TAX_AMT_LCL, 0))
  from w_rtl_sls_it_lc_dy_A t
 where to_date(substr(t.dt_wid, 2, 8), 'YYYYMMDD') between DATE
 '2012-09-01'
   and DATE '2012-09-30'
 GROUP BY t.dt_wid
 ORDER BY T.DT_WID;

--明细核对
--BBG_RA_SLS_TRX_REF_V
select t.day_dt DAY,
       t.prod_it_num ITEM,
       t.org_num LOC,
       sum(T.sls_amt_lcl),
       sum(t.sls_tax_amt_lcl),
       SUM(T.sls_profit_amt_lcl),
       sum(nvl(t.SLS_AMT_LCL, 0) - nvl(t.RET_AMT_LCL, 0)) -
       sum(nvl(t.SLS_TAX_AMT_LCL, 0) - nvl(t.RET_TAX_AMT_LCL, 0))
  from BBG_RA_SLS_TRX_REF_V t
 WHERE T.day_dt = DATE '2013-05-07'
 GROUP BY t.day_dt, t.prod_it_num, t.org_num
 ORDER BY t.day_dt, t.prod_it_num, t.org_num;
--w_rtl_sls_trx_it_lc_dy_f
select TO_DATE(SUBSTR(t.dt_wid, 2, 8), 'YYYYMMDD') DAY,
       p.prod_num ITEM,
       o.org_num LOC,
       sum(T.sls_amt_lcl),
       sum(t.sls_tax_amt_lcl),
       SUM(T.sls_profit_amt_lcl),
       sum(nvl(t.SLS_AMT_LCL, 0) - nvl(t.RET_AMT_LCL, 0)) -
       sum(nvl(t.SLS_TAX_AMT_LCL, 0) - nvl(t.RET_TAX_AMT_LCL, 0))
  from w_rtl_sls_trx_it_lc_dy_f t, w_int_org_d o, w_product_d p
 where t.prod_wid = p.row_wid
   and t.org_wid = o.row_wid
   and t.dt_wid = '120130507000'
 GROUP BY t.dt_wid, p.prod_num, o.org_num
 ORDER BY T.DT_WID, p.prod_num, o.org_num;

SELECT R.DAY, R.ITEM, R.LOC, R.WX, F.WX
  FROM (select t.day_dt DAY,
               t.prod_it_num ITEM,
               t.org_num LOC,
               sum(T.sls_amt_lcl),
               sum(t.sls_tax_amt_lcl),
               SUM(T.sls_profit_amt_lcl),
               sum(nvl(t.SLS_AMT_LCL, 0) - nvl(t.RET_AMT_LCL, 0)) -
               sum(nvl(t.SLS_TAX_AMT_LCL, 0) - nvl(t.RET_TAX_AMT_LCL, 0)) WX
          from BBG_RA_SLS_TRX_REF_V t
         WHERE T.day_dt = DATE '2013-05-07'
         GROUP BY t.day_dt, t.prod_it_num, t.org_num
         ORDER BY t.day_dt, t.prod_it_num, t.org_num) R,
       (select TO_DATE(SUBSTR(t.dt_wid, 2, 8), 'YYYYMMDD') DAY,
               p.prod_num ITEM,
               o.org_num LOC,
               sum(T.sls_amt_lcl),
               sum(t.sls_tax_amt_lcl),
               SUM(T.sls_profit_amt_lcl),
               sum(nvl(t.SLS_AMT_LCL, 0) - nvl(t.RET_AMT_LCL, 0)) -
               sum(nvl(t.SLS_TAX_AMT_LCL, 0) - nvl(t.RET_TAX_AMT_LCL, 0)) WX
          from w_rtl_sls_trx_it_lc_dy_f t, w_int_org_d o, w_product_d p
         where t.prod_wid = p.row_wid
           and t.org_wid = o.row_wid
           and t.dt_wid = '120130507000'
         GROUP BY t.dt_wid, p.prod_num, o.org_num
         ORDER BY T.DT_WID, p.prod_num, o.org_num) F
 WHERE R.DAY = F.DAY
   AND R.ITEM = F.ITEM
   AND R.LOC = F.LOC
   AND R.WX <> F.WX;
------
SELECT *
  FROM BBG_RA_SLS_TRX_REF_V T
 WHERE T.day_dt = DATE '2013-05-02'
   AND T.prod_it_num = '800190536'
   AND T.org_num = '130024';

SELECT *
  FROM w_rtl_sls_trx_it_lc_dy_f T
 WHERE T.DT_WID = '120130502000'
   AND T.PROD_WID = 302963
   AND T.ORG_WID = 198;

SELECT *
  FROM RABATCHER.W_RTL_SLS_TRX_IT_LC_DY_TMP T
 WHERE T.ORG_NUM = '130024'
   AND T.PROD_IT_NUM = '800190536';

SELECT T.ROW_WID FROM W_PRODUCT_D T WHERE T.PROD_NUM = '800190536';
SELECT T.ROW_WID FROM w_int_org_d T WHERE T.ORG_NUM = '130024';

SELECT * FROM RABATCHER.W_INT_ORG_DH_RTL_TMP T WHERE T.ORG_NUM = '130024';

SELECT T.ORG_NUM, COUNT(*)
  FROM RABATCHER.W_INT_ORG_DH_RTL_TMP T
 GROUP BY T.ORG_NUM
HAVING COUNT(*) > 1;

--ITEM_LOC纬度问题
--源表商品地点不在纬度中的
SELECT *
  FROM RADM.BBG_RA_SLS_TRX_REF_201305 T
 WHERE T.DAY_DT = DATE
 '2013-05-07'
   AND (T.PROD_IT_NUM, T.ORG_NUM) NOT IN
       (SELECT IL.ITEM, IL.LOC
          FROM RADM.BBG_RA_ITEM_LOC_D IL
         WHERE DATE '2013-05-07' >= IL.EFFECTIVE_FROM_DT
           AND DATE '2013-05-07' <= IL.EFFECTIVE_FROM_DT);
SELECT *
  FROM BBG_RA_ITEM_LOC_D T
 WHERE T.ITEM = '800190536'
   AND T.LOC = '130024';

--**********************************************************
--历史供应商销售（第二次导入）
--**********************************************************
SELECT * FROM BBG_RA_SUPP_SLS_REF_V;
select MAX(T.DAY_DT) from BBG_RA_SUPP_SLS_REF t;
SELECT *
  FROM RADM.BBG_RA_SUPP_SALES_IT_LC_DY_F T
 WHERE T.DT_WID = '120130508000';

SELECT SUM(SUPP_SALES_COST)
  FROM BBG_RA_SUPP_SLS_REF T
 WHERE T.DAY_DT BETWEEN DATE '2013-04-01' AND DATE '2013-04-30';

SELECT SUM(SUPP_SALES_COST)
  FROM RADM.BBG_RA_SUPP_SALES_IT_LC_DY_F T
 WHERE T.DT_WID BETWEEN '120130401000' AND '120130430000';

SELECT * FROM BBG_RA_SUPP_SLS_REF T WHERE T.DAY_DT = DATE '2013-05-07';

SELECT SUM(SUPP_SALES_COST)
  FROM BBG_RA_SUPP_SLS_REF T
 WHERE T.DAY_DT = DATE '2013-05-07';

SELECT SUM(SUPP_SALES_COST)
  FROM RADM.BBG_RA_SUPP_SALES_IT_LC_DY_F T
 WHERE T.DT_WID = '120130507000';
