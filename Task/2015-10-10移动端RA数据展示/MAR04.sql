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
  is '����';
comment on column MAR04.loc
  is '�ص����';
comment on column MAR04.district
  is '���б���';
comment on column MAR04.region
  is '�������';
comment on column MAR04.area
  is 'ʡ�ݱ���';
comment on column MAR04.chain
  is 'ҵ̬����';
comment on column MAR04.net_sales_amt
  is '�����۶�';
comment on column MAR04.gp
  is 'ë����(gross profit rate)';
comment on column MAR04.vip_net_sales_amt
  is '��Ա�����۶�';
comment on column MAR04.vip_per
  is '��Ա����ռ��';
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



--���ڡ������������ͣ�һ�����������۶��Ա�����۶��Ա����ռ�ȡ�ë����
SELECT TRUNC(MCAL.MCAL_DAY_DT) DAYS, --����
       O.ORG_HIER9_NUM LOC, --�ص�
       O.ORG_HIER10_NUM DISTRICT, --����
       O.ORG_HIER11_NUM REGION, --����
       O.ORG_HIER12_NUM AREA, --ʡ��
       O.ORG_HIER13_NUM CHAIN, --ҵ̬
       RT.RETAIL_GROUP_ID || '-' || RT.RETAIL_GROUP_DESC RETAIL_GROUP, --�������ͣ�һ����
       RT.RETAIL_TYPE_ID || '-' || RT.RETAIL_TYPE_DESC RETAIL_TYPE, --�������ͣ�������
       T.AMT net_sales_amt, --�����۽��
       DECODE(T.AMT, 0, 0, T.PROFIT / T.AMT) GP, --ë����
       T.VIP_AMT vip_net_sales_amt, --��Ա����
       DECODE(T.AMT, 0, 0, T.VIP_AMT / T.AMT) VIP_PER --��Առ��
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
