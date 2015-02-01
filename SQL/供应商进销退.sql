SELECT SP.MONTH,
       SP.SUP1,
       SP.SUPN1,
       SP.SUP2,
       SP.SUPN2,
       SP.CONTRACT_NO,
       SP.DEPT,
       SP.BRAND,
       SP.MARGIN_RATE,
       SP.GROSS_MARGIN_RATE,
       SP.CONTRACT_TYPE_DESC,
       RV.REVENUE 入库,
       RV.RTV_REVENUE 返厂,
       RV.TURNOVER 净入库,
       SA.COSTVALUE 销售成本,
       SA.SALEVALUE 销售金额,
       (SA.SALEVALUE-SA.COSTVALUE) 销售毛利,
       round(DECODE(nvl(sa.salevalue,0),0,0,((SA.SALEVALUE-SA.COSTVALUE)/SA.SALEVALUE)),4) 销售毛利率
  FROM (SELECT *
          FROM (SELECT CS.SUP1,
                       CS.SUPN1,
                       CS.SUP2 SUP2,
                       CS.SUPN2,
                       CF.CONTRACT_NO,
                       SUBSTR(CS.SUP2, 1, 2) DEPT,
                       cf.BRAND_CODE,
                       CF.MARGIN_RATE,
                               CF.GROSS_MARGIN_RATE,
                       (SELECT UV.UDA_VALUE_DESC
                          FROM UDA_VALUES UV
                         WHERE UV.UDA_ID = 3
                           AND UV.UDA_VALUE = CF.BRAND_CODE) BRAND,
                           CF.CONTRACT_TYPE,
                       (SELECT CD.CODE_DESC
                          FROM CMX_CODE_DETAIL CD
                         WHERE CD.CODE = CF.CONTRACT_TYPE
                           AND CD.CODE_TYPE = 'BSTP'
                           AND CD.LANG = 8) CONTRACT_TYPE_DESC  
                  FROM (SELECT CC.SUPPLIER,
                               CC.CONTRACT_NO,
                               CC.CONTRACT_TYPE,
                               CC.STATUS,
                               TO_CHAR(CC.BRAND_CODE) BRAND_CODE,
                               CC.MARGIN_RATE,
                               CC.GROSS_MARGIN_RATE
                          FROM (SELECT T1.*,
                                       ROW_NUMBER() OVER(PARTITION BY T1.SUPPLIER ORDER BY T1.REV_NO DESC NULLS LAST) RN
                                  FROM CMX_CONTRACT T1
                                 WHERE NVL(YEAR, 2014) = 2014) CC
                         WHERE RN = 1
                        UNION ALL
                        SELECT CC.SUPPLIER,
                               CC.CONTRACT_NO,
                               CC.CONTRACT_TYPE,
                               CC.STATUS,
                               CC.BRAND_CODE,
                              0 MARGIN_RATE,
                              0 GROSS_MARGIN_RATE
                               
                          FROM (SELECT T1.*,
                                       ROW_NUMBER() OVER(PARTITION BY T1.SUPPLIER ORDER BY T1.REV_NO DESC NULLS LAST) RN
                                  FROM CMX_CONTRACT_MALL T1
                                 WHERE NVL(YEAR, 2014) = 2014) CC
                         WHERE RN = 1) CF, --合同品牌状态

                       (SELECT C2.SUPPLIER SUP1,
                               C2.SUP_NAME SUPN1,
                               C1.SUPPLIER SUP2,
                               C1.SUP_NAME SUPN2,
                               C1.TERMS
                          FROM (SELECT C.SUPPLIER,
                                       C.SUP_NAME,
                                       C.SUPPLIER_PARENT,
                                       C.TERMS
                                  FROM SUPS C) C1,
                               (SELECT C.SUPPLIER,
                                       C.SUPPLIER_PARENT,
                                       C.SUP_NAME
                                  FROM SUPS C) C2
                         WHERE C1.SUPPLIER_PARENT = C2.SUPPLIER) CS ---供应商关系
                 WHERE CS.SUP2(+) = CF.SUPPLIER) SP ----供应商数据
              ,
               (SELECT '201401' MONTH
                  FROM DUAL
                ) ) SP, ----月份

       ---入库返厂
       (SELECT MONTH,
               SUPPLIER,
               SUM(T.REVENUE) REVENUE,
               SUM(T.RTV_REVENUE) RTV_REVENUE,
               SUM(T.REVENUE - T.RTV_REVENUE) TURNOVER
          FROM (SELECT NVL(A.MONTH, B.MONTH) MONTH,
       NVL(A.SUPPLIER, B.SUPPLIER) SUPPLIER,
       NVL(a.location,b.location) LOCATION,
       NVL(A.REVENUE, 0) REVENUE,
       NVL(RTV_REVENUE, 0) RTV_REVENUE
  FROM (SELECT MONTH, SUPPLIER,LOCATION, SUM(TOTAL_COST_TAX) REVENUE
          FROM (SELECT TO_CHAR(TRAN_DATE, 'YYYYMM') MONTH,
                       C.SUPPLIER,
                       a.LOCATION ,
                       '20' TRAN_CODE,
                       SUM(TOTAL_COST * (1 + B.VAT_RATE / 100)) TOTAL_COST_TAX
                  FROM TRAN_DATA_HISTORY A, V_CMX_COST_VAT_ITEM B, ORDHEAD C
                 WHERE TRAN_DATE BETWEEN DATE '2014-01-01' AND DATE
                 '2014-01-31'
                   AND ((TRAN_CODE = 20))
                   AND A.ITEM = B.ITEM
                   AND A.REF_NO_1 = C.ORDER_NO
                 GROUP BY C.SUPPLIER, TO_CHAR(TRAN_DATE, 'YYYYMM'),a.LOCATION
                /*UNION ALL
                SELECT MONTH,
                       TO_NUMBER(SUPPLIER),
                       TO_NUMBER(loc),
                       TRAN_CODE,
                       TOTAL_COST_TAX + 0
                  FROM rmshist.rt_201301_201305rtvrcv T*/)
         WHERE TRAN_CODE = '20'
         GROUP BY MONTH, SUPPLIER,LOCATION) A
  FULL JOIN (SELECT MONTH, SUPPLIER, location,SUM(TOTAL_COST_TAX) RTV_REVENUE
               FROM (SELECT TO_CHAR(TRAN_DATE, 'YYYYMM') MONTH,
                            C.SUPPLIER,
                           a.LOCATION ,
                            '24' TRAN_CODE,
                            SUM(TOTAL_COST * (1 + B.VAT_RATE / 100)) TOTAL_COST_TAX
                       FROM TRAN_DATA_HISTORY   A,
                            V_CMX_COST_VAT_ITEM B,
                            RTV_HEAD            C
                      WHERE TRAN_DATE BETWEEN DATE '2014-01-01' AND DATE
                      '2014-01-31'
                        AND (TRAN_CODE = 24)
                        AND A.ITEM = B.ITEM
                        AND C.RTV_ORDER_NO = A.REF_NO_1
                      GROUP BY C.SUPPLIER, TO_CHAR(TRAN_DATE, 'YYYYMM'),a.LOCATION
                     /*UNION ALL
                     SELECT MONTH,
                            TO_NUMBER(SUPPLIER),
                            to_number(loc),
                            TRAN_CODE,
                            TOTAL_COST_TAX + 0
                       FROM rmshist.rt_201301_201305rtvrcv T*/)
              WHERE TRAN_CODE = '24'
              GROUP BY MONTH, SUPPLIER,LOCATION) B ON A.MONTH = B.MONTH
                                         AND A.SUPPLIER = B.SUPPLIER
                                         AND a.location=b.location
                                        
) T
         GROUP BY MONTH, SUPPLIER) RV,

       --供应商销售合计
       (SELECT TO_CHAR(SS.ORIGIN_SALES_DATE, 'yyyymm') MONTH,
               -- STORE LOC,
               SUPPLIER SUPPLIER,
               -- ITEM,
               --SUM(QTY) SALEQTY,
               SUM(TOTAL_COST * (100 + SS.COST_VAT_RATE) / 100) COSTVALUE,
               SUM(SS.TOTAL_RETAIL) SALEVALUE
          FROM CMX_SUPP_SALES SS
         WHERE SS.ORIGIN_SALES_DATE BETWEEN DATE '2014-01-01' AND  DATE '2014-01-31'
         GROUP BY TO_CHAR(SS.ORIGIN_SALES_DATE, 'yyyymm'), /*STORE,*/
                  SUPPLIER /*, ITEM*/) SA

 WHERE SP.SUP2 = SA.SUPPLIER(+)
   AND SP.SUP2 = RV.SUPPLIER(+)
   AND SP.MONTH = SA.MONTH(+)
   AND SP.MONTH = RV.MONTH(+)
   AND (nvl(RV.REVENUE,0)<>0 OR
       nvl(RV.RTV_REVENUE,0)<> 0 OR
       nvl(RV.TURNOVER,0)<>0 OR
       nvl(SA.COSTVALUE,0)<>0 OR
       nvl(SA.SALEVALUE,0)<>0 );