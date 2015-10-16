--MAR01
-- Create table
create table MAR01
(
  days              DATE not null,
  dept_no           NUMBER(10) not null,
  net_sales_amt     NUMBER(20,4),
  dp_per            NUMBER(20,4),
  cust              NUMBER(20,4),
  vip_net_sales_amt NUMBER(20,4),
  vip_cust          NUMBER(20,4),
  month_reach       NUMBER(20,4)
)
tablespace CSMB_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 16K
    next 8K
    minextents 1
    maxextents unlimited
  );
-- Add comments to the columns 
comment on column MAR01.days
  is '日期';
comment on column MAR01.dept_no
  is '大类编码';
comment on column MAR01.net_sales_amt
  is '净销售额';
comment on column MAR01.dp_per
  is '大类占比';
comment on column MAR01.cust
  is '来客数';
comment on column MAR01.vip_net_sales_amt
  is '会员净销售额';
comment on column MAR01.vip_cust
  is '会员来客数';
comment on column MAR01.month_reach
  is '月达成率';
-- Create/Recreate indexes 
create unique index PK_MAR01 on MAR01 (DAYS, DEPT_NO)
  tablespace CSMB_INDEX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );


--日期、大类编码、净销售额、大类占比、客流量、会员净销售额、会员客流量、月达成率
SELECT A.DAYS DAYS, --日期
       A.DEPTNO DEPT_NO, --大类编码
       A.AMT NET_SALES_AMT, --净销售额
       ROUND(A.AMT / A.TOSLS,4) DP_PER, --大类占比
       A.CUST CUST, --客流量
       A.VIPAMT VIP_NET_SALES_AMT, --会员净销售额
       A.VIPCUST VIP_CUST, --会员客流量
       ROUND(A.AMT / A.BUDGETAMT,4) MONTH_REACH --月达成率
  FROM (SELECT TRUNC(MCAL.MCAL_DAY_DT) DAYS,
               PROD.LVL6ANC_PRODCAT_ID DEPTNO,
               SUM((SLS.SLS_AMT_LCL - SLS.SLS_TAX_AMT_LCL) -
                   (SLS.RET_AMT_LCL - SLS.RET_TAX_AMT_LCL)) AMT,
               SUM(CUST.BBG_CUSTOMER_COUNT) CUST,
               DPS.TOSLS,
               SUM((SLS.VIP_SLS_AMT_LCL - SLS.VIP_SLS_TAX_AMT_LCL) -
                   (SLS.VIP_RET_AMT_LCL - SLS.VIP_RET_TAX_AMT_LCL)) VIPAMT,
               SUM(CUST.VIP_BBG_CUSTOMER_COUNT) VIPCUST,
               FC.BUDGETAMT
          FROM RADM.W_MCAL_DAY_DV MCAL,
               RADM.W_PROD_CAT_DH PROD,
               RADM.BBG_RA_CUST_DP_LC_DY_A CUST,
               RADM.W_RTL_SLS_DP_LC_DY_A SLS,
               (SELECT SUBSTR(BUD.DT_WID, 2, 6) MN_WID，BUD.PROD_DH_WID,
                       SUM(BUD.SLS_BUDGET_AMT_LCL) BUDGETAMT
                  FROM RADM.BBG_RA_SLSFC_DP_LC_DY_F BUD
                 GROUP BY SUBSTR(BUD.DT_WID, 2, 6) ，BUD.PROD_DH_WID) FC,
               (SELECT TS.DT_WID,
                       SUM((TS.SLS_AMT_LCL - TS.SLS_TAX_AMT_LCL) -
                           (TS.RET_AMT_LCL - TS.RET_TAX_AMT_LCL)) TOSLS
                  FROM RADM.W_RTL_SLS_DP_LC_DY_A TS
                 GROUP BY TS.DT_WID) DPS
         WHERE MCAL.ROW_WID = CUST.DT_WID
           AND MCAL.ROW_WID = SLS.DT_WID
           AND MCAL.ROW_WID = DPS.DT_WID
           AND MCAL.CAL_MONTH_WID = FC.MN_WID
           AND PROD.LEVEL_NAME = 'DEPT'
           AND CUST.ORG_WID = SLS.ORG_WID
           AND PROD.ROW_WID = CUST.PROD_DH_WID
           AND PROD.ROW_WID = SLS.PROD_DH_WID
           AND PROD.ROW_WID = FC.PROD_DH_WID
           AND MCAL.MCAL_CAL_WID = 1.0
           AND TRUNC(MCAL.MCAL_DAY_DT) = TO_DATE('2015-10-04', 'YYYY-MM-DD')
         GROUP BY TRUNC(MCAL.MCAL_DAY_DT),
                  PROD.LVL6ANC_PRODCAT_ID,
                  DPS.TOSLS,
                  FC.BUDGETAMT) A
 ORDER BY A.DEPTNO;
