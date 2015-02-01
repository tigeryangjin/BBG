SELECT CS.SUP1,
       CS.SUPN1,
       M.SUPPLIER,
       CS.SUPN2,
       M.CONTRACT_NO,
       M.DEPT,
       M.CONTRACT_TYPE,
       M.CONTRACT_TYPE_DESC,
       (SELECT TH.TERMS_DESC
          FROM TERMS_HEAD TH
         WHERE TH.TERMS_CODE(+) = CS.TERMS) TERMS_DESC,
         (SELECT UV.UDA_VALUE_DESC
          FROM UDA_VALUES UV
         WHERE UV.UDA_ID = 3
           AND UV.UDA_VALUE = Cf.BRAND_CODE) 经营主要品牌,
           CASE
         WHEN cf.STATUS = 'C' THEN
          '终止'
         WHEN Cf.STATUS = 'A' THEN
          '正在执行'
         WHEN Cf.STATUS = 'S' THEN
          '录入'
         WHEN Cf.STATUS = 'I' THEN
          '提交'
         ELSE
          NULL
       END AS 合同状态,
       M.COST_CODE,
       M.COST_CODE_DESC,
       M.AMOUNT
  FROM (SELECT T.SUPPLIER,
                T.CONTRACT_NO,
                SUBSTR(T.SUPPLIER, 1, 2) DEPT,
                T.CONTRACT_TYPE,

                (SELECT CD.CODE_DESC
                   FROM CMX_CODE_DETAIL CD
                  WHERE CD.CODE = T.CONTRACT_TYPE
                    AND CD.CODE_TYPE = 'BSTP'
                    AND CD.LANG = 8) CONTRACT_TYPE_DESC,
                T.COST_CODE,
                (SELECT CCO.COST_NAME
                   FROM CMX_CONTRACT_OPTIONS CCO
                  WHERE CCO.COST_CODE = T.COST_CODE) COST_CODE_DESC,

                SUM(DECODE(T.TYPE, 'C', T.REAL_AMOUNT, 'CC', T.REAL_DIF, 0)) AMOUNT

           FROM CMX_CONTRACT_RESULT T
          WHERE --T.CONTRACT_TYPE <> 'ZS'   AND
          T.COLLECTION_DATE BETWEEN DATE '2014-01-01' AND DATE
          '2014-01-31'
       AND T.PROCESS_FLAG = 'P'
          GROUP BY T.SUPPLIER,
                   T.CONTRACT_NO,
                   SUBSTR(T.SUPPLIER, 1, 2),
                   T.CONTRACT_TYPE,
                   T.COST_CODE) M ---主数据
      ,
       (SELECT C2.SUPPLIER SUP1,
               C2.SUP_NAME SUPN1,
               C1.SUPPLIER SUP2,
               C1.SUP_NAME SUPN2,
               C1.TERMS
          FROM (SELECT C.SUPPLIER, C.SUP_NAME, C.SUPPLIER_PARENT, C.TERMS
                  FROM SUPS C) C1,
               (SELECT C.SUPPLIER, C.SUPPLIER_PARENT, C.SUP_NAME FROM SUPS C) C2
         WHERE C1.SUPPLIER_PARENT = C2.SUPPLIER) CS, ---供应商关系

         (
SELECT cc.supplier,cc.status,to_char(cc.brand_code) brand_code FROM (SELECT T1.*,
                               ROW_NUMBER() OVER(PARTITION BY T1.SUPPLIER ORDER BY T1.REV_NO DESC NULLS LAST) RN
                          FROM CMX_CONTRACT T1
                         WHERE nvl(YEAR,2014)=2014) cc WHERE rn=1
UNION ALL
SELECT cc.supplier,cc.status,cc.brand_code FROM (SELECT T1.*,
                               ROW_NUMBER() OVER(PARTITION BY T1.SUPPLIER ORDER BY T1.REV_NO DESC NULLS LAST) RN
                          FROM cmx_contract_mall T1
                         WHERE nvl(YEAR,2014)=2014) cc WHERE rn=1  ) cf  --合同品牌状态
 WHERE CS.SUP2(+) = M.SUPPLIER AND cf.supplier(+)=m.supplier;
 