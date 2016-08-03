--******************************
--SDE
--******************************
--ADD COLUMN NAME:BBG_MINUS_COUPON_TRX_AMT

-- ADD/MODIFY COLUMNS 
ALTER TABLE RA_RMS.W_RTL_SLS_TRX_TMP ADD BBG_COUPON_TRX_AMT NUMBER(20,4);
ALTER TABLE RA_RMS.W_RTL_SLS_TRX_TMP ADD BBG_TAX_EX_COUPON_TRX_AMT NUMBER(20,4);
-- ADD COMMENTS TO THE COLUMNS 
COMMENT ON COLUMN RA_RMS.W_RTL_SLS_TRX_TMP.BBG_COUPON_TRX_AMT
  IS '劵销售金额(50,51,52)';
COMMENT ON COLUMN RA_RMS.W_RTL_SLS_TRX_TMP.TAX_INC_TRX_AMT
  IS '含券销售金额';
COMMENT ON COLUMN RA_RMS.W_RTL_SLS_TRX_TMP.BBG_TAX_EX_COUPON_TRX_AMT
  IS '未税劵销售金额(50,51,52)';

-- ADD/MODIFY COLUMNS 
ALTER TABLE RA_RMS.W_RTL_SLSPK_TRX_TMP ADD SLS_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RA_RMS.W_RTL_SLSPK_TRX_TMP ADD RET_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RA_RMS.W_RTL_SLSPK_TRX_TMP ADD SLS_TAX_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RA_RMS.W_RTL_SLSPK_TRX_TMP ADD RET_TAX_COUPON_AMT_LCL NUMBER(20,4);
-- ADD COMMENTS TO THE COLUMNS 
COMMENT ON COLUMN RA_RMS.W_RTL_SLSPK_TRX_TMP.SLS_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)';
COMMENT ON COLUMN RA_RMS.W_RTL_SLSPK_TRX_TMP.RET_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)';
COMMENT ON COLUMN RA_RMS.W_RTL_SLSPK_TRX_TMP.SLS_TAX_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)税额';
COMMENT ON COLUMN RA_RMS.W_RTL_SLSPK_TRX_TMP.RET_TAX_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)税额';


-- ADD/MODIFY COLUMNS 
ALTER TABLE W_RTL_SLS_TRX_IT_LC_DY_FS ADD SLS_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE W_RTL_SLS_TRX_IT_LC_DY_FS ADD RET_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE W_RTL_SLS_TRX_IT_LC_DY_FS ADD SLS_TAX_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE W_RTL_SLS_TRX_IT_LC_DY_FS ADD RET_TAX_COUPON_AMT_LCL NUMBER(20,4);
-- ADD COMMENTS TO THE COLUMNS 
COMMENT ON COLUMN W_RTL_SLS_TRX_IT_LC_DY_FS.SLS_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)';
COMMENT ON COLUMN W_RTL_SLS_TRX_IT_LC_DY_FS.RET_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)';
COMMENT ON COLUMN W_RTL_SLS_TRX_IT_LC_DY_FS.SLS_TAX_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)税额';
COMMENT ON COLUMN W_RTL_SLS_TRX_IT_LC_DY_FS.RET_TAX_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)税额';	
	
--******************************
--SIL
--******************************	
-- ADD/MODIFY COLUMNS 
ALTER TABLE RABATCHER.W_RTL_SLS_TRX_IT_LC_DY_TMP ADD SLS_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RABATCHER.W_RTL_SLS_TRX_IT_LC_DY_TMP ADD RET_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RABATCHER.W_RTL_SLS_TRX_IT_LC_DY_TMP ADD SLS_TAX_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RABATCHER.W_RTL_SLS_TRX_IT_LC_DY_TMP ADD RET_TAX_COUPON_AMT_LCL NUMBER(20,4);
-- ADD COMMENTS TO THE COLUMNS 
COMMENT ON COLUMN RABATCHER.W_RTL_SLS_TRX_IT_LC_DY_TMP.SLS_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)';
COMMENT ON COLUMN RABATCHER.W_RTL_SLS_TRX_IT_LC_DY_TMP.RET_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)';
COMMENT ON COLUMN RABATCHER.W_RTL_SLS_TRX_IT_LC_DY_TMP.SLS_TAX_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)税额';
COMMENT ON COLUMN RABATCHER.W_RTL_SLS_TRX_IT_LC_DY_TMP.RET_TAX_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)税额';


-- ADD/MODIFY COLUMNS 
ALTER TABLE RADM.W_RTL_SLS_TRX_IT_LC_DY_F ADD SLS_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_TRX_IT_LC_DY_F ADD RET_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_TRX_IT_LC_DY_F ADD SLS_TAX_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_TRX_IT_LC_DY_F ADD RET_TAX_COUPON_AMT_LCL NUMBER(20,4);
-- ADD COMMENTS TO THE COLUMNS 
COMMENT ON COLUMN RADM.W_RTL_SLS_TRX_IT_LC_DY_F.SLS_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)';
COMMENT ON COLUMN RADM.W_RTL_SLS_TRX_IT_LC_DY_F.RET_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)';
COMMENT ON COLUMN RADM.W_RTL_SLS_TRX_IT_LC_DY_F.SLS_TAX_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)税额';
COMMENT ON COLUMN RADM.W_RTL_SLS_TRX_IT_LC_DY_F.RET_TAX_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)税额';

