--������ԭ��
select '������ԭ��',count(*) from rms.bbg_ra_ajustment_reason_dv
union all
--��Ӫ����
select '��Ӫ����',count(*) from rms.BBG_RA_CONTRACT_TYPE_D_V
--����������
union all
select '����������',count(*) from rms.BBG_RA_INVADJ_IT_LC_DY_FV
--ת�Ƶ�
union all
select 'ת�Ƶ�',count(*) from rms.BBG_RA_INVTSF_IT_LC_DY_FV
--��Ʒ�ص�
union all
select '��Ʒ�ص�',count(*) from rms.CMX_ITEM_LOC_INFO WHERE last_update_date>=TO_DATE(TO_CHAR(SYSDATE,'YYYY-MM-DD'),'YYYY-MM-DD')
--��Ʒ�ص㹩Ӧ��
union all
select '��Ʒ�ص㹩Ӧ��',count(*) from rms.BBG_RA_ITEM_LOC_SUPP_D_V WHERE LAST_UPDATE_DATE>=TO_DATE(TO_CHAR(SYSDATE,'YYYY-MM-DD'),'YYYY-MM-DD')
--��������
union all
select '��������',count(*) from RMS.BBG_RA_RETAIL_TYPE_V
--����
union all
select '����',count(*) from rms.BBG_RA_RTV_IT_LC_SUPP_DY_FV
--����Ԥ��
union all
select '����Ԥ��',count(*) from radm.BBG_RA_SLSFC_DP_LC_DY_FS_V@rms_ra where day_dt=TO_DATE(TO_CHAR(SYSDATE,'YYYY-MM-DD'),'YYYY-MM-DD')
--��ͬ��������
union all
select '��ͬ��������',count(*) from rms.CMX_CONTRACT_OPTIONS
--��Ӧ�̿��
union all
select '��Ӧ�̿��',count(*) from rms.BBG_RA_SUPP_INV_FV_SRC
--��Ӧ������
union all
select '��Ӧ�̿��',count(*) from rms.BBG_RA_SUPP_SALES_FV
--��������
union all
select '��������',count(*) from rms.BBG_RA_WHOLE_SALES_FV
--��Ʒ���
union all
select '��Ʒ���',count(*) from RA_RMS.RA_INV_IT_LC_V
--�۸���
union all
select '�۸���',count(*) from rms.PRICE_HIST WHERE ACTION_DATE=TO_DATE(TO_CHAR(SYSDATE,'YYYY-MM-DD'),'YYYY-MM-DD')
--��Ӧ�̶������
union all
select '��Ӧ�̶������',count(*) from RMS.IF_TRAN_DATA WHERE TRAN_CODE=20
--��Ӧ������
union all
select '��Ӧ������',count(*) from rms.BBG_RA_SUPPLIER_CUSTOM_V
--BASTCOST
union all
select 'BASTCOST',count(*) from  RMS.PRICE_HIST T WHERE T.TRAN_TYPE IN(0,2) AND T.ACTION_DATE=TO_DATE(TO_CHAR(SYSDATE,'YYYY-MM-DD'),'YYYY-MM-DD')
--NETCOST
union all
select 'NETCOST',count(*) from RMS.FUTURE_COST T WHERE T.ACTIVE_DATE=TO_DATE(TO_CHAR(SYSDATE,'YYYY-MM-DD'),'YYYY-MM-DD')
--����
union all
select '����',count(*) from RMS.IF_TRAN_DATA WHERE TRAN_CODE in(11, 13, 15, 16, 12, 14, 17, 18)
/*--
union all
select '',count(*) from 
--
union all
select '',count(*) from 
--
union all
select '',count(*) from*/ 
;
