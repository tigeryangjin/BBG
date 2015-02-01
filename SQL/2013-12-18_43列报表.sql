--目标表,金辅君建立
SELECT * FROM ksl_supplier_statistic;
--参考语句
select supps.supplier 一级供应商编码,
			 supps.sup_name 一级供应商名称,
			 ct.supplier 二级供应商编码,
			 supp.sup_name 二级供应商名称,
			 ct.contract_no 二级供应商合同号,
			 substr(ct.supplier, 0, 2) 合同大类,
			 (select uv.uda_value_desc
					from uda_values uv
				 where uv.uda_id = 3
					 and uv.uda_value = ct.brand_code) 经营主要品牌,
			 (select cd.code_desc
					from cmx_code_detail cd
				 where cd.code = ct.contract_type
					 and cd.code_type = 'BSTP'
					 and cd.lang = 8) 合同类型,
			 ct.items_num 及时正常SKU数,
			 supp.qty 经营门店数,
			 xh.rk_cost 入库金额,
			 xh.ch_cost 退货金额,
			 xh.rk_cost - xh.ch_cost 净入库金额,
			 xh.zh_qty 正常销量,
			 xh.zh_retail 正常销售金额,
			 xh.zh_cost 正常销售成本,
			 xh.cx_qty 促销销量,
			 xh.cx_retail 促销销售金额,
			 xh.cx_cost 促销销售成本,
			 xh.hj_retail 合计销售金额,
			 xh.hj_cost 合计销售成本,
			 xh.zh_retail - xh.zh_cost 正常毛利额,
			 case
				 when xh.zh_retail <> 0 then
					(xh.zh_retail - xh.zh_cost) / xh.zh_retail
				 else
					null
			 end as 正常毛利率,
			 xh.cx_retail - xh.cx_cost 促销毛利额,
			 case
				 when xh.cx_retail <> 0 then
					(xh.cx_retail - xh.cx_cost) / xh.cx_retail
				 else
					null
			 end as 促销毛利率,
			 case
				 when ct.status = 'C' then
					'终止'
				 when ct.status = 'A' then
					'正在执行'
				 when ct.status = 'S' then
					'录入'
				 else
					null
			 end as 合同状态,
			 td.terms_desc 方式,
			 dm.cost_code 费用代码,
			 dm.amount 费用金额
	from cmx_contract ct,
			 sups supp,
			 sups supps,
			 terms_head td,
			 (select ccr.contract_no,
							 ccr.supplier,
							 ccr.cost_code,
							 sum(round(CASE
													 WHEN CCO.INCOME_TYPE IN ('F', 'O') AND CCR.Cal_Type <> 'J' THEN
														decode(ccr.type, 'CC', CCR.REAL_DIF, 'C', CCR.Real_Amount) *
														(1 + CCO.VAT_RATE / 100)
													 WHEN CCO.INCOME_TYPE = 'P' AND CCO.SPECAIL_EXPENSE_IND = 'Y' THEN
														decode(ccr.type, 'CC', CCR.REAL_DIF, 'C', CCR.Real_Amount) *
														(1 + CCO.VAT_RATE / 100)
													 WHEN CCO.INCOME_TYPE = 'P' AND CCO.SPECAIL_EXPENSE_IND = 'N' THEN
														decode(ccr.type, 'CC', CCR.REAL_DIF, 'C', CCR.Real_Amount) *
														(1 + CC.VAT_RATE / 100)
													 WHEN CCR.Cal_Type = 'J' THEN
														decode(ccr.type, 'CC', CCR.REAL_DIF, 'C', CCR.Real_Amount)
												 END,
												 2)) AMOUNT
					from cmx_contract_result  ccr,
							 CMX_CONTRACT         CC,
							 CMX_CONTRACT_OPTIONS CCO
				 where (nvl(ccr.Real_Amount, 0) <> 0 or nvl(ccr.real_dif, 0) <> 0)
					 and process_flag = 'P'
					 and ccr.contract_id = cc.contract_id(+)
					 and ccr.cost_code = cco.cost_code
					 and post_date > to_date('20130507', 'yyyymmdd')
					 and trunc(nvl(ccr.approve_date, ccr.creation_date)) between
							 &PM_STDATE and &PM_ENDDATE
				 group by trunc(nvl(ccr.approve_date, ccr.creation_date)),
									ccr.contract_no,
									ccr.supplier,
									ccr.cost_code) dm,
			 (select il.primary_supp, count(distinct il.loc) qty
					from item_loc il
				 group by il.primary_supp) supp,
			 (select il.primary_supp supplier,
							 sum(case
										 when th.tran_code = 20 then
											th.total_cost
										 else
											0
									 end) rk_cost,
							 sum(case
										 when th.tran_code = 24 then
											th.total_cost
										 else
											0
									 end) ch_cost,
							 sum(case
										 when th.tran_code = 1 and th.sales_type = 'R' then
											th.total_retail
										 else
											0
									 end) zh_retail,
							 sum(case
										 when th.tran_code = 1 and th.sales_type = 'R' then
											th.units
										 else
											0
									 end) zh_qty,
							 sum(case
										 when th.tran_code = 1 and th.sales_type = 'R' then
											th.total_cost
										 else
											0
									 end) zh_cost,
							 sum(case
										 when th.tran_code = 1 and th.sales_type = 'P' then
											th.total_retail
										 else
											0
									 end) cx_retail,
							 sum(case
										 when th.tran_code = 1 and th.sales_type = 'P' then
											th.units
										 else
											0
									 end) cx_qty,
							 sum(case
										 when th.tran_code = 1 and th.sales_type = 'P' then
											th.total_cost
										 else
											0
									 end) cx_cost,
							 sum(case
										 when th.tran_code = 1 then
											th.total_retail
										 else
											0
									 end) hj_retail,
							 sum(case
										 when th.tran_code = 1 then
											th.total_cost
										 else
											0
									 end) hj_cost
					from tran_data_history th, item_loc il
				 where th.tran_code in ('20', '24', '1')
					 and th.loc_type = 'S'
					 and th.item = il.item
					 and th.location = il.loc
					 and th.tran_date between &PM_STDATE and &PM_ENDDATE
				 group by il.primary_supp) xh
 where ct.supplier = supp.primary_supp(+)
	 and ct.supplier = xh.supplier(+)
	 and ct.supplier = dm.supplier
	 and ct.contract_no = dm.contract_no
	 and ct.supplier = supp.supplier
	 and supp.supplier_parent = supps.supplier
	 and supp.terms = td.terms
	 and ct.status = 'A'
	 and ct.year = 2013;

