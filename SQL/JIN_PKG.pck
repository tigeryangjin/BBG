CREATE OR REPLACE PACKAGE JIN_PKG AS
  O_PI /*CONSTANT*/
  NUMBER := 3.141592654;
  TYPE CUR_RETURN IS REF CURSOR;
  FUNCTION GETAREA(R IN NUMBER) RETURN NUMBER;

  ----------------------------------------------------------
  --- 功能名:       P_CK_IT_INV_DAY_ERROR
  --- 目的:         检查商品库存表的日期是否重复
  --- 作者:         杨进
  --- 创建时间：    2014/12/18
  --- 最后修改人：
  --- 最后更改日期：
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

END JIN_PKG;
/
CREATE OR REPLACE PACKAGE BODY JIN_PKG AS
  FUNCTION GETAREA(R IN NUMBER) RETURN NUMBER IS
    V_AREA NUMBER;
  BEGIN
    V_AREA := R * R * O_PI;
    RETURN V_AREA;
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
      SELECT /*+PARALLEL(W_MCAL_DAY_D,20) PARALLEL(W_PRODUCT_D_RTL_TMP,20) PARALLEL(W_INT_ORG_DH_RTL_TMP,20) PARALLEL(W_INT_ORG_D_RTL_TMP,20) PARALLEL(W_PARTY_ORG_D,20) PARALLEL(BBG_RA_ITEM_LOC_D,20) PARALLEL(BBG_RA_ITEM_LOC_SUPP_D,20) PARALLEL(STG_BBG_RA_SLS_IT_LC_DY_FS,20) PARALLEL(W_MCAL_WEEK_D,20)*/
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

END;
/
