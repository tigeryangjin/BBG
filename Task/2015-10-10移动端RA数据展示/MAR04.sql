--MAR04
-- Create table
create table MAR04
(
  days              DATE not null,
  loc               NUMBER(10) not null,
  district          NUMBER(10) not null,
  region            NUMBER(10) not null,
  area              NUMBER(10) not null,
  chain             NUMBER(10) not null,
  retail_group      NUMBER(10) not null,
  retail_type       NUMBER(10) not null,
  net_sales_amt     NUMBER(20,4),
  gp                NUMBER(20,4),
  vip_net_sales_amt NUMBER(20,4),
  vip_per           NUMBER(20,4)
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
comment on column MAR04.days
  is '日期';
comment on column MAR04.loc
  is '地点编码';
comment on column MAR04.district
  is '城市编码';
comment on column MAR04.region
  is '区域编码';
comment on column MAR04.area
  is '省份编码';
comment on column MAR04.chain
  is '业态编码';
comment on column MAR04.net_sales_amt
  is '净销售额';
comment on column MAR04.gp
  is '毛利率(gross profit rate)';
comment on column MAR04.vip_net_sales_amt
  is '会员净销售额';
comment on column MAR04.vip_per
  is '会员销售占比';
-- Create/Recreate indexes 
create unique index PK_MAR04 on MAR04 (DAYS, LOC)
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



--日期、区域、零售类型（一级）、净销售额、会员净销售额、会员销售占比、毛利率
SELECT TRUNC(MCAL.MCAL_DAY_DT) DAYS, --日期
       O.ORG_HIER9_NUM LOC, --地点
       O.ORG_HIER10_NUM DISTRICT, --城市
       O.ORG_HIER11_NUM REGION, --区域
       O.ORG_HIER12_NUM AREA, --省份
       O.ORG_HIER13_NUM CHAIN, --业态
       RT.RETAIL_GROUP_ID || '-' || RT.RETAIL_GROUP_DESC RETAIL_GROUP, --零售类型（一级）
       RT.RETAIL_TYPE_ID || '-' || RT.RETAIL_TYPE_DESC RETAIL_TYPE, --零售类型（二级）
       T.AMT net_sales_amt, --净销售金额
       DECODE(T.AMT, 0, 0, T.PROFIT / T.AMT) GP, --毛利率
       T.VIP_AMT vip_net_sales_amt, --会员销售
       DECODE(T.AMT, 0, 0, T.VIP_AMT / T.AMT) VIP_PER --会员占比
  FROM RADM.W_MCAL_DAY_DV MCAL,
       (SELECT S.DT_WID,
               S.ORG_DH_WID,
               S.BBG_RETAIL_TYPE_WID,
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
         GROUP BY S.DT_WID, S.ORG_DH_WID, S.BBG_RETAIL_TYPE_WID) T,
       RADM.W_INT_ORG_DH O,
       RADM.BBG_RA_RETAIL_TYPE_D RT
 WHERE MCAL.ROW_WID = T.DT_WID
   AND T.ORG_DH_WID = O.ROW_WID
   AND RT.ROW_WID = T.BBG_RETAIL_TYPE_WID
 ORDER BY O.ORG_HIER9_NUM, RT.RETAIL_TYPE_ID;