--XH子表_历史数据
SELECT SUP.SUPPLIER_NUM,
	FROM W_PARTY_ORG_D SUPP, BBG_RA_SUPP_SALES_IT_LC_DY_F SUS
 WHERE SUP.ROW_WID = SUS.SUPPLIER_WID(+);

SELECT SUS.SUPPLIER_WID,
			 SUM(CASE
						 WHEN SLS.RTL_TYPE_WID = 1 THEN
							SLS.SLS_QTY - SLS.RET_QTY
						 ELSE
							0
					 END) ZH_QTY,
			 SUM(CASE
						 WHEN SLS.RTL_TYPE_WID = 1 THEN
							SLS.SLS_AMT_LCL - SLS.RET_QTY
						 ELSE
							0
					 END)
	FROM BBG_RA_SUPP_SALES_IT_LC_DY_F SUS, W_RTL_SLS_TRX_IT_LC_DY_F SLS
 WHERE SUS.BBG_ITEM_LOC_WID = SLS.BBG_ITEM_LOC_WID
	 AND SUS.DT_WID = SLS.DT_WID
	 AND SUBSTR(SUS.DT_WID, 2, 6) = '201301'
 GROUP BY SUS.SUPPLIER_WID;

--入库金额
SELECT T.day_dt POST_DATE,
			 T.SUPPLIER_NUM,
			 SUM(T.bbg_reference_fo2) 入库金额
	FROM RADM.BBG_RA_SUPPCM_REF_V T
 WHERE T.DAY_DT BETWEEN DATE '2013-01-01' AND DATE '2013-05-07'
 GROUP BY T.day_dt, T.SUPPLIER_NUM;

--退货金额
SELECT T.day_dt POST_DATE, T.SUPPLIER_NUM, SUM(T.rtv_cost) 退货金额
	FROM RADM.BBG_RA_RTV_REF_V T
 WHERE T.DAY_DT BETWEEN DATE '2013-01-01' AND DATE '2013-05-07'
 GROUP BY T.day_dt, T.SUPPLIER_NUM;

