select * from W_RTL_SLS_IT_DY_A t WHERE T.DT_WID = 120150624000;

UPDATE RADM.W_RTL_SLS_IT_DY_A T
   SET T.SLS_QTY                     = T.SLS_QTY / 2,
       T.SLS_AMT_LCL                 = T.SLS_AMT_LCL / 2,
       T.SLS_PROFIT_AMT_LCL          = T.SLS_PROFIT_AMT_LCL / 2,
       T.SLS_TAX_AMT_LCL             = T.SLS_TAX_AMT_LCL / 2,
       T.sls_emp_disc_amt_lcl        = T.sls_emp_disc_amt_lcl / 2,
       T.ret_qty                     = T.ret_qty / 2,
       T.ret_amt_lcl                 = T.ret_amt_lcl / 2,
       T.ret_profit_amt_lcl          = T.ret_profit_amt_lcl / 2,
       T.ret_tax_amt_lcl             = T.ret_tax_amt_lcl / 2,
       T.ret_emp_disc_amt_lcl        = T.ret_emp_disc_amt_lcl / 2,
       T.sls_manual_mkdn_amt_lcl     = T.sls_manual_mkdn_amt_lcl / 2,
       T.sls_manual_mkup_amt_lcl     = T.sls_manual_mkup_amt_lcl / 2,
       T.ret_manual_mkdn_amt_lcl     = T.ret_manual_mkdn_amt_lcl / 2,
       T.ret_manual_mkup_amt_lcl     = T.ret_manual_mkup_amt_lcl / 2,
       T.sls_amt                     = T.sls_amt / 2,
       T.SLS_PROFIT_AMT              = T.SLS_PROFIT_AMT / 2,
       T.SLS_MANUAL_MKDN_AMT         = T.SLS_MANUAL_MKDN_AMT / 2,
       T.sls_manual_mkup_amt         = T.sls_manual_mkup_amt / 2,
       T.sls_tax_amt                 = T.sls_tax_amt / 2,
       T.sls_emp_disc_amt            = T.sls_emp_disc_amt / 2,
       T.ret_amt                     = T.ret_amt / 2,
       T.ret_profit_amt              = T.ret_profit_amt / 2,
       T.ret_manual_mkdn_amt         = T.ret_manual_mkdn_amt / 2,
       T.ret_manual_mkup_amt         = T.ret_manual_mkup_amt / 2,
       T.ret_tax_amt                 = T.ret_tax_amt / 2,
       T.ret_emp_disc_amt            = T.ret_emp_disc_amt / 2,
       T.sls_manual_count            = T.sls_manual_count / 2,
       T.sls_scan_count              = T.sls_scan_count / 2,
       T.ret_manual_count            = T.ret_manual_count / 2,
       T.ret_scan_count              = T.ret_scan_count / 2,
       T.vip_sls_qty                 = T.vip_sls_qty / 2,
       T.vip_sls_amt_lcl             = T.vip_sls_amt_lcl / 2,
       T.vip_sls_profit_amt_lcl      = T.vip_sls_profit_amt_lcl / 2,
       T.vip_sls_tax_amt_lcl         = T.vip_sls_tax_amt_lcl / 2,
       T.vip_sls_emp_disc_amt_lcl    = T.vip_sls_emp_disc_amt_lcl / 2,
       T.vip_ret_qty                 = T.vip_ret_qty / 2,
       T.vip_ret_amt_lcl             = T.vip_ret_amt_lcl / 2,
       T.vip_ret_profit_amt_lcl      = T.vip_ret_profit_amt_lcl / 2,
       T.vip_ret_tax_amt_lcl         = T.vip_ret_tax_amt_lcl / 2,
       T.vip_ret_emp_disc_amt_lcl    = T.vip_ret_emp_disc_amt_lcl / 2,
       T.vip_sls_manual_mkdn_amt_lcl = T.vip_sls_manual_mkdn_amt_lcl / 2,
       T.vip_sls_manual_mkup_amt_lcl = T.vip_sls_manual_mkup_amt_lcl / 2,
       T.vip_ret_manual_mkdn_amt_lcl = T.vip_ret_manual_mkdn_amt_lcl / 2,
       T.vip_ret_manual_mkup_amt_lcl = T.vip_ret_manual_mkup_amt_lcl / 2,
       T.vip_sls_amt                 = T.vip_sls_amt / 2,
       T.VIP_SLS_PROFIT_AMT          = T.VIP_SLS_PROFIT_AMT / 2,
       T.vip_sls_manual_mkdn_amt     = T.vip_sls_manual_mkdn_amt / 2,
       T.vip_sls_manual_mkup_amt     = T.vip_sls_manual_mkup_amt / 2,
       T.vip_sls_tax_amt             = T.vip_sls_tax_amt / 2,
       T.vip_sls_emp_disc_amt        = T.vip_sls_emp_disc_amt / 2,
       T.vip_ret_amt                 = T.vip_ret_amt / 2,
       T.vip_ret_profit_amt          = T.vip_ret_profit_amt / 2,
       T.vip_ret_manual_mkdn_amt     = T.vip_ret_manual_mkdn_amt / 2,
       T.vip_ret_manual_mkup_amt     = T.vip_ret_manual_mkup_amt / 2,
       T.vip_ret_tax_amt             = T.vip_ret_tax_amt / 2,
       T.vip_ret_emp_disc_amt        = T.vip_ret_emp_disc_amt / 2,
       T.vip_sls_manual_count        = T.vip_sls_manual_count / 2,
       T.vip_sls_scan_count          = T.vip_sls_scan_count / 2,
       T.vip_ret_manual_count        = T.vip_ret_manual_count / 2,
       T.vip_ret_scan_count          = T.vip_ret_scan_count / 2
 WHERE T.DT_WID = 120150624000;