--******************************
--PLP
--******************************
-- ADD/MODIFY COLUMNS 
ALTER TABLE RABATCHER.W_RTL_SLS_IT_LC_DY_TMP ADD SLS_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RABATCHER.W_RTL_SLS_IT_LC_DY_TMP ADD RET_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RABATCHER.W_RTL_SLS_IT_LC_DY_TMP ADD SLS_TAX_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RABATCHER.W_RTL_SLS_IT_LC_DY_TMP ADD RET_TAX_COUPON_AMT_LCL NUMBER(20,4);
-- ADD COMMENTS TO THE COLUMNS 
COMMENT ON COLUMN RABATCHER.W_RTL_SLS_IT_LC_DY_TMP.SLS_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)';
COMMENT ON COLUMN RABATCHER.W_RTL_SLS_IT_LC_DY_TMP.RET_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)';
COMMENT ON COLUMN RABATCHER.W_RTL_SLS_IT_LC_DY_TMP.SLS_TAX_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)税额';
COMMENT ON COLUMN RABATCHER.W_RTL_SLS_IT_LC_DY_TMP.RET_TAX_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)税额';

-- ADD/MODIFY COLUMNS 
ALTER TABLE RABATCHER.BBG_RA_SLS_CL_BM_DY_TMP ADD SLS_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RABATCHER.BBG_RA_SLS_CL_BM_DY_TMP ADD RET_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RABATCHER.BBG_RA_SLS_CL_BM_DY_TMP ADD SLS_TAX_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RABATCHER.BBG_RA_SLS_CL_BM_DY_TMP ADD RET_TAX_COUPON_AMT_LCL NUMBER(20,4);
-- ADD COMMENTS TO THE COLUMNS 
COMMENT ON COLUMN RABATCHER.BBG_RA_SLS_CL_BM_DY_TMP.SLS_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)';
COMMENT ON COLUMN RABATCHER.BBG_RA_SLS_CL_BM_DY_TMP.RET_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)'; 
COMMENT ON COLUMN RABATCHER.BBG_RA_SLS_CL_BM_DY_TMP.SLS_TAX_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)税额';
COMMENT ON COLUMN RABATCHER.BBG_RA_SLS_CL_BM_DY_TMP.RET_TAX_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)税额';
	
-- ADD/MODIFY COLUMNS 
ALTER TABLE RADM.BBG_RA_SLS_CL_BM_DY_A ADD SLS_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.BBG_RA_SLS_CL_BM_DY_A ADD RET_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.BBG_RA_SLS_CL_BM_DY_A ADD SLS_TAX_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.BBG_RA_SLS_CL_BM_DY_A ADD RET_TAX_COUPON_AMT_LCL NUMBER(20,4);
-- ADD COMMENTS TO THE COLUMNS 
COMMENT ON COLUMN RADM.BBG_RA_SLS_CL_BM_DY_A.SLS_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)';
COMMENT ON COLUMN RADM.BBG_RA_SLS_CL_BM_DY_A.RET_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)';
COMMENT ON COLUMN RADM.BBG_RA_SLS_CL_BM_DY_A.SLS_TAX_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)税额';
COMMENT ON COLUMN RADM.BBG_RA_SLS_CL_BM_DY_A.RET_TAX_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)税额';
	
-- ADD/MODIFY COLUMNS 
ALTER TABLE RABATCHER.BBG_RA_SLS_DP_BM_DY_TMP ADD SLS_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RABATCHER.BBG_RA_SLS_DP_BM_DY_TMP ADD RET_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RABATCHER.BBG_RA_SLS_DP_BM_DY_TMP ADD SLS_TAX_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RABATCHER.BBG_RA_SLS_DP_BM_DY_TMP ADD RET_TAX_COUPON_AMT_LCL NUMBER(20,4);
-- ADD COMMENTS TO THE COLUMNS 
COMMENT ON COLUMN RABATCHER.BBG_RA_SLS_DP_BM_DY_TMP.SLS_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)';
COMMENT ON COLUMN RABATCHER.BBG_RA_SLS_DP_BM_DY_TMP.RET_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)';
COMMENT ON COLUMN RABATCHER.BBG_RA_SLS_DP_BM_DY_TMP.SLS_TAX_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)税额';
COMMENT ON COLUMN RABATCHER.BBG_RA_SLS_DP_BM_DY_TMP.RET_TAX_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)税额';
	
-- ADD/MODIFY COLUMNS 
ALTER TABLE RADM.BBG_RA_SLS_DP_BM_DY_A ADD SLS_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.BBG_RA_SLS_DP_BM_DY_A ADD RET_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.BBG_RA_SLS_DP_BM_DY_A ADD SLS_TAX_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.BBG_RA_SLS_DP_BM_DY_A ADD RET_TAX_COUPON_AMT_LCL NUMBER(20,4);
-- ADD COMMENTS TO THE COLUMNS 
COMMENT ON COLUMN RADM.BBG_RA_SLS_DP_BM_DY_A.SLS_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)';
COMMENT ON COLUMN RADM.BBG_RA_SLS_DP_BM_DY_A.RET_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)';
COMMENT ON COLUMN RADM.BBG_RA_SLS_DP_BM_DY_A.SLS_TAX_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)税额';
COMMENT ON COLUMN RADM.BBG_RA_SLS_DP_BM_DY_A.RET_TAX_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)税额';
	
-- ADD/MODIFY COLUMNS 
ALTER TABLE RABATCHER.BBG_RA_SLS_DV_BM_DY_TMP ADD SLS_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RABATCHER.BBG_RA_SLS_DV_BM_DY_TMP ADD RET_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RABATCHER.BBG_RA_SLS_DV_BM_DY_TMP ADD SLS_TAX_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RABATCHER.BBG_RA_SLS_DV_BM_DY_TMP ADD RET_TAX_COUPON_AMT_LCL NUMBER(20,4);
-- ADD COMMENTS TO THE COLUMNS 
COMMENT ON COLUMN RABATCHER.BBG_RA_SLS_DV_BM_DY_TMP.SLS_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)';
COMMENT ON COLUMN RABATCHER.BBG_RA_SLS_DV_BM_DY_TMP.RET_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)';
COMMENT ON COLUMN RABATCHER.BBG_RA_SLS_DV_BM_DY_TMP.SLS_TAX_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)税额';
COMMENT ON COLUMN RABATCHER.BBG_RA_SLS_DV_BM_DY_TMP.RET_TAX_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)税额';
	