--合并，净入库金额 UNION
--BETWEEN DATE '2013-01-01' AND DATE '2013-05-07'
CREATE TABLE YJ_SUPP_IN_OUT_AMT_HIST AS
	SELECT CM.POST_DATE,
				 CM.SUPPLIER_NUM,
				 NVL(CM.入库金额, 0) P_COST,
				 NVL(RTV.退货金额, 0) R_COST,
				 NVL(CM.入库金额, 0) - NVL(RTV.退货金额, 0) NET_COST
		FROM (SELECT T.day_dt POST_DATE,
								 T.SUPPLIER_NUM,
								 SUM(T.bbg_reference_fo2) 入库金额
						FROM RADM.BBG_RA_SUPPCM_REF_V T
					 WHERE T.DAY_DT BETWEEN DATE '2013-01-01' AND DATE '2013-05-07'
					 GROUP BY T.day_dt, T.SUPPLIER_NUM) CM,
				 (SELECT T.day_dt POST_DATE,
								 T.SUPPLIER_NUM,
								 SUM(T.rtv_cost) 退货金额
						FROM RADM.BBG_RA_RTV_REF_V T
					 WHERE T.DAY_DT BETWEEN DATE '2013-01-01' AND DATE '2013-05-07'
					 GROUP BY T.day_dt, T.SUPPLIER_NUM) RTV
	 WHERE CM.POST_DATE = RTV.POST_DATE(+)
		 AND CM.SUPPLIER_NUM = RTV.SUPPLIER_NUM(+)
	UNION
	SELECT RTV.POST_DATE,
				 RTV.SUPPLIER_NUM,
				 NVL(CM.入库金额, 0) P_COST,
				 NVL(RTV.退货金额, 0) R_COST,
				 NVL(CM.入库金额, 0) - NVL(RTV.退货金额, 0) NET_COST
		FROM (SELECT T.day_dt POST_DATE,
								 T.SUPPLIER_NUM,
								 SUM(T.bbg_reference_fo2) 入库金额
						FROM RADM.BBG_RA_SUPPCM_REF_V T
					 WHERE T.DAY_DT BETWEEN DATE '2013-01-01' AND DATE '2013-05-07'
					 GROUP BY T.day_dt, T.SUPPLIER_NUM) CM,
				 (SELECT T.day_dt POST_DATE,
								 T.SUPPLIER_NUM,
								 SUM(T.rtv_cost) 退货金额
						FROM RADM.BBG_RA_RTV_REF_V T
					 WHERE T.DAY_DT BETWEEN DATE '2013-01-01' AND DATE '2013-05-07'
					 GROUP BY T.day_dt, T.SUPPLIER_NUM) RTV
	 WHERE CM.POST_DATE(+) = RTV.POST_DATE
		 AND CM.SUPPLIER_NUM(+) = RTV.SUPPLIER_NUM;

DROP TABLE RADM.YJ_SUPP_IN_OUT_AMT_HIST;

SELECT * FROM RADM.BBG_RA_RTV_REF_V;

SELECT * FROM W_PRODUCT_D;
SELECT * FROM TRAN_DATA_CODES;
SELECT * FROM TRAN_DATA_HISTORY T WHERE T.TRAN_CODE = 20;
SELECT * FROM TRAN_DATA_HISTORY T ORDER BY T.TRAN_DATE;
SELECT * FROM BBG_RA_ITEM_LOC_D IL;
SELECT * FROM W_PARTY_ORG_D;
SELECT * FROM W_PARTY_D;
SELECT * FROM W_PARTY_ORG_D T WHERE T.ROW_WID = 18412;
SELECT * FROM W_PARTY_D T WHERE T.PARTY_ORG_WID = 18412;
SELECT * FROM RMS.SUPS;
SELECT * FROM YJ_SUPP_IN_OUT_AMT_HIST@RMS_RA;
SELECT primary_supp FROM RMS.SUPS;
SELECT * FROM W_RTL_SLS_IT_LC_MN_A;
SELECT * FROM W_PRODUCT_D T WHERE T.PROD_NUM = '100759903';
SELECT * FROM W_INT_ORG_D T WHERE T.ORG_NUM = '120125';
SELECT *
	FROM W_RTL_SLS_IT_LC_MN_A T
 WHERE T.PROD_WID = 942109
	 AND T.ORG_WID = 117
	 AND T.MN_WID = '201312';

