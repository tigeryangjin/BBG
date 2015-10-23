--MAR01
MERGE /*+APPEND PARALLEL(16)*/
INTO MAR01@CSMBDB T
USING (SELECT /*+PARALLEL(16)*/
        A.DAYS DAYS, --日期
        A.DEPTNO DEPT_NO, --大类编码
        A.AMT NET_SALES_AMT, --净销售额
        ROUND(A.AMT / A.TOSLS, 4) DP_PER, --大类占比
        A.CUST CUST, --客流量
        A.VIPAMT VIP_NET_SALES_AMT, --会员净销售额
        A.VIPCUST VIP_CUST, --会员客流量
        A.BUDGETAMT MONTH_BUDGET, --月预算金额，
        A.TOSLS MONTH_NET_SALES_AMT --月累计净销售额
         FROM (SELECT /*+PARALLEL(16)*/
                TRUNC(MCAL.MCAL_DAY_DT) DAYS,
                PROD.LVL6ANC_PRODCAT_ID DEPTNO,
                SUM((SLS.SLS_AMT_LCL - SLS.SLS_TAX_AMT_LCL) -
                    (SLS.RET_AMT_LCL - SLS.RET_TAX_AMT_LCL)) AMT,
                SUM(CUST.BBG_CUSTOMER_COUNT) CUST,
                DPS.TOSLS,
                SUM((SLS.VIP_SLS_AMT_LCL - SLS.VIP_SLS_TAX_AMT_LCL) -
                    (SLS.VIP_RET_AMT_LCL - SLS.VIP_RET_TAX_AMT_LCL)) VIPAMT,
                SUM(CUST.VIP_BBG_CUSTOMER_COUNT) VIPCUST,
                FC.BUDGETAMT
                 FROM RADM.W_MCAL_DAY_DV MCAL,
                      RADM.W_PROD_CAT_DH PROD,
                      RADM.BBG_RA_CUST_DP_LC_DY_A CUST,
                      RADM.W_RTL_SLS_DP_LC_DY_A SLS,
                      (SELECT /*+PARALLEL(16)*/
                        SUBSTR(BUD.DT_WID, 2, 6) MN_WID，BUD.PROD_DH_WID,
                        SUM(BUD.SLS_BUDGET_AMT_LCL) BUDGETAMT
                         FROM RADM.BBG_RA_SLSFC_DP_LC_DY_F BUD
                        GROUP BY SUBSTR(BUD.DT_WID, 2, 6) ，BUD.PROD_DH_WID) FC,
                      (SELECT /*+PARALLEL(16)*/
                        SUBSTR(TS.DT_WID, 2, 6) MN_WID,
                        TS.PROD_DH_WID,
                        SUM((TS.SLS_AMT_LCL - TS.SLS_TAX_AMT_LCL) -
                            (TS.RET_AMT_LCL - TS.RET_TAX_AMT_LCL)) TOSLS
                         FROM RADM.W_RTL_SLS_DP_LC_DY_A TS
                        GROUP BY SUBSTR(TS.DT_WID, 2, 6), TS.PROD_DH_WID) DPS
                WHERE MCAL.ROW_WID = CUST.DT_WID
                  AND MCAL.ROW_WID = SLS.DT_WID
                  AND MCAL.CAL_MONTH_WID = DPS.MN_WID 
                  AND MCAL.CAL_MONTH_WID = FC.MN_WID
                  AND PROD.LEVEL_NAME = 'DEPT'
                  AND CUST.ORG_WID = SLS.ORG_WID
                  AND PROD.ROW_WID = CUST.PROD_DH_WID
                  AND PROD.ROW_WID = SLS.PROD_DH_WID
                  AND PROD.ROW_WID = FC.PROD_DH_WID
                  AND PROD.ROW_WID = DPS.PROD_DH_WID
                  AND MCAL.MCAL_CAL_WID = 1.0
                  AND TRUNC(MCAL.MCAL_DAY_DT) BETWEEN &BEGIN_DAYS AND
                      &END_DAYS
                GROUP BY TRUNC(MCAL.MCAL_DAY_DT),
                         PROD.LVL6ANC_PRODCAT_ID,
                         DPS.TOSLS,
                         FC.BUDGETAMT) A
        ORDER BY A.DEPTNO) S
