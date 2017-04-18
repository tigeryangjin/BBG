CREATE OR REPLACE PACKAGE JIN_PKG AS
  O_PI /*CONSTANT*/
  NUMBER := 3.141592654;
  TYPE CUR_RETURN IS REF CURSOR;

  FUNCTION ORACLE_TO_UNIX(IN_DATE DATE) RETURN NUMBER;

  FUNCTION GETAREA(R IN NUMBER) RETURN NUMBER;

  ----------------------------------------------------------
  --- 功能名:       P_UPD_BBG_RA_ITEM_LOC_D_JL
  --- 目的:         金立大家电商品地点维度不同经营属性处理
  --- 作者:         杨进
  --- 创建时间：    2016/11/15
  --- 最后修改人：
  --- 最后更改日期：
  ----------------------------------------------------------
  PROCEDURE P_UPD_BBG_RA_ITEM_LOC_D_JL;

  ----------------------------------------------------------
  --- 功能名:       P_FIX_JL_NEW_ITEM_LOC
  --- 目的:         金立大家电新店商品地点维度修复
  --- 作者:         杨进
  --- 创建时间：    2016/09/18
  --- 最后修改人：
  --- 最后更改日期：
  ----------------------------------------------------------
  PROCEDURE P_FIX_JL_NEW_ITEM_LOC(NEW_LOC IN INT);

  ----------------------------------------------------------
  --- 功能名:       P_CLOSE_STORE_REPORT
  --- 目的:         闭店门店日期列表
  --- 作者:         杨进
  --- 创建时间：    2016/09/27
  --- 最后修改人：
  --- 最后更改日期：
  ----------------------------------------------------------
  /*  PROCEDURE P_CLOSE_STORE_REPORT;*/

  ----------------------------------------------------------
  --- 功能名:       P_FIX_JL_NEW_LOC_SALES
  --- 目的:         金立大家电新店销售缺失修复
  --- 作者:         杨进
  --- 创建时间：    2016/09/18
  --- 最后修改人：
  --- 最后更改日期：
  ----------------------------------------------------------
  PROCEDURE P_FIX_JL_NEW_LOC_SALES(IN_DAY_DT IN DATE, IN_DT_WID IN INT);

  ----------------------------------------------------------
  --- 功能名:       P_BACKUP_ODI_LOG
  --- 目的:         ODI日志备份
  --- 作者:         杨进
  --- 创建时间：    2014/12/18
  --- 最后修改人：
  --- 最后更改日期：
  ----------------------------------------------------------
  PROCEDURE P_BACKUP_ODI_LOG;

  ----------------------------------------------------------
  --- 功能名:       P_DEL_SLS_AGG
  --- 目的:         删除RA的商品销售的汇总表数据
  --- 作者:         杨进
  --- 创建时间：    2016/08/11
  --- 最后修改人：  杨进
  --- 最后更改日期：2015/01/27
  ----------------------------------------------------------

  PROCEDURE P_DEL_SLS_AGG(DTWID IN NUMBER);

  ----------------------------------------------------------
  --- 功能名:       P_CK_IT_INV_DAY_ERROR
  --- 目的:         删除RA的商品销售的汇总表数据
  --- 作者:         杨进
  --- 创建时间：    2016/08/11
  --- 最后修改人：  杨进
  --- 最后更改日期：2015/01/27
  ----------------------------------------------------------

  PROCEDURE P_CK_IT_INV_DAY_ERROR(CUR_OUT IN OUT CUR_RETURN);

  ----------------------------------------------------------
  --- 功能名:       P_CK_SUPP_SLS_DAY_RESULT
  --- 目的:         检查供应商销售与商品销售差异(汇总)
  --- 作者:         杨进
  --- 创建时间：    2014/12/18
  --- 最后修改人：  杨进
  --- 最后更改日期：2015/01/27
  ----------------------------------------------------------
  PROCEDURE P_CK_SUPP_SLS_DAY_REPORT(CUR_OUT OUT CUR_RETURN,
                                     BDATE   IN DATE,
                                     EDATE   IN DATE);

  ----------------------------------------------------------
  --- 功能名:       P_CK_SUPP_SLS_LOC_DIFF_REPORT
  --- 目的:         检查供应商销售与商品销售差异(门店)
  --- 作者:         杨进
  --- 创建时间：    2015/01/27
  --- 最后修改人：
  --- 最后更改日期：
  ----------------------------------------------------------
  PROCEDURE P_CK_SUPP_SLS_LOC_DIFF_REPORT(CUR_OUT OUT CUR_RETURN,
                                          BDATE   IN DATE,
                                          EDATE   IN DATE);

  ----------------------------------------------------------
  --- 功能名:       P_CK_SUPP_SLS_ITEM_DIFF_REPORT
  --- 目的:         检查供应商销售与商品销售差异(单品)
  --- 作者:         杨进
  --- 创建时间：    2014/12/25
  --- 最后修改人：  杨进
  --- 最后更改日期：2015/01/27
  ----------------------------------------------------------
  PROCEDURE P_CK_SUPP_SLS_ITEM_DIFF_REPORT(CUR_OUT /*IN*/ OUT CUR_RETURN,
                                           BDATE   IN DATE,
                                           EDATE   IN DATE);

  ----------------------------------------------------------
  --- 功能名:       P_CK_RA_RMS_SLS_NOTAX_AMT
  --- 目的:         检查RA-销售-供应商销售未税净销售额差异
  --- 作者:         杨进
  --- 创建时间：    2014/12/18
  --- 最后修改人：
  --- 最后更改日期：
  ----------------------------------------------------------
  PROCEDURE P_CK_RA_RMS_SLS_NOTAX_AMT(CUR_OUT IN OUT CUR_RETURN,
                                      B_DTWID IN NUMBER,
                                      E_DTWID IN NUMBER);

  ----------------------------------------------------------
  --- 功能名:       P_CK_RA_RMS_SUPPSLS_DAY
  --- 目的:         检查RA-RMS的供应商销售差异情况(按天)
  --- 作者:         杨进
  --- 创建时间：    2015/1/5
  --- 最后修改人：
  --- 最后更改日期：
  ----------------------------------------------------------
  PROCEDURE P_CK_RA_RMS_SUPPSLS_DAY(CUR_OUT IN OUT CUR_RETURN,
                                    BDATE   IN DATE,
                                    EDATE   IN DATE);

  ----------------------------------------------------------
  --- 功能名:    F_INSERT_RA_SUPPSLS_ITLCDY_TMP
  --- 目的:      从BBG_RA_SUPP_SALES_IT_LC_DY_F往BBG_RA_SUPP_SLS_IT_LC_DY_TMP查数据,
  ---               然后从此表往各汇总表插入数据
  --- 作者:         杨进
  --- 创建时间：    2014/12/18
  --- 最后修改人：
  --- 最后更改日期：
  ----------------------------------------------------------
  FUNCTION F_INSERT_RA_SUPPSLS_ITLCDY_TMP(O_ERROR_MESSAGE IN OUT VARCHAR2,
                                          B_DTWID         IN NUMBER,
                                          E_DTWID         IN NUMBER)
    RETURN BOOLEAN;

  ----------------------------------------------------------
  --- 功能名:       F_DEL_RA_SUPPSLS_AGGREGATE_TAB
  --- 目的:         删除供应商销售的汇总表数据
  --- 作者:         杨进
  --- 创建时间：    2014/12/18
  --- 最后修改人：
  --- 最后更改日期：
  ----------------------------------------------------------
  FUNCTION F_DEL_RA_SUPPSLS_AGGREGATE_TAB(O_ERROR_MESSAGE IN OUT VARCHAR2,
                                          DTWID           IN NUMBER)
    RETURN BOOLEAN;

  ----------------------------------------------------------
  --- 功能名:       F_SLS_TRX_IT_LC_DY_TMP_FIX_JL
  --- 目的:         修复RA中金力销售数据
  --- 作者:         杨进
  --- 创建时间：    2015/05/04
  --- 最后修改人：
  --- 最后更改日期：
  ----------------------------------------------------------
  FUNCTION F_SLS_TRX_IT_LC_DY_TMP_FIX_JL(O_ERROR_MESSAGE IN OUT VARCHAR2,
                                         BDATE           IN DATE,
                                         EDATE           IN DATE)
    RETURN BOOLEAN;

