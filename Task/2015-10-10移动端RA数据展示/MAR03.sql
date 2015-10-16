--MAR03
-- Create table
create table MAR03
(
  days              DATE not null,
  hour_24           NUMBER(10) not null,
  net_sales_amt     NUMBER(20,4),
  cust              NUMBER(20,4),
  pct               NUMBER(20,4),
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
comment on column MAR03.days
  is '日期';
comment on column MAR03.hour_24
  is '小时';
comment on column MAR03.net_sales_amt
  is '净销售额';
comment on column MAR03.cust
  is '来客数';
comment on column MAR03.pct
  is '客单价(per customer transaction)';
comment on column MAR03.vip_net_sales_amt
  is '会员净销售额';
comment on column MAR03.vip_cust
  is '会员来客数';
comment on column MAR03.vip_pct
  is '会员客单价(per customer transaction)';
-- Create/Recreate indexes 
create unique index PK_MAR03 on MAR03 (DAYS, HOUR_24)
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



--日期、小时、净销售额、客流量、客单、会员净销售额、会员客流量、会员客单
SELECT A.DAYS DAYS,--日期
       A.HOUR_24 HOUR_24,--小时
       A.AMT net_sales_amt,--净销售额
       A.CUST CUST,--客流量
       A.AMT / A.CUST PCT,--客单
       A.VIP_AMT vip_net_sales_amt,--会员净销售额
       A.VIP_CUST VIP_CUST,--会员客流量
       A.VIP_AMT / A.VIP_CUST vip_pct --会员客单
  FROM (SELECT TRUNC(MCAL.MCAL_DAY_DT) DAYS,
               SLS.HOUR_24,
               SLS.AMT AMT,
               CUST.CUST CUST,
               SLS.VIP_AMT,
               CUST.VIP_CUST VIP_CUST
          FROM RADM.W_MCAL_DAY_DV MCAL,
               (SELECT T.DT_WID,
                       M.HOUR_24_NUM HOUR_24,
                       SUM(T.BBG_CUSTOMER_COUNT) CUST,
                       SUM(T.VIP_BBG_CUSTOMER_COUNT) VIP_CUST
                  FROM RADM.BBG_RA_CUST_LC_DY_HR_A T,
                       RADM.W_MINUTE_OF_DAY_D      M
                 WHERE T.DT_WID = 120150513000
                   AND T.MINUTE_WID = M.ROW_WID
                 GROUP BY T.DT_WID, M.HOUR_24_NUM) CUST,
               (SELECT S.DT_WID,
                       M.HOUR_24_NUM HOUR_24,
                       SUM((S.SLS_AMT_LCL - S.SLS_TAX_AMT_LCL) -
                           (S.RET_AMT_LCL - S.RET_TAX_AMT_LCL)) AMT,
                       SUM((S.VIP_SLS_AMT_LCL - S.VIP_SLS_TAX_AMT_LCL) -
                           (S.VIP_RET_AMT_LCL - S.VIP_RET_TAX_AMT_LCL)) VIP_AMT
                  FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_F S,
                       RADM.W_MINUTE_OF_DAY_D        M
                 WHERE S.DT_WID = 120150513000
                   AND S.MIN_WID = M.ROW_WID
                 GROUP BY S.DT_WID, M.HOUR_24_NUM) SLS
         WHERE MCAL.ROW_WID = CUST.DT_WID
           AND MCAL.ROW_WID = SLS.DT_WID
           AND SLS.HOUR_24 = CUST.HOUR_24) A
 ORDER BY A.HOUR_24;