-- ADD/MODIFY COLUMNS 
ALTER TABLE RADM.BBG_RA_SLS_DV_BM_DY_A ADD SLS_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.BBG_RA_SLS_DV_BM_DY_A ADD RET_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.BBG_RA_SLS_DV_BM_DY_A ADD SLS_TAX_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.BBG_RA_SLS_DV_BM_DY_A ADD RET_TAX_COUPON_AMT_LCL NUMBER(20,4);
-- ADD COMMENTS TO THE COLUMNS 
COMMENT ON COLUMN RADM.BBG_RA_SLS_DV_BM_DY_A.SLS_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)';
COMMENT ON COLUMN RADM.BBG_RA_SLS_DV_BM_DY_A.RET_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)';
COMMENT ON COLUMN RADM.BBG_RA_SLS_DV_BM_DY_A.SLS_TAX_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)税额';
COMMENT ON COLUMN RADM.BBG_RA_SLS_DV_BM_DY_A.RET_TAX_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)税额';

-- ADD/MODIFY COLUMNS 
ALTER TABLE RADM.W_RTL_SLS_IT_LC_DY_A ADD SLS_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_IT_LC_DY_A ADD RET_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_IT_LC_DY_A ADD SLS_TAX_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_IT_LC_DY_A ADD RET_TAX_COUPON_AMT_LCL NUMBER(20,4);
-- ADD COMMENTS TO THE COLUMNS 
COMMENT ON COLUMN RADM.W_RTL_SLS_IT_LC_DY_A.SLS_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)';
COMMENT ON COLUMN RADM.W_RTL_SLS_IT_LC_DY_A.RET_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)';
COMMENT ON COLUMN RADM.W_RTL_SLS_IT_LC_DY_A.SLS_TAX_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)税额';
COMMENT ON COLUMN RADM.W_RTL_SLS_IT_LC_DY_A.RET_TAX_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)税额';
	
-- ADD/MODIFY COLUMNS 
ALTER TABLE RABATCHER.W_RTL_SLS_SC_LC_DY_TMP ADD SLS_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RABATCHER.W_RTL_SLS_SC_LC_DY_TMP ADD RET_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RABATCHER.W_RTL_SLS_SC_LC_DY_TMP ADD SLS_TAX_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RABATCHER.W_RTL_SLS_SC_LC_DY_TMP ADD RET_TAX_COUPON_AMT_LCL NUMBER(20,4);
-- ADD COMMENTS TO THE COLUMNS 
COMMENT ON COLUMN RABATCHER.W_RTL_SLS_SC_LC_DY_TMP.SLS_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)';
COMMENT ON COLUMN RABATCHER.W_RTL_SLS_SC_LC_DY_TMP.RET_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)';
COMMENT ON COLUMN RABATCHER.W_RTL_SLS_SC_LC_DY_TMP.SLS_TAX_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)税额';
COMMENT ON COLUMN RABATCHER.W_RTL_SLS_SC_LC_DY_TMP.RET_TAX_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)税额';
	
-- ADD/MODIFY COLUMNS 
ALTER TABLE RADM.W_RTL_SLS_SC_LC_DY_A ADD SLS_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_SC_LC_DY_A ADD RET_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_SC_LC_DY_A ADD SLS_TAX_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_SC_LC_DY_A ADD RET_TAX_COUPON_AMT_LCL NUMBER(20,4);
-- ADD COMMENTS TO THE COLUMNS 
COMMENT ON COLUMN RADM.W_RTL_SLS_SC_LC_DY_A.SLS_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)';
COMMENT ON COLUMN RADM.W_RTL_SLS_SC_LC_DY_A.RET_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)';
COMMENT ON COLUMN RADM.W_RTL_SLS_SC_LC_DY_A.SLS_TAX_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)税额';
COMMENT ON COLUMN RADM.W_RTL_SLS_SC_LC_DY_A.RET_TAX_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)税额';
	
-- ADD/MODIFY COLUMNS 
ALTER TABLE RADM.W_RTL_SLS_CL_LC_DY_A ADD SLS_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_CL_LC_DY_A ADD RET_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_CL_LC_DY_A ADD SLS_TAX_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_CL_LC_DY_A ADD RET_TAX_COUPON_AMT_LCL NUMBER(20,4);
-- ADD COMMENTS TO THE COLUMNS 
COMMENT ON COLUMN RADM.W_RTL_SLS_CL_LC_DY_A.SLS_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)';
COMMENT ON COLUMN RADM.W_RTL_SLS_CL_LC_DY_A.RET_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)';
COMMENT ON COLUMN RADM.W_RTL_SLS_CL_LC_DY_A.SLS_TAX_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)税额';
COMMENT ON COLUMN RADM.W_RTL_SLS_CL_LC_DY_A.RET_TAX_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)税额';
	
-- ADD/MODIFY COLUMNS 
ALTER TABLE RADM.W_RTL_SLS_DP_LC_DY_A ADD SLS_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_DP_LC_DY_A ADD RET_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_DP_LC_DY_A ADD SLS_TAX_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_DP_LC_DY_A ADD RET_TAX_COUPON_AMT_LCL NUMBER(20,4);
-- ADD COMMENTS TO THE COLUMNS 
COMMENT ON COLUMN RADM.W_RTL_SLS_DP_LC_DY_A.SLS_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)';
COMMENT ON COLUMN RADM.W_RTL_SLS_DP_LC_DY_A.RET_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)';
COMMENT ON COLUMN RADM.W_RTL_SLS_DP_LC_DY_A.SLS_TAX_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)税额';
COMMENT ON COLUMN RADM.W_RTL_SLS_DP_LC_DY_A.RET_TAX_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)税额';
	
