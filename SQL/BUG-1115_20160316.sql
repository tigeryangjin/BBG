--SALES_AMT RANK
SELECT D6.DEPT_NO           大类编码,
       D6.DEPT_NAME         大类名称,
       D6.SUBCLASS_NO       小类编码,
       D6.SUBCLASS_NAME     小类名称,
       D6.PROD_NUM          商品编码,
       D6.PRODUCT_NAME      商品名称,
       D6.SALES_QTY         销售数量,
       D6.SALES_AMT         未税销售额,
       D6.PROFIT_AMT        未税毛利额,
       D6.SALES_AMT_RANK    销售额排名,
       D6.SALES_STORE_COUNT 销售门店数
  FROM (SELECT D5.DEPT_NO,
               D5.DEPT_NAME,
               D5.SUBCLASS_NO,
               D5.SUBCLASS_NAME,
               D5.PROD_NUM,
               D5.PRODUCT_NAME,
               D5.SALES_QTY,
               D5.SALES_AMT,
               D5.PROFIT_AMT,
               RANK() OVER(PARTITION BY D5.SUBCLASS_NO ORDER BY D5.SALES_AMT DESC) SALES_AMT_RANK,
               D5.SALES_STORE_COUNT
          FROM (SELECT D3.DEPT_NO,
                       D3.DEPT_NAME,
                       D3.SUBCLASS_NO,
                       D4.DOMAIN_MEMBER_NAME SUBCLASS_NAME,
                       D3.PROD_NUM,
                       D3.PRODUCT_NAME,
                       D3.SALES_QTY,
                       D3.SALES_AMT,
                       D3.PROFIT_AMT,
                       D3.SALES_STORE_COUNT
                  FROM (SELECT D1.DEPT_NO,
                               D2.DOMAIN_MEMBER_NAME DEPT_NAME,
                               D1.SUBCLASS_NO,
                               D1.SUBCLASS,
                               D1.PROD_NUM,
                               D1.PRODUCT_NAME,
                               D1.SALES_QTY,
                               D1.SALES_AMT,
                               D1.PROFIT_AMT,
                               D1.SALES_STORE_COUNT
                          FROM (SELECT CONCAT('DEPT~', C.LVL6ANC_PRODCAT_ID) DEPT,
                                       C.LVL6ANC_PRODCAT_ID DEPT_NO,
                                       CONCAT('SBC~',
                                              CONCAT(C.LVL6ANC_PRODCAT_ID,
                                                     CONCAT('~',
                                                            CONCAT(C.LVL5ANC_PRODCAT_ID,
                                                                   CONCAT('~',
                                                                          C.LVL4ANC_PRODCAT_ID))))) SUBCLASS,
                                       C.LVL4ANC_PRODCAT_ID SUBCLASS_NO,
                                       P.PROD_NUM,
                                       P.PRODUCT_NAME,
                                       COUNT(DISTINCT S.ORG_WID) SALES_STORE_COUNT,
                                       SUM(NVL(S.SLS_QTY, 0) -
                                           NVL(S.RET_QTY, 0)) SALES_QTY,
                                       SUM((NVL(S.SLS_AMT_LCL, 0) -
                                           NVL(S.RET_AMT_LCL, 0)) -
                                           (NVL(S.SLS_TAX_AMT_LCL, 0) -
                                           NVL(S.RET_TAX_AMT_LCL, 0))) SALES_AMT,
                                       SUM(NVL(S.SLS_PROFIT_AMT_LCL, 0) -
                                           NVL(S.RET_PROFIT_AMT_LCL, 0)) PROFIT_AMT
                                  FROM RADM.W_RTL_SLS_IT_LC_DY_A S,
                                       (SELECT A.ROW_WID PROD_WID,
                                               A.PROD_CAT5_WID_AS_WAS,
                                               A.PROD_NUM,
                                               B.PRODUCT_NAME
                                          FROM RADM.W_PRODUCT_D    A,
                                               RADM.W_PRODUCT_D_TL B
                                         WHERE A.DATASOURCE_NUM_ID =
                                               B.DATASOURCE_NUM_ID
                                           AND A.INTEGRATION_ID =
                                               B.INTEGRATION_ID
                                           AND B.LANGUAGE_CODE = 'ZHS') P,
                                       RADM.W_PROD_CAT_DH C
                                 WHERE S.PROD_WID = P.PROD_WID
                                   AND P.PROD_CAT5_WID_AS_WAS = C.ROW_WID
                                   AND S.DT_WID BETWEEN &B_DT_WID AND &E_DT_WID
                                 GROUP BY P.PROD_CAT5_WID_AS_WAS,
                                          C.LVL6ANC_PRODCAT_ID,
                                          C.LVL5ANC_PRODCAT_ID,
                                          C.LVL4ANC_PRODCAT_ID,
                                          P.PROD_NUM,
                                          P.PRODUCT_NAME) D1
                         INNER JOIN (SELECT DOMAIN_MEMBER_NAME,
                                           DOMAIN_MEMBER_CODE
                                      FROM W_DOMAIN_MEMBER_LKP_TL
                                     WHERE (DOMAIN_CODE = 'MCAT' AND
                                           DOMAIN_TYPE_CODE = 'S' AND
                                           LANGUAGE_CODE = 'ZHS')) D2
                            ON D1.DEPT = D2.DOMAIN_MEMBER_CODE) D3
                 INNER JOIN (SELECT DOMAIN_MEMBER_NAME, DOMAIN_MEMBER_CODE
                              FROM W_DOMAIN_MEMBER_LKP_TL
                             WHERE (DOMAIN_CODE = 'MCAT' AND
                                   DOMAIN_TYPE_CODE = 'S' AND
                                   LANGUAGE_CODE = 'ZHS')) D4
                    ON D3.SUBCLASS = D4.DOMAIN_MEMBER_CODE) D5) D6
 WHERE D6.SALES_AMT_RANK <= 20
 ORDER BY D6.SUBCLASS_NO, D6.SALES_AMT DESC;

