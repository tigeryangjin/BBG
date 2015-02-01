--活动本周,
--活动前一周BF,去年同期LY,去年同期活动前一周LYBF,活动后一周AF,去年同期活动后一周LYAF
--创建维度表
CREATE TABLE BBG_RA_PROMO_STAMP_WK_D
(
  ROW_WID NUMBER(10) DEFAULT 0 NOT NULL,
  PROMO_WK_KEY NUMBER(10) ,
  PROMO_WK VARCHAR2(40),
  PROMO_NAMES VARCHAR2(60),
  DT_WID NUMBER(15),
  WEEK_START_DT DATE,
  WEEK_END_DT DATE,
  W_INSERT_DT DATE,
  W_UPDATE_DT DATE  
);

DROP TABLE BBG_RA_PROMO_STAMP_WK_D;
--创建序列
create sequence BBG_RA_PROMO_STAMP_WK_D_SEQ increment by 1 start with 1 maxvalue 999999999;
DROP SEQUENCE BBG_RA_PROMO_STAMP_WK_D_SEQ;


--查询条件插入数据(测试)
INSERT INTO BBG_RA_PROMO_STAMP_WK_D 
      (ROW_WID,PROMO_WK_KEY,PROMO_WK,PROMO_NAMES,DT_WID,WEEK_START_DT,WEEK_END_DT,W_INSERT_DT,W_UPDATE_DT)
SELECT BBG_RA_PROMO_STAMP_WK_D_SEQ.NEXTVAL,1,'第一周','BRANDLOYALTY',ROW_WID,DATE'2013-09-26',DATE'2013-10-02',SYSDATE,SYSDATE
FROM W_MCAL_DAY_DV
WHERE ROW_WID BETWEEN '120130926000' AND '120131002000';

INSERT INTO BBG_RA_PROMO_STAMP_WK_D 
      (ROW_WID,PROMO_WK_KEY,PROMO_WK,PROMO_NAMES,DT_WID,WEEK_START_DT,WEEK_END_DT,W_INSERT_DT,W_UPDATE_DT)
SELECT BBG_RA_PROMO_STAMP_WK_D_SEQ.NEXTVAL,2,'第二周','BRANDLOYALTY',ROW_WID,DATE'2013-10-03',DATE'2013-10-09',SYSDATE,SYSDATE
FROM W_MCAL_DAY_DV
WHERE ROW_WID BETWEEN '120131003000' AND '120131009000';

INSERT INTO BBG_RA_PROMO_STAMP_WK_D 
      (ROW_WID,PROMO_WK_KEY,PROMO_WK,PROMO_NAMES,DT_WID,WEEK_START_DT,WEEK_END_DT,W_INSERT_DT,W_UPDATE_DT)
SELECT BBG_RA_PROMO_STAMP_WK_D_SEQ.NEXTVAL,3,'第三周','BRANDLOYALTY',ROW_WID,DATE'2013-10-10',DATE'2013-10-16',SYSDATE,SYSDATE
FROM W_MCAL_DAY_DV
WHERE ROW_WID BETWEEN '120131010000' AND '120131016000';
--插入活动周临时表格
create table bbg_ra_promo_stamp_wk_tmp(
promo_wk varchar2(40),
promo_wk_key number(10),
week_start_dt date,
week_end_dt date
);
select * from bbg_ra_promo_stamp_wk_tmp for update;
--查询条件插入数据(正式)
INSERT INTO BBG_RA_PROMO_STAMP_WK_D (ROW_WID,PROMO_WK_KEY,PROMO_WK,PROMO_NAMES,DT_WID,WEEK_START_DT,WEEK_END_DT,W_INSERT_DT,W_UPDATE_DT)
SELECT BBG_RA_PROMO_STAMP_WK_D_SEQ.NEXTVAL,T.PROMO_WK_KEY,T.PROMO_WK,'BRANDLOYALTY',DV.ROW_WID,T.WEEK_START_DT,T.WEEK_END_DT,SYSDATE,SYSDATE
FROM W_MCAL_DAY_DV DV,bbg_ra_promo_stamp_wk_tmp T
WHERE DV.MCAL_DAY_DT BETWEEN T.WEEK_START_DT AND T.WEEK_END_DT /*AND T.PROMO_WK_KEY IN ('1','2')*/;
--检查BBG_RA_PROMO_STAMP_WK_D插入的数据
SELECT DISTINCT T.PROMO_WK_KEY,T.PROMO_WK,T.WEEK_START_DT,T.WEEK_END_DT FROM BBG_RA_PROMO_STAMP_WK_D T ORDER BY T.PROMO_WK_KEY;
/*
活动前偏移18
去年偏移40
去年活动前偏移58
*/