-- ADD/MODIFY COLUMNS 
ALTER TABLE RABATCHER.W_RTL_SLS_IT_DY_TMP ADD SLS_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RABATCHER.W_RTL_SLS_IT_DY_TMP ADD RET_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RABATCHER.W_RTL_SLS_IT_DY_TMP ADD SLS_TAX_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RABATCHER.W_RTL_SLS_IT_DY_TMP ADD RET_TAX_COUPON_AMT_LCL NUMBER(20,4);
-- ADD COMMENTS TO THE COLUMNS 
COMMENT ON COLUMN RABATCHER.W_RTL_SLS_IT_DY_TMP.SLS_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)';
COMMENT ON COLUMN RABATCHER.W_RTL_SLS_IT_DY_TMP.RET_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)';
COMMENT ON COLUMN RABATCHER.W_RTL_SLS_IT_DY_TMP.SLS_TAX_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)税额';
COMMENT ON COLUMN RABATCHER.W_RTL_SLS_IT_DY_TMP.RET_TAX_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)税额';
	
-- ADD/MODIFY COLUMNS 
ALTER TABLE RADM.W_RTL_SLS_IT_DY_A ADD SLS_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_IT_DY_A ADD RET_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_IT_DY_A ADD SLS_TAX_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_IT_DY_A ADD RET_TAX_COUPON_AMT_LCL NUMBER(20,4);
-- ADD COMMENTS TO THE COLUMNS 
COMMENT ON COLUMN RADM.W_RTL_SLS_IT_DY_A.SLS_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)';
COMMENT ON COLUMN RADM.W_RTL_SLS_IT_DY_A.RET_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)';
COMMENT ON COLUMN RADM.W_RTL_SLS_IT_DY_A.SLS_TAX_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)税额';
COMMENT ON COLUMN RADM.W_RTL_SLS_IT_DY_A.RET_TAX_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)税额';
	
-- ADD/MODIFY COLUMNS 
ALTER TABLE RADM.W_RTL_SLS_SC_DY_A ADD SLS_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_SC_DY_A ADD RET_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_SC_DY_A ADD SLS_TAX_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_SC_DY_A ADD RET_TAX_COUPON_AMT_LCL NUMBER(20,4);
-- ADD COMMENTS TO THE COLUMNS 
COMMENT ON COLUMN RADM.W_RTL_SLS_SC_DY_A.SLS_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)';
COMMENT ON COLUMN RADM.W_RTL_SLS_SC_DY_A.RET_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)';
COMMENT ON COLUMN RADM.W_RTL_SLS_SC_DY_A.SLS_TAX_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)税额';
COMMENT ON COLUMN RADM.W_RTL_SLS_SC_DY_A.RET_TAX_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)税额';

-- ADD/MODIFY COLUMNS 
ALTER TABLE RABATCHER.W_RTL_SLS_LC_DY_TMP ADD SLS_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RABATCHER.W_RTL_SLS_LC_DY_TMP ADD RET_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RABATCHER.W_RTL_SLS_LC_DY_TMP ADD SLS_TAX_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RABATCHER.W_RTL_SLS_LC_DY_TMP ADD RET_TAX_COUPON_AMT_LCL NUMBER(20,4);
-- ADD COMMENTS TO THE COLUMNS 
COMMENT ON COLUMN RABATCHER.W_RTL_SLS_LC_DY_TMP.SLS_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)';
COMMENT ON COLUMN RABATCHER.W_RTL_SLS_LC_DY_TMP.RET_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)';
COMMENT ON COLUMN RABATCHER.W_RTL_SLS_LC_DY_TMP.SLS_TAX_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)税额';
COMMENT ON COLUMN RABATCHER.W_RTL_SLS_LC_DY_TMP.RET_TAX_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)税额';

-- ADD/MODIFY COLUMNS 
ALTER TABLE RADM.W_RTL_SLS_LC_DY_A ADD SLS_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_LC_DY_A ADD RET_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_LC_DY_A ADD SLS_TAX_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_LC_DY_A ADD RET_TAX_COUPON_AMT_LCL NUMBER(20,4);
-- ADD COMMENTS TO THE COLUMNS 
COMMENT ON COLUMN RADM.W_RTL_SLS_LC_DY_A.SLS_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)';
COMMENT ON COLUMN RADM.W_RTL_SLS_LC_DY_A.RET_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)';
COMMENT ON COLUMN RADM.W_RTL_SLS_LC_DY_A.SLS_TAX_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)税额';
COMMENT ON COLUMN RADM.W_RTL_SLS_LC_DY_A.RET_TAX_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)税额';

-- ADD/MODIFY COLUMNS 
ALTER TABLE RABATCHER.W_RTL_SLS_IT_LC_DY_SN_TMP ADD SLS_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RABATCHER.W_RTL_SLS_IT_LC_DY_SN_TMP ADD RET_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RABATCHER.W_RTL_SLS_IT_LC_DY_SN_TMP ADD SLS_TAX_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RABATCHER.W_RTL_SLS_IT_LC_DY_SN_TMP ADD RET_TAX_COUPON_AMT_LCL NUMBER(20,4);
-- ADD COMMENTS TO THE COLUMNS 
COMMENT ON COLUMN RABATCHER.W_RTL_SLS_IT_LC_DY_SN_TMP.SLS_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)';
COMMENT ON COLUMN RABATCHER.W_RTL_SLS_IT_LC_DY_SN_TMP.RET_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)';
COMMENT ON COLUMN RABATCHER.W_RTL_SLS_IT_LC_DY_SN_TMP.SLS_TAX_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)税额';
COMMENT ON COLUMN RABATCHER.W_RTL_SLS_IT_LC_DY_SN_TMP.RET_TAX_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)税额';

