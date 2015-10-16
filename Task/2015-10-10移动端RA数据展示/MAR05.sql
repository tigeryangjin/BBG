--MAR05
-- Create table
create table MAR05
(
  days              DATE not null,
  region            NUMBER(10) not null,
  net_sales_amt     NUMBER(20,4),
  cust              NUMBER(20,4),
  pct               NUMBER(20,4),
  gp                NUMBER(20,4),
  vip_net_sales_amt NUMBER(20,4),
  vip_cust          NUMBER(20,4),
  vip_pct           NUMBER(20,4)
)
tablespace CSMB_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 16
    next 8
    minextents 1
    maxextents unlimited
  );
-- Add comments to the columns 
comment on column MAR05.days
  is '日期';
comment on column MAR05.region
  is '区域编码';
comment on column MAR05.net_sales_amt
  is '净销售额';
comment on column MAR05.cust
  is '来客数';
comment on column MAR05.pct
  is '客单价(per customer transaction)';
comment on column MAR05.gp
  is '毛利率(gross profit rate)';
comment on column MAR05.vip_net_sales_amt
  is '会员净销售额';
comment on column MAR05.vip_cust
  is '会员来客数';
comment on column MAR05.vip_pct
  is '会员客单价(per customer transaction)';
-- Create/Recreate indexes 
create unique index PK_MAR05 on MAR05 (DAYS, REGION)
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



--日期、区域、净销售额、来客数、客单、毛利率、会员净销售额、会员来客数、会员客单
SELECT TRUNC(MCAL.MCAL_DAY_DT) DAYS, --日期
       O.ORG_HIER11_NUM REGION, --区域
       T.AMT net_sales_amt, --净销售额
       T.CUST CUST, --来客数
       T.AMT / T.CUST PCT, --客单
       T.PROFIT / T.AMT GP, --毛利率
       T.VIP_AMT vip_net_sales_amt, --会员净销售额
       T.VIP_CUST VIP_CUST, --会员来客数
       T.VIP_AMT / T.VIP_CUST vip_pct --会员客单
  FROM RADM.W_MCAL_DAY_DV MCAL,
       (SELECT S.DT_WID,
               S.ORG_DH_WID,
               SUM((S.SLS_AMT_LCL - S.SLS_TAX_AMT_LCL) -
                   (S.RET_AMT_LCL - S.RET_TAX_AMT_LCL)) AMT,
               SUM((S.VIP_SLS_AMT_LCL - S.VIP_SLS_TAX_AMT_LCL) -
                   (S.VIP_RET_AMT_LCL - S.VIP_RET_TAX_AMT_LCL)) VIP_AMT,
               SUM(S.SLS_PROFIT_AMT_LCL - S.RET_PROFIT_AMT_LCL) PROFIT,
               SUM(C.BBG_CUSTOMER_COUNT) CUST,
               SUM(C.VIP_BBG_CUSTOMER_COUNT) VIP_CUST
          FROM RADM.W_RTL_SLS_LC_DY_A S, RADM.BBG_RA_CUST_LC_DY_A C
         WHERE S.DT_WID = 120150513000
           AND S.DT_WID = C.DT_WID
           AND S.ORG_WID = C.ORG_WID
         GROUP BY S.DT_WID, S.ORG_DH_WID) T,
       RADM.W_INT_ORG_DH O
 WHERE MCAL.ROW_WID = T.DT_WID
   AND T.ORG_DH_WID = O.ROW_WID
 ORDER BY O.ORG_HIER11_NUM;