--脚步重新写---------------------------
--销售  7'19
DROP MATERIALIZED VIEW YJ_SUPP_SLS_2013;
CREATE MATERIALIZED VIEW YJ_SUPP_SLS_2013 AS
	SELECT IL.PRIMARY_SUPP SUPP,
				 TS.MN_WID,
				 SUM(TS.NORMAL_QTY) NORMAL_QTY, --正常销量
				 SUM(TS.NORMAL_AMT) NORMAL_AMT, --正常销售金额
				 SUM(TS.NORMAL_COST) NORMAL_COST, --正常销售成本
				 SUM(TS.PROMO_QTY) PROMO_QTY, --促销销量
				 SUM(TS.PROMO_AMT) PROMO_AMT, --促销金额
				 SUM(TS.PROMO_COST) PROMO_COST, --促销成本
				 SUM(TS.TOTAL_QTY) TOTAL_QTY, --合计销售量
				 SUM(TS.TOTAL_AMT) TOTAL_AMT, --合计销售金额
				 SUM(TS.TOTAL_COST) TOTAL_COST, --合计销售成本
				 SUM(TS.NORMAL_AMT) - SUM(TS.NORMAL_COST) NORMAL_PROFIT, --正常毛利额
				 DECODE(SUM(TS.NORMAL_AMT),
								0,
								0,
								(SUM(TS.NORMAL_AMT) - SUM(TS.NORMAL_COST)) /
								SUM(TS.NORMAL_AMT)) NORMAL_PROFIT_PER, --正常毛利率
				 SUM(TS.PROMO_AMT) - SUM(TS.PROMO_COST) PROMO_PROFIT, --促销毛利额
				 DECODE(SUM(TS.PROMO_AMT),
								0,
								0,
								(SUM(TS.PROMO_AMT) - SUM(TS.PROMO_COST)) / SUM(TS.PROMO_AMT)) PROMO_PROFIT_PER --促销毛利率
		FROM ITEM_LOC IL,
				 (SELECT TOS.ITEM,
								 TOS.LOC,
								 TOS.MN_WID,
								 SUM(TOS.NORMAL_QTY) NORMAL_QTY,
								 SUM(TOS.NORMAL_AMT) NORMAL_AMT,
								 SUM(TOS.NORMAL_COST) NORMAL_COST,
								 SUM(TOS.PROMO_QTY) PROMO_QTY,
								 SUM(TOS.PROMO_AMT) PROMO_AMT,
								 SUM(TOS.PROMO_COST) PROMO_COST,
								 SUM(TOS.TOTAL_QTY) TOTAL_QTY,
								 SUM(TOS.TOTAL_AMT) TOTAL_AMT,
								 SUM(TOS.TOTAL_COST) TOTAL_COST
						FROM (SELECT PROD.PROD_NUM ITEM,
												 ORG.ORG_NUM LOC,
												 MN_WID,
												 NVL(CASE
															 WHEN SLS.RTL_TYPE_WID = 4 THEN
																SUM(SLS.SLS_QTY - SLS.RET_QTY)
														 END,
														 0) NORMAL_QTY,
												 NVL(CASE
															 WHEN SLS.RTL_TYPE_WID = 4 THEN
																SUM((NVL(SLS.SLS_AMT_LCL, 0) -
																		NVL(SLS.RET_AMT_LCL, 0)) -
																		(NVL(SLS.SLS_TAX_AMT_LCL, 0) -
																		NVL(SLS.RET_TAX_AMT_LCL, 0)))
														 END,
														 0) NORMAL_AMT,
												 NVL(CASE
															 WHEN SLS.RTL_TYPE_WID = 4 THEN
																SUM(((NVL(SLS.SLS_AMT_LCL, 0) -
																		NVL(SLS.RET_AMT_LCL, 0)) -
																		(NVL(SLS.Sls_Tax_Amt_Lcl, 0) -
																		NVL(SLS.Ret_Tax_Amt_Lcl, 0))) -
																		NVL(SLS.SLS_PROFIT_AMT_LCL, 0))
														 END,
														 0) NORMAL_COST,
												 NVL(CASE
															 WHEN SLS.RTL_TYPE_WID <> 4 THEN
																SUM(SLS.SLS_QTY - SLS.RET_QTY)
														 END,
														 0) PROMO_QTY,
												 NVL(CASE
															 WHEN SLS.RTL_TYPE_WID <> 4 THEN
																SUM((NVL(SLS.SLS_AMT_LCL, 0) -
																		NVL(SLS.RET_AMT_LCL, 0)) -
																		(NVL(SLS.SLS_TAX_AMT_LCL, 0) -
																		NVL(SLS.RET_TAX_AMT_LCL, 0)))
														 END,
														 0) PROMO_AMT,
												 NVL(CASE
															 WHEN SLS.RTL_TYPE_WID <> 4 THEN
																SUM(((NVL(SLS.SLS_AMT_LCL, 0) -
																		NVL(SLS.RET_AMT_LCL, 0)) -
																		(NVL(SLS.Sls_Tax_Amt_Lcl, 0) -
																		NVL(SLS.Ret_Tax_Amt_Lcl, 0))) -
																		NVL(SLS.SLS_PROFIT_AMT_LCL, 0))
														 END,
														 0) PROMO_COST,
												 SUM(SLS.SLS_QTY - SLS.RET_QTY) TOTAL_QTY,
												 SUM((NVL(SLS.SLS_AMT_LCL, 0) -
														 NVL(SLS.RET_AMT_LCL, 0)) -
														 (NVL(SLS.SLS_TAX_AMT_LCL, 0) -
														 NVL(SLS.RET_TAX_AMT_LCL, 0))) TOTAL_AMT,
												 SUM(((NVL(SLS.SLS_AMT_LCL, 0) -
														 NVL(SLS.RET_AMT_LCL, 0)) -
														 (NVL(SLS.Sls_Tax_Amt_Lcl, 0) -
														 NVL(SLS.Ret_Tax_Amt_Lcl, 0))) -
														 NVL(SLS.SLS_PROFIT_AMT_LCL, 0)) TOTAL_COST
										FROM W_RTL_SLS_IT_LC_MN_A@RMS_RA SLS,
												 W_PRODUCT_D@RMS_RA          PROD,
												 W_INT_ORG_D@RMS_RA          ORG
									 WHERE SLS.PROD_WID = PROD.ROW_WID(+)
										 AND SLS.ORG_WID = ORG.ROW_WID(+)
										 AND SLS.MN_WID BETWEEN '201301' AND '201312' --销售月份
									 GROUP BY PROD.PROD_NUM,
														ORG.ORG_NUM,
														MN_WID,
														SLS.RTL_TYPE_WID) TOS
					 GROUP BY TOS.ITEM, TOS.LOC, TOS.MN_WID) TS
	 WHERE IL.ITEM = TS.ITEM
		 AND IL.LOC = TS.LOC
	 GROUP BY IL.PRIMARY_SUPP, TS.MN_WID;