ON (S.DAYS = T.DAYS AND S.DEPT_NO = T.DEPT_NO)
WHEN MATCHED THEN
  UPDATE
     SET T.NET_SALES_AMT       = S.NET_SALES_AMT,
         T.DP_PER              = S.DP_PER,
         T.CUST                = S.CUST,
         T.VIP_NET_SALES_AMT   = S.VIP_NET_SALES_AMT,
         T.VIP_CUST            = S.VIP_CUST,
         T.MONTH_BUDGET        = S.MONTH_BUDGET,
         T.MONTH_NET_SALES_AMT = S.MONTH_NET_SALES_AMT,
         T.W_UPDATE_DT         = SYSDATE
WHEN NOT MATCHED THEN
  INSERT
    (T.DAYS,
     T.DEPT_NO,
     T.NET_SALES_AMT,
     T.DP_PER,
     T.CUST,
     T.VIP_NET_SALES_AMT,
     T.VIP_CUST,
     T.MONTH_BUDGET,
     T.MONTH_NET_SALES_AMT,
     T.W_INSERT_DT,
     T.W_UPDATE_DT)
  VALUES
    (S.DAYS,
     S.DEPT_NO,
     S.NET_SALES_AMT,
     S.DP_PER,
     S.CUST,
     S.VIP_NET_SALES_AMT,
     S.VIP_CUST,
     S.MONTH_BUDGET,
     S.MONTH_NET_SALES_AMT,
     SYSDATE,
     SYSDATE);
COMMIT;

--MAR03
MERGE /*+APPEND PARALLEL(16)*/
INTO MAR03@CSMBDB T
USING (SELECT /*+PARALLEL(16)*/
        A.DAYS DAYS, --日期
        A.HOUR_24 HOUR_24, --小时
        A.AMT net_sales_amt, --净销售额
        A.CUST CUST, --客流量
        DECODE(A.CUST, 0, 0, A.AMT / A.CUST) PCT, --客单
        A.VIP_AMT vip_net_sales_amt, --会员净销售额
        A.VIP_CUST VIP_CUST, --会员客流量
        DECODE(A.VIP_CUST, 0, 0, A.VIP_AMT / A.VIP_CUST) vip_pct --会员客单
         FROM (SELECT /*+PARALLEL(16)*/
                TRUNC(MCAL.MCAL_DAY_DT) DAYS,
                SLS.HOUR_24,
                SLS.AMT AMT,
                CUST.CUST CUST,
                SLS.VIP_AMT,
                CUST.VIP_CUST VIP_CUST
                 FROM RADM.W_MCAL_DAY_DV MCAL,
                      (SELECT /*+PARALLEL(16)*/
                        T.DT_WID,
                        M.HOUR_24_NUM HOUR_24,
                        SUM(T.BBG_CUSTOMER_COUNT) CUST,
                        SUM(T.VIP_BBG_CUSTOMER_COUNT) VIP_CUST
                         FROM RADM.BBG_RA_CUST_LC_DY_HR_A T,
                              RADM.W_MINUTE_OF_DAY_D      M
                        WHERE T.DT_WID BETWEEN &BEGIN_DTWID AND &END_DTWID
                          AND T.MINUTE_WID = M.ROW_WID
                        GROUP BY T.DT_WID, M.HOUR_24_NUM) CUST,
                      (SELECT /*+PARALLEL(16)*/
                        S.DT_WID,
                        M.HOUR_24_NUM HOUR_24,
                        SUM((S.SLS_AMT_LCL - S.SLS_TAX_AMT_LCL) -
                            (S.RET_AMT_LCL - S.RET_TAX_AMT_LCL)) AMT,
                        SUM((S.VIP_SLS_AMT_LCL - S.VIP_SLS_TAX_AMT_LCL) -
                            (S.VIP_RET_AMT_LCL - S.VIP_RET_TAX_AMT_LCL)) VIP_AMT
                         FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_F S,
                              RADM.W_MINUTE_OF_DAY_D        M
                        WHERE S.DT_WID BETWEEN &BEGIN_DTWID AND &END_DTWID
                          AND S.MIN_WID = M.ROW_WID
                        GROUP BY S.DT_WID, M.HOUR_24_NUM) SLS
                WHERE MCAL.ROW_WID = CUST.DT_WID
                  AND MCAL.ROW_WID = SLS.DT_WID
                  AND SLS.HOUR_24 = CUST.HOUR_24) A
        ORDER BY A.HOUR_24) S