--UPDATE BBG_RA_PROMO_STAMP_WK_D T SET T.PROMO_WK_KEY=3  WHERE PROMO_WK_KEY=2;
--TRUNCATE TABLE BBG_RA_PROMO_STAMP_WK_D;
SELECT * FROM BBG_RA_PROMO_STAMP_WK_D ;



SELECT * FROM W_MCAL_DAY_DV;

--******************************************************************************************************
--******************************************************************************************************
--消费档在RA中实现
SELECT * FROM W_RTL_SLS_TRX_IT_LC_DY_F;
SELECT * FROM cmx_ksl_bllevel@ra_rms_dblink ;
SELECT * FROM W_RTL_SLS_TRX_IT_LC_DY_F T WHERE T.SLS_TRX_ID='21447145            ';
--按小票号合并出小票合计金额
--W_RTL_SLS_TRX_IT_LC_DY_F表的数据包含销售和退货数据，不能简单的sum销售金额，count行数。
--与赛龙和永昱沟通后，退货交易算入来客数。
CREATE OR REPLACE VIEW RADM.BBG_RA_SLS_TRX_DY_FV
AS
--按小票号合并出小票合计金额,只需要统计出全司合计的。用于宝莱印花活动
--减去税额
SELECT T.SLS_TRX_ID,T.DT_WID,SUM((T.SLS_AMT_LCL-T.RET_AMT_LCL)-(T.SLS_TAX_AMT_LCL-T.RET_TAX_AMT_LCL)) SLS_AMT_LCL
FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_F T
GROUP BY T.SLS_TRX_ID,T.DT_WID;



--更新小票合计金额所在消费段的标志。
CREATE OR REPLACE VIEW RADM.BBG_RA_SLS_SEGMENT_DY_FV
AS
--根据小票号合计金额,得到消费档标志PRICE_LEVEL,只需要统计出全司合计的。用于宝莱印花活动
SELECT FV.DT_WID,FV.SLS_TRX_ID,FV.SLS_AMT_LCL,LEV.ROW_WID PRICE_LEVEL
FROM RADM.BBG_RA_SLS_TRX_DY_FV FV,RADM.BBG_RA_SLS_SEGMENT_D LEV
WHERE FV.SLS_AMT_LCL BETWEEN LEV.LOW AND LEV.HIGH AND LEV.SEGMENT_NAME='宝莱消费金额段'
AND FV.DT_WID>'120131030000';

--合计来客数和消费金额，用表固定下来
--创建序列用于BBG_RA_SLSTOT_LC_DY_A表
create sequence RADM.BBG_RA_SLSTOT_LC_DY_A_SEQ increment by 1 start with 1 maxvalue 999999999;
DROP SEQUENCE RADM.BBG_RA_SLSTOT_LC_DY_A_SEQ;

-- Create table
create table BBG_RA_SLSTOT_LC_DY_A
(
  row_wid      NUMBER(10) not null,
  dt_wid       NUMBER(15) not null,
  org_wid      NUMBER(10) not null,
  org_dh_wid   NUMBER(10) not null,
  org_scd1_wid NUMBER(10) not null,
  w_insert_dt  DATE,
  w_update_dt  DATE,
	price_level  number(10),
  sls_trx_cnt  NUMBER,
  sls_amt_lcl  NUMBER
);