--入库,退货,净入库_
--BBG_REFERENCE_FO2入库金额
select *
	from W_RTL_SUPPCM_IT_LC_DY_F t
 WHERE T.BBG_REFERENCE_FO1 <> T.BBG_REFERENCE_FO2;
SELECT PA.SUPPLIER_NUM, SUM(CM.BBG_REFERENCE_FO2) REC_COST
	FROM RADM.W_RTL_SUPPCM_IT_LC_DY_F CM, RADM.W_PARTY_ORG_D PA
 WHERE CM.SUPPLIER_WID = PA.ROW_WID
	 AND CM.DT_WID BETWEEN '120130101000' AND '120131231000'
 GROUP BY PA.SUPPLIER_NUM;
--TRANSFER_COST 退货金额
SELECT PA.SUPPLIER_NUM, SUM(RTV.TRANSFER_COST) RTV_COST
	FROM BBG_RA_RTV_IT_LC_SUPP_DY_F RTV, RADM.W_PARTY_ORG_D PA
 WHERE RTV.SUPPLIER_WID = PA.ROW_WID
	 AND RTV.DT_WID BETWEEN '120130101000' AND '120131231000'
 GROUP BY PA.SUPPLIER_NUM;
--进退货合并
DROP MATERIALIZED VIEW YJ_SUPP_PR_2013;
CREATE MATERIALIZED VIEW YJ_SUPP_PR_2013 AS
	SELECT R.SUPPLIER,
				 R.MN_WID,
				 R.REC_COST,
				 R.RTV_COST,
				 R.REC_COST - R.RTV_COST NET_COST
		FROM (SELECT REC.SUPPLIER_NUM SUPPLIER,
								 REC.MN_WID,
								 NVL(REC.REC_COST, 0) REC_COST,
								 NVL(RTV.RTV_COST, 0) RTV_COST
						FROM (SELECT PA.SUPPLIER_NUM,
												 SUBSTR(CM.DT_WID, 2, 6) MN_WID,
												 SUM(CM.BBG_REFERENCE_FO2) REC_COST
										FROM RADM.W_RTL_SUPPCM_IT_LC_DY_F@RMS_RA CM,
												 RADM.W_PARTY_ORG_D@RMS_RA           PA
									 WHERE CM.SUPPLIER_WID = PA.ROW_WID
										 AND CM.DT_WID BETWEEN '120130101000' AND '120131231000'
									 GROUP BY PA.SUPPLIER_NUM, SUBSTR(CM.DT_WID, 2, 6)) REC,
								 (SELECT PA.SUPPLIER_NUM,
												 SUBSTR(RTV.DT_WID, 2, 6) MN_WID,
												 SUM(RTV.TRANSFER_COST) RTV_COST
										FROM BBG_RA_RTV_IT_LC_SUPP_DY_F@RMS_RA RTV,
												 RADM.W_PARTY_ORG_D@RMS_RA         PA
									 WHERE RTV.SUPPLIER_WID = PA.ROW_WID
										 AND RTV.DT_WID BETWEEN '120130101000' AND '120131231000'
									 GROUP BY PA.SUPPLIER_NUM, SUBSTR(RTV.DT_WID, 2, 6)) RTV
					 WHERE REC.SUPPLIER_NUM = RTV.SUPPLIER_NUM(+)
						 AND REC.MN_WID = RTV.MN_WID(+)
					UNION
					SELECT RTV.SUPPLIER_NUM SUPPLIER,
								 RTV.MN_WID,
								 NVL(REC.REC_COST, 0) REC_COST,
								 NVL(RTV.RTV_COST, 0) RTV_COST
						FROM (SELECT PA.SUPPLIER_NUM,
												 SUBSTR(CM.DT_WID, 2, 6) MN_WID,
												 SUM(CM.BBG_REFERENCE_FO2) REC_COST
										FROM RADM.W_RTL_SUPPCM_IT_LC_DY_F@RMS_RA CM,
												 RADM.W_PARTY_ORG_D@RMS_RA           PA
									 WHERE CM.SUPPLIER_WID = PA.ROW_WID
										 AND CM.DT_WID BETWEEN '120130101000' AND '120131231000'
									 GROUP BY PA.SUPPLIER_NUM, SUBSTR(CM.DT_WID, 2, 6)) REC,
								 (SELECT PA.SUPPLIER_NUM,
												 SUBSTR(RTV.DT_WID, 2, 6) MN_WID,
												 SUM(RTV.TRANSFER_COST) RTV_COST
										FROM BBG_RA_RTV_IT_LC_SUPP_DY_F@RMS_RA RTV,
												 RADM.W_PARTY_ORG_D@RMS_RA         PA
									 WHERE RTV.SUPPLIER_WID = PA.ROW_WID
										 AND RTV.DT_WID BETWEEN '120130101000' AND '120131231000'
									 GROUP BY PA.SUPPLIER_NUM, SUBSTR(RTV.DT_WID, 2, 6)) RTV
					 WHERE REC.SUPPLIER_NUM(+) = RTV.SUPPLIER_NUM
						 AND REC.MN_WID(+) = RTV.MN_WID) R;