-- ADD/MODIFY COLUMNS 
ALTER TABLE RADM.W_RTL_SLS_IT_LC_DY_SN_A ADD SLS_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_IT_LC_DY_SN_A ADD RET_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_IT_LC_DY_SN_A ADD SLS_TAX_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_IT_LC_DY_SN_A ADD RET_TAX_COUPON_AMT_LCL NUMBER(20,4);
-- ADD COMMENTS TO THE COLUMNS 
COMMENT ON COLUMN RADM.W_RTL_SLS_IT_LC_DY_SN_A.SLS_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)';
COMMENT ON COLUMN RADM.W_RTL_SLS_IT_LC_DY_SN_A.RET_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)';
COMMENT ON COLUMN RADM.W_RTL_SLS_IT_LC_DY_SN_A.SLS_TAX_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)税额';
COMMENT ON COLUMN RADM.W_RTL_SLS_IT_LC_DY_SN_A.RET_TAX_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)税额';
	
-- ADD/MODIFY COLUMNS 
ALTER TABLE RADM.W_RTL_SLS_IT_DY_SN_A ADD SLS_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_IT_DY_SN_A ADD RET_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_IT_DY_SN_A ADD SLS_TAX_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_IT_DY_SN_A ADD RET_TAX_COUPON_AMT_LCL NUMBER(20,4);
-- ADD COMMENTS TO THE COLUMNS 
COMMENT ON COLUMN RADM.W_RTL_SLS_IT_DY_SN_A.SLS_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)';
COMMENT ON COLUMN RADM.W_RTL_SLS_IT_DY_SN_A.RET_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)';
COMMENT ON COLUMN RADM.W_RTL_SLS_IT_DY_SN_A.SLS_TAX_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)税额';
COMMENT ON COLUMN RADM.W_RTL_SLS_IT_DY_SN_A.RET_TAX_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)税额';

-- ADD/MODIFY COLUMNS 
ALTER TABLE RADM.W_RTL_SLS_TRX_LC_DY_A ADD SLS_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_TRX_LC_DY_A ADD RET_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_TRX_LC_DY_A ADD SLS_TAX_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_TRX_LC_DY_A ADD RET_TAX_COUPON_AMT_LCL NUMBER(20,4);
-- ADD COMMENTS TO THE COLUMNS 
COMMENT ON COLUMN RADM.W_RTL_SLS_TRX_LC_DY_A.SLS_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)';
COMMENT ON COLUMN RADM.W_RTL_SLS_TRX_LC_DY_A.RET_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)';
COMMENT ON COLUMN RADM.W_RTL_SLS_TRX_LC_DY_A.SLS_TAX_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)税额';
COMMENT ON COLUMN RADM.W_RTL_SLS_TRX_LC_DY_A.RET_TAX_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)税额';
	
-- ADD/MODIFY COLUMNS 
ALTER TABLE RADM.W_RTL_SLS_TRX_DP_LC_DY_A ADD SLS_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_TRX_DP_LC_DY_A ADD RET_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_TRX_DP_LC_DY_A ADD SLS_TAX_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_TRX_DP_LC_DY_A ADD RET_TAX_COUPON_AMT_LCL NUMBER(20,4);
-- ADD COMMENTS TO THE COLUMNS 
COMMENT ON COLUMN RADM.W_RTL_SLS_TRX_DP_LC_DY_A.SLS_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)';
COMMENT ON COLUMN RADM.W_RTL_SLS_TRX_DP_LC_DY_A.RET_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)';
COMMENT ON COLUMN RADM.W_RTL_SLS_TRX_DP_LC_DY_A.SLS_TAX_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)税额';
COMMENT ON COLUMN RADM.W_RTL_SLS_TRX_DP_LC_DY_A.RET_TAX_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)税额';
	
-- ADD/MODIFY COLUMNS 
ALTER TABLE RADM.BBG_RA_RFM_VIP_F ADD SLS_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.BBG_RA_RFM_VIP_F ADD RET_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.BBG_RA_RFM_VIP_F ADD SLS_TAX_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.BBG_RA_RFM_VIP_F ADD RET_TAX_COUPON_AMT_LCL NUMBER(20,4);
-- ADD COMMENTS TO THE COLUMNS 
COMMENT ON COLUMN RADM.BBG_RA_RFM_VIP_F.SLS_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)';
COMMENT ON COLUMN RADM.BBG_RA_RFM_VIP_F.RET_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)';
COMMENT ON COLUMN RADM.BBG_RA_RFM_VIP_F.SLS_TAX_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)税额';
COMMENT ON COLUMN RADM.BBG_RA_RFM_VIP_F.RET_TAX_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)税额';

-- ADD/MODIFY COLUMNS 
ALTER TABLE RABATCHER.W_RTL_SLS_SC_LC_DY_CUR_TMP ADD SLS_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RABATCHER.W_RTL_SLS_SC_LC_DY_CUR_TMP ADD RET_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RABATCHER.W_RTL_SLS_SC_LC_DY_CUR_TMP ADD SLS_TAX_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RABATCHER.W_RTL_SLS_SC_LC_DY_CUR_TMP ADD RET_TAX_COUPON_AMT_LCL NUMBER(20,4);
-- ADD COMMENTS TO THE COLUMNS 
COMMENT ON COLUMN RABATCHER.W_RTL_SLS_SC_LC_DY_CUR_TMP.SLS_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)';
COMMENT ON COLUMN RABATCHER.W_RTL_SLS_SC_LC_DY_CUR_TMP.RET_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)';
COMMENT ON COLUMN RABATCHER.W_RTL_SLS_SC_LC_DY_CUR_TMP.SLS_TAX_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)税额';
COMMENT ON COLUMN RABATCHER.W_RTL_SLS_SC_LC_DY_CUR_TMP.RET_TAX_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)税额';
	