/*INSERT INTO BBG_RA_SLSTOT_LC_DY_A 
(ROW_WID,DT_WID,ORG_WID,ORG_DH_WID,ORG_SCD1_WID,W_INSERT_DT,W_UPDATE_DT,SLS_TRX_CNT,SLS_AMT_LCL)
SELECT RADM.BBG_RA_SLSTOT_LC_DY_A_SEQ.NEXTVAL,
       A.DT_WID,
			 A.ORG_WID,
			 A.ORG_DH_WID,
			 A.ORG_SCD1_WID,
			 A.W_INSERT_DT,
			 A.W_UPDATE_DT,
			 A.SLS_TRX_CNT,
			 A.SLS_AMT_LCL
FROM ( 
SELECT 
       T.DT_WID,
       T.ORG_WID,
       T.ORG_DH_WID,
       T.ORG_SCD1_WID,
			 SYSDATE W_INSERT_DT,
			 SYSDATE W_UPDATE_DT,
       COUNT(T.SLS_TRX_ID) SLS_TRX_CNT,
       SUM(T.SLS_AMT_LCL) SLS_AMT_LCL
FROM (
       SELECT   FV.DT_WID,
                FV.ORG_WID,
                FV.ORG_DH_WID,
                FV.ORG_SCD1_WID,
                FV.SLS_TRX_ID,
                FV.SLS_AMT_LCL,
                LEV.ROW_WID PRICE_LEVEL
         FROM (
                SELECT   T.SLS_TRX_ID,
                         T.DT_WID,
                         T.ORG_WID,
                         T.ORG_DH_WID,
                         T.ORG_SCD1_WID,
                         SUM((T.SLS_AMT_LCL-T.RET_AMT_LCL)-(T.SLS_TAX_AMT_LCL-T.RET_TAX_AMT_LCL)) SLS_AMT_LCL
                FROM     RADM.W_RTL_SLS_TRX_IT_LC_DY_F T
                GROUP BY T.SLS_TRX_ID,T.DT_WID,T.ORG_WID,T.ORG_DH_WID,T.ORG_SCD1_WID
                ) FV,
                RADM.BBG_RA_SLS_SEGMENT_D LEV
         WHERE    FV.SLS_AMT_LCL BETWEEN LEV.LOW AND LEV.HIGH 
                  AND LEV.SEGMENT_NAME='宝莱消费金额段'
                  AND FV.DT_WID>'120131030000'
         ) T
GROUP BY T.DT_WID,
         T.ORG_WID,
         T.ORG_DH_WID, 
         T.ORG_SCD1_WID
) A;*/

SELECT * FROM RADM.BBG_RA_SLSTOT_LC_DY_A;
--MERGE插入数据 2013.5.8之后
MERGE /*+APPEND*/ INTO
RADM.BBG_RA_SLSTOT_LC_DY_A A
USING
     (SELECT T.DT_WID,
             T.ORG_WID,
             T.ORG_DH_WID,
             T.ORG_SCD1_WID,
						 T.PRICE_LEVEL,
             COUNT(T.SLS_TRX_ID) SLS_TRX_CNT,
             SUM(T.SLS_AMT_LCL) SLS_AMT_LCL
       FROM  (
              SELECT   FV.DT_WID,
                       FV.ORG_WID,
                       FV.ORG_DH_WID,
                       FV.ORG_SCD1_WID,
                       FV.SLS_TRX_ID,
                       FV.SLS_AMT_LCL,
                       LEV.ROW_WID PRICE_LEVEL
              FROM (
                       SELECT   T.SLS_TRX_ID,
                                T.DT_WID,
                                T.ORG_WID,
                                T.ORG_DH_WID,
                                T.ORG_SCD1_WID,
                                SUM((T.SLS_AMT_LCL-T.RET_AMT_LCL)-(T.SLS_TAX_AMT_LCL-T.RET_TAX_AMT_LCL)) SLS_AMT_LCL
                       FROM     RADM.W_RTL_SLS_TRX_IT_LC_DY_F T
                       GROUP BY T.SLS_TRX_ID,T.DT_WID,T.ORG_WID,T.ORG_DH_WID,T.ORG_SCD1_WID
                    ) FV,
                      RADM.BBG_RA_SLS_SEGMENT_D LEV
              WHERE   FV.SLS_AMT_LCL BETWEEN LEV.LOW AND LEV.HIGH 
                      AND LEV.SEGMENT_NAME='宝莱消费金额段'
                      --AND FV.DT_WID >= '1'||TO_CHAR(SYSDATE-1,'YYYYMMDD')||'000'
											AND FV.DT_WID = '120140116000'
            ) T
            GROUP BY T.DT_WID,
                     T.ORG_WID,
                     T.ORG_DH_WID, 
                     T.ORG_SCD1_WID,
										 T.PRICE_LEVEL
		  ) S
ON (
       A.DT_WID=S.DT_WID
   AND A.ORG_WID=S.ORG_WID
	 AND A.ORG_DH_WID=S.ORG_DH_WID
	 AND A.ORG_SCD1_WID=S.ORG_SCD1_WID
	 AND A.PRICE_LEVEL=S.PRICE_LEVEL
   )