ON (S.DAYS = T.DAYS AND S.HOUR_24 = T.HOUR_24)
WHEN MATCHED THEN
  UPDATE
     SET T.NET_SALES_AMT     = S.NET_SALES_AMT,
         T.CUST              = S.CUST,
         T.PCT               = S.PCT,
         T.vip_net_sales_amt = S.vip_net_sales_amt,
         T.VIP_CUST          = S.VIP_CUST,
         T.VIP_PCT           = S.VIP_PCT,
         T.W_UPDATE_DT       = SYSDATE
WHEN NOT MATCHED THEN
  INSERT
    (T.DAYS,
     T.HOUR_24,
     T.NET_SALES_AMT,
     T.CUST,
     T.PCT,
     T.vip_net_sales_amt,
     T.VIP_CUST,
     T.VIP_PCT,
     T.W_INSERT_DT,
     W_UPDATE_DT)
  VALUES
    (S.DAYS,
     S.HOUR_24,
     S.NET_SALES_AMT,
     S.CUST,
     S.PCT,
     S.vip_net_sales_amt,
     S.VIP_CUST,
     S.VIP_PCT,
     SYSDATE,
     SYSDATE);
COMMIT;

--MAR04
MERGE /*+APPEND PARALLEL(16)*/
INTO MAR04@CSMBDB T
USING (SELECT /*+PARALLEL(16)*/
        TRUNC(MCAL.MCAL_DAY_DT) DAYS, --日期
        O.ORG_HIER9_NUM LOC, --地点
        O.ORG_HIER10_NUM DISTRICT, --城市
        O.ORG_HIER11_NUM REGION, --区域
        O.ORG_HIER12_NUM AREA, --省份
        O.ORG_HIER13_NUM CHAIN, --业态
        RT.RETAIL_GROUP_ID || '-' || RT.RETAIL_GROUP_DESC RETAIL_GROUP, --零售类型（一级）
        RT.RETAIL_TYPE_ID || '-' || RT.RETAIL_TYPE_DESC RETAIL_TYPE, --零售类型（二级）
        T.AMT net_sales_amt, --净销售金额
        T.PROFIT PROFIT_AMT, --毛利率
        T.VIP_AMT vip_net_sales_amt, --会员销售
        DECODE(T.AMT, 0, 0, T.VIP_AMT / T.AMT) VIP_PER --会员占比
         FROM RADM.W_MCAL_DAY_DV MCAL,
              (SELECT /*+PARALLEL(16)*/
                S.DT_WID,
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
                WHERE S.DT_WID BETWEEN &BEGIN_DTWID AND &END_DTWID
                  AND S.DT_WID = C.DT_WID
                  AND S.ORG_WID = C.ORG_WID
                GROUP BY S.DT_WID, S.ORG_DH_WID, S.BBG_RETAIL_TYPE_WID) T,
              RADM.W_INT_ORG_DH O,
              RADM.BBG_RA_RETAIL_TYPE_D RT
        WHERE MCAL.ROW_WID = T.DT_WID
          AND T.ORG_DH_WID = O.ROW_WID
          AND RT.ROW_WID = T.BBG_RETAIL_TYPE_WID
        ORDER BY O.ORG_HIER9_NUM, RT.RETAIL_TYPE_ID) S
ON (S.DAYS = T.DAYS AND S.LOC = T.LOC AND S.DISTRICT = T.DISTRICT AND S.REGION = T.REGION AND S.AREA = T.AREA AND S.CHAIN = T.CHAIN AND T.RETAIL_GROUP = S.RETAIL_GROUP AND S.RETAIL_TYPE = T.RETAIL_TYPE)
WHEN MATCHED THEN
  UPDATE
     SET T.net_sales_amt     = S.net_sales_amt,
         T.PROFIT_AMT        = S.PROFIT_AMT,
         T.vip_net_sales_amt = S.vip_net_sales_amt,
         T.VIP_PER           = S.VIP_PER
WHEN NOT MATCHED THEN
  INSERT
    (T.DAYS,
     T.LOC,
     T.DISTRICT,
     T.REGION,
     T.AREA,
     T.CHAIN,
     T.RETAIL_GROUP,
     T.RETAIL_TYPE,
     T.net_sales_amt,
     T.PROFIT_AMT,
     T.vip_net_sales_amt,
     T.VIP_PER)
  VALUES
    (S.DAYS,
     S.LOC,
     S.DISTRICT,
     S.REGION,
     S.AREA,
     S.CHAIN,
     S.RETAIL_GROUP,
     S.RETAIL_TYPE,
     S.net_sales_amt,
     S.PROFIT_AMT,
     S.vip_net_sales_amt,
     S.VIP_PER);
COMMIT;