END JIN_PKG;
/
CREATE OR REPLACE PACKAGE BODY JIN_PKG AS

  FUNCTION ORACLE_TO_UNIX(IN_DATE DATE) RETURN NUMBER IS
  BEGIN
    RETURN(in_date - TO_DATE('19700101', 'yyyymmdd')) * 86400 - TO_NUMBER(SUBSTR(TZ_OFFSET(sessiontimezone),
                                                                                 1,
                                                                                 3)) * 3600;
  END oracle_to_unix;

  FUNCTION GETAREA(R IN NUMBER) RETURN NUMBER IS
    V_AREA NUMBER;
  BEGIN
    V_AREA := R * R * O_PI;
    RETURN V_AREA;
  END;

  PROCEDURE P_UPD_BBG_RA_ITEM_LOC_D_JL IS
  BEGIN
    UPDATE RADM.BBG_RA_ITEM_LOC_D E
       SET E.BUSINESS_MODE =
           (SELECT F.BUSINESS_MODE
              FROM (SELECT G.ITEM,
                           G.BUSINESS_MODE,
                           G.EFFECTIVE_FROM_DT,
                           RANK() OVER(PARTITION BY G.ITEM ORDER BY G.EFFECTIVE_FROM_DT DESC, G.BUSINESS_MODE) RANK1
                      FROM (SELECT /*+PARALLEL(4)*/
                             D.ITEM,
                             D.BUSINESS_MODE,
                             MAX(D.EFFECTIVE_FROM_DT) EFFECTIVE_FROM_DT
                              FROM RADM.BBG_RA_ITEM_LOC_D D
                             WHERE LENGTH(D.ITEM) = 13
                               AND SUBSTR(D.ITEM, 1, 2) = 24
                               AND D.CURRENT_FLG = 'Y'
                               AND EXISTS
                             (SELECT 1
                                      FROM (SELECT A.ITEM,
                                                   COUNT(A.BUSINESS_MODE)
                                              FROM (SELECT /*+PARALLEL(4)*/
                                                    DISTINCT B.ITEM,
                                                             B.BUSINESS_MODE
                                                      FROM RADM.BBG_RA_ITEM_LOC_D B
                                                     WHERE LENGTH(B.ITEM) = 13
                                                       AND SUBSTR(B.ITEM, 1, 2) = 24
                                                       AND B.CURRENT_FLG = 'Y') A
                                             GROUP BY A.ITEM
                                            HAVING COUNT(A.BUSINESS_MODE) > 1) C
                                     WHERE D.ITEM = C.ITEM)
                             GROUP BY D.ITEM, D.BUSINESS_MODE) G) F
             WHERE E.ITEM = F.ITEM
               AND F.RANK1 = 1)
     WHERE EXISTS
     (SELECT 1
              FROM (SELECT G.ITEM,
                           G.BUSINESS_MODE,
                           G.EFFECTIVE_FROM_DT,
                           RANK() OVER(PARTITION BY G.ITEM ORDER BY G.EFFECTIVE_FROM_DT DESC, G.BUSINESS_MODE) RANK1
                      FROM (SELECT /*+PARALLEL(4)*/
                             D.ITEM,
                             D.BUSINESS_MODE,
                             MAX(D.EFFECTIVE_FROM_DT) EFFECTIVE_FROM_DT
                              FROM RADM.BBG_RA_ITEM_LOC_D D
                             WHERE LENGTH(D.ITEM) = 13
                               AND SUBSTR(D.ITEM, 1, 2) = 24
                               AND D.CURRENT_FLG = 'Y'
                               AND EXISTS
                             (SELECT 1
                                      FROM (SELECT A.ITEM,
                                                   COUNT(A.BUSINESS_MODE)
                                              FROM (SELECT /*+PARALLEL(4)*/
                                                    DISTINCT B.ITEM,
                                                             B.BUSINESS_MODE
                                                      FROM RADM.BBG_RA_ITEM_LOC_D B
                                                     WHERE LENGTH(B.ITEM) = 13
                                                       AND SUBSTR(B.ITEM, 1, 2) = 24
                                                       AND B.CURRENT_FLG = 'Y') A
                                             GROUP BY A.ITEM
                                            HAVING COUNT(A.BUSINESS_MODE) > 1) C
                                     WHERE D.ITEM = C.ITEM)
                             GROUP BY D.ITEM, D.BUSINESS_MODE) G) H
             WHERE E.ITEM = H.ITEM
               AND E.EFFECTIVE_FROM_DT = H.EFFECTIVE_FROM_DT
               AND E.BUSINESS_MODE = H.BUSINESS_MODE
               AND H.RANK1 <> 1)
       AND E.CURRENT_FLG = 'Y'
       AND LENGTH(E.ITEM) = 13
       AND SUBSTR(E.ITEM, 1, 2) = 24;
    COMMIT;
  END;

  PROCEDURE P_FIX_JL_NEW_ITEM_LOC(NEW_LOC IN INT) IS
  BEGIN
    execute immediate 'TRUNCATE TABLE RADM.BBG_RA_ITEM_LOC_DS';
    EXECUTE IMMEDIATE 'TRUNCATE TABLE RADM.C_LOAD_DATES';
    insert into RADM.BBG_RA_ITEM_LOC_DS T
      (ITEM,
       LOC,
       NBB,
       NBO,
       SALE_TYPE,
       STANDARD_GROSS_MARGIN,
       PROMO_GROSS_MARGIN,
       BUSINESS_MODE,
       ZC_IND,
       ZG_IND,
       HERO_ITEM_IND,
       REF_NO1,
       REF_NO2,
       REF_NO3,
       REF_NO4,
       SRC_EFF_FROM_DT,
       INTEGRATION_ID,
       NEW_ITEM_FLAG,
       DATASOURCE_NUM_ID,
       ETL_PROC_WID)
      select S.ITEM,
             S.LOC,
             S.NBB,
             S.NBO,
             S.SALE_TYPE,
             S.STANDARD_GROSS_MARGIN,
             S.PROMO_GROSS_MARGIN,
             S.BUSINESS_MODE,
             S.ZC_IND,
             S.BBG_ZG_IND ZG_IND,
             S.HERO_ITEM_IND,
             S.REF_NO1,
             S.REF_NO2,
             S.REF_NO3,
             S.REF_NO4,
             S.SRC_EFF_FROM_DT,
             S.INTEGRATION_ID,
             S.NEW_ITEM_FLAG,
             S.DATASOURCE_NUM_ID,
             S.ETL_PROC_WID
        from (SELECT JL.ITEM,
                     TO_NUMBER(JL.LOC) LOC,
                     JL.NBB,
                     JL.NBO,
                     JL.SALE_TYPE,
                     JL.STANDARD_GROSS_MARGIN,
                     JL.PROMO_GROSS_MARGIN,
                     JL.BUSINESS_MODE,
                     JL.ZC_IND,
                     JL.BBG_ZG_IND,
                     JL.HERO_ITEM_IND,
                     JL.REF_NO1,
                     TO_NUMBER(JL.REF_NO2) REF_NO2,
                     JL.REF_NO3,
                     JL.REF_NO4,
                     JL.SRC_EFF_FROM_DT,
                     JL.ITEM || '~' || JL.LOC INTEGRATION_ID,
                     JL.NEW_ITEM_FLAG,
                     1 DATASOURCE_NUM_ID,
                     100 ETL_PROC_WID
                FROM BBG_RA_ITEM_LOC_JL_V_ALL@RA_JL JL
               WHERE JL.LOC = NEW_LOC) S
       WHERE NOT EXISTS (SELECT 1
                FROM (SELECT DISTINCT ITEM, LOC, BUSINESS_MODE
                        FROM RADM.BBG_RA_ITEM_LOC_D
                       WHERE LOC = NEW_LOC) IL
               WHERE S.ITEM = IL.ITEM
                 AND S.LOC = IL.LOC
                 AND S.BUSINESS_MODE = IL.BUSINESS_MODE);
    COMMIT;
  END;

  /*  PROCEDURE P_CLOSE_STORE_REPORT IS
  BEGIN
    CURSOR C_ORG_NUM IS
      SELECT ORG_NUM FROM RADM.W_INT_ORG_D;
    R_ORG_NUM C_ORG_NUM%ROWTYPE;
  for R_ORG_NUM in C_ORG_NUM  loop
      SELECT \*+PARALLEL(16)*\ J.ORG_NUM, J.MIN_DATE + LEVEL - 1 DAYS
    FROM (SELECT \*+PARALLEL(16)*\ O.ORG_NUM,
                 MIN(TO_DATE(SUBSTR(T.DT_WID, 2, 8), 'YYYYMMDD')) MIN_DATE,
                 MAX(TO_DATE(SUBSTR(T.DT_WID, 2, 8), 'YYYYMMDD') + 1) MAX_DATE
            FROM RADM.W_RTL_SLS_LC_DY_A T, RADM.W_INT_ORG_D O
           WHERE T.ORG_WID = O.ROW_WID
           --AND O.ORG_NUM=120033
           GROUP BY O.ORG_NUM) J
  CONNECT BY LEVEL <= J.MAX_DATE - J.MIN_DATE;
  END;*/

  PROCEDURE P_FIX_JL_NEW_LOC_SALES(IN_DAY_DT IN DATE, IN_DT_WID IN INT) IS
  BEGIN
    --执行成功后，再执行ODI的商品销售和供应商销售的SIL,PLP部分
    --商品销售处理
    EXECUTE IMMEDIATE 'TRUNCATE TABLE RADM.W_RTL_SLS_TRX_IT_LC_DY_FS';
    INSERT INTO RADM.W_RTL_SLS_TRX_IT_LC_DY_FS
      (SLS_TRX_ID,
       PROD_IT_NUM,
       ORG_NUM,
       DAY_DT,
       VOUCHER_ID,
       RTL_TYPE_CODE,
       MIN_NUM,
       EMPLOYEE_NUM,
       SLS_QTY,
       SLS_AMT_LCL,
       SLS_PROFIT_AMT_LCL,
       SLS_TAX_AMT_LCL,
       SLS_EMP_DISC_AMT_LCL,
       SLS_MANUAL_COUNT,
       SLS_SCAN_COUNT,
       RET_QTY,
       RET_AMT_LCL,
       RET_PROFIT_AMT_LCL,
       RET_TAX_AMT_LCL,
       RET_EMP_DISC_AMT_LCL,
       RET_MANUAL_COUNT,
       RET_SCAN_COUNT,
       REJECT_FLG,
       SLS_MANUAL_MKDN_AMT_LCL,
       SLS_MANUAL_MKUP_AMT_LCL,
       RET_MANUAL_MKDN_AMT_LCL,
       RET_MANUAL_MKUP_AMT_LCL,
       EXCHANGE_DT,
       AUX1_CHANGED_ON_DT,
       AUX2_CHANGED_ON_DT,
       AUX3_CHANGED_ON_DT,
       AUX4_CHANGED_ON_DT,
       CHANGED_BY_ID,
       CHANGED_ON_DT,
       CREATED_BY_ID,
       CREATED_ON_DT,
       DATASOURCE_NUM_ID,
       DELETE_FLG,
       DOC_CURR_CODE,
       ETL_THREAD_VAL,
       GLOBAL1_EXCHANGE_RATE,
       GLOBAL2_EXCHANGE_RATE,
       GLOBAL3_EXCHANGE_RATE,
       INTEGRATION_ID,
       LOC_CURR_CODE,
       LOC_EXCHANGE_RATE,
       TENANT_ID,
       X_CUSTOM,
       BBG_RETAIL_TYPE_ID,
       BBG_SERVICE_SATISFACTION,
       SRC_REF_NO1,
       SRC_REF_NO2,
       SRC_REF_NO3,
       SRC_REF_NO6,
       SRC_REF_NO7,
       SRC_REF_NO8,
       BBG_REFERENCE_DO1,
       BBG_REFERENCE_DO2,
       BBG_REFERENCE_DO3,
       BBG_REFERENCE_DO4,
       BBG_REFERENCE_DO5,
       BBG_REFERENCE_FO1,
       BBG_REFERENCE_FO2,
       BBG_REFERENCE_FO3,
       BBG_REFERENCE_FO4,
       BBG_REFERENCE_FO5,
       BBG_REFERENCE_FO6,
       BBG_REFERENCE_FO7,
       BBG_REFERENCE_FO8,
       BBG_REFERENCE_FO9,
       BBG_REFERENCE_FO10,
       HYK_NO)
      SELECT /*+PARALLEL(16)*/
       T.SLS_TRX_ID,
       T.PROD_IT_NUM,
       T.ORG_NUM,
       T.DAY_DT,
       -1 VOUCHER_ID,
       T.RTL_TYPE_CODE,
       T.MIN_NUM,
       -1 EMPLOYEE_NUM,
       T.SLS_QTY,
       T.SLS_AMT_LCL,
       T.SLS_PROFIT_AMT_LCL,
       T.SLS_TAX_AMT_LCL,
       T.SLS_EMP_DISC_AMT_LCL,
       T.SLS_MANUAL_COUNT,
       T.SLS_SCAN_COUNT,
       T.RET_QTY RET_QTY,
       T.RET_AMT_LCL RET_AMT_LCL,
       T.RET_PROFIT_AMT_LCL,
       T.RET_TAX_AMT_LCL RET_TAX_AMT_LCL,
       T.RET_EMP_DISC_AMT_LCL,
       T.RET_MANUAL_COUNT,
       T.RET_SCAN_COUNT,
       NULL REJECT_FLG,
       T.SLS_MANUAL_MKDN_AMT_LCL,
       T.SLS_MANUAL_MKUP_AMT_LCL,
       T.RET_MANUAL_MKDN_AMT_LCL,
       T.RET_MANUAL_MKUP_AMT_LCL,
       T.DAY_DT EXCHANGE_DT,
       NULL AUX1_CHANGED_ON_DT,
       NULL AUX2_CHANGED_ON_DT,
       NULL AUX3_CHANGED_ON_DT,
       NULL AUX4_CHANGED_ON_DT,
       -1 CHANGED_BY_ID,
       SYSDATE CHANGED_ON_DT,
       -1 CREATED_BY_ID,
       SYSDATE CREATED_ON_DT,
       1 DATASOURCE_NUM_ID,
       NULL DELETE_FLG,
       'CNY' DOC_CURR_CODE,
       (SELECT L.THREAD_VAL
          FROM RA_RMS.RA_RESTART_LOC@RA_RMS_DBLINK L
         WHERE T.ORG_NUM = L.DRIVER_VALUE
           AND L.SCENARIO_NAME = 'SDE_BBG_RETAIL_SALESTRANSACTIONFACT') ETL_THREAD_VAL,
       NULL GLOBAL1_EXCHANGE_RATE,
       NULL GLOBAL2_EXCHANGE_RATE,
       NULL GLOBAL3_EXCHANGE_RATE,
       T.SLS_TRX_ID || '~' || T.PROD_IT_NUM || '~-1~' ||
       TO_CHAR(T.DAY_DT, 'DD-MON-YY', 'NLS_DATE_LANGUAGE = American') INTEGRATION_ID,
       'CNY' LOC_CURR_CODE,
       NULL LOC_EXCHANGE_RATE,
       NULL TENANT_ID,
       NULL X_CUSTOM,
       T.BBG_RETAIL_TYPE_ID,
       3.5 BBG_SERVICE_SATISFACTION,
       NULL SRC_REF_NO1,
       NULL SRC_REF_NO2,
       NULL SRC_REF_NO3,
       T.PROD_IT_NUM SRC_REF_NO6,
       NULL SRC_REF_NO7,
       NULL SRC_REF_NO8,
       NULL BBG_REFERENCE_DO1,
       NULL BBG_REFERENCE_DO2,
       NULL BBG_REFERENCE_DO3,
       NULL BBG_REFERENCE_DO4,
       NULL BBG_REFERENCE_DO5,
       NULL BBG_REFERENCE_FO1,
       NULL BBG_REFERENCE_FO2,
       NULL BBG_REFERENCE_FO3,
       NULL BBG_REFERENCE_FO4,
       NULL BBG_REFERENCE_FO5,
       NULL BBG_REFERENCE_FO6,
       NULL BBG_REFERENCE_FO7,
       NULL BBG_REFERENCE_FO8,
       NULL BBG_REFERENCE_FO9,
       NULL BBG_REFERENCE_FO10,
       T.HYK_NO HYK_NO
        FROM (SELECT /*+PARALLEL(16)*/
               B.SLS_TRX_ID,
               B.PROD_IT_NUM,
               B.ORG_NUM,
               B.DAY_DT,
               B.VOUCHER_ID,
               B.RTL_TYPE_CODE,
               B.MIN_NUM,
               B.SLS_QTY,
               B.SLS_AMT_LCL,
               B.SLS_PROFIT_AMT_LCL,
               B.SLS_TAX_AMT_LCL,
               B.SLS_EMP_DISC_AMT_LCL,
               B.SLS_MANUAL_COUNT,
               B.SLS_SCAN_COUNT,
               -B.RET_QTY                 RET_QTY,
               -B.RET_AMT_LCL             RET_AMT_LCL,
               -B.RET_PROFIT_AMT_LCL      RET_PROFIT_AMT_LCL,
               -B.RET_TAX_AMT_LCL         RET_TAX_AMT_LCL,
               -B.RET_EMP_DISC_AMT_LCL    RET_EMP_DISC_AMT_LCL,
               -B.RET_MANUAL_COUNT        RET_MANUAL_COUNT,
               -B.RET_SCAN_COUNT          RET_SCAN_COUNT,
               B.SLS_MANUAL_MKDN_AMT_LCL,
               B.SLS_MANUAL_MKUP_AMT_LCL,
               -B.RET_MANUAL_MKDN_AMT_LCL RET_MANUAL_MKDN_AMT_LCL,
               -B.RET_MANUAL_MKUP_AMT_LCL RET_MANUAL_MKUP_AMT_LCL,
               B.BBG_RETAIL_TYPE_ID,
               B.HYK_NO
                FROM BBG_RA_SLS_TRX_JL_V@RA_JL B
               WHERE B.DAY_DT = IN_DAY_DT
                 AND EXISTS
               (SELECT /*+PARALLEL(16)*/
                       1
                        FROM (SELECT /*+PARALLEL(16)*/
                              DISTINCT A.DAY_DT, A.ORG_NUM, A.PROD_IT_NUM
                                FROM BBG_RA_SLS_TRX_JL_V@RA_JL A
                               WHERE A.DAY_DT = IN_DAY_DT
                                 AND NOT EXISTS
                               (SELECT /*+PARALLEL(16)*/
                                       1
                                        FROM RADM.W_RTL_SLS_IT_LC_DY_A B,
                                             RADM.W_PRODUCT_D          P,
                                             RADM.W_INT_ORG_D          O
                                       WHERE B.PROD_WID = P.ROW_WID
                                         AND B.ORG_WID = O.ROW_WID
                                         AND B.DT_WID = IN_DT_WID
                                         AND A.ORG_NUM = O.ORG_NUM
                                         AND A.PROD_IT_NUM = P.PROD_NUM)) A
                       WHERE B.DAY_DT = A.DAY_DT
                         AND B.ORG_NUM = A.ORG_NUM
                         AND B.PROD_IT_NUM = A.PROD_IT_NUM)) T;
    COMMIT;
  
    --供应商销售处理
    EXECUTE IMMEDIATE 'TRUNCATE TABLE RADM.BBG_RA_SLS_IT_LC_DY_FS';
    INSERT INTO RADM.BBG_RA_SLS_IT_LC_DY_FS
      (DAY_DT,
       PROD_IT_NUM,
       ORG_NUM,
       SUPPLIER_NUM,
       SUPP_SALES_QTY,
       SUPP_SALES_COST,
       SUPP_SALES_AMT,
       CHANGED_BY_ID,
       CHANGED_ON_DT,
       CREATED_BY_ID,
       CREATED_ON_DT,
       DATASOURCE_NUM_ID,
       DELETE_FLG,
       ETL_THREAD_VAL,
       INTEGRATION_ID,
       AUX1_CHANGED_ON_DT,
       AUX2_CHANGED_ON_DT,
       AUX3_CHANGED_ON_DT,
       AUX4_CHANGED_ON_DT,
       DOC_CURR_CODE,
       GLOBAL1_EXCHANGE_RATE,
       GLOBAL2_EXCHANGE_RATE,
       GLOBAL3_EXCHANGE_RATE,
       LOC_CURR_CODE,
       LOC_EXCHANGE_RATE,
       TENANT_ID,
       X_CUSTOM,
       BBG_REFERENCE_DO1,
       BBG_REFERENCE_DO2,
       BBG_REFERENCE_DO3,
       BBG_REFERENCE_DO4,
       BBG_REFERENCE_DO5,
       BBG_REFERENCE_FO1,
       BBG_REFERENCE_FO2,
       BBG_REFERENCE_FO3,
       BBG_REFERENCE_FO4,
       BBG_REFERENCE_FO5,
       BBG_REFERENCE_FO6,
       BBG_REFERENCE_FO7,
       BBG_REFERENCE_FO8,
       BBG_REFERENCE_FO9,
       BBG_REFERENCE_FO10)
      SELECT /*+PARALLEL(16)*/
       T.DAY_DT,
       T.PROD_IT_NUM,
       T.ORG_NUM,
       T.SUPPLIER_NUM,
       T.SUPP_SALES_QTY,
       T.SUPP_SALES_COST,
       T.SUPP_SALES_AMT,
       -1 CHANGED_BY_ID,
       SYSDATE CHANGED_ON_DT,
       -1 CREATED_BY_ID,
       SYSDATE CREATED_ON_DT,
       1 DATASOURCE_NUM_ID,
       NULL DELETE_FLG,
       (SELECT L.THREAD_VAL
          FROM RA_RMS.RA_RESTART_LOC@RA_RMS_DBLINK L
         WHERE T.ORG_NUM = L.DRIVER_VALUE
           AND L.SCENARIO_NAME = 'SDE_BBG_RA_SUPP_SALES_IT_LC_DY_FS') ETL_THREAD_VAL,
       TO_CHAR(T.DAY_DT, 'DD-MON-YY', 'NLS_DATE_LANGUAGE = American') || '~' ||
       T.PROD_IT_NUM || '~' || T.ORG_NUM || '~' || T.SUPPLIER_NUM INTEGRATION_ID,
       NULL AUX1_CHANGED_ON_DT,
       NULL AUX2_CHANGED_ON_DT,
       NULL AUX3_CHANGED_ON_DT,
       NULL AUX4_CHANGED_ON_DT,
       'CNY' DOC_CURR_CODE,
       NULL GLOBAL1_EXCHANGE_RATE,
       NULL GLOBAL2_EXCHANGE_RATE,
       NULL GLOBAL3_EXCHANGE_RATE,
       'CNY' LOC_CURR_CODE,
       NULL LOC_EXCHANGE_RATE,
       NULL TENANT_ID,
       NULL X_CUSTOM,
       (SELECT IL.BUSINESS_MODE
          FROM RADM.BBG_RA_ITEM_LOC_D IL
         WHERE IL.ITEM = T.PROD_IT_NUM
           AND IL.LOC = T.ORG_NUM
           AND T.DAY_DT BETWEEN IL.EFFECTIVE_FROM_DT AND IL.EFFECTIVE_TO_DT) BBG_REFERENCE_DO1,
       'JINLI' BBG_REFERENCE_DO2,
       NULL BBG_REFERENCE_DO3,
       NULL BBG_REFERENCE_DO4,
       NULL BBG_REFERENCE_DO5,
       T.BBG_REFERENCE_FO1 BBG_REFERENCE_FO1,
       NULL BBG_REFERENCE_FO2,
       NULL BBG_REFERENCE_FO3,
       NULL BBG_REFERENCE_FO4,
       NULL BBG_REFERENCE_FO5,
       NULL BBG_REFERENCE_FO6,
       NULL BBG_REFERENCE_FO7,
       NULL BBG_REFERENCE_FO8,
       NULL BBG_REFERENCE_FO9,
       NULL BBG_REFERENCE_FO10
        FROM (SELECT /*+PARALLEL(16)*/
               A.DAY_DT,
               A.PROD_IT_NUM,
               A.ORG_NUM,
               A.SUPPLIER_NUM,
               A.SUPP_SALES_QTY,
               A.SUPP_SALES_COST,
               A.SUPP_SALES_AMT,
               A.BBG_REFERENCE_FO1
                FROM BBG_RA_SUPP_SLS_JL_V@RA_JL A
               WHERE A.DAY_DT = IN_DAY_DT
                 AND EXISTS
               (SELECT 1
                        FROM (SELECT /*+PARALLEL(16)*/
                              DISTINCT A.DAY_DT, A.ORG_NUM, A.PROD_IT_NUM
                                FROM BBG_RA_SLS_TRX_JL_V@RA_JL A
                               WHERE A.DAY_DT = IN_DAY_DT
                                 AND NOT EXISTS
                               (SELECT /*+PARALLEL(16)*/
                                       1
                                        FROM RADM.BBG_RA_SLS_IT_LC_DY_A B,
                                             RADM.W_PRODUCT_D           P,
                                             RADM.W_INT_ORG_D           O
                                       WHERE B.PROD_WID = P.ROW_WID
                                         AND B.ORG_WID = O.ROW_WID
                                         AND B.DT_WID = IN_DT_WID
                                         AND A.ORG_NUM = O.ORG_NUM
                                         AND A.PROD_IT_NUM = P.PROD_NUM)) B
                       WHERE B.DAY_DT = A.DAY_DT
                         AND B.ORG_NUM = A.ORG_NUM
                         AND B.PROD_IT_NUM = A.PROD_IT_NUM)) T;
    COMMIT;
  END;

  PROCEDURE P_BACKUP_ODI_LOG IS
  BEGIN
    INSERT /*+PARALLEL(16)*/
    INTO RADM.SNP_SESSION A
      SELECT /*+PARALLEL(16)*/
       *
        FROM ODI_WREP_USER.SNP_SESSION B
       WHERE B.SESS_STATUS <> 'R'
         AND NOT EXISTS (SELECT /*+PARALLEL(16)*/
               1
                FROM RADM.SNP_SESSION C
               WHERE B.SESS_NO = C.SESS_NO);
    COMMIT;
  
    INSERT /*+PARALLEL(16)*/
    INTO RADM.SNP_SESS_STEP A
      SELECT /*+PARALLEL(16)*/
       *
        FROM ODI_WREP_USER.SNP_SESS_STEP B
       WHERE EXISTS (SELECT 1
                FROM ODI_WREP_USER.SNP_SESSION D
               WHERE B.SESS_NO = D.SESS_NO
                 AND D.SESS_STATUS <> 'R')
         AND NOT EXISTS (SELECT /*+PARALLEL(16)*/
               1
                FROM RADM.SNP_SESS_STEP C
               WHERE B.SESS_NO = C.SESS_NO
                 AND B.NNO = C.NNO);
    COMMIT;
  
    INSERT /*+PARALLEL(16)*/
    INTO RADM.SNP_SESS_TASK_LOG A
      SELECT /*+PARALLEL(16)*/
       *
        FROM ODI_WREP_USER.SNP_SESS_TASK_LOG B
       WHERE EXISTS (SELECT /*+PARALLEL(16)*/
               1
                FROM ODI_WREP_USER.SNP_SESSION D
               WHERE B.SESS_NO = D.SESS_NO
                 AND D.SESS_STATUS <> 'R')
         AND NOT EXISTS
       (SELECT /*+PARALLEL(16)*/
               1
                FROM RADM.SNP_SESS_TASK_LOG C
               WHERE B.SESS_NO = C.SESS_NO
                 AND B.NNO = C.NNO
                 AND B.NB_RUN = C.NB_RUN
                 AND B.SCEN_TASK_NO = C.SCEN_TASK_NO);
    COMMIT;
    /*  EXCEPTION
    WHEN OTHERS THEN
      O_ERROR_MESSAGE := SQLERRM;*/
  END;

  PROCEDURE P_DEL_SLS_AGG(DTWID IN NUMBER) IS
  BEGIN
    EXECUTE IMMEDIATE 'ALTER SESSION ENABLE PARALLEL DML';
    DELETE /*+PARALLEL(T,16)*/
    W_RTL_SLS_CL_DY_CUR_A T
     WHERE T.DT_WID = DTWID;
    COMMIT;
    DELETE /*+PARALLEL(T,16)*/
    W_RTL_SLS_CL_LC_DY_A T
     WHERE T.DT_WID = DTWID;
    COMMIT;
    DELETE /*+PARALLEL(T,16)*/
    W_RTL_SLS_CL_LC_DY_CUR_A T
     WHERE T.DT_WID = DTWID;
    COMMIT;
    DELETE /*+PARALLEL(T,16)*/
    W_RTL_SLS_DP_DY_CUR_A T
     WHERE T.DT_WID = DTWID;
    COMMIT;
    DELETE /*+PARALLEL(T,16)*/
    W_RTL_SLS_DP_LC_DY_A T
     WHERE T.DT_WID = DTWID;
    COMMIT;
    DELETE /*+PARALLEL(T,16)*/
    W_RTL_SLS_DP_LC_DY_CUR_A T
     WHERE T.DT_WID = DTWID;
    COMMIT;
    DELETE /*+PARALLEL(T,16)*/
    W_RTL_SLS_IT_DY_A T
     WHERE T.DT_WID = DTWID;
    COMMIT;
    DELETE /*+PARALLEL(T,16)*/
    W_RTL_SLS_IT_DY_SN_A T
     WHERE T.DT_WID = DTWID;
    COMMIT;
    DELETE /*+PARALLEL(T,16)*/
    W_RTL_SLS_IT_LC_DY_A T
     WHERE T.DT_WID = DTWID; --此表数据量很大，需要分批删除。
    COMMIT;
    DELETE /*+PARALLEL(T,16)*/
    W_RTL_SLS_IT_LC_DY_SN_A T
     WHERE T.DT_WID = DTWID;
    COMMIT;
    DELETE /*+PARALLEL(T,16)*/
    W_RTL_SLS_LC_DY_A T
     WHERE T.DT_WID = DTWID;
    COMMIT;
    DELETE /*+PARALLEL(T,16)*/
    W_RTL_SLS_SC_DY_A T
     WHERE T.DT_WID = DTWID;
    COMMIT;
    DELETE /*+PARALLEL(T,16)*/
    W_RTL_SLS_SC_DY_CUR_A T
     WHERE T.DT_WID = DTWID;
    COMMIT;
    DELETE /*+PARALLEL(T,16)*/
    W_RTL_SLS_SC_LC_DY_A T
     WHERE T.DT_WID = DTWID;
    COMMIT;
    DELETE /*+PARALLEL(T,16)*/
    W_RTL_SLS_SC_LC_DY_CUR_A T
     WHERE T.DT_WID = DTWID;
    COMMIT;
    DELETE /*+PARALLEL(T,16)*/
    W_RTL_SLS_TRX_DP_LC_DY_A T
     WHERE T.DT_WID = DTWID;
    COMMIT;
    DELETE /*+PARALLEL(T,16)*/
    W_RTL_SLS_TRX_LC_DY_A T
     WHERE T.DT_WID = DTWID;
    COMMIT;
    --清除日志，装载数据
    EXECUTE IMMEDIATE 'TRUNCATE TABLE RADM.C_LOAD_DATES';
    EXECUTE IMMEDIATE 'TRUNCATE TABLE RABATCHER.W_RTL_SLS_TRX_IT_LC_DY_TMP';
    INSERT INTO /*+PARALLEL(T,16)*/
    RABATCHER.W_RTL_SLS_TRX_IT_LC_DY_TMP
      SELECT /*+PARALLEL(T,16)*/
       *
        FROM RABATCHER.W_RTL_SLS_TRX_IT_LC_DY_TMP_BK T
       WHERE T.DT_WID = DTWID;
    COMMIT;
    EXECUTE IMMEDIATE 'ALTER SESSION DISABLE PARALLEL DML';
  END;

  PROCEDURE P_CK_IT_INV_DAY_ERROR(CUR_OUT IN OUT CUR_RETURN) IS
  BEGIN
    OPEN CUR_OUT FOR
      SELECT /*+PARALLEL(T,20)*/
       T.PROD_SCD1_WID ITEM, T.ORG_SCD1_WID LOC
        FROM RADM.W_RTL_INV_IT_LC_DY_F T
       WHERE T.TO_DT_WID = '999999999999999'
       GROUP BY T.PROD_SCD1_WID, T.ORG_SCD1_WID
      HAVING COUNT(*) > 1;
    RETURN;
  END;

  PROCEDURE P_CK_SUPP_SLS_DAY_REPORT(CUR_OUT OUT CUR_RETURN,
                                     BDATE   IN DATE,
                                     EDATE   IN DATE) IS
  BEGIN
    OPEN CUR_OUT FOR
      SELECT /*+PARALLEL(RMS_SUPP_SALES,20) PARALLEL(RA_ITEM_SALES,20) PARALLEL(RA_SUPP_SALES,20)*/
       RMS_SUPP_SALES.DAY_DT,
       RMS_SUPP_SALES.RMS_SUPP_QTY,
       RA_SUPP_SALES.RA_SUPP_QTY,
       RA_ITEM_SALES.RA_ITEM_QTY,
       RMS_SUPP_SALES.RMS_SUPP_QTY - RA_SUPP_SALES.RA_SUPP_QTY QTY_DIFF1,
       RMS_SUPP_SALES.RMS_SUPP_QTY - RA_ITEM_SALES.RA_ITEM_QTY QTY_DIFF2,
       '|',
       RMS_SUPP_SALES.RMS_SUPP_NET_AMT,
       RA_SUPP_SALES.RA_SUPP_NET_AMT,
       RA_ITEM_SALES.RA_ITEM_NET_AMT,
       RMS_SUPP_SALES.RMS_SUPP_NET_AMT - RA_SUPP_SALES.RA_SUPP_NET_AMT NET_AMT_DIFF1,
       RMS_SUPP_SALES.RMS_SUPP_NET_AMT - RA_ITEM_SALES.RA_ITEM_NET_AMT NET_AMT_DIFF2,
       '|',
       RMS_SUPP_SALES.RMS_SUPP_COST,
       RA_SUPP_SALES.RA_SUPP_COST,
       RA_ITEM_SALES.RA_ITEM_COST,
       RMS_SUPP_SALES.RMS_SUPP_COST - RA_SUPP_SALES.RA_SUPP_COST COST_DIFF1,
       RMS_SUPP_SALES.RMS_SUPP_COST - RA_ITEM_SALES.RA_ITEM_COST COST_DIFF2,
       '|',
       RMS_SUPP_SALES.RMS_SUPP_AMT,
       RA_SUPP_SALES.RA_SUPP_AMT,
       RA_ITEM_SALES.RA_ITEM_AMT,
       RMS_SUPP_SALES.RMS_SUPP_AMT - RA_SUPP_SALES.RA_SUPP_AMT AMT_DIFF1,
       RMS_SUPP_SALES.RMS_SUPP_AMT - RA_ITEM_SALES.RA_ITEM_AMT AMT_DIFF2
        FROM --RMS_SUPP_SALES
             (SELECT /*+PARALLEL(RMS,20)*/
               RMS.DAY_DT,
               SUM(RMS.SUPP_SALES_QTY) RMS_SUPP_QTY,
               SUM(RMS.SUPP_SALES_COST) RMS_SUPP_COST,
               SUM(RMS.SUPP_SALES_AMT) RMS_SUPP_NET_AMT,
               SUM(RMS.BBG_REFERENCE_FO1) RMS_SUPP_AMT
                FROM RADM.JIN_RMS_SUPP_SALES_TMP RMS
               WHERE RMS.DAY_DT BETWEEN BDATE AND EDATE
                    --剔出118001批发销售
                 AND RMS.LOC <> 118001
               GROUP BY RMS.DAY_DT) RMS_SUPP_SALES,
             --RA_ITEM_SALES
             (SELECT /*+PARALLEL(T1,20)*/
               T1.DAY_DT,
               SUM(RA_ITEM_QTY) RA_ITEM_QTY,
               SUM(RA_ITEM_COST) RA_ITEM_COST,
               SUM(RA_ITEM_NET_AMT) RA_ITEM_NET_AMT,
               SUM(RA_ITEM_AMT) RA_ITEM_AMT
                FROM (SELECT /*+PARALLEL(T,20) PARALLEL(MCAL,20) PARALLEL(PK,20) PARALLEL(P,20)*/
                       MCAL.MCAL_DAY_DT DAY_DT,
                       CASE
                         WHEN PK.PACK_NO IS NULL THEN
                          P.PROD_NUM
                         ELSE
                          PK.ITEM
                       END ITEM,
                       SUM((T.SLS_QTY - T.RET_QTY) * NVL(PK.PACK_QTY, 1)) RA_ITEM_QTY,
                       SUM((((T.SLS_AMT_LCL - T.RET_AMT_LCL) -
                           (T.SLS_TAX_AMT_LCL - T.RET_TAX_AMT_LCL)) -
                           (NVL(T.SLS_PROFIT_AMT_LCL, 0) -
                           NVL(T.RET_PROFIT_AMT_LCL, 0))) /
                           NVL(PK2.PACK_QTY, 1) * NVL(PK.PACK_QTY, 1)) RA_ITEM_COST,
                       SUM(((T.SLS_AMT_LCL - T.RET_AMT_LCL) -
                           (T.SLS_TAX_AMT_LCL - T.RET_TAX_AMT_LCL)) /
                           NVL(PK2.PACK_QTY, 1) * NVL(PK.PACK_QTY, 1)) RA_ITEM_NET_AMT,
                       SUM((T.SLS_AMT_LCL - T.RET_AMT_LCL) /
                           NVL(PK2.PACK_QTY, 1) * NVL(PK.PACK_QTY, 1)) RA_ITEM_AMT
                        FROM RADM.W_RTL_SLS_IT_LC_DY_A T,
                             RADM.W_MCAL_DAY_DV        MCAL,
                             RADM.PACKITEM             PK,
                             --一个包装商品对应多个子商品_PK2
                             (SELECT /*+PARALLEL(PK1,20)*/
                               PACK_NO, SUM(PK1.PACK_QTY) PACK_QTY
                                FROM PACKITEM PK1
                               GROUP BY PACK_NO) PK2,
                             RADM.W_PRODUCT_D P
                       WHERE MCAL.ROW_WID = T.DT_WID
                         AND T.PROD_WID = P.ROW_WID
                         AND P.PROD_NUM = PK.PACK_NO(+)
                         AND PK.PACK_NO = PK2.PACK_NO(+)
                         AND MCAL.MCAL_DAY_DT BETWEEN BDATE AND EDATE
                         AND EXISTS
                       (SELECT /*+PARALLEL(D,20)*/
                               1
                                FROM RADM.BBG_RA_ITEM_LOC_D D
                               WHERE T.BBG_ITEM_LOC_WID = D.ROW_WID
                                 AND D.BUSINESS_MODE <> 'ZS')
                         AND EXISTS
                       (SELECT /*+PARALLEL(O,20)  PARALLEL(A,20)*/
                               1
                                FROM RADM.W_INT_ORG_D      O,
                                     RADM.W_INT_ORG_ATTR_D A
                               WHERE T.ORG_WID = O.ROW_WID
                                 AND O.SCD1_WID = A.SCD1_WID
                                 AND A.ORG_ATTR23_NAME = 1)
                       GROUP BY MCAL.MCAL_DAY_DT,
                                PK.ITEM,
                                PK.PACK_NO,
                                P.PROD_NUM) T1
               GROUP BY T1.DAY_DT) RA_ITEM_SALES,
             --RA_SUPP_SALES
             (SELECT /*+PARALLEL(T,20) PARALLEL(MCAL,20)*/
               MCAL.MCAL_DAY_DT DAY_DT,
               SUM(T.SUPP_SALES_QTY) RA_SUPP_QTY,
               SUM(T.SUPP_SALES_COST) RA_SUPP_COST,
               SUM(T.SUPP_SALES_AMT) RA_SUPP_NET_AMT,
               SUM(T.BBG_REFERENCE_FO1) RA_SUPP_AMT
                FROM RADM.BBG_RA_SLS_IT_LC_DY_A T,
                     RADM.W_MCAL_DAY_DV         MCAL,
                     RADM.W_INT_ORG_D           O
               WHERE MCAL.ROW_WID = T.DT_WID
                 AND T.ORG_WID = O.ROW_WID
                 AND MCAL.MCAL_DAY_DT BETWEEN BDATE AND EDATE
                    --剔除118001的批发销售
                 AND O.ORG_NUM <> 118001
               GROUP BY MCAL.MCAL_DAY_DT) RA_SUPP_SALES
       WHERE RMS_SUPP_SALES.DAY_DT = RA_SUPP_SALES.DAY_DT
         AND RMS_SUPP_SALES.DAY_DT = RA_ITEM_SALES.DAY_DT
       ORDER BY RMS_SUPP_SALES.DAY_DT;
    RETURN;
  END;

  PROCEDURE P_CK_SUPP_SLS_LOC_DIFF_REPORT(CUR_OUT OUT CUR_RETURN,
                                          BDATE   IN DATE,
                                          EDATE   IN DATE) IS
  BEGIN
    OPEN CUR_OUT FOR
      SELECT /*+PARALLEL(RMS_SUPP_SALES,20) PARALLEL(RA_ITEM_SALES,20) PARALLEL(RA_SUPP_SALES,20)*/
       RMS_SUPP_SALES.DAY_DT,
       RMS_SUPP_SALES.LOC,
       RMS_SUPP_SALES.RMS_SUPP_QTY,
       RA_SUPP_SALES.RA_SUPP_QTY,
       RA_ITEM_SALES.RA_ITEM_QTY,
       RMS_SUPP_SALES.RMS_SUPP_QTY - RA_SUPP_SALES.RA_SUPP_QTY QTY_DIFF1,
       RMS_SUPP_SALES.RMS_SUPP_QTY - RA_ITEM_SALES.RA_ITEM_QTY QTY_DIFF2,
       '|',
       RMS_SUPP_SALES.RMS_SUPP_NET_AMT,
       RA_SUPP_SALES.RA_SUPP_NET_AMT,
       RA_ITEM_SALES.RA_ITEM_NET_AMT,
       RMS_SUPP_SALES.RMS_SUPP_NET_AMT - RA_SUPP_SALES.RA_SUPP_NET_AMT NET_AMT_DIFF1,
       RMS_SUPP_SALES.RMS_SUPP_NET_AMT - RA_ITEM_SALES.RA_ITEM_NET_AMT NET_AMT_DIFF2,
       '|',
       RMS_SUPP_SALES.RMS_SUPP_COST,
       RA_SUPP_SALES.RA_SUPP_COST,
       RA_ITEM_SALES.RA_ITEM_COST,
       RMS_SUPP_SALES.RMS_SUPP_COST - RA_SUPP_SALES.RA_SUPP_COST COST_DIFF1,
       RMS_SUPP_SALES.RMS_SUPP_COST - RA_ITEM_SALES.RA_ITEM_COST COST_DIFF2,
       '|',
       RMS_SUPP_SALES.RMS_SUPP_AMT,
       RA_SUPP_SALES.RA_SUPP_AMT,
       RA_ITEM_SALES.RA_ITEM_AMT,
       RMS_SUPP_SALES.RMS_SUPP_AMT - RA_SUPP_SALES.RA_SUPP_AMT AMT_DIFF1,
       RMS_SUPP_SALES.RMS_SUPP_AMT - RA_ITEM_SALES.RA_ITEM_AMT AMT_DIFF2
        FROM --RMS_SUPP_SALES
             (SELECT /*+PARALLEL(RMS,20)*/
               RMS.DAY_DT,
               RMS.LOC,
               SUM(RMS.SUPP_SALES_QTY) RMS_SUPP_QTY,
               SUM(RMS.SUPP_SALES_COST) RMS_SUPP_COST,
               SUM(RMS.SUPP_SALES_AMT) RMS_SUPP_NET_AMT,
               SUM(RMS.BBG_REFERENCE_FO1) RMS_SUPP_AMT
                FROM RADM.JIN_RMS_SUPP_SALES_TMP RMS
               WHERE RMS.DAY_DT BETWEEN BDATE AND EDATE
                    --剔出118001批发销售
                 AND RMS.LOC <> 118001
               GROUP BY RMS.DAY_DT, RMS.LOC) RMS_SUPP_SALES,
             --RA_ITEM_SALES
             (SELECT /*+PARALLEL(T1,20)*/
               T1.DAY_DT,
               T1.LOC,
               SUM(RA_ITEM_QTY) RA_ITEM_QTY,
               SUM(RA_ITEM_COST) RA_ITEM_COST,
               SUM(RA_ITEM_NET_AMT) RA_ITEM_NET_AMT,
               SUM(RA_ITEM_AMT) RA_ITEM_AMT
                FROM (SELECT /*+PARALLEL(T,20) PARALLEL(MCAL,20) PARALLEL(PK,20) PARALLEL(PK2,20) PARALLEL(P,20) PARALLEL(O,20)*/
                       MCAL.MCAL_DAY_DT DAY_DT,
                       O.ORG_NUM LOC,
                       CASE
                         WHEN PK.PACK_NO IS NULL THEN
                          P.PROD_NUM
                         ELSE
                          PK.ITEM
                       END ITEM,
                       SUM((T.SLS_QTY - T.RET_QTY) * NVL(PK.PACK_QTY, 1)) RA_ITEM_QTY,
                       SUM((((T.SLS_AMT_LCL - T.RET_AMT_LCL) -
                           (T.SLS_TAX_AMT_LCL - T.RET_TAX_AMT_LCL)) -
                           (NVL(T.SLS_PROFIT_AMT_LCL, 0) -
                           NVL(T.RET_PROFIT_AMT_LCL, 0))) /
                           NVL(PK2.PACK_QTY, 1) * NVL(PK.PACK_QTY, 1)) RA_ITEM_COST,
                       SUM(((T.SLS_AMT_LCL - T.RET_AMT_LCL) -
                           (T.SLS_TAX_AMT_LCL - T.RET_TAX_AMT_LCL)) /
                           NVL(PK2.PACK_QTY, 1) * NVL(PK.PACK_QTY, 1)) RA_ITEM_NET_AMT,
                       SUM((T.SLS_AMT_LCL - T.RET_AMT_LCL) /
                           NVL(PK2.PACK_QTY, 1) * NVL(PK.PACK_QTY, 1)) RA_ITEM_AMT
                        FROM RADM.W_RTL_SLS_IT_LC_DY_A T,
                             RADM.W_MCAL_DAY_DV        MCAL,
                             RADM.PACKITEM             PK,
                             --一个包装商品对应多个子商品_PK2
                             (SELECT /*+PARALLEL(PK1,20)*/
                               PACK_NO, SUM(PK1.PACK_QTY) PACK_QTY
                                FROM PACKITEM PK1
                               GROUP BY PACK_NO) PK2,
                             RADM.W_PRODUCT_D P,
                             RADM.W_INT_ORG_D O
                       WHERE MCAL.ROW_WID = T.DT_WID
                         AND T.PROD_WID = P.ROW_WID
                         AND T.ORG_WID = O.ROW_WID
                         AND P.PROD_NUM = PK.PACK_NO(+)
                         AND PK.PACK_NO = PK2.PACK_NO(+)
                         AND MCAL.MCAL_DAY_DT BETWEEN BDATE AND EDATE
                         AND EXISTS
                       (SELECT /*+PARALLEL(D,20)*/
                               1
                                FROM RADM.BBG_RA_ITEM_LOC_D D
                               WHERE T.BBG_ITEM_LOC_WID = D.ROW_WID
                                 AND D.BUSINESS_MODE <> 'ZS')
                         AND EXISTS
                       (SELECT /*+PARALLEL(O,20)  PARALLEL(A,20)*/
                               1
                                FROM RADM.W_INT_ORG_D      O,
                                     RADM.W_INT_ORG_ATTR_D A
                               WHERE T.ORG_WID = O.ROW_WID
                                 AND O.SCD1_WID = A.SCD1_WID
                                 AND A.ORG_ATTR23_NAME = 1)
                       GROUP BY MCAL.MCAL_DAY_DT,
                                PK.ITEM,
                                PK.PACK_NO,
                                P.PROD_NUM,
                                O.ORG_NUM) T1
               GROUP BY T1.DAY_DT, T1.LOC) RA_ITEM_SALES,
             --RA_SUPP_SALES
             (SELECT /*+PARALLEL(T,20) PARALLEL(MCAL,20)*/
               MCAL.MCAL_DAY_DT DAY_DT,
               O.ORG_NUM LOC,
               SUM(T.SUPP_SALES_QTY) RA_SUPP_QTY,
               SUM(T.SUPP_SALES_COST) RA_SUPP_COST,
               SUM(T.SUPP_SALES_AMT) RA_SUPP_NET_AMT,
               SUM(T.BBG_REFERENCE_FO1) RA_SUPP_AMT
                FROM RADM.BBG_RA_SLS_IT_LC_DY_A T,
                     RADM.W_MCAL_DAY_DV         MCAL,
                     RADM.W_INT_ORG_D           O
               WHERE MCAL.ROW_WID = T.DT_WID
                 AND T.ORG_WID = O.ROW_WID
                    --剔出118001的批发销售
                 AND O.ORG_NUM <> 118001
                 AND MCAL.MCAL_DAY_DT BETWEEN BDATE AND EDATE
               GROUP BY MCAL.MCAL_DAY_DT, O.ORG_NUM) RA_SUPP_SALES
       WHERE RMS_SUPP_SALES.DAY_DT = RA_SUPP_SALES.DAY_DT(+)
         AND RMS_SUPP_SALES.DAY_DT = RA_ITEM_SALES.DAY_DT(+)
         AND RMS_SUPP_SALES.LOC = RA_SUPP_SALES.LOC(+)
         AND RMS_SUPP_SALES.LOC = RA_ITEM_SALES.LOC(+)
       ORDER BY RMS_SUPP_SALES.DAY_DT;
    RETURN;
  END;

  PROCEDURE P_CK_SUPP_SLS_ITEM_DIFF_REPORT(CUR_OUT OUT CUR_RETURN,
                                           BDATE   IN DATE,
                                           EDATE   IN DATE) IS
  BEGIN
    OPEN CUR_OUT FOR
      SELECT /*+PARALLEL(RMS_SUPP_SALES,20) PARALLEL(RA_ITEM_SALES,20) PARALLEL(RA_SUPP_SALES,20)*/
       RMS_SUPP_SALES.DAY_DT,
       RMS_SUPP_SALES.LOC,
       RMS_SUPP_SALES.ITEM,
       RMS_SUPP_SALES.RMS_SUPP_QTY,
       RA_SUPP_SALES.RA_SUPP_QTY,
       RA_ITEM_SALES.RA_ITEM_QTY,
       RMS_SUPP_SALES.RMS_SUPP_QTY - RA_SUPP_SALES.RA_SUPP_QTY QTY_DIFF1,
       RMS_SUPP_SALES.RMS_SUPP_QTY - RA_ITEM_SALES.RA_ITEM_QTY QTY_DIFF2,
       '|',
       RMS_SUPP_SALES.RMS_SUPP_NET_AMT,
       RA_SUPP_SALES.RA_SUPP_NET_AMT,
       RA_ITEM_SALES.RA_ITEM_NET_AMT,
       RMS_SUPP_SALES.RMS_SUPP_NET_AMT - RA_SUPP_SALES.RA_SUPP_NET_AMT NET_AMT_DIFF1,
       RMS_SUPP_SALES.RMS_SUPP_NET_AMT - RA_ITEM_SALES.RA_ITEM_NET_AMT NET_AMT_DIFF2,
       '|',
       RMS_SUPP_SALES.RMS_SUPP_COST,
       RA_SUPP_SALES.RA_SUPP_COST,
       RA_ITEM_SALES.RA_ITEM_COST,
       RMS_SUPP_SALES.RMS_SUPP_COST - RA_SUPP_SALES.RA_SUPP_COST COST_DIFF1,
       RMS_SUPP_SALES.RMS_SUPP_COST - RA_ITEM_SALES.RA_ITEM_COST COST_DIFF2,
       '|',
       RMS_SUPP_SALES.RMS_SUPP_AMT,
       RA_SUPP_SALES.RA_SUPP_AMT,
       RA_ITEM_SALES.RA_ITEM_AMT,
       RMS_SUPP_SALES.RMS_SUPP_AMT - RA_SUPP_SALES.RA_SUPP_AMT AMT_DIFF1,
       RMS_SUPP_SALES.RMS_SUPP_AMT - RA_ITEM_SALES.RA_ITEM_AMT AMT_DIFF2
        FROM --RMS_SUPP_SALES
             (SELECT /*+PARALLEL(BBG_RA_SUPP_SALES_FV,20)*/
               BBG_RA_SUPP_SALES_FV.DAY_DT,
               BBG_RA_SUPP_SALES_FV.LOC,
               BBG_RA_SUPP_SALES_FV.ITEM,
               SUM(BBG_RA_SUPP_SALES_FV.SALES_QTY) RMS_SUPP_QTY,
               --供应商净销售成本
               SUM(CASE
                     WHEN BBG_RA_SUPP_SALES_FV.BUSINESS_MODE = 'LY' OR
                          BBG_RA_SUPP_SALES_FV.BUSINESS_MODE = 'ZL' THEN
                      BBG_RA_SUPP_SALES_FV.SALES_COST /
                      (1 + BBG_RA_SUPP_SALES_FV.COST_VAT_RATE / 100)
                     ELSE
                      BBG_RA_SUPP_SALES_FV.SALES_COST
                   END) RMS_SUPP_COST,
               --供应商净销售金额
               SUM(BBG_RA_SUPP_SALES_FV.SALES_AMT /
                   (1 + (select VAT_RATE / 100
                           from VAT_ITEM@RA_RMS_DBLINK
                          where ACTIVE_DATE =
                                (select max(v.ACTIVE_DATE)
                                   from VAT_ITEM@RA_RMS_DBLINK v
                                  where v.ITEM = BBG_RA_SUPP_SALES_FV.ITEM
                                    and v.VAT_REGION = 1000
                                    AND V.VAT_TYPE IN ('R', 'B')
                                    and v.ACTIVE_DATE <=
                                        BBG_RA_SUPP_SALES_FV.DAY_DT)
                            and ITEM = BBG_RA_SUPP_SALES_FV.ITEM
                            and VAT_REGION = 1000
                            and VAT_TYPE IN ('R', 'B')))) RMS_SUPP_NET_AMT,
               SUM(BBG_RA_SUPP_SALES_FV.SALES_AMT) RMS_SUPP_AMT
                FROM (SELECT /*+PARALLEL(CSS,20)*/
                       CSS.ORIGIN_SALES_DATE DAY_DT,
                       CSS.ITEM,
                       CSS.STORE LOC,
                       CSS.SUPPLIER,
                       CSS.QTY SALES_QTY,
                       CSS.TOTAL_COST SALES_COST,
                       CSS.TOTAL_RETAIL SALES_AMT,
                       (SELECT SUPP.BUSINESS_TYPE
                          FROM RMS.CMX_SUPPLIER_INFO@RA_RMS_DBLINK SUPP
                         WHERE SUPP.SUPPLIER = CSS.SUPPLIER) BUSINESS_MODE,
                       CSS.COST_VAT_RATE,
                       (SELECT SUPP.BUSINESS_TYPE
                          FROM RMS.CMX_SUPPLIER_INFO@RA_RMS_DBLINK SUPP
                         WHERE SUPP.SUPPLIER = CSS.SUPPLIER) BBG_REFERENCE_DO1,
                       '' BBG_REFERENCE_DO2,
                       '' BBG_REFERENCE_DO3,
                       '' BBG_REFERENCE_DO4,
                       '' BBG_REFERENCE_DO5,
                       NULL BBG_REFERENCE_FO1,
                       NULL BBG_REFERENCE_FO2,
                       NULL BBG_REFERENCE_FO3,
                       NULL BBG_REFERENCE_FO4,
                       NULL BBG_REFERENCE_FO5,
                       NULL BBG_REFERENCE_FO6,
                       NULL BBG_REFERENCE_FO7,
                       NULL BBG_REFERENCE_FO8,
                       NULL BBG_REFERENCE_FO9,
                       NULL BBG_REFERENCE_FO10
                        FROM RMS.CMX_SUPP_SALES@RA_RMS_DBLINK CSS
                       WHERE CSS.ORIGIN_SALES_DATE BETWEEN BDATE AND EDATE
                            --剔出118001的批发销售
                         AND CSS.STORE <> 118001) BBG_RA_SUPP_SALES_FV
               GROUP BY BBG_RA_SUPP_SALES_FV.DAY_DT,
                        BBG_RA_SUPP_SALES_FV.LOC,
                        BBG_RA_SUPP_SALES_FV.ITEM) RMS_SUPP_SALES,
             --RA_ITEM_SALES
             (SELECT /*+PARALLEL(T1,20)*/
               T1.DAY_DT,
               T1.LOC,
               T1.ITEM,
               SUM(T1.RA_ITEM_QTY) RA_ITEM_QTY,
               SUM(T1.RA_ITEM_COST) RA_ITEM_COST,
               SUM(T1.RA_ITEM_NET_AMT) RA_ITEM_NET_AMT,
               SUM(T1.RA_ITEM_AMT) RA_ITEM_AMT
                FROM (SELECT /*+PARALLEL(T,20) PARALLEL(MCAL,20) PARALLEL(PK,20) PARALLEL(PK2,20) PARALLEL(P,20) PARALLEL(O,20)*/
                       MCAL.MCAL_DAY_DT DAY_DT,
                       O.ORG_NUM LOC,
                       CASE
                         WHEN PK.PACK_NO IS NULL THEN
                          P.PROD_NUM
                         ELSE
                          PK.ITEM
                       END ITEM,
                       SUM((T.SLS_QTY - T.RET_QTY) * NVL(PK.PACK_QTY, 1)) RA_ITEM_QTY,
                       SUM((((T.SLS_AMT_LCL - T.RET_AMT_LCL) -
                           (T.SLS_TAX_AMT_LCL - T.RET_TAX_AMT_LCL)) -
                           (NVL(T.SLS_PROFIT_AMT_LCL, 0) -
                           NVL(T.RET_PROFIT_AMT_LCL, 0))) /
                           NVL(PK2.PACK_QTY, 1) * NVL(PK.PACK_QTY, 1)) RA_ITEM_COST,
                       SUM(((T.SLS_AMT_LCL - T.RET_AMT_LCL) -
                           (T.SLS_TAX_AMT_LCL - T.RET_TAX_AMT_LCL)) /
                           NVL(PK2.PACK_QTY, 1) * NVL(PK.PACK_QTY, 1)) RA_ITEM_NET_AMT,
                       SUM((T.SLS_AMT_LCL - T.RET_AMT_LCL) /
                           NVL(PK2.PACK_QTY, 1) * NVL(PK.PACK_QTY, 1)) RA_ITEM_AMT
                        FROM RADM.W_RTL_SLS_IT_LC_DY_A T,
                             RADM.W_MCAL_DAY_DV MCAL,
                             RADM.PACKITEM PK,
                             (SELECT /*+PARALLEL(PK1,20)*/
                               PACK_NO, SUM(PK1.PACK_QTY) PACK_QTY
                                FROM PACKITEM PK1
                               GROUP BY PACK_NO) PK2, --一个包装商品对应多个子商品
                             RADM.W_PRODUCT_D P,
                             RADM.W_INT_ORG_D O
                       WHERE MCAL.ROW_WID = T.DT_WID
                         AND T.PROD_WID = P.ROW_WID
                         AND T.ORG_WID = O.ROW_WID
                         AND P.PROD_NUM = PK.PACK_NO(+)
                         AND PK.PACK_NO = PK2.PACK_NO(+)
                         AND MCAL.MCAL_DAY_DT BETWEEN BDATE AND EDATE
                         AND EXISTS
                       (SELECT /*+PARALLEL(D,20)*/
                               1
                                FROM RADM.BBG_RA_ITEM_LOC_D D
                               WHERE T.BBG_ITEM_LOC_WID = D.ROW_WID
                                 AND D.BUSINESS_MODE <> 'ZS')
                         AND EXISTS
                       (SELECT /*+PARALLEL(O,20)  PARALLEL(A,20)*/
                               1
                                FROM RADM.W_INT_ORG_D      O,
                                     RADM.W_INT_ORG_ATTR_D A
                               WHERE T.ORG_WID = O.ROW_WID
                                 AND O.SCD1_WID = A.SCD1_WID
                                 AND A.ORG_ATTR23_NAME = 1)
                       GROUP BY MCAL.MCAL_DAY_DT,
                                PK.ITEM,
                                PK.PACK_NO,
                                P.PROD_NUM,
                                O.ORG_NUM) T1
               GROUP BY T1.DAY_DT, T1.LOC, T1.ITEM) RA_ITEM_SALES,
             --RA_SUPP_SALES
             (SELECT /*+PARALLEL(T,20) PARALLEL(MCAL,20) PARALLEL(P,20) PARALLEL(O,20)*/
               MCAL.MCAL_DAY_DT DAY_DT,
               P.PROD_NUM ITEM,
               O.ORG_NUM LOC,
               SUM(T.SUPP_SALES_QTY) RA_SUPP_QTY,
               SUM(T.SUPP_SALES_COST) RA_SUPP_COST,
               SUM(T.SUPP_SALES_AMT) RA_SUPP_NET_AMT,
               SUM(T.BBG_REFERENCE_FO1) RA_SUPP_AMT
                FROM RADM.BBG_RA_SLS_IT_LC_DY_A T,
                     RADM.W_MCAL_DAY_DV         MCAL,
                     RADM.W_PRODUCT_D           P,
                     RADM.W_INT_ORG_D           O
               WHERE MCAL.ROW_WID = T.DT_WID
                 AND T.PROD_WID = P.ROW_WID
                 AND T.ORG_WID = O.ROW_WID
                    --剔除118001的批发销售
                 AND O.ORG_NUM <> 118001
                 AND MCAL.MCAL_DAY_DT BETWEEN BDATE AND EDATE
               GROUP BY MCAL.MCAL_DAY_DT, P.PROD_NUM, O.ORG_NUM) RA_SUPP_SALES
       WHERE RMS_SUPP_SALES.DAY_DT = RA_SUPP_SALES.DAY_DT(+)
         AND RMS_SUPP_SALES.DAY_DT = RA_ITEM_SALES.DAY_DT(+)
         AND RMS_SUPP_SALES.LOC = RA_SUPP_SALES.LOC(+)
         AND RMS_SUPP_SALES.LOC = RA_ITEM_SALES.LOC(+)
         AND RMS_SUPP_SALES.ITEM = RA_SUPP_SALES.ITEM(+)
         AND RMS_SUPP_SALES.ITEM = RA_ITEM_SALES.ITEM(+)
         AND ABS(NVL(RMS_SUPP_SALES.RMS_SUPP_NET_AMT, 0) -
                 NVL(RA_ITEM_SALES.RA_ITEM_NET_AMT, 0)) > 0.01
       ORDER BY RMS_SUPP_SALES.DAY_DT;
    RETURN;
  END;

  PROCEDURE P_CK_RA_RMS_SLS_NOTAX_AMT(CUR_OUT IN OUT CUR_RETURN,
                                      B_DTWID IN NUMBER,
                                      E_DTWID IN NUMBER) IS
  BEGIN
    OPEN CUR_OUT FOR
      SELECT P.PROD_NUM,
             T3.PROD_WID,
             T3.DT_WID,
             T3.WQTY,
             T3.SQTY,
             T3.WAMT,
             T3.SAMT,
             T3.DIFF
        FROM (SELECT /*+PARALLEL(W,20) PARALLEL(B,20)*/
               W.PROD_WID,
               W.DT_WID,
               W.WQTY,
               B.SQTY,
               W.WAMT,
               B.SAMT,
               ABS(W.WAMT - B.SAMT) DIFF
                FROM (SELECT /*+PARALLEL(T1,20)*/
                       T1.PROD_WID,
                       T1.DT_WID,
                       ROUND(SUM(T1.SLS_QTY - T1.RET_QTY), 4) WQTY,
                       ROUND(SUM((T1.SLS_AMT_LCL - T1.RET_AMT_LCL) -
                                 (T1.SLS_TAX_AMT_LCL - T1.RET_TAX_AMT_LCL)),
                             4) WAMT
                        FROM RADM.W_RTL_SLS_IT_DY_A T1
                       WHERE T1.DT_WID BETWEEN B_DTWID AND E_DTWID
                       GROUP BY T1.PROD_WID, T1.DT_WID) W,
                     (SELECT /*+PARALLEL(T2,20)*/
                       T2.PROD_WID,
                       T2.DT_WID,
                       ROUND(SUM(T2.SUPP_SALES_QTY), 4) SQTY,
                       ROUND(SUM(T2.SUPP_SALES_AMT), 4) SAMT
                        FROM RADM.BBG_RA_SLS_IT_DY_A T2
                       WHERE T2.DT_WID BETWEEN B_DTWID AND E_DTWID
                       GROUP BY T2.PROD_WID, T2.DT_WID) B
               WHERE W.PROD_WID = B.PROD_WID
                 AND W.DT_WID = B.DT_WID
                 AND W.WQTY = B.SQTY
                 AND ABS(W.WAMT - B.SAMT) > 0.1) T3,
             RADM.W_PRODUCT_D P
       WHERE T3.PROD_WID = P.ROW_WID;
    RETURN;
  END;

  PROCEDURE P_CK_RA_RMS_SUPPSLS_DAY(CUR_OUT IN OUT CUR_RETURN,
                                    BDATE   IN DATE,
                                    EDATE   IN DATE) IS
  BEGIN
    OPEN CUR_OUT FOR
      SELECT /*+PARALLEL(T1,20) PARALLEL(T2,20)*/
       T2.DAY_DT,
       T2.SUPP_SALES_QTY RMS_SSQ,
       T1.SUPP_SALES_QTY RA_SSQ,
       T2.SUPP_SALES_QTY - T1.SUPP_SALES_QTY DIFF_SSQ,
       T2.SUPP_SALES_AMT RMS_SSA,
       T1.SUPP_SALES_AMT RA_SSA,
       ROUND(T2.SUPP_SALES_AMT - T1.SUPP_SALES_AMT, 4) DIFF_SSA,
       T2.SUPP_SALES_COST RMS_SSC,
       T1.SUPP_SALES_COST RA_SSC,
       ROUND(T2.SUPP_SALES_COST - T1.SUPP_SALES_COST, 4) DIFF_SSC
        FROM (SELECT /*+PARALLEL(T,20)*/
               TO_DATE(SUBSTR(T.DT_WID, 2, 8), 'YYYYMMDD') DAY_DT,
               SUM(T.SUPP_SALES_QTY) SUPP_SALES_QTY,
               SUM(T.SUPP_SALES_COST) SUPP_SALES_COST,
               SUM(T.SUPP_SALES_AMT) SUPP_SALES_AMT
                FROM RADM.BBG_RA_SUPP_SALES_IT_LC_DY_F T
               WHERE T.DT_WID BETWEEN
                     '1' || TO_CHAR(BDATE, 'YYYYMMDD') || '000' AND
                     '1' || TO_CHAR(EDATE, 'YYYYMMDD') || '000'
               GROUP BY TO_DATE(SUBSTR(T.DT_WID, 2, 8), 'YYYYMMDD')
               ORDER BY TO_DATE(SUBSTR(T.DT_WID, 2, 8), 'YYYYMMDD')) T1,
             (SELECT /*+PARALLEL(T3,20)*/
               T3.DAY_DT,
               SUM(T3.SUPP_SALES_QTY) SUPP_SALES_QTY,
               SUM(T3.SUPP_SALES_AMT) SUPP_SALES_AMT,
               SUM(T3.SUPP_SALES_COST) SUPP_SALES_COST
                FROM RADM.JIN_RMS_SUPP_SALES_TMP T3
               GROUP BY T3.DAY_DT) T2
       WHERE T1.DAY_DT(+) = T2.DAY_DT
         AND T2.DAY_DT BETWEEN BDATE AND EDATE
       ORDER BY T2.DAY_DT;
    RETURN;
  END;

  FUNCTION F_INSERT_RA_SUPPSLS_ITLCDY_TMP(O_ERROR_MESSAGE IN OUT VARCHAR2,
                                          B_DTWID         IN NUMBER,
                                          E_DTWID         IN NUMBER)
    RETURN BOOLEAN IS
  BEGIN
    EXECUTE IMMEDIATE 'TRUNCATE TABLE RABATCHER.BBG_RA_SUPP_SLS_IT_LC_DY_TMP';
    EXECUTE IMMEDIATE 'TRUNCATE TABLE RADM.BBG_RA_SUPP_SLS_IT_LC_DY_F_BAK';
    EXECUTE IMMEDIATE 'TRUNCATE TABLE RADM.C_LOAD_DATES';
  
    --清除临时表  
    BEGIN
      -- CALL THE PROCEDURE
      JIN_TRUNCATE_TMP_SUPP_SLS_T;
    END;
  
    INSERT INTO RADM.BBG_RA_SUPP_SLS_IT_LC_DY_F_BAK
      SELECT /*+PARALLEL(F,20)*/
       *
        FROM RADM.BBG_RA_SUPP_SALES_IT_LC_DY_F F
       WHERE F.DT_WID BETWEEN B_DTWID AND E_DTWID;
    COMMIT;
  
    INSERT INTO /*+PARALLEL(T,20)*/
    RABATCHER.BBG_RA_SUPP_SLS_IT_LC_DY_TMP T
      (ORG_WID,
       ORG_SCD1_WID,
       PROD_IT_WID,
       PROD_SCD1_WID,
       ORG_LC_WID,
       ORG_DS_WID,
       ORG_RG_WID,
       ORG_AR_WID,
       ORG_CH_WID,
       PROD_DV_WID,
       PROD_GP_WID,
       PROD_DP_WID,
       PROD_CL_WID,
       PROD_SC_WID,
       DT_WID,
       WK_WID,
       PR_WID,
       QT_WID,
       DAY_DT,
       WK_NUM,
       PR_NUM,
       QT_NUM,
       ORG_NUM,
       ORG_DS_NUM,
       ORG_RG_NUM,
       ORG_AR_NUM,
       ORG_CH_NUM,
       PROD_IT_NUM,
       PROD_SC_NUM,
       PROD_CL_NUM,
       PROD_DP_NUM,
       PROD_GP_NUM,
       PROD_DV_NUM,
       SUPPLIER_WID,
       SUPPLIER_NUM,
       BBG_ITEM_LOC_WID,
       BBG_ITEM_LOC_SUPP_WID,
       SUPP_SALES_QTY,
       SUPP_SALES_COST,
       SUPP_SALES_AMT,
       AUX1_CHANGED_ON_DT,
       AUX2_CHANGED_ON_DT,
       AUX3_CHANGED_ON_DT,
       AUX4_CHANGED_ON_DT,
       CHANGED_BY_ID,
       CHANGED_ON_DT,
       CREATED_BY_ID,
       CREATED_ON_DT,
       DATASOURCE_NUM_ID,
       DELETE_FLG,
       DOC_CURR_CODE,
       GLOBAL1_EXCHANGE_RATE,
       GLOBAL2_EXCHANGE_RATE,
       GLOBAL3_EXCHANGE_RATE,
       LOC_CURR_CODE,
       LOC_EXCHANGE_RATE,
       TENANT_ID,
       X_CUSTOM,
       INTEGRATION_ID,
       BBG_REFERENCE_DO1,
       BBG_REFERENCE_DO2,
       BBG_REFERENCE_DO3,
       BBG_REFERENCE_DO4,
       BBG_REFERENCE_DO5,
       BBG_REFERENCE_FO1,
       BBG_REFERENCE_FO2,
       BBG_REFERENCE_FO3,
       BBG_REFERENCE_FO4,
       BBG_REFERENCE_FO5,
       BBG_REFERENCE_FO6,
       BBG_REFERENCE_FO7,
       BBG_REFERENCE_FO8,
       BBG_REFERENCE_FO9,
       BBG_REFERENCE_FO10,
       ETL_THREAD_VAL)
      SELECT /*+PARALLEL(20)*/
       W_INT_ORG_D_RTL_TMP.ORG_WID,
       W_INT_ORG_DH_RTL_TMP.ORG_SCD1_WID,
       W_PRODUCT_D_RTL_TMP.PROD_IT_WID,
       W_PRODUCT_D_RTL_TMP.PROD_SCD1_WID,
       W_INT_ORG_DH_RTL_TMP.ORG_LC_WID,
       W_INT_ORG_DH_RTL_TMP.ORG_DS_WID,
       W_INT_ORG_DH_RTL_TMP.ORG_RG_WID,
       W_INT_ORG_DH_RTL_TMP.ORG_AR_WID,
       W_INT_ORG_DH_RTL_TMP.ORG_CH_WID,
       W_PRODUCT_D_RTL_TMP.PROD_DV_WID,
       W_PRODUCT_D_RTL_TMP.PROD_GP_WID,
       W_PRODUCT_D_RTL_TMP.PROD_DP_WID,
       W_PRODUCT_D_RTL_TMP.PROD_CL_WID,
       W_PRODUCT_D_RTL_TMP.PROD_SC_WID,
       W_MCAL_DAY_D.ROW_WID,
       W_MCAL_WEEK_D.ROW_WID,
       W_MCAL_DAY_D.MCAL_PERIOD_WID,
       W_MCAL_DAY_D.MCAL_QTR_WID,
       TO_DATE(SUBSTR(STG_BBG_RA_SLS_IT_LC_DY_FS.DT_WID, 2, 8), 'YYYYMMDD'),
       W_MCAL_WEEK_D.MCAL_YEAR || W_MCAL_WEEK_D.MCAL_WEEK,
       W_MCAL_DAY_D.MCAL_YEAR || W_MCAL_DAY_D.MCAL_PERIOD,
       W_MCAL_DAY_D.MCAL_YEAR || W_MCAL_DAY_D.MCAL_QTR,
       W_INT_ORG_DH_RTL_TMP.ORG_NUM,
       W_INT_ORG_DH_RTL_TMP.ORG_DS_NUM,
       W_INT_ORG_DH_RTL_TMP.ORG_RG_NUM,
       W_INT_ORG_DH_RTL_TMP.ORG_AR_NUM,
       W_INT_ORG_DH_RTL_TMP.ORG_CH_NUM,
       W_PRODUCT_D_RTL_TMP.PROD_IT_NUM,
       W_PRODUCT_D_RTL_TMP.PROD_SC_NUM,
       W_PRODUCT_D_RTL_TMP.PROD_CL_NUM,
       W_PRODUCT_D_RTL_TMP.PROD_DP_NUM,
       W_PRODUCT_D_RTL_TMP.PROD_GP_NUM,
       W_PRODUCT_D_RTL_TMP.PROD_DV_NUM,
       W_PARTY_ORG_D.ROW_WID,
       W_PARTY_ORG_D.SUPPLIER_NUM,
       BBG_RA_ITEM_LOC_D.ROW_WID,
       NVL(BBG_RA_ITEM_LOC_SUPP_D.ROW_WID, -1),
       STG_BBG_RA_SLS_IT_LC_DY_FS.SUPP_SALES_QTY,
       STG_BBG_RA_SLS_IT_LC_DY_FS.SUPP_SALES_COST,
       STG_BBG_RA_SLS_IT_LC_DY_FS.SUPP_SALES_AMT,
       STG_BBG_RA_SLS_IT_LC_DY_FS.AUX1_CHANGED_ON_DT,
       STG_BBG_RA_SLS_IT_LC_DY_FS.AUX2_CHANGED_ON_DT,
       STG_BBG_RA_SLS_IT_LC_DY_FS.AUX3_CHANGED_ON_DT,
       STG_BBG_RA_SLS_IT_LC_DY_FS.AUX4_CHANGED_ON_DT,
       STG_BBG_RA_SLS_IT_LC_DY_FS.CHANGED_BY_ID,
       STG_BBG_RA_SLS_IT_LC_DY_FS.CHANGED_ON_DT,
       STG_BBG_RA_SLS_IT_LC_DY_FS.CREATED_BY_ID,
       STG_BBG_RA_SLS_IT_LC_DY_FS.CREATED_ON_DT,
       STG_BBG_RA_SLS_IT_LC_DY_FS.DATASOURCE_NUM_ID,
       STG_BBG_RA_SLS_IT_LC_DY_FS.DELETE_FLG,
       STG_BBG_RA_SLS_IT_LC_DY_FS.DOC_CURR_CODE,
       STG_BBG_RA_SLS_IT_LC_DY_FS.GLOBAL1_EXCHANGE_RATE,
       STG_BBG_RA_SLS_IT_LC_DY_FS.GLOBAL2_EXCHANGE_RATE,
       STG_BBG_RA_SLS_IT_LC_DY_FS.GLOBAL3_EXCHANGE_RATE,
       STG_BBG_RA_SLS_IT_LC_DY_FS.LOC_CURR_CODE,
       1.0,
       STG_BBG_RA_SLS_IT_LC_DY_FS.TENANT_ID,
       STG_BBG_RA_SLS_IT_LC_DY_FS.X_CUSTOM,
       STG_BBG_RA_SLS_IT_LC_DY_FS.INTEGRATION_ID,
       STG_BBG_RA_SLS_IT_LC_DY_FS.BBG_REFERENCE_DO1,
       STG_BBG_RA_SLS_IT_LC_DY_FS.BBG_REFERENCE_DO2,
       STG_BBG_RA_SLS_IT_LC_DY_FS.BBG_REFERENCE_DO3,
       STG_BBG_RA_SLS_IT_LC_DY_FS.BBG_REFERENCE_DO4,
       STG_BBG_RA_SLS_IT_LC_DY_FS.BBG_REFERENCE_DO5,
       STG_BBG_RA_SLS_IT_LC_DY_FS.BBG_REFERENCE_FO1,
       STG_BBG_RA_SLS_IT_LC_DY_FS.BBG_REFERENCE_FO2,
       STG_BBG_RA_SLS_IT_LC_DY_FS.BBG_REFERENCE_FO3,
       STG_BBG_RA_SLS_IT_LC_DY_FS.BBG_REFERENCE_FO4,
       STG_BBG_RA_SLS_IT_LC_DY_FS.BBG_REFERENCE_FO5,
       STG_BBG_RA_SLS_IT_LC_DY_FS.BBG_REFERENCE_FO6,
       STG_BBG_RA_SLS_IT_LC_DY_FS.BBG_REFERENCE_FO7,
       STG_BBG_RA_SLS_IT_LC_DY_FS.BBG_REFERENCE_FO8,
       STG_BBG_RA_SLS_IT_LC_DY_FS.BBG_REFERENCE_FO9,
       STG_BBG_RA_SLS_IT_LC_DY_FS.BBG_REFERENCE_FO10,
       STG_BBG_RA_SLS_IT_LC_DY_FS.ETL_THREAD_VAL
        FROM RADM.W_MCAL_DAY_D                   W_MCAL_DAY_D,
             RABATCHER.W_PRODUCT_D_RTL_TMP       W_PRODUCT_D_RTL_TMP,
             RABATCHER.W_INT_ORG_DH_RTL_TMP      W_INT_ORG_DH_RTL_TMP,
             RABATCHER.W_INT_ORG_D_RTL_TMP       W_INT_ORG_D_RTL_TMP,
             RADM.W_PARTY_ORG_D                  W_PARTY_ORG_D,
             RADM.BBG_RA_ITEM_LOC_D              BBG_RA_ITEM_LOC_D,
             RADM.BBG_RA_ITEM_LOC_SUPP_D         BBG_RA_ITEM_LOC_SUPP_D,
             RADM.W_MCAL_WEEK_D                  W_MCAL_WEEK_D,
             RADM.BBG_RA_SUPP_SLS_IT_LC_DY_F_BAK STG_BBG_RA_SLS_IT_LC_DY_FS
       WHERE (1 = 1)
         AND (W_MCAL_DAY_D.MCAL_DAY_DT =
             TO_DATE(SUBSTR(STG_BBG_RA_SLS_IT_LC_DY_FS.DT_WID, 2, 8),
                      'YYYYMMDD'))
         AND (W_PRODUCT_D_RTL_TMP.PROD_IT_WID =
             STG_BBG_RA_SLS_IT_LC_DY_FS.PROD_WID)
         AND (W_INT_ORG_DH_RTL_TMP.ORG_LC_WID =
             STG_BBG_RA_SLS_IT_LC_DY_FS.ORG_DH_WID)
         AND (W_INT_ORG_D_RTL_TMP.ORG_WID =
             STG_BBG_RA_SLS_IT_LC_DY_FS.ORG_WID)
         AND (W_PARTY_ORG_D.ROW_WID =
             STG_BBG_RA_SLS_IT_LC_DY_FS.SUPPLIER_WID)
         AND (BBG_RA_ITEM_LOC_D.ROW_WID =
             STG_BBG_RA_SLS_IT_LC_DY_FS.BBG_ITEM_LOC_WID)
         AND (BBG_RA_ITEM_LOC_SUPP_D.ROW_WID(+) =
             STG_BBG_RA_SLS_IT_LC_DY_FS.BBG_ITEM_LOC_SUPP_WID)
         AND ((((W_MCAL_DAY_D.MCAL_DAY_DT BETWEEN
             W_MCAL_WEEK_D.MCAL_WEEK_START_DT AND
             W_MCAL_WEEK_D.MCAL_WEEK_END_DT)) AND
             W_MCAL_DAY_D.DATASOURCE_NUM_ID =
             W_MCAL_WEEK_D.DATASOURCE_NUM_ID))
         AND (W_PARTY_ORG_D.SUPPLIER_FLG = 'Y');
    COMMIT;
    RETURN TRUE;
  EXCEPTION
    WHEN OTHERS THEN
      O_ERROR_MESSAGE := SQLERRM;
      RETURN FALSE;
  END;

  FUNCTION F_DEL_RA_SUPPSLS_AGGREGATE_TAB(O_ERROR_MESSAGE IN OUT VARCHAR2,
                                          DTWID           IN NUMBER)
    RETURN BOOLEAN IS
  BEGIN
    --删除汇总表数据
    DELETE /*+PARALLEL(T,20)*/
    BBG_RA_SLS_SC_LC_DY_CUR_A T
     WHERE T.DT_WID = DTWID;
    COMMIT;
    DELETE /*+PARALLEL(T,20)*/
    BBG_RA_SLS_SC_LC_DY_A T
     WHERE T.DT_WID = DTWID;
    COMMIT;
    DELETE /*+PARALLEL(T,20)*/
    BBG_RA_SLS_SC_DY_CUR_A T
     WHERE T.DT_WID = DTWID;
    COMMIT;
    DELETE /*+PARALLEL(T,20)*/
    BBG_RA_SLS_SC_DY_A T
     WHERE T.DT_WID = DTWID;
    COMMIT;
    DELETE /*+PARALLEL(T,20)*/
    BBG_RA_SLS_LC_DY_A T
     WHERE T.DT_WID = DTWID;
    COMMIT;
    DELETE /*+PARALLEL(T,20)*/
    BBG_RA_SLS_IT_LC_DY_SN_A T
     WHERE T.DT_WID = DTWID;
    COMMIT;
    DELETE /*+PARALLEL(T,20)*/
    BBG_RA_SLS_IT_LC_DY_A T
     WHERE T.DT_WID = DTWID;
    COMMIT;
    DELETE /*+PARALLEL(T,20)*/
    BBG_RA_SLS_IT_DY_SN_A T
     WHERE T.DT_WID = DTWID;
    COMMIT;
    DELETE /*+PARALLEL(T,20)*/
    BBG_RA_SLS_IT_DY_A T
     WHERE T.DT_WID = DTWID;
    COMMIT;
    DELETE /*+PARALLEL(T,20)*/
    BBG_RA_SLS_DP_LC_DY_CUR_A T
     WHERE T.DT_WID = DTWID;
    COMMIT;
    DELETE /*+PARALLEL(T,20)*/
    BBG_RA_SLS_DP_LC_DY_A T
     WHERE T.DT_WID = DTWID;
    COMMIT;
    DELETE /*+PARALLEL(T,20)*/
    BBG_RA_SLS_DP_DY_CUR_A T
     WHERE T.DT_WID = DTWID;
    COMMIT;
    DELETE /*+PARALLEL(T,20)*/
    BBG_RA_SLS_CL_LC_DY_CUR_A T
     WHERE T.DT_WID = DTWID;
    COMMIT;
    DELETE /*+PARALLEL(T,20)*/
    BBG_RA_SLS_CL_LC_DY_A T
     WHERE T.DT_WID = DTWID;
    COMMIT;
    DELETE /*+PARALLEL(T,20)*/
    BBG_RA_SLS_CL_DY_CUR_A T
     WHERE T.DT_WID = DTWID;
    COMMIT;
    RETURN TRUE;
  EXCEPTION
    WHEN OTHERS THEN
      O_ERROR_MESSAGE := SQLERRM;
      RETURN FALSE;
  END;

  FUNCTION F_SLS_TRX_IT_LC_DY_TMP_FIX_JL(O_ERROR_MESSAGE IN OUT VARCHAR2,
                                         BDATE           IN DATE,
                                         EDATE           IN DATE)
    RETURN BOOLEAN IS
  BEGIN
    insert into RABATCHER.W_RTL_SLS_TRX_IT_LC_DY_TMP T
      (ORG_WID,
       ORG_LC_WID,
       ORG_DS_WID,
       ORG_RG_WID,
       ORG_AR_WID,
       ORG_CH_WID,
       ORG_NUM,
       ORG_DS_NUM,
       ORG_RG_NUM,
       ORG_AR_NUM,
       ORG_CH_NUM,
       ORG_SCD1_WID,
       PROD_SCD1_WID,
       PROD_IT_WID,
       PROD_SC_WID,
       PROD_CL_WID,
       PROD_DP_WID,
       PROD_GP_WID,
       PROD_DV_WID,
       PROD_IT_NUM,
       PROD_SC_NUM,
       PROD_CL_NUM,
       PROD_DP_NUM,
       PROD_GP_NUM,
       PROD_DV_NUM,
       SLS_TRX_ID,
       VOUCHER_ID,
       RTL_TYPE_WID,
       RTL_TYPE_CODE,
       DT_WID,
       DAY_DT,
       MIN_WID,
       MIN_NUM,
       WK_WID,
       WK_NUM,
       PR_WID,
       PR_NUM,
       QT_WID,
       QT_NUM,
       SLS_QTY,
       SLS_AMT_LCL,
       SLS_PROFIT_AMT_LCL,
       SLS_MANUAL_MKDN_AMT_LCL,
       SLS_MANUAL_MKUP_AMT_LCL,
       SLS_TAX_AMT_LCL,
       SLS_EMP_DISC_AMT_LCL,
       SLS_MANUAL_COUNT,
       SLS_SCAN_COUNT,
       RET_QTY,
       RET_AMT_LCL,
       RET_PROFIT_AMT_LCL,
       RET_MANUAL_MKDN_AMT_LCL,
       RET_MANUAL_MKUP_AMT_LCL,
       RET_TAX_AMT_LCL,
       RET_EMP_DISC_AMT_LCL,
       RET_MANUAL_COUNT,
       RET_SCAN_COUNT,
       DOC_CURR_CODE,
       LOC_CURR_CODE,
       LOC_EXCHANGE_RATE,
       GLOBAL1_EXCHANGE_RATE,
       GLOBAL2_EXCHANGE_RATE,
       GLOBAL3_EXCHANGE_RATE,
       CREATED_BY_ID,
       CHANGED_BY_ID,
       DELETE_FLG,
       DATASOURCE_NUM_ID,
       TENANT_ID,
       X_CUSTOM,
       ETL_THREAD_VAL,
       BBG_ITEM_LOC_WID,
       BBG_RETAIL_TYPE_ID,
       BBG_RETAIL_TYPE_WID,
       BBG_SERVICE_SATISFACTION,
       SRC_REF_NO1,
       SRC_REF_NO2,
       SRC_REF_NO3,
       SRC_REF_NO6,
       SRC_REF_NO7,
       SRC_REF_NO8,
       BBG_REFERENCE_DO1,
       BBG_REFERENCE_DO2,
       BBG_REFERENCE_DO3,
       BBG_REFERENCE_DO4,
       BBG_REFERENCE_DO5,
       BBG_REFERENCE_FO1,
       BBG_REFERENCE_FO2,
       BBG_REFERENCE_FO3,
       BBG_REFERENCE_FO4,
       BBG_REFERENCE_FO5,
       BBG_REFERENCE_FO6,
       BBG_REFERENCE_FO7,
       BBG_REFERENCE_FO8,
       BBG_REFERENCE_FO9,
       BBG_REFERENCE_FO10,
       HYK_NO,
       EMPLOYEE_WID,
       CREATED_ON_DT,
       CHANGED_ON_DT)
      select W_INT_ORG_D_RTL_TMP.ORG_WID,
             W_INT_ORG_DH_RTL_TMP.ORG_LC_WID,
             W_INT_ORG_DH_RTL_TMP.ORG_DS_WID,
             W_INT_ORG_DH_RTL_TMP.ORG_RG_WID,
             W_INT_ORG_DH_RTL_TMP.ORG_AR_WID,
             W_INT_ORG_DH_RTL_TMP.ORG_CH_WID,
             W_INT_ORG_DH_RTL_TMP.ORG_NUM,
             W_INT_ORG_DH_RTL_TMP.ORG_DS_NUM,
             W_INT_ORG_DH_RTL_TMP.ORG_RG_NUM,
             W_INT_ORG_DH_RTL_TMP.ORG_AR_NUM,
             W_INT_ORG_DH_RTL_TMP.ORG_CH_NUM,
             W_INT_ORG_DH_RTL_TMP.ORG_SCD1_WID,
             W_PRODUCT_D_RTL_TMP.PROD_SCD1_WID,
             W_PRODUCT_D_RTL_TMP.PROD_IT_WID,
             W_PRODUCT_D_RTL_TMP.PROD_SC_WID,
             W_PRODUCT_D_RTL_TMP.PROD_CL_WID,
             W_PRODUCT_D_RTL_TMP.PROD_DP_WID,
             W_PRODUCT_D_RTL_TMP.PROD_GP_WID,
             W_PRODUCT_D_RTL_TMP.PROD_DV_WID,
             W_PRODUCT_D_RTL_TMP.PROD_IT_NUM,
             W_PRODUCT_D_RTL_TMP.PROD_SC_NUM,
             W_PRODUCT_D_RTL_TMP.PROD_CL_NUM,
             W_PRODUCT_D_RTL_TMP.PROD_DP_NUM,
             W_PRODUCT_D_RTL_TMP.PROD_GP_NUM,
             W_PRODUCT_D_RTL_TMP.PROD_DV_NUM,
             STG_W_RTL_SLS_TRX_IT_LC_DY_FS.SLS_TRX_ID,
             STG_W_RTL_SLS_TRX_IT_LC_DY_FS.VOUCHER_ID,
             W_XACT_TYPE_D.ROW_WID,
             STG_W_RTL_SLS_TRX_IT_LC_DY_FS.RTL_TYPE_CODE,
             W_MCAL_DAY_D.ROW_WID,
             STG_W_RTL_SLS_TRX_IT_LC_DY_FS.DAY_DT,
             W_MINUTE_OF_DAY_D.ROW_WID,
             STG_W_RTL_SLS_TRX_IT_LC_DY_FS.MIN_NUM,
             W_MCAL_WEEK_D.ROW_WID,
             W_MCAL_WEEK_D.MCAL_YEAR || W_MCAL_WEEK_D.MCAL_WEEK,
             W_MCAL_DAY_D.MCAL_PERIOD_WID,
             W_MCAL_DAY_D.MCAL_YEAR || W_MCAL_DAY_D.MCAL_PERIOD,
             W_MCAL_DAY_D.MCAL_QTR_WID,
             W_MCAL_DAY_D.MCAL_YEAR || W_MCAL_DAY_D.MCAL_QTR,
             0 SLS_QTY, --STG_W_RTL_SLS_TRX_IT_LC_DY_FS.SLS_QTY,
             0 SLS_AMT_LCL, --STG_W_RTL_SLS_TRX_IT_LC_DY_FS.SLS_AMT_LCL,
             STG_W_RTL_SLS_TRX_IT_LC_DY_FS.SLS_PROFIT_AMT_LCL -
             STF.SLS_PROFIT_AMT_LCL SLS_PROFIT_AMT_LCL,
             0 SLS_MANUAL_MKDN_AMT_LCL, --STG_W_RTL_SLS_TRX_IT_LC_DY_FS.SLS_MANUAL_MKDN_AMT_LCL,
             0 SLS_MANUAL_MKUP_AMT_LCL, --STG_W_RTL_SLS_TRX_IT_LC_DY_FS.SLS_MANUAL_MKUP_AMT_LCL,
             STG_W_RTL_SLS_TRX_IT_LC_DY_FS.SLS_TAX_AMT_LCL -
             STF.SLS_TAX_AMT_LCL SLS_TAX_AMT_LCL,
             0 SLS_EMP_DISC_AMT_LCL, --STG_W_RTL_SLS_TRX_IT_LC_DY_FS.SLS_EMP_DISC_AMT_LCL,
             0 SLS_MANUAL_COUNT, --STG_W_RTL_SLS_TRX_IT_LC_DY_FS.SLS_MANUAL_COUNT,
             0 SLS_SCAN_COUNT, --STG_W_RTL_SLS_TRX_IT_LC_DY_FS.SLS_SCAN_COUNT,
             0 RET_QTY, --STG_W_RTL_SLS_TRX_IT_LC_DY_FS.RET_QTY,
             0 RET_AMT_LCL, --STG_W_RTL_SLS_TRX_IT_LC_DY_FS.RET_AMT_LCL,
             STG_W_RTL_SLS_TRX_IT_LC_DY_FS.RET_PROFIT_AMT_LCL -
             STF.RET_PROFIT_AMT_LCL RET_PROFIT_AMT_LCL,
             0 RET_MANUAL_MKDN_AMT_LCL, --STG_W_RTL_SLS_TRX_IT_LC_DY_FS.RET_MANUAL_MKDN_AMT_LCL,
             0 RET_MANUAL_MKUP_AMT_LCL, --STG_W_RTL_SLS_TRX_IT_LC_DY_FS.RET_MANUAL_MKUP_AMT_LCL,
             STG_W_RTL_SLS_TRX_IT_LC_DY_FS.RET_TAX_AMT_LCL -
             STF.RET_TAX_AMT_LCL RET_TAX_AMT_LCL,
             0 RET_EMP_DISC_AMT_LCL, --STG_W_RTL_SLS_TRX_IT_LC_DY_FS.RET_EMP_DISC_AMT_LCL,
             0 RET_MANUAL_COUNT, --STG_W_RTL_SLS_TRX_IT_LC_DY_FS.RET_MANUAL_COUNT,
             0 RET_SCAN_COUNT, --STG_W_RTL_SLS_TRX_IT_LC_DY_FS.RET_SCAN_COUNT,
             STG_W_RTL_SLS_TRX_IT_LC_DY_FS.DOC_CURR_CODE,
             STG_W_RTL_SLS_TRX_IT_LC_DY_FS.LOC_CURR_CODE,
             (CASE
               WHEN STG_W_RTL_SLS_TRX_IT_LC_DY_FS.LOC_CURR_CODE =
                    STG_W_RTL_SLS_TRX_IT_LC_DY_FS.DOC_CURR_CODE THEN
                1.0
               ELSE
                (SELECT EX_RT.EXCH_RATE
                   FROM RADM.W_EXCH_RATE_G EX_RT
                  WHERE EX_RT.W_FROM_CURCY_CODE =
                        STG_W_RTL_SLS_TRX_IT_LC_DY_FS.DOC_CURR_CODE
                    AND EX_RT.W_TO_CURCY_CODE =
                        STG_W_RTL_SLS_TRX_IT_LC_DY_FS.LOC_CURR_CODE
                    AND EX_RT.START_DT <=
                        STG_W_RTL_SLS_TRX_IT_LC_DY_FS.EXCHANGE_DT
                    AND EX_RT.END_DT >
                        STG_W_RTL_SLS_TRX_IT_LC_DY_FS.EXCHANGE_DT
                    AND EX_RT.RATE_TYPE =
                        W_GLOBAL_CURR_G.DEFAULT_LOC_RATE_TYPE
                    AND EX_RT.DATASOURCE_NUM_ID =
                        STG_W_RTL_SLS_TRX_IT_LC_DY_FS.DATASOURCE_NUM_ID)
             
             END),
             (CASE
               WHEN W_GLOBAL_CURR_G.GLOBAL1_CURR_CODE IS NULL THEN
                NULL
               ELSE
                (CASE
                  WHEN W_GLOBAL_CURR_G.GLOBAL1_CURR_CODE =
                       STG_W_RTL_SLS_TRX_IT_LC_DY_FS.DOC_CURR_CODE THEN
                   1.0
                  ELSE
                   (CASE
                     WHEN W_GLOBAL_CURR_G.GLOBAL1_CURR_CODE =
                          STG_W_RTL_SLS_TRX_IT_LC_DY_FS.LOC_CURR_CODE AND NOT
                           STG_W_RTL_SLS_TRX_IT_LC_DY_FS.LOC_EXCHANGE_RATE IS NULL THEN
                      STG_W_RTL_SLS_TRX_IT_LC_DY_FS.LOC_EXCHANGE_RATE
                     ELSE
                      (SELECT EX_RT.EXCH_RATE
                         FROM RADM.W_EXCH_RATE_G EX_RT
                        WHERE EX_RT.W_FROM_CURCY_CODE =
                              STG_W_RTL_SLS_TRX_IT_LC_DY_FS.DOC_CURR_CODE
                          AND EX_RT.W_TO_CURCY_CODE =
                              W_GLOBAL_CURR_G.GLOBAL1_CURR_CODE
                          AND EX_RT.START_DT <=
                              STG_W_RTL_SLS_TRX_IT_LC_DY_FS.EXCHANGE_DT
                          AND EX_RT.END_DT >
                              STG_W_RTL_SLS_TRX_IT_LC_DY_FS.EXCHANGE_DT
                          AND EX_RT.RATE_TYPE = W_GLOBAL_CURR_G.GLOBAL1_RATE_TYPE
                          AND EX_RT.DATASOURCE_NUM_ID =
                              STG_W_RTL_SLS_TRX_IT_LC_DY_FS.DATASOURCE_NUM_ID
                       
                       )
                   
                   END)
                
                END)
             
             END),
             (CASE
               WHEN W_GLOBAL_CURR_G.GLOBAL2_CURR_CODE IS NULL THEN
                NULL
               ELSE
                (CASE
                  WHEN W_GLOBAL_CURR_G.GLOBAL2_CURR_CODE =
                       STG_W_RTL_SLS_TRX_IT_LC_DY_FS.DOC_CURR_CODE THEN
                   1.0
                  ELSE
                   (CASE
                     WHEN W_GLOBAL_CURR_G.GLOBAL2_CURR_CODE =
                          STG_W_RTL_SLS_TRX_IT_LC_DY_FS.LOC_CURR_CODE AND NOT
                           STG_W_RTL_SLS_TRX_IT_LC_DY_FS.LOC_EXCHANGE_RATE IS NULL THEN
                      STG_W_RTL_SLS_TRX_IT_LC_DY_FS.LOC_EXCHANGE_RATE
                     ELSE
                      (SELECT EX_RT.EXCH_RATE
                         FROM RADM.W_EXCH_RATE_G EX_RT
                        WHERE EX_RT.W_FROM_CURCY_CODE =
                              STG_W_RTL_SLS_TRX_IT_LC_DY_FS.DOC_CURR_CODE
                          AND EX_RT.W_TO_CURCY_CODE =
                              W_GLOBAL_CURR_G.GLOBAL2_CURR_CODE
                          AND EX_RT.START_DT <=
                              STG_W_RTL_SLS_TRX_IT_LC_DY_FS.EXCHANGE_DT
                          AND EX_RT.END_DT >
                              STG_W_RTL_SLS_TRX_IT_LC_DY_FS.EXCHANGE_DT
                          AND EX_RT.RATE_TYPE = W_GLOBAL_CURR_G.GLOBAL2_RATE_TYPE
                          AND EX_RT.DATASOURCE_NUM_ID =
                              STG_W_RTL_SLS_TRX_IT_LC_DY_FS.DATASOURCE_NUM_ID
                       
                       )
                   
                   END)
                
                END)
             
             END),
             (CASE
               WHEN W_GLOBAL_CURR_G.GLOBAL3_CURR_CODE IS NULL THEN
                NULL
               ELSE
                (CASE
                  WHEN W_GLOBAL_CURR_G.GLOBAL3_CURR_CODE =
                       STG_W_RTL_SLS_TRX_IT_LC_DY_FS.DOC_CURR_CODE THEN
                   1.0
                  ELSE
                   (CASE
                     WHEN W_GLOBAL_CURR_G.GLOBAL3_CURR_CODE =
                          STG_W_RTL_SLS_TRX_IT_LC_DY_FS.LOC_CURR_CODE AND NOT
                           STG_W_RTL_SLS_TRX_IT_LC_DY_FS.LOC_EXCHANGE_RATE IS NULL THEN
                      STG_W_RTL_SLS_TRX_IT_LC_DY_FS.LOC_EXCHANGE_RATE
                     ELSE
                      (SELECT EX_RT.EXCH_RATE
                         FROM RADM.W_EXCH_RATE_G EX_RT
                        WHERE EX_RT.W_FROM_CURCY_CODE =
                              STG_W_RTL_SLS_TRX_IT_LC_DY_FS.DOC_CURR_CODE
                          AND EX_RT.W_TO_CURCY_CODE =
                              W_GLOBAL_CURR_G.GLOBAL3_CURR_CODE
                          AND EX_RT.START_DT <=
                              STG_W_RTL_SLS_TRX_IT_LC_DY_FS.EXCHANGE_DT
                          AND EX_RT.END_DT >
                              STG_W_RTL_SLS_TRX_IT_LC_DY_FS.EXCHANGE_DT
                          AND EX_RT.RATE_TYPE = W_GLOBAL_CURR_G.GLOBAL3_RATE_TYPE
                          AND EX_RT.DATASOURCE_NUM_ID =
                              STG_W_RTL_SLS_TRX_IT_LC_DY_FS.DATASOURCE_NUM_ID
                       
                       )
                   
                   END)
                
                END)
             
             END),
             STG_W_RTL_SLS_TRX_IT_LC_DY_FS.CREATED_BY_ID,
             STG_W_RTL_SLS_TRX_IT_LC_DY_FS.CHANGED_BY_ID,
             STG_W_RTL_SLS_TRX_IT_LC_DY_FS.DELETE_FLG,
             STG_W_RTL_SLS_TRX_IT_LC_DY_FS.DATASOURCE_NUM_ID,
             STG_W_RTL_SLS_TRX_IT_LC_DY_FS.TENANT_ID,
             STG_W_RTL_SLS_TRX_IT_LC_DY_FS.X_CUSTOM,
             STG_W_RTL_SLS_TRX_IT_LC_DY_FS.ETL_THREAD_VAL,
             BBG_RA_ITEM_LOC_D.ROW_WID,
             STG_W_RTL_SLS_TRX_IT_LC_DY_FS.BBG_RETAIL_TYPE_ID,
             BBG_RA_RETAIL_TYPE_D.ROW_WID,
             STG_W_RTL_SLS_TRX_IT_LC_DY_FS.BBG_SERVICE_SATISFACTION,
             STG_W_RTL_SLS_TRX_IT_LC_DY_FS.SRC_REF_NO1,
             STG_W_RTL_SLS_TRX_IT_LC_DY_FS.SRC_REF_NO2,
             STG_W_RTL_SLS_TRX_IT_LC_DY_FS.SRC_REF_NO3,
             STG_W_RTL_SLS_TRX_IT_LC_DY_FS.SRC_REF_NO6,
             STG_W_RTL_SLS_TRX_IT_LC_DY_FS.SRC_REF_NO7,
             STG_W_RTL_SLS_TRX_IT_LC_DY_FS.SRC_REF_NO8,
             STG_W_RTL_SLS_TRX_IT_LC_DY_FS.BBG_REFERENCE_DO1,
             STG_W_RTL_SLS_TRX_IT_LC_DY_FS.BBG_REFERENCE_DO2,
             STG_W_RTL_SLS_TRX_IT_LC_DY_FS.BBG_REFERENCE_DO3,
             STG_W_RTL_SLS_TRX_IT_LC_DY_FS.BBG_REFERENCE_DO4,
             STG_W_RTL_SLS_TRX_IT_LC_DY_FS.BBG_REFERENCE_DO5,
             STG_W_RTL_SLS_TRX_IT_LC_DY_FS.BBG_REFERENCE_FO1,
             STG_W_RTL_SLS_TRX_IT_LC_DY_FS.BBG_REFERENCE_FO2,
             STG_W_RTL_SLS_TRX_IT_LC_DY_FS.BBG_REFERENCE_FO3,
             STG_W_RTL_SLS_TRX_IT_LC_DY_FS.BBG_REFERENCE_FO4,
             STG_W_RTL_SLS_TRX_IT_LC_DY_FS.BBG_REFERENCE_FO5,
             STG_W_RTL_SLS_TRX_IT_LC_DY_FS.BBG_REFERENCE_FO6,
             STG_W_RTL_SLS_TRX_IT_LC_DY_FS.BBG_REFERENCE_FO7,
             STG_W_RTL_SLS_TRX_IT_LC_DY_FS.BBG_REFERENCE_FO8,
             STG_W_RTL_SLS_TRX_IT_LC_DY_FS.BBG_REFERENCE_FO9,
             STG_W_RTL_SLS_TRX_IT_LC_DY_FS.BBG_REFERENCE_FO10,
             STG_W_RTL_SLS_TRX_IT_LC_DY_FS.HYK_NO,
             1,
             SYSDATE,
             SYSDATE
        from RADM.W_GLOBAL_CURR_G W_GLOBAL_CURR_G,
             RABATCHER.W_INT_ORG_DH_RTL_TMP W_INT_ORG_DH_RTL_TMP,
             RABATCHER.W_PRODUCT_D_RTL_TMP W_PRODUCT_D_RTL_TMP,
             RADM.W_MCAL_WEEK_D W_MCAL_WEEK_D,
             RADM.W_MCAL_DAY_D W_MCAL_DAY_D,
             RADM.W_XACT_TYPE_D W_XACT_TYPE_D,
             RADM.W_MCAL_CONTEXT_G W_MCAL_CONTEXT_G,
             RABATCHER.W_INT_ORG_D_RTL_TMP W_INT_ORG_D_RTL_TMP,
             RADM.BBG_RA_RETAIL_TYPE_D BBG_RA_RETAIL_TYPE_D,
             RADM.BBG_RA_ITEM_LOC_D BBG_RA_ITEM_LOC_D,
             RADM.W_MINUTE_OF_DAY_D W_MINUTE_OF_DAY_D,
             (SELECT T.SLS_TRX_ID,
                     T.PROD_IT_NUM,
                     T.ORG_NUM,
                     T.DAY_DT,
                     -1 VOUCHER_ID,
                     T.RTL_TYPE_CODE,
                     T.MIN_NUM,
                     -1 EMPLOYEE_NUM,
                     T.SLS_QTY,
                     T.SLS_AMT_LCL,
                     T.SLS_PROFIT_AMT_LCL,
                     T.SLS_TAX_AMT_LCL,
                     T.SLS_EMP_DISC_AMT_LCL,
                     T.SLS_MANUAL_COUNT,
                     T.SLS_SCAN_COUNT,
                     ABS(T.RET_QTY) RET_QTY,
                     ABS(T.RET_AMT_LCL) RET_AMT_LCL,
                     T.RET_PROFIT_AMT_LCL,
                     ABS(T.RET_TAX_AMT_LCL) RET_TAX_AMT_LCL,
                     T.RET_EMP_DISC_AMT_LCL,
                     T.RET_MANUAL_COUNT,
                     T.RET_SCAN_COUNT,
                     NULL REJECT_FLG,
                     T.SLS_MANUAL_MKDN_AMT_LCL,
                     T.SLS_MANUAL_MKUP_AMT_LCL,
                     T.RET_MANUAL_MKDN_AMT_LCL,
                     T.RET_MANUAL_MKUP_AMT_LCL,
                     T.DAY_DT EXCHANGE_DT,
                     NULL AUX1_CHANGED_ON_DT,
                     NULL AUX2_CHANGED_ON_DT,
                     NULL AUX3_CHANGED_ON_DT,
                     NULL AUX4_CHANGED_ON_DT,
                     -1 CHANGED_BY_ID,
                     SYSDATE CHANGED_ON_DT,
                     -1 CREATED_BY_ID,
                     SYSDATE CREATED_ON_DT,
                     1 DATASOURCE_NUM_ID,
                     NULL DELETE_FLG,
                     'CNY' DOC_CURR_CODE,
                     (SELECT L.THREAD_VAL
                        FROM RA_RMS.RA_RESTART_LOC@RA_RMS_DBLINK L
                       WHERE T.ORG_NUM = L.DRIVER_VALUE
                         AND L.SCENARIO_NAME =
                             'SDE_BBG_RETAIL_SALESTRANSACTIONFACT') ETL_THREAD_VAL,
                     NULL GLOBAL1_EXCHANGE_RATE,
                     NULL GLOBAL2_EXCHANGE_RATE,
                     NULL GLOBAL3_EXCHANGE_RATE,
                     T.SLS_TRX_ID || '~' || T.PROD_IT_NUM || '~-1~' ||
                     TO_CHAR(T.DAY_DT,
                             'DD-MON-YY',
                             'NLS_DATE_LANGUAGE = American') INTEGRATION_ID,
                     'CNY' LOC_CURR_CODE,
                     NULL LOC_EXCHANGE_RATE,
                     NULL TENANT_ID,
                     NULL X_CUSTOM,
                     T.BBG_RETAIL_TYPE_ID,
                     3.5 BBG_SERVICE_SATISFACTION,
                     NULL SRC_REF_NO1,
                     NULL SRC_REF_NO2,
                     NULL SRC_REF_NO3,
                     T.PROD_IT_NUM SRC_REF_NO6,
                     NULL SRC_REF_NO7,
                     NULL SRC_REF_NO8,
                     NULL BBG_REFERENCE_DO1,
                     NULL BBG_REFERENCE_DO2,
                     NULL BBG_REFERENCE_DO3,
                     NULL BBG_REFERENCE_DO4,
                     NULL BBG_REFERENCE_DO5,
                     NULL BBG_REFERENCE_FO1,
                     NULL BBG_REFERENCE_FO2,
                     NULL BBG_REFERENCE_FO3,
                     NULL BBG_REFERENCE_FO4,
                     NULL BBG_REFERENCE_FO5,
                     NULL BBG_REFERENCE_FO6,
                     NULL BBG_REFERENCE_FO7,
                     NULL BBG_REFERENCE_FO8,
                     NULL BBG_REFERENCE_FO9,
                     NULL BBG_REFERENCE_FO10,
                     NULL HYK_NO
                FROM (SELECT SLS_TRX_ID,
                             PROD_IT_NUM,
                             ORG_NUM,
                             DAY_DT,
                             VOUCHER_ID,
                             RTL_TYPE_CODE,
                             MIN_NUM,
                             SLS_QTY,
                             SLS_AMT_LCL,
                             SLS_PROFIT_AMT_LCL,
                             SLS_TAX_AMT_LCL,
                             SLS_EMP_DISC_AMT_LCL,
                             SLS_MANUAL_COUNT,
                             SLS_SCAN_COUNT,
                             -RET_QTY                 RET_QTY,
                             -RET_AMT_LCL             RET_AMT_LCL,
                             -RET_PROFIT_AMT_LCL      RET_PROFIT_AMT_LCL,
                             -RET_TAX_AMT_LCL         RET_TAX_AMT_LCL,
                             -RET_EMP_DISC_AMT_LCL    RET_EMP_DISC_AMT_LCL,
                             -RET_MANUAL_COUNT        RET_MANUAL_COUNT,
                             -RET_SCAN_COUNT          RET_SCAN_COUNT,
                             SLS_MANUAL_MKDN_AMT_LCL,
                             SLS_MANUAL_MKUP_AMT_LCL,
                             -RET_MANUAL_MKDN_AMT_LCL RET_MANUAL_MKDN_AMT_LCL,
                             -RET_MANUAL_MKUP_AMT_LCL RET_MANUAL_MKUP_AMT_LCL,
                             BBG_RETAIL_TYPE_ID
                        FROM BBG_RA_SLS_TRX_JL_V@RA_JL
                       WHERE DAY_DT BETWEEN BDATE AND EDATE) T) STG_W_RTL_SLS_TRX_IT_LC_DY_FS,
             RADM.W_RTL_SLS_TRX_IT_LC_DY_F STF
       where (1 = 1)
         AND STG_W_RTL_SLS_TRX_IT_LC_DY_FS.SLS_TRX_ID = STF.SLS_TRX_ID(+)
         AND W_INT_ORG_D_RTL_TMP.ORG_WID = STF.ORG_WID(+)
         AND W_PRODUCT_D_RTL_TMP.PROD_IT_WID = STF.PROD_WID(+)
         And (W_MCAL_DAY_D.MCAL_CAL_WID = W_MCAL_CONTEXT_G.MCAL_CAL_WID)
         AND (STG_W_RTL_SLS_TRX_IT_LC_DY_FS.DATASOURCE_NUM_ID =
             W_MCAL_CONTEXT_G.DATASOURCE_NUM_ID)
         AND (W_MCAL_CONTEXT_G.MCAL_CAL_WID = W_MCAL_WEEK_D.MCAL_CAL_WID)
         AND (((LPAD(W_MINUTE_OF_DAY_D.HOUR_24_NUM, 2, '0') ||
             LPAD(W_MINUTE_OF_DAY_D.MINUTE_NUM, 2, '0')) =
             LPAD(STG_W_RTL_SLS_TRX_IT_LC_DY_FS.MIN_NUM, 4, '0')) AND
             W_MINUTE_OF_DAY_D.DATASOURCE_NUM_ID =
             STG_W_RTL_SLS_TRX_IT_LC_DY_FS.DATASOURCE_NUM_ID)
         AND (BBG_RA_RETAIL_TYPE_D.RETAIL_TYPE_ID =
             STG_W_RTL_SLS_TRX_IT_LC_DY_FS.BBG_RETAIL_TYPE_ID)
         AND (BBG_RA_ITEM_LOC_D.ITEM =
             STG_W_RTL_SLS_TRX_IT_LC_DY_FS.PROD_IT_NUM AND
             BBG_RA_ITEM_LOC_D.LOC = STG_W_RTL_SLS_TRX_IT_LC_DY_FS.ORG_NUM and
             (STG_W_RTL_SLS_TRX_IT_LC_DY_FS.DAY_DT between
             BBG_RA_ITEM_LOC_D.EFFECTIVE_FROM_DT and
             BBG_RA_ITEM_LOC_D.EFFECTIVE_TO_DT))
         AND ((((W_MCAL_DAY_D.MCAL_DAY_DT BETWEEN
             W_MCAL_WEEK_D.MCAL_WEEK_START_DT AND
             W_MCAL_WEEK_D.MCAL_WEEK_END_DT)) AND
             W_MCAL_DAY_D.DATASOURCE_NUM_ID =
             W_MCAL_WEEK_D.DATASOURCE_NUM_ID))
         AND ((W_PRODUCT_D_RTL_TMP.PROD_IT_NUM =
             STG_W_RTL_SLS_TRX_IT_LC_DY_FS.PROD_IT_NUM) AND
             W_PRODUCT_D_RTL_TMP.SRC_EFF_FROM_DT <=
             STG_W_RTL_SLS_TRX_IT_LC_DY_FS.DAY_DT AND
             W_PRODUCT_D_RTL_TMP.SRC_EFF_TO_DT >=
             STG_W_RTL_SLS_TRX_IT_LC_DY_FS.DAY_DT)
         AND ((W_MCAL_DAY_D.DATASOURCE_NUM_ID =
             STG_W_RTL_SLS_TRX_IT_LC_DY_FS.DATASOURCE_NUM_ID) AND
             W_MCAL_DAY_D.MCAL_DAY_DT =
             STG_W_RTL_SLS_TRX_IT_LC_DY_FS.DAY_DT)
         AND (W_XACT_TYPE_D.DATASOURCE_NUM_ID =
             STG_W_RTL_SLS_TRX_IT_LC_DY_FS.DATASOURCE_NUM_ID AND
             W_XACT_TYPE_D.W_XACT_CAT_CODE = 'RETAIL_TRAN_TYPE' and
             W_XACT_TYPE_D.W_XACT_TYPE_CODE =
             STG_W_RTL_SLS_TRX_IT_LC_DY_FS.RTL_TYPE_CODE)
         AND ((W_INT_ORG_DH_RTL_TMP.ORG_NUM =
             STG_W_RTL_SLS_TRX_IT_LC_DY_FS.ORG_NUM) AND
             W_INT_ORG_DH_RTL_TMP.EFFECTIVE_FROM_DT <=
             STG_W_RTL_SLS_TRX_IT_LC_DY_FS.DAY_DT AND
             W_INT_ORG_DH_RTL_TMP.EFFECTIVE_TO_DT >=
             STG_W_RTL_SLS_TRX_IT_LC_DY_FS.DAY_DT)
         AND ((W_INT_ORG_D_RTL_TMP.ORG_NUM =
             STG_W_RTL_SLS_TRX_IT_LC_DY_FS.ORG_NUM) AND
             W_INT_ORG_D_RTL_TMP.EFFECTIVE_FROM_DT <=
             STG_W_RTL_SLS_TRX_IT_LC_DY_FS.DAY_DT AND
             W_INT_ORG_D_RTL_TMP.EFFECTIVE_TO_DT >=
             STG_W_RTL_SLS_TRX_IT_LC_DY_FS.DAY_DT)
         AND (STG_W_RTL_SLS_TRX_IT_LC_DY_FS.DATASOURCE_NUM_ID =
             W_GLOBAL_CURR_G.DATASOURCE_NUM_ID)
         AND EXISTS
       (SELECT 1
                FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_F F,
                     RADM.W_PRODUCT_D              P,
                     RADM.W_INT_ORG_D              O
               WHERE F.PROD_WID = P.ROW_WID
                 AND F.ORG_WID = O.ROW_WID
                 AND F.SLS_TRX_ID = STG_W_RTL_SLS_TRX_IT_LC_DY_FS.SLS_TRX_ID
                 AND P.PROD_NUM = STG_W_RTL_SLS_TRX_IT_LC_DY_FS.PROD_IT_NUM
                 AND O.ORG_NUM = STG_W_RTL_SLS_TRX_IT_LC_DY_FS.ORG_NUM
                 AND F.DT_WID =
                     '1' || TO_CHAR(STG_W_RTL_SLS_TRX_IT_LC_DY_FS.DAY_DT,
                                    'YYYYMMDD') || '000'
                 AND F.DT_WID BETWEEN
                     '1' || TO_CHAR(BDATE, 'YYYYMMDD') || '000' AND
                     '1' || TO_CHAR(EDATE, 'YYYYMMDD') || '000'
                 AND F.BBG_SERVICE_SATISFACTION = 3.5
                 AND ABS((STG_W_RTL_SLS_TRX_IT_LC_DY_FS.SLS_AMT_LCL -
                         STG_W_RTL_SLS_TRX_IT_LC_DY_FS.RET_AMT_LCL) -
                         (STG_W_RTL_SLS_TRX_IT_LC_DY_FS.SLS_TAX_AMT_LCL -
                         STG_W_RTL_SLS_TRX_IT_LC_DY_FS.RET_TAX_AMT_LCL)) <>
                     ABS((F.SLS_AMT_LCL - F.RET_AMT_LCL) -
                         (F.SLS_TAX_AMT_LCL - F.RET_TAX_AMT_LCL)));
    RETURN TRUE;
  EXCEPTION
    WHEN OTHERS THEN
      O_ERROR_MESSAGE := SQLERRM;
      RETURN FALSE;
  END;
END;
/