--进退销合并
SELECT S.SUPP SUPPLIER,
			 TO_CHAR(S.MN_WID) MN_WID,
			 S.NORMAL_QTY,
			 S.NORMAL_AMT,
			 S.NORMAL_COST,
			 S.PROMO_QTY,
			 S.PROMO_AMT,
			 S.PROMO_COST,
			 S.TOTAL_QTY,
			 S.TOTAL_AMT,
			 S.TOTAL_COST,
			 S.NORMAL_PROFIT,
			 S.NORMAL_PROFIT_PER,
			 S.PROMO_PROFIT,
			 S.PROMO_PROFIT_PER,
			 R.REC_COST,
			 R.RTV_COST,
			 R.NET_COST
	FROM YJ_SUPP_SLS_2013 S,
			 (SELECT RR.MONTH MN_WID,
							 RR.SUPPLIER,
							 SUM(RR.REVENUE) REC_COST,
							 SUM(RR.RTV_REVENUE) RTV_COST,
							 SUM(RR.REVENUE - RR.RTV_REVENUE) NET_COST
					FROM RMSHIST.CMX_RTVRCV_2013 RR
				 GROUP BY RR.MONTH, RR.SUPPLIER) R
 WHERE S.SUPP = R.SUPPLIER(+)
	 AND S.MN_WID = R.MN_WID(+)