WHEN MATCHED
	   THEN UPDATE SET 
		      A.SLS_TRX_CNT=S.SLS_TRX_CNT,
		      A.SLS_AMT_LCL=S.SLS_AMT_LCL,
					A.W_UPDATE_DT=SYSDATE 
WHEN NOT MATCHED
	   THEN INSERT
	        (
					 A.ROW_WID,
	         A.DT_WID,
	         A.ORG_WID,
		       A.ORG_DH_WID,
		       A.ORG_SCD1_WID,
					 A.W_INSERT_DT,
					 A.W_UPDATE_DT,
					 A.PRICE_LEVEL,
		       A.SLS_TRX_CNT,
			     A.SLS_AMT_LCL			     
			     )
       VALUES
			    (
					 RADM.BBG_RA_SLSTOT_LC_DY_A_SEQ.NEXTVAL,
					 S.DT_WID,
					 S.ORG_WID,
					 S.ORG_DH_WID,
					 S.ORG_SCD1_WID,
					 SYSDATE,
					 SYSDATE,
					 S.PRICE_LEVEL,
					 S.SLS_TRX_CNT,
					 S.SLS_AMT_LCL
					);
				 
-----------------------------------------------------------------------------------------------
--历史分段来客数处理(2013-5-7之前)
--更新RABATCHER.W_INT_ORG_DH_RTL_TMP表开始日期
UPDATE RABATCHER.W_INT_ORG_DH_RTL_TMP T
   SET T.EFFECTIVE_FROM_DT = DATE '2013-01-01'
 WHERE T.EFFECTIVE_FROM_DT = DATE '2013-05-07';
COMMIT;
--删除BBG_RA_SLSTOT_LC_DY_A数据
DELETE RADM.BBG_RA_SLSTOT_LC_DY_A T WHERE T.DT_WID BETWEEN 120130101000 AND 120130507000;
COMMIT;
--建立临时表
CREATE TABLE RADM.JIN_SALEDETAIL_TRX AS
SELECT SAD.SD0101, SAD.SHOPID, SAD.SD0106, SAD.SD0109, SUM(AMT) AMT
  FROM RADM.SALEDETAIL SAD
 WHERE SAD.SD0101 BETWEEN 20130101 AND 20130507
 GROUP BY SAD.SD0101, SAD.SHOPID, SAD.SD0106, SAD.SD0109;
--历史数据_MERGE插入数据(2013-5-7之前)
MERGE /*+APPEND*/
INTO RADM.BBG_RA_SLSTOT_LC_DY_A A
USING (SELECT T.DT_WID,
              T.ORG_WID,
              T.ORG_DH_WID,
              T.ORG_SCD1_WID,
              T.PRICE_LEVEL,
              COUNT(T.SLS_TRX_ID) SLS_TRX_CNT,
              SUM(T.SLS_AMT_LCL) SLS_AMT_LCL
         FROM (SELECT FV.DT_WID,
                      FV.ORG_WID,
                      FV.ORG_DH_WID,
                      FV.ORG_SCD1_WID,
                      FV.SLS_TRX_ID,
                      FV.SLS_AMT_LCL,
                      LEV.ROW_WID PRICE_LEVEL
                 FROM (SELECT SD.SD0101 || SD.SHOPID || SD.SD0109 || SD.SD0106 SLS_TRX_ID,
                              '1' || SD.SD0101 || '000' DT_WID,
                              ORG.ORG_WID ORG_WID,
                              DH.ORG_LC_WID ORG_DH_WID,
                              ORG.ORG_SCD1_WID ORG_SCD1_WID,
                              SD.AMT SLS_AMT_LCL
                         FROM RADM.JIN_SALEDETAIL_TRX SD,
                              RABATCHER.W_INT_ORG_D_RTL_TMP ORG,
                              RABATCHER.W_INT_ORG_DH_RTL_TMP DH
                        WHERE SUBSTR(SD.SHOPID, 2, 2) ||
                              SUBSTR(SD.SHOPID, 1, 1) ||
                              SUBSTR(SD.SHOPID, 4, 3) = ORG.ORG_NUM
                          AND ORG.ORG_SCD1_WID = DH.ORG_SCD1_WID
                          AND TO_DATE(SD.SD0101,'YYYYMMDD') BETWEEN DH.EFFECTIVE_FROM_DT AND
                              DH.EFFECTIVE_TO_DT
                          AND SD.SD0101 BETWEEN 20130101 AND 20130507) FV,
                      RADM.BBG_RA_SLS_SEGMENT_D LEV
                WHERE FV.SLS_AMT_LCL BETWEEN LEV.LOW AND LEV.HIGH
                  AND LEV.SEGMENT_NAME = '宝莱消费金额段'
               /*AND FV.DT_WID >=
               '1' || TO_CHAR(SYSDATE - 1, 'YYYYMMDD') || '000'*/
               ) T
        GROUP BY T.DT_WID,
                 T.ORG_WID,
                 T.ORG_DH_WID,
                 T.ORG_SCD1_WID,
                 T.PRICE_LEVEL) S