-- ADD/MODIFY COLUMNS 
ALTER TABLE RADM.W_RTL_SLS_SC_LC_DY_CUR_A ADD SLS_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_SC_LC_DY_CUR_A ADD RET_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_SC_LC_DY_CUR_A ADD SLS_TAX_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_SC_LC_DY_CUR_A ADD RET_TAX_COUPON_AMT_LCL NUMBER(20,4);
-- ADD COMMENTS TO THE COLUMNS 
COMMENT ON COLUMN RADM.W_RTL_SLS_SC_LC_DY_CUR_A.SLS_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)';
COMMENT ON COLUMN RADM.W_RTL_SLS_SC_LC_DY_CUR_A.RET_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)';
COMMENT ON COLUMN RADM.W_RTL_SLS_SC_LC_DY_CUR_A.SLS_TAX_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)税额';
COMMENT ON COLUMN RADM.W_RTL_SLS_SC_LC_DY_CUR_A.RET_TAX_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)税额';
	
-- ADD/MODIFY COLUMNS 
ALTER TABLE RADM.W_RTL_SLS_CL_LC_DY_CUR_A ADD SLS_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_CL_LC_DY_CUR_A ADD RET_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_CL_LC_DY_CUR_A ADD SLS_TAX_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_CL_LC_DY_CUR_A ADD RET_TAX_COUPON_AMT_LCL NUMBER(20,4);
-- ADD COMMENTS TO THE COLUMNS 
COMMENT ON COLUMN RADM.W_RTL_SLS_CL_LC_DY_CUR_A.SLS_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)';
COMMENT ON COLUMN RADM.W_RTL_SLS_CL_LC_DY_CUR_A.RET_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)';
COMMENT ON COLUMN RADM.W_RTL_SLS_CL_LC_DY_CUR_A.SLS_TAX_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)税额';
COMMENT ON COLUMN RADM.W_RTL_SLS_CL_LC_DY_CUR_A.RET_TAX_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)税额';
	
-- ADD/MODIFY COLUMNS 
ALTER TABLE RADM.W_RTL_SLS_DP_LC_DY_CUR_A ADD SLS_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_DP_LC_DY_CUR_A ADD RET_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_DP_LC_DY_CUR_A ADD SLS_TAX_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_DP_LC_DY_CUR_A ADD RET_TAX_COUPON_AMT_LCL NUMBER(20,4);
-- ADD COMMENTS TO THE COLUMNS 
COMMENT ON COLUMN RADM.W_RTL_SLS_DP_LC_DY_CUR_A.SLS_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)';
COMMENT ON COLUMN RADM.W_RTL_SLS_DP_LC_DY_CUR_A.RET_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)';
COMMENT ON COLUMN RADM.W_RTL_SLS_DP_LC_DY_CUR_A.SLS_TAX_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)税额';
COMMENT ON COLUMN RADM.W_RTL_SLS_DP_LC_DY_CUR_A.RET_TAX_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)税额';

-- ADD/MODIFY COLUMNS 
ALTER TABLE RABATCHER.W_RTL_SLS_SC_LC_DY_RC_TMP ADD SLS_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RABATCHER.W_RTL_SLS_SC_LC_DY_RC_TMP ADD RET_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RABATCHER.W_RTL_SLS_SC_LC_DY_RC_TMP ADD SLS_TAX_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RABATCHER.W_RTL_SLS_SC_LC_DY_RC_TMP ADD RET_TAX_COUPON_AMT_LCL NUMBER(20,4);
-- ADD COMMENTS TO THE COLUMNS 
COMMENT ON COLUMN RABATCHER.W_RTL_SLS_SC_LC_DY_RC_TMP.SLS_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)';
COMMENT ON COLUMN RABATCHER.W_RTL_SLS_SC_LC_DY_RC_TMP.RET_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)';
COMMENT ON COLUMN RABATCHER.W_RTL_SLS_SC_LC_DY_RC_TMP.SLS_TAX_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)税额';
COMMENT ON COLUMN RABATCHER.W_RTL_SLS_SC_LC_DY_RC_TMP.RET_TAX_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)税额';
	
-- ADD/MODIFY COLUMNS 
ALTER TABLE RADM.W_RTL_SLS_SC_DY_CUR_A ADD SLS_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_SC_DY_CUR_A ADD RET_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_SC_DY_CUR_A ADD SLS_TAX_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_SC_DY_CUR_A ADD RET_TAX_COUPON_AMT_LCL NUMBER(20,4);
-- ADD COMMENTS TO THE COLUMNS 
COMMENT ON COLUMN RADM.W_RTL_SLS_SC_DY_CUR_A.SLS_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)';
COMMENT ON COLUMN RADM.W_RTL_SLS_SC_DY_CUR_A.RET_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)';
COMMENT ON COLUMN RADM.W_RTL_SLS_SC_DY_CUR_A.SLS_TAX_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)税额';
COMMENT ON COLUMN RADM.W_RTL_SLS_SC_DY_CUR_A.RET_TAX_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)税额';
	
-- ADD/MODIFY COLUMNS 
ALTER TABLE RADM.W_RTL_SLS_CL_DY_CUR_A ADD SLS_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_CL_DY_CUR_A ADD RET_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_CL_DY_CUR_A ADD SLS_TAX_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_CL_DY_CUR_A ADD RET_TAX_COUPON_AMT_LCL NUMBER(20,4);
-- ADD COMMENTS TO THE COLUMNS 
COMMENT ON COLUMN RADM.W_RTL_SLS_CL_DY_CUR_A.SLS_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)';
COMMENT ON COLUMN RADM.W_RTL_SLS_CL_DY_CUR_A.RET_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)';
COMMENT ON COLUMN RADM.W_RTL_SLS_CL_DY_CUR_A.SLS_TAX_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)税额';
COMMENT ON COLUMN RADM.W_RTL_SLS_CL_DY_CUR_A.RET_TAX_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)税额';
	
