--库存调整原因
select '库存调整原因',count(*) from rms.bbg_ra_ajustment_reason_dv
union all
--经营属性
select '经营属性',count(*) from rms.BBG_RA_CONTRACT_TYPE_D_V
--库存调整单据
union all
select '库存调整单据',count(*) from rms.BBG_RA_INVADJ_IT_LC_DY_FV
--转移单
union all
select '转移单',count(*) from rms.BBG_RA_INVTSF_IT_LC_DY_FV
--商品地点
union all
select '商品地点',count(*) from rms.CMX_ITEM_LOC_INFO WHERE last_update_date>=TO_DATE(TO_CHAR(SYSDATE,'YYYY-MM-DD'),'YYYY-MM-DD')
--商品地点供应商
union all
select '商品地点供应商',count(*) from rms.BBG_RA_ITEM_LOC_SUPP_D_V WHERE LAST_UPDATE_DATE>=TO_DATE(TO_CHAR(SYSDATE,'YYYY-MM-DD'),'YYYY-MM-DD')
--零售类型
union all
select '零售类型',count(*) from RMS.BBG_RA_RETAIL_TYPE_V
--返仓
union all
select '返仓',count(*) from rms.BBG_RA_RTV_IT_LC_SUPP_DY_FV
--销售预算
union all
select '销售预算',count(*) from radm.BBG_RA_SLSFC_DP_LC_DY_FS_V@rms_ra where day_dt=TO_DATE(TO_CHAR(SYSDATE,'YYYY-MM-DD'),'YYYY-MM-DD')
--合同费用类型
union all
select '合同费用类型',count(*) from rms.CMX_CONTRACT_OPTIONS
--供应商库存
union all
select '供应商库存',count(*) from rms.BBG_RA_SUPP_INV_FV_SRC
--供应商销售
union all
select '供应商库存',count(*) from rms.BBG_RA_SUPP_SALES_FV
--批发销售
union all
select '批发销售',count(*) from rms.BBG_RA_WHOLE_SALES_FV
--商品库存
union all
select '商品库存',count(*) from RA_RMS.RA_INV_IT_LC_V
--价格变更
union all
select '价格变更',count(*) from rms.PRICE_HIST WHERE ACTION_DATE=TO_DATE(TO_CHAR(SYSDATE,'YYYY-MM-DD'),'YYYY-MM-DD')
--供应商订货入库
union all
select '供应商订货入库',count(*) from RMS.IF_TRAN_DATA WHERE TRAN_CODE=20
--供应商资料
union all
select '供应商资料',count(*) from rms.BBG_RA_SUPPLIER_CUSTOM_V
--BASTCOST
union all
select 'BASTCOST',count(*) from  RMS.PRICE_HIST T WHERE T.TRAN_TYPE IN(0,2) AND T.ACTION_DATE=TO_DATE(TO_CHAR(SYSDATE,'YYYY-MM-DD'),'YYYY-MM-DD')
--NETCOST
union all
select 'NETCOST',count(*) from RMS.FUTURE_COST T WHERE T.ACTIVE_DATE=TO_DATE(TO_CHAR(SYSDATE,'YYYY-MM-DD'),'YYYY-MM-DD')
--降价
union all
select '降价',count(*) from RMS.IF_TRAN_DATA WHERE TRAN_CODE in(11, 13, 15, 16, 12, 14, 17, 18)
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