ON (A.DT_WID = S.DT_WID AND A.ORG_WID = S.ORG_WID AND A.ORG_DH_WID = S.ORG_DH_WID AND A.ORG_SCD1_WID = S.ORG_SCD1_WID AND A.PRICE_LEVEL = S.PRICE_LEVEL)
WHEN MATCHED THEN
  UPDATE
     SET A.SLS_TRX_CNT = S.SLS_TRX_CNT,
         A.SLS_AMT_LCL = S.SLS_AMT_LCL,
         A.W_UPDATE_DT = SYSDATE
WHEN NOT MATCHED THEN
  INSERT
    (A.ROW_WID,
     A.DT_WID,
     A.ORG_WID,
     A.ORG_DH_WID,
     A.ORG_SCD1_WID,
     A.W_INSERT_DT,
     A.W_UPDATE_DT,
     A.PRICE_LEVEL,
     A.SLS_TRX_CNT,
     A.SLS_AMT_LCL)
  VALUES
    (RADM.BBG_RA_SLSTOT_LC_DY_A_SEQ.NEXTVAL,
     S.DT_WID,
     S.ORG_WID,
     S.ORG_DH_WID,
     S.ORG_SCD1_WID,
     SYSDATE,
     SYSDATE,
     S.PRICE_LEVEL,
     S.SLS_TRX_CNT,
     S.SLS_AMT_LCL);
COMMIT;
------------------------------------------------------------------------------------------------				 
				 
SELECT * FROM RADM.BBG_RA_SLSTOT_LC_DY_A;
DROP TABLE RADM.BBG_RA_SLSTOT_LC_DY_A;
TRUNCATE TABLE RADM.BBG_RA_SLSTOT_LC_DY_A;




--创建BBG_RA_SLS_SEGMENT_D表序列
create sequence RADM.BBG_RA_SLS_SEGMENT_D_SEQ increment by 1 start with 1 maxvalue 999999999;
DROP SEQUENCE RADM.BBG_RA_SLS_SEGMENT_D_SEQ;
--RADM 中创建消费分段表
CREATE TABLE RADM.BBG_RA_SLS_SEGMENT_D 
      (
       "ROW_WID"      NUMBER(10,0) NOT NULL ENABLE,
       "PRICE_LEVEL"  NUMBER(10,0) NOT NULL ENABLE,
			 "LOW"          NUMBER(20,6) NOT NULL ENABLE,
			 "HIGH"         NUMBER(20,6) NOT NULL ENABLE,
			 "SEGMENT_NAME" VARCHAR2(80),
			 "DSC1"         VARCHAR2(100),
			 "DSC2"         VARCHAR2(100)
			 );

DROP TABLE RADM.BBG_RA_SLS_SEGMENT_D; 
--建立数据	
INSERT INTO RADM.BBG_RA_SLS_SEGMENT_D
            (ROW_WID,PRICE_LEVEL,LOW,HIGH,SEGMENT_NAME,DSC1,DSC2)
VALUES(
            RADM.BBG_RA_SLS_SEGMENT_D_SEQ.NEXTVAL,
						1,
						-9999999999,
						0,
						'宝莱消费金额段',
						NULL,
						NULL
			);
		 
INSERT INTO RADM.BBG_RA_SLS_SEGMENT_D 
       (ROW_WID,PRICE_LEVEL,LOW,HIGH,SEGMENT_NAME,DSC1,DSC2)
SELECT RADM.BBG_RA_SLS_SEGMENT_D_SEQ.NEXTVAL,
       PRICELEVEL+1,
			 LOW,
			 HIGH,
			 '宝莱消费金额段',
			 NULL,
			 NULL
FROM   cmx_ksl_bllevel@ra_rms_dblink
WHERE  PRICELEVEL<61;