-- ADD/MODIFY COLUMNS 
ALTER TABLE RADM.W_RTL_SLS_DP_DY_CUR_A ADD SLS_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_DP_DY_CUR_A ADD RET_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_DP_DY_CUR_A ADD SLS_TAX_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_DP_DY_CUR_A ADD RET_TAX_COUPON_AMT_LCL NUMBER(20,4);
-- ADD COMMENTS TO THE COLUMNS 
COMMENT ON COLUMN RADM.W_RTL_SLS_DP_DY_CUR_A.SLS_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)';
COMMENT ON COLUMN RADM.W_RTL_SLS_DP_DY_CUR_A.RET_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)';
COMMENT ON COLUMN RADM.W_RTL_SLS_DP_DY_CUR_A.SLS_TAX_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)税额';
COMMENT ON COLUMN RADM.W_RTL_SLS_DP_DY_CUR_A.RET_TAX_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)税额';
	
-- ADD/MODIFY COLUMNS 
ALTER TABLE RADM.W_RTL_SLS_SC_LC_MN_A ADD SLS_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_SC_LC_MN_A ADD RET_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_SC_LC_MN_A ADD SLS_TAX_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_SC_LC_MN_A ADD RET_TAX_COUPON_AMT_LCL NUMBER(20,4);
-- ADD COMMENTS TO THE COLUMNS 
COMMENT ON COLUMN RADM.W_RTL_SLS_SC_LC_MN_A.SLS_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)';
COMMENT ON COLUMN RADM.W_RTL_SLS_SC_LC_MN_A.RET_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)';
COMMENT ON COLUMN RADM.W_RTL_SLS_SC_LC_MN_A.SLS_TAX_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)税额';
COMMENT ON COLUMN RADM.W_RTL_SLS_SC_LC_MN_A.RET_TAX_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)税额';

-- ADD/MODIFY COLUMNS 
ALTER TABLE RADM.W_RTL_SLS_SC_LC_MN_CUR_A ADD SLS_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_SC_LC_MN_CUR_A ADD RET_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_SC_LC_MN_CUR_A ADD SLS_TAX_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_SC_LC_MN_CUR_A ADD RET_TAX_COUPON_AMT_LCL NUMBER(20,4);
-- ADD COMMENTS TO THE COLUMNS 
COMMENT ON COLUMN RADM.W_RTL_SLS_SC_LC_MN_CUR_A.SLS_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)';
COMMENT ON COLUMN RADM.W_RTL_SLS_SC_LC_MN_CUR_A.RET_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)';
COMMENT ON COLUMN RADM.W_RTL_SLS_SC_LC_MN_CUR_A.SLS_TAX_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)税额';
COMMENT ON COLUMN RADM.W_RTL_SLS_SC_LC_MN_CUR_A.RET_TAX_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)税额';
	
-- ADD/MODIFY COLUMNS 
ALTER TABLE RADM.W_RTL_SLS_SC_MN_A ADD SLS_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_SC_MN_A ADD RET_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_SC_MN_A ADD SLS_TAX_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_SC_MN_A ADD RET_TAX_COUPON_AMT_LCL NUMBER(20,4);
-- ADD COMMENTS TO THE COLUMNS 
COMMENT ON COLUMN RADM.W_RTL_SLS_SC_MN_A.SLS_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)';
COMMENT ON COLUMN RADM.W_RTL_SLS_SC_MN_A.RET_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)';
COMMENT ON COLUMN RADM.W_RTL_SLS_SC_MN_A.SLS_TAX_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)税额';
COMMENT ON COLUMN RADM.W_RTL_SLS_SC_MN_A.RET_TAX_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)税额';
	
-- ADD/MODIFY COLUMNS 
ALTER TABLE RADM.W_RTL_SLS_SC_MN_CUR_A ADD SLS_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_SC_MN_CUR_A ADD RET_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_SC_MN_CUR_A ADD SLS_TAX_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_SC_MN_CUR_A ADD RET_TAX_COUPON_AMT_LCL NUMBER(20,4);
-- ADD COMMENTS TO THE COLUMNS 
COMMENT ON COLUMN RADM.W_RTL_SLS_SC_MN_CUR_A.SLS_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)';
COMMENT ON COLUMN RADM.W_RTL_SLS_SC_MN_CUR_A.RET_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)';
COMMENT ON COLUMN RADM.W_RTL_SLS_SC_MN_CUR_A.SLS_TAX_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)税额';
COMMENT ON COLUMN RADM.W_RTL_SLS_SC_MN_CUR_A.RET_TAX_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)税额';
	
-- ADD/MODIFY COLUMNS 
ALTER TABLE RADM.W_RTL_SLS_CL_LC_MN_A ADD SLS_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_CL_LC_MN_A ADD RET_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_CL_LC_MN_A ADD SLS_TAX_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_CL_LC_MN_A ADD RET_TAX_COUPON_AMT_LCL NUMBER(20,4);
-- ADD COMMENTS TO THE COLUMNS 
COMMENT ON COLUMN RADM.W_RTL_SLS_CL_LC_MN_A.SLS_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)';
COMMENT ON COLUMN RADM.W_RTL_SLS_CL_LC_MN_A.RET_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)';
COMMENT ON COLUMN RADM.W_RTL_SLS_CL_LC_MN_A.SLS_TAX_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)税额';
COMMENT ON COLUMN RADM.W_RTL_SLS_CL_LC_MN_A.RET_TAX_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)税额';
	
-- ADD/MODIFY COLUMNS 
ALTER TABLE RADM.W_RTL_SLS_CL_LC_MN_CUR_A ADD SLS_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_CL_LC_MN_CUR_A ADD RET_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_CL_LC_MN_CUR_A ADD SLS_TAX_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_CL_LC_MN_CUR_A ADD RET_TAX_COUPON_AMT_LCL NUMBER(20,4);
-- ADD COMMENTS TO THE COLUMNS 
COMMENT ON COLUMN RADM.W_RTL_SLS_CL_LC_MN_CUR_A.SLS_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)';
COMMENT ON COLUMN RADM.W_RTL_SLS_CL_LC_MN_CUR_A.RET_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)';
COMMENT ON COLUMN RADM.W_RTL_SLS_CL_LC_MN_CUR_A.SLS_TAX_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)税额';
COMMENT ON COLUMN RADM.W_RTL_SLS_CL_LC_MN_CUR_A.RET_TAX_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)税额';
	
