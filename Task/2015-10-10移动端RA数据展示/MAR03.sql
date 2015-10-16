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
  is '����';
comment on column MAR03.hour_24
  is 'Сʱ';
comment on column MAR03.net_sales_amt
  is '�����۶�';
comment on column MAR03.cust
  is '������';
comment on column MAR03.pct
  is '�͵���(per customer transaction)';
comment on column MAR03.vip_net_sales_amt
  is '��Ա�����۶�';
comment on column MAR03.vip_cust
  is '��Ա������';
comment on column MAR03.vip_pct
  is '��Ա�͵���(per customer transaction)';
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



--���ڡ�Сʱ�������۶���������͵�����Ա�����۶��Ա����������Ա�͵�
SELECT A.DAYS DAYS,--����
       A.HOUR_24 HOUR_24,--Сʱ
       A.AMT net_sales_amt,--�����۶�
       A.CUST CUST,--������
       A.AMT / A.CUST PCT,--�͵�
       A.VIP_AMT vip_net_sales_amt,--��Ա�����۶�
       A.VIP_CUST VIP_CUST,--��Ա������
       A.VIP_AMT / A.VIP_CUST vip_pct --��Ա�͵�
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
