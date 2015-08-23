CREATE OR REPLACE PROCEDURE JIN_UPDATE_VIP_SLS_TRX_PROC AS
BEGIN
  --更新RADM.W_RTL_SLS_TRX_IT_LC_DY_F表的VIP开头的列的数据，日期范围：2014.1.1--2015.6.23
	execute immediate 'ALTER TABLE RADM.W_RTL_SLS_TRX_IT_LC_DY_F NOLOGGING';
	UPDATE /*+PARALLEL(A,16)*/  RADM.W_RTL_SLS_TRX_IT_LC_DY_F PARTITION(RTL_SLS_TRX_IT_LC_DY_F_201506) A 
		 SET A.vip_sls_qty                 = CASE WHEN A.VIP_sls_qty IS NULL THEN CASE WHEN A.HYK_NO IS NOT NULL THEN A.sls_qty ELSE 0 END ELSE A.VIP_sls_qty END,
				 A.vip_sls_amt_lcl             = CASE WHEN A.VIP_sls_amt_lcl IS NULL THEN CASE WHEN A.HYK_NO IS NOT NULL THEN A.sls_amt_lcl ELSE 0 END ELSE A.VIP_sls_amt_lcl END,
				 A.vip_sls_profit_amt_lcl      = CASE WHEN A.VIP_sls_profit_amt_lcl IS NULL THEN CASE WHEN A.HYK_NO IS NOT NULL THEN A.sls_profit_amt_lcl ELSE 0 END ELSE A.VIP_sls_profit_amt_lcl END,
				 A.vip_sls_manual_mkdn_amt_lcl = CASE WHEN A.VIP_sls_manual_mkdn_amt_lcl IS NULL THEN CASE WHEN A.HYK_NO IS NOT NULL THEN A.sls_manual_mkdn_amt_lcl ELSE 0 END ELSE A.VIP_sls_manual_mkdn_amt_lcl END,
				 A.vip_sls_manual_mkup_amt_lcl = CASE WHEN A.VIP_sls_manual_mkup_amt_lcl IS NULL THEN CASE WHEN A.HYK_NO IS NOT NULL THEN A.sls_manual_mkup_amt_lcl ELSE 0 END ELSE A.VIP_sls_manual_mkup_amt_lcl END,
				 A.vip_sls_tax_amt_lcl         = CASE WHEN A.VIP_sls_tax_amt_lcl IS NULL THEN CASE WHEN A.HYK_NO IS NOT NULL THEN A.sls_tax_amt_lcl ELSE 0 END ELSE A.VIP_sls_tax_amt_lcl END,
				 A.vip_sls_emp_disc_amt_lcl    = CASE WHEN A.VIP_sls_emp_disc_amt_lcl IS NULL THEN CASE WHEN A.HYK_NO IS NOT NULL THEN A.sls_emp_disc_amt_lcl ELSE 0 END ELSE A.VIP_sls_emp_disc_amt_lcl END,
				 A.vip_sls_manual_count        = CASE WHEN A.VIP_sls_manual_count IS NULL THEN CASE WHEN A.HYK_NO IS NOT NULL THEN A.sls_manual_count ELSE 0 END ELSE A.VIP_sls_manual_count END,
				 A.vip_sls_scan_count          = CASE WHEN A.VIP_sls_scan_count IS NULL THEN CASE WHEN A.HYK_NO IS NOT NULL THEN A.sls_scan_count ELSE 0 END ELSE A.VIP_sls_scan_count END,
				 A.vip_ret_qty                 = CASE WHEN A.VIP_ret_qty IS NULL THEN CASE WHEN A.HYK_NO IS NOT NULL THEN A.ret_qty ELSE 0 END ELSE A.VIP_ret_qty END,
				 A.vip_ret_amt_lcl             = CASE WHEN A.VIP_ret_amt_lcl IS NULL THEN CASE WHEN A.HYK_NO IS NOT NULL THEN A.ret_amt_lcl ELSE 0 END ELSE A.VIP_ret_amt_lcl END,
				 A.vip_ret_profit_amt_lcl      = CASE WHEN A.VIP_ret_profit_amt_lcl IS NULL THEN CASE WHEN A.HYK_NO IS NOT NULL THEN A.ret_profit_amt_lcl ELSE 0 END ELSE A.VIP_ret_profit_amt_lcl END,
				 A.vip_ret_manual_mkdn_amt_lcl = CASE WHEN A.VIP_ret_manual_mkdn_amt_lcl IS NULL THEN CASE WHEN A.HYK_NO IS NOT NULL THEN A.ret_manual_mkdn_amt_lcl ELSE 0 END ELSE A.VIP_ret_manual_mkdn_amt_lcl END,
				 A.vip_ret_manual_mkup_amt_lcl = CASE WHEN A.VIP_ret_manual_mkup_amt_lcl IS NULL THEN CASE WHEN A.HYK_NO IS NOT NULL THEN A.ret_manual_mkup_amt_lcl ELSE 0 END ELSE A.VIP_ret_manual_mkup_amt_lcl END,
				 A.vip_ret_tax_amt_lcl         = CASE WHEN A.VIP_ret_tax_amt_lcl IS NULL THEN CASE WHEN A.HYK_NO IS NOT NULL THEN A.ret_tax_amt_lcl ELSE 0 END ELSE A.VIP_ret_tax_amt_lcl END,
				 A.vip_ret_emp_disc_amt_lcl    = CASE WHEN A.VIP_ret_emp_disc_amt_lcl IS NULL THEN CASE WHEN A.HYK_NO IS NOT NULL THEN A.ret_emp_disc_amt_lcl ELSE 0 END ELSE A.VIP_ret_emp_disc_amt_lcl END,
				 A.vip_ret_manual_count        = CASE WHEN A.VIP_ret_manual_count IS NULL THEN CASE WHEN A.HYK_NO IS NOT NULL THEN A.ret_manual_count ELSE 0 END ELSE A.VIP_ret_manual_count END,
				 A.vip_ret_scan_count          = CASE WHEN A.VIP_ret_scan_count IS NULL THEN CASE WHEN A.HYK_NO IS NOT NULL THEN A.ret_scan_count ELSE 0 END ELSE A.VIP_ret_scan_count END;
	COMMIT;
	execute immediate 'ALTER TABLE RADM.W_RTL_SLS_TRX_IT_LC_DY_F LOGGING';
END;
/