UNION
SELECT R.SUPPLIER SUPPLIER,
			 R.MN_WID,
			 S.NORMAL_QTY,
			 S.NORMAL_AMT,
			 S.NORMAL_COST,
			 S.PROMO_QTY,
			 S.PROMO_AMT,
			 S.PROMO_COST,
			 S.TOTAL_QTY,
			 S.TOTAL_AMT,
			 S.TOTAL_COST,
			 S.NORMAL_PROFIT,
			 S.NORMAL_PROFIT_PER,
			 S.PROMO_PROFIT,
			 S.PROMO_PROFIT_PER,
			 R.REC_COST,
			 R.RTV_COST,
			 R.NET_COST
	FROM YJ_SUPP_SLS_2013 S,
			 (SELECT RR.MONTH MN_WID,
							 RR.SUPPLIER,
							 SUM(RR.REVENUE) REC_COST,
							 SUM(RR.RTV_REVENUE) RTV_COST,
							 SUM(RR.REVENUE - RR.RTV_REVENUE) NET_COST
					FROM RMSHIST.CMX_RTVRCV_2013 RR
				 GROUP BY RR.MONTH, RR.SUPPLIER) R
 WHERE S.SUPP(+) = R.SUPPLIER
	 AND S.MN_WID(+) = R.MN_WID;

SELECT RR.MONTH MN_WID,
			 RR.SUPPLIER,
			 SUM(RR.REVENUE) REC_COST,
			 SUM(RR.RTV_REVENUE) RTV_COST,
			 SUM(RR.REVENUE - RR.RTV_REVENUE) NET_COST
	FROM RMSHIST.CMX_RTVRCV_2013 RR
 GROUP BY RR.MONTH, RR.SUPPLIER;
SELECT * FROM rmshist.cmx_rtvrcv_2013;