--SALES_QTY RANK
SELECT D6.DEPT_NO           大类编码,
       D6.DEPT_NAME         大类名称,
       D6.SUBCLASS_NO       小类编码,
       D6.SUBCLASS_NAME     小类名称,
       D6.PROD_NUM          商品编码,
       D6.PRODUCT_NAME      商品名称,
       D6.SALES_QTY         销售数量,
       D6.SALES_AMT         未税销售额,
       D6.PROFIT_AMT        未税毛利额,
       D6.SALES_QTY_RANK    销售量排名,
       D6.SALES_STORE_COUNT 销售门店数
  FROM (SELECT D5.DEPT_NO,
               D5.DEPT_NAME,
               D5.SUBCLASS_NO,
               D5.SUBCLASS_NAME,
               D5.PROD_NUM,
               D5.PRODUCT_NAME,
               D5.SALES_QTY,
               D5.SALES_AMT,
               D5.PROFIT_AMT,
               RANK() OVER(PARTITION BY D5.SUBCLASS_NO ORDER BY D5.SALES_QTY DESC) SALES_QTY_RANK,
               D5.SALES_STORE_COUNT
          FROM (SELECT D3.DEPT_NO,
                       D3.DEPT_NAME,
                       D3.SUBCLASS_NO,
                       D4.DOMAIN_MEMBER_NAME SUBCLASS_NAME,
                       D3.PROD_NUM,
                       D3.PRODUCT_NAME,
                       D3.SALES_QTY,
                       D3.SALES_AMT,
                       D3.PROFIT_AMT,
                       D3.SALES_STORE_COUNT
                  FROM (SELECT D1.DEPT_NO,
                               D2.DOMAIN_MEMBER_NAME DEPT_NAME,
                               D1.SUBCLASS_NO,
                               D1.SUBCLASS,
                               D1.PROD_NUM,
                               D1.PRODUCT_NAME,
                               D1.SALES_QTY,
                               D1.SALES_AMT,
                               D1.PROFIT_AMT,
                               D1.SALES_STORE_COUNT
                          FROM (SELECT CONCAT('DEPT~', C.LVL6ANC_PRODCAT_ID) DEPT,
                                       C.LVL6ANC_PRODCAT_ID DEPT_NO,
                                       CONCAT('SBC~',
                                              CONCAT(C.LVL6ANC_PRODCAT_ID,
                                                     CONCAT('~',
                                                            CONCAT(C.LVL5ANC_PRODCAT_ID,
                                                                   CONCAT('~',
                                                                          C.LVL4ANC_PRODCAT_ID))))) SUBCLASS,
                                       C.LVL4ANC_PRODCAT_ID SUBCLASS_NO,
                                       P.PROD_NUM,
                                       P.PRODUCT_NAME,
                                       COUNT(DISTINCT S.ORG_WID) SALES_STORE_COUNT,
                                       SUM(NVL(S.SLS_QTY, 0) -
                                           NVL(S.RET_QTY, 0)) SALES_QTY,
                                       SUM((NVL(S.SLS_AMT_LCL, 0) -
                                           NVL(S.RET_AMT_LCL, 0)) -
                                           (NVL(S.SLS_TAX_AMT_LCL, 0) -
                                           NVL(S.RET_TAX_AMT_LCL, 0))) SALES_AMT,
                                       SUM(NVL(S.SLS_PROFIT_AMT_LCL, 0) -
                                           NVL(S.RET_PROFIT_AMT_LCL, 0)) PROFIT_AMT
                                  FROM RADM.W_RTL_SLS_IT_LC_DY_A S,
                                       (SELECT A.ROW_WID PROD_WID,
                                               A.PROD_CAT5_WID_AS_WAS,
                                               A.PROD_NUM,
                                               B.PRODUCT_NAME
                                          FROM RADM.W_PRODUCT_D    A,
                                               RADM.W_PRODUCT_D_TL B
                                         WHERE A.DATASOURCE_NUM_ID =
                                               B.DATASOURCE_NUM_ID
                                           AND A.INTEGRATION_ID =
                                               B.INTEGRATION_ID
                                           AND B.LANGUAGE_CODE = 'ZHS') P,
                                       RADM.W_PROD_CAT_DH C
                                 WHERE S.PROD_WID = P.PROD_WID
                                   AND P.PROD_CAT5_WID_AS_WAS = C.ROW_WID
                                   AND S.DT_WID BETWEEN &B_DT_WID AND &E_DT_WID
                                 GROUP BY P.PROD_CAT5_WID_AS_WAS,
                                          C.LVL6ANC_PRODCAT_ID,
                                          C.LVL5ANC_PRODCAT_ID,
                                          C.LVL4ANC_PRODCAT_ID,
                                          P.PROD_NUM,
                                          P.PRODUCT_NAME) D1
                         INNER JOIN (SELECT DOMAIN_MEMBER_NAME,
                                           DOMAIN_MEMBER_CODE
                                      FROM W_DOMAIN_MEMBER_LKP_TL
                                     WHERE (DOMAIN_CODE = 'MCAT' AND
                                           DOMAIN_TYPE_CODE = 'S' AND
                                           LANGUAGE_CODE = 'ZHS')) D2
                            ON D1.DEPT = D2.DOMAIN_MEMBER_CODE) D3
                 INNER JOIN (SELECT DOMAIN_MEMBER_NAME, DOMAIN_MEMBER_CODE
                              FROM W_DOMAIN_MEMBER_LKP_TL
                             WHERE (DOMAIN_CODE = 'MCAT' AND
                                   DOMAIN_TYPE_CODE = 'S' AND
                                   LANGUAGE_CODE = 'ZHS')) D4
                    ON D3.SUBCLASS = D4.DOMAIN_MEMBER_CODE) D5) D6
 WHERE D6.SALES_QTY_RANK <= 20
 ORDER BY D6.SUBCLASS_NO, D6.SALES_QTY DESC;