INSERT INTO RADM.BBG_RA_SLS_SEGMENT_D
            (ROW_WID,PRICE_LEVEL,LOW,HIGH,SEGMENT_NAME,DSC1,DSC2)
VALUES(
            RADM.BBG_RA_SLS_SEGMENT_D_SEQ.NEXTVAL,
						62,
						1000,
						9999999999,
						'宝莱消费金额段',
						NULL,
						NULL
			);


UPDATE RADM.BBG_RA_SLS_SEGMENT_D T SET T.DSC1=TO_CHAR(ROUND(LOW,2),'FM9999999999999999.00')||' - '||TO_CHAR(ROUND(HIGH,2),'FM9999999999999999.00')
WHERE T.DSC1 IS NULL;

--测试数据
SELECT le.price_level,le.dsc1,count(FV.SLS_AMT_LCL),SUM(FV.SLS_AMT_LCL)
FROM RADM.BBG_RA_SLS_TRX_DY_FV FV,BBG_RA_SLS_SEGMENT_D LE
WHERE FV.SLS_AMT_LCL BETWEEN LE.LOW AND LE.HIGH
AND   FV.DT_WID='120131001000'
group by le.price_level,le.dsc1
order by le.price_level;

--RA表现层说明插入
SELECT * FROM RADM.W_LOCALIZED_STRING_G WHERE 1=2 FOR UPDATE;
SELECT * FROM RADM.W_LOCALIZED_STRING_G T WHERE T.MSG_NUM LIKE '%Was_BBG_Sale_Transaction_Amt%' FOR UPDATE;
/*
CN_Retail_As-Was_BBG_Sale_Amt_Segment
CD_Retail_As-Was_BBG_Sale_Amt_Segment
CN_Retail_As-Was_BBG_Sale_Amt_Segment_DSC1
CD_Retail_As-Was_BBG_Sale_Amt_Segment_DSC1
CN_Retail_As-Was_BBG_Sale_Amt_Segment_SEGMENT_NAME
CD_Retail_As-Was_BBG_Sale_Amt_Segment_SEGMENT_NAME

CN_Retail_As-Was_BBG_Sale_Transaction_Amt
CD_Retail_As-Was_BBG_Sale_Transaction_Amt
CN_Retail_As-Was_BBG_Sale_Transaction_Amt_SLS_AMT_LCL
CD_Retail_As-Was_BBG_Sale_Transaction_Amt_SLS_AMT_LCL
CN_Retail_As-Was_BBG_Sale_Transaction_Amt_SLS_TRX_ID
CD_Retail_As-Was_BBG_Sale_Transaction_Amt_SLS_TRX_ID
*/
--交易小票印花数量
--创建合计视图RADM.BBG_RA_TICKET_V

SELECT * FROM RMS.Bbg_Ticketsheet_Result@Ra_Rms_Dblink; 
SELECT * FROM W_INT_ORG_D;

CREATE MATERIALIZED VIEW RADM.BBG_RA_TICKET_V
AS  
SELECT TO_NUMBER('1'||TO_CHAR(BTR.TRAN_DATE,'YYYYMMDD')||'000') DT_WID,D.ORG_WID ORG_WID,DH.ORG_LC_WID ORG_DH_WID,DH.ORG_SCD1_WID ORG_SCD1_WID,SUM(BTR.TICKET_QTY) TICKET_QTY
FROM RMS.Bbg_Ticketsheet_Result@Ra_Rms_Dblink BTR,RABATCHER.W_INT_ORG_D_RTL_TMP D,RABATCHER.W_INT_ORG_DH_RTL_TMP DH
WHERE BTR.STORE=D.ORG_NUM AND BTR.STORE=DH.ORG_NUM
GROUP BY '1'||TO_CHAR(BTR.TRAN_DATE,'YYYYMMDD')||'000',D.ORG_WID,DH.ORG_LC_WID,DH.ORG_SCD1_WID;

DROP MATERIALIZED VIEW RADM.BBG_RA_TICKET_V;

SELECT * FROM RADM.BBG_RA_TICKET_V;


--RA表现层说明插入
SELECT * FROM RADM.W_LOCALIZED_STRING_G WHERE 1=2 FOR UPDATE;

CN_Retail_As-Was_BBG_Ticket_Qty
CD_Retail_As-Was_BBG_Ticket_Qty
CN_Retail_As-Was_BBG_Ticket_Qty_TICKET_QTY
CD_Retail_As-Was_BBG_Ticket_Qty_TICKET_QTY