--正式合并_RMS
SELECT TS.MN_WID 月份,
			 SUP1.SUPPLIER 一级供应商,
			 SUP1.SUP_NAME 一级供应商名称,
			 SUP2.SUPPLIER 二级供应商,
			 SUP2.SUP_NAME 二级供应商名称,
			 CO.CONTRACT_NO 二级供应商合同号,
			 SUBSTR(SUP2.SUPPLIER, 1, 2) 合同大类,
			 (SELECT UV.UDA_VALUE_DESC
					FROM UDA_VALUES UV
				 WHERE UV.UDA_ID = 3
					 AND UV.UDA_VALUE = CO.BRAND_CODE) 经营主要品牌,
			 (SELECT CD.CODE_DESC
					FROM CMX_CODE_DETAIL CD
				 WHERE CD.CODE = CO.CONTRACT_TYPE
					 AND CD.CODE_TYPE = 'BSTP'
					 AND CD.LANG = 8) 合同类型,
			 CO.ITEMS_NUM 及时正常SKU数,
			 SUP3.QTY 经营门店数,
			 TS.REC_COST 入库金额,
			 TS.RTV_COST 退货金额,
			 TS.NET_COST 净入库金额,
			 TS.NORMAL_QTY 正常销量,
			 TS.NORMAL_AMT 正常销售金额,
			 TS.NORMAL_COST 正常销售成本,
			 TS.PROMO_QTY 促销销量,
			 TS.PROMO_AMT 促销销售金额,
			 TS.PROMO_COST 促销销售成本,
			 --TS.TOTAL_QTY ,
			 TS.TOTAL_AMT 合计销售金额,
			 TS.TOTAL_COST 合计销售成本,
			 TS.NORMAL_PROFIT 正常毛利额,
			 TS.NORMAL_PROFIT_PER 正常毛利率,
			 TS.PROMO_PROFIT 促销毛利额,
			 TS.PROMO_PROFIT_PER 促销毛利率,
			 CASE
				 WHEN CO.STATUS = 'C' THEN
					'终止'
				 WHEN CO.STATUS = 'A' THEN
					'正在执行'
				 WHEN CO.STATUS = 'S' THEN
					'录入'
				 WHEN CO.STATUS = 'I' THEN
					'提交'
				 ELSE
					NULL
			 END AS 合同状态,
			 (SELECT TH.TERMS_DESC
					FROM TERMS_HEAD TH
				 WHERE TH.TERMS_CODE = SUP2.TERMS) 方式
	FROM SUPS SUP1,
			 SUPS SUP2,
			 CMX_CONTRACT CO,
			 (select il.primary_supp, count(distinct il.loc) qty
					from item_loc il
				 group by il.primary_supp) sup3,
			 (SELECT C.SUPPLIER,
							 MAX(C.CONTRACT_ID) CONTRACT_ID,
							 MAX(C.CONTRACT_NO) CONTRACT_NO
					FROM CMX_CONTRACT C
				 WHERE C.YEAR = '2013'
				 GROUP BY C.SUPPLIER) CO1,
			 (SELECT S.SUPP SUPPLIER,
							 TO_CHAR(S.MN_WID) MN_WID,
							 S.NORMAL_QTY,
							 S.NORMAL_AMT,
							 S.NORMAL_COST,
							 S.PROMO_QTY,
							 S.PROMO_AMT,
							 S.PROMO_COST,
							 S.TOTAL_QTY,
							 S.TOTAL_AMT,
							 S.TOTAL_COST,
							 S.NORMAL_PROFIT,
							 S.NORMAL_PROFIT_PER,
							 S.PROMO_PROFIT,
							 S.PROMO_PROFIT_PER,
							 R.REC_COST,
							 R.RTV_COST,
							 R.NET_COST
					FROM YJ_SUPP_SLS_2013 S,
							 (SELECT RR.MONTH MN_WID,
											 RR.SUPPLIER,
											 SUM(RR.REVENUE) REC_COST,
											 SUM(RR.RTV_REVENUE) RTV_COST,
											 SUM(RR.REVENUE - RR.RTV_REVENUE) NET_COST
									FROM RMSHIST.CMX_RTVRCV_2013 RR
								 GROUP BY RR.MONTH, RR.SUPPLIER) R
				 WHERE S.SUPP = R.SUPPLIER(+)
					 AND S.MN_WID = R.MN_WID(+)
				UNION
				SELECT R.SUPPLIER SUPPLIER,
							 R.MN_WID,
							 S.NORMAL_QTY,
							 S.NORMAL_AMT,
							 S.NORMAL_COST,
							 S.PROMO_QTY,
							 S.PROMO_AMT,
							 S.PROMO_COST,
							 S.TOTAL_QTY,
							 S.TOTAL_AMT,
							 S.TOTAL_COST,
							 S.NORMAL_PROFIT,
							 S.NORMAL_PROFIT_PER,
							 S.PROMO_PROFIT,
							 S.PROMO_PROFIT_PER,
							 R.REC_COST,
							 R.RTV_COST,
							 R.NET_COST
					FROM YJ_SUPP_SLS_2013 S,
							 (SELECT RR.MONTH MN_WID,
											 RR.SUPPLIER,
											 SUM(RR.REVENUE) REC_COST,
											 SUM(RR.RTV_REVENUE) RTV_COST,
											 SUM(RR.REVENUE - RR.RTV_REVENUE) NET_COST
									FROM RMSHIST.CMX_RTVRCV_2013 RR
								 GROUP BY RR.MONTH, RR.SUPPLIER) R
				 WHERE S.SUPP(+) = R.SUPPLIER
					 AND S.MN_WID(+) = R.MN_WID) TS
 WHERE SUP1.SUPPLIER = SUP2.SUPPLIER_PARENT
	 AND SUP2.SUPPLIER = CO1.SUPPLIER
	 AND CO.CONTRACT_ID = CO1.CONTRACT_ID
	 AND CO.CONTRACT_NO = CO1.CONTRACT_NO
	 AND CO.SUPPLIER = CO1.SUPPLIER
	 AND CO1.SUPPLIER = SUP3.primary_supp(+)
	 AND CO1.SUPPLIER = TS.SUPPLIER(+);