-- ADD/MODIFY COLUMNS 
ALTER TABLE RADM.W_RTL_SLS_DP_LC_MN_A ADD SLS_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_DP_LC_MN_A ADD RET_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_DP_LC_MN_A ADD SLS_TAX_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_DP_LC_MN_A ADD RET_TAX_COUPON_AMT_LCL NUMBER(20,4);
-- ADD COMMENTS TO THE COLUMNS 
COMMENT ON COLUMN RADM.W_RTL_SLS_DP_LC_MN_A.SLS_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)';
COMMENT ON COLUMN RADM.W_RTL_SLS_DP_LC_MN_A.RET_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)';
COMMENT ON COLUMN RADM.W_RTL_SLS_DP_LC_MN_A.SLS_TAX_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)税额';
COMMENT ON COLUMN RADM.W_RTL_SLS_DP_LC_MN_A.RET_TAX_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)税额';
	
-- ADD/MODIFY COLUMNS 
ALTER TABLE RADM.W_RTL_SLS_DP_LC_MN_CUR_A ADD SLS_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_DP_LC_MN_CUR_A ADD RET_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_DP_LC_MN_CUR_A ADD SLS_TAX_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_DP_LC_MN_CUR_A ADD RET_TAX_COUPON_AMT_LCL NUMBER(20,4);
-- ADD COMMENTS TO THE COLUMNS 
COMMENT ON COLUMN RADM.W_RTL_SLS_DP_LC_MN_CUR_A.SLS_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)';
COMMENT ON COLUMN RADM.W_RTL_SLS_DP_LC_MN_CUR_A.RET_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)';
COMMENT ON COLUMN RADM.W_RTL_SLS_DP_LC_MN_CUR_A.SLS_TAX_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)税额';
COMMENT ON COLUMN RADM.W_RTL_SLS_DP_LC_MN_CUR_A.RET_TAX_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)税额';
	
-- ADD/MODIFY COLUMNS 
ALTER TABLE RADM.W_RTL_SLS_LC_MN_A ADD SLS_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_LC_MN_A ADD RET_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_LC_MN_A ADD SLS_TAX_COUPON_AMT_LCL NUMBER(20,4);
ALTER TABLE RADM.W_RTL_SLS_LC_MN_A ADD RET_TAX_COUPON_AMT_LCL NUMBER(20,4);
-- ADD COMMENTS TO THE COLUMNS 
COMMENT ON COLUMN RADM.W_RTL_SLS_LC_MN_A.SLS_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)';
COMMENT ON COLUMN RADM.W_RTL_SLS_LC_MN_A.RET_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)';
COMMENT ON COLUMN RADM.W_RTL_SLS_LC_MN_A.SLS_TAX_COUPON_AMT_LCL
  IS '券销售金额(50,51,52)税额';
COMMENT ON COLUMN RADM.W_RTL_SLS_LC_MN_A.RET_TAX_COUPON_AMT_LCL
  IS '券退货金额(50,51,52)税额';


--知而行劵，厂商券，siebel劵
--CN_Retail_As-Was_Sales_-----Net_Sales_Coupon-----
--CD_Retail_As-Was_Sales_-----Net_Sales_Coupon-----
--CN_Retail_As-Was_Sales_Net_Sales_Coupon_Amt
--CD_Retail_As-Was_Sales_Net_Sales_Coupon_Amt
--CN_Retail_As-Was_Sales_Net_Sales_Coupon_Amt_LY
--CD_Retail_As-Was_Sales_Net_Sales_Coupon_Amt_LY
--CN_Retail_As-Was_Sales_Net_Sales_Coupon_Amt_LY_MTD
--CD_Retail_As-Was_Sales_Net_Sales_Coupon_Amt_LY_MTD
--CN_Retail_As-Was_Sales_Net_Sales_Coupon_Amt_LY_YTD
--CD_Retail_As-Was_Sales_Net_Sales_Coupon_Amt_LY_YTD
--CN_Retail_As-Was_Sales_Net_Sales_Coupon_Amt_MTD
--CD_Retail_As-Was_Sales_Net_Sales_Coupon_Amt_MTD
--CN_Retail_As-Was_Sales_Net_Sales_Coupon_Amt_YTD
--CD_Retail_As-Was_Sales_Net_Sales_Coupon_Amt_YTD
--CN_Retail_As-Was_Sales_Net_Sales_Coupon_Amt_Inc_Tax
--CD_Retail_As-Was_Sales_Net_Sales_Coupon_Amt_Inc_Tax
--CN_Retail_As-Was_Sales_Net_Sales_Coupon_Amt_Inc_Tax_LY
--CD_Retail_As-Was_Sales_Net_Sales_Coupon_Amt_Inc_Tax_LY
--CN_Retail_As-Was_Sales_Net_Sales_Coupon_Amt_Inc_Tax_LY_MTD
--CD_Retail_As-Was_Sales_Net_Sales_Coupon_Amt_Inc_Tax_LY_MTD
--CN_Retail_As-Was_Sales_Net_Sales_Coupon_Amt_Inc_Tax_LY_YTD
--CD_Retail_As-Was_Sales_Net_Sales_Coupon_Amt_Inc_Tax_LY_YTD
--CN_Retail_As-Was_Sales_Net_Sales_Coupon_Amt_Inc_Tax_MTD
--CD_Retail_As-Was_Sales_Net_Sales_Coupon_Amt_Inc_Tax_MTD
--CN_Retail_As-Was_Sales_Net_Sales_Coupon_Amt_Inc_Tax_YTD
--CD_Retail_As-Was_Sales_Net_Sales_Coupon_Amt_Inc_Tax_YTD

SELECT * FROM RADM.W_LOCALIZED_STRING_G T WHERE T.MSG_NUM LIKE '%Net_Sales_Coupon%' FOR UPDATE;
