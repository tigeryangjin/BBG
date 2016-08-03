SELECT TO_CHAR(TDH.TRAN_DATE, 'YYYYMM') ��������,
       TDH.SUBCLASS С��,
       (SELECT SC.SUB_NAME
          FROM RMS.SUBCLASS SC
         WHERE TDH.SUBCLASS = SC.SUBCLASS) С������,
       (SELECT IL.PRIMARY_SUPP
          FROM RMS.ITEM_LOC IL
         WHERE IL.ITEM(+) = TDH.ITEM
           AND IL.LOC(+) = TDH.LOCATION) ��Ӧ�̱���,
       (SELECT su.sup_name
          FROM rms.sups su, RMS.ITEM_LOC IL
         where IL.ITEM(+) = TDH.ITEM
           AND IL.LOC(+) = TDH.LOCATION
           and su.supplier(+) = IL.PRIMARY_SUPP) ��Ӧ������,
       TDH.LOCATION �ŵ����,
       (SELECT S.STORE_NAME FROM STORE S WHERE TDH.LOCATION = S.STORE(+)) �ŵ�����,
       (SELECT DCV.chain_name
          FROM RMS.DISTRICT_CHAIN_V DCV
         WHERE DCV.store(+) = TDH.LOCATION) ҵ̬,
       (SELECT DCV.region_name
          FROM RMS.DISTRICT_CHAIN_V DCV
         WHERE DCV.store(+) = TDH.LOCATION) ����,
       TDH.ITEM ��Ʒ,
       (SELECT IM.ITEM_DESC
          FROM RMS.ITEM_MASTER IM
         WHERE IM.ITEM(+) = TDH.ITEM) ��Ʒ����,
       SUM(TDH.UNITS) ��������,
       SUM(TDH.TOTAL_COST) ���۳ɱ�,
       SUM(TDH.TOTAL_RETAIL) ���۽��,
       SUM(TDH.TOTAL_RETAIL) - SUM(TDH.TOTAL_COST) ë����
  FROM RMS.TRAN_DATA_HISTORY TDH
 WHERE TDH.TRAN_DATE BETWEEN :BDATE AND :EDATE
   AND TDH.TRAN_CODE IN (1, 3)
   AND TDH.CLASS = 215
 GROUP BY TDH.ITEM,
          TDH.SUBCLASS,
          TDH.LOCATION,
          TO_CHAR(TDH.TRAN_DATE, 'YYYYMM')
 ORDER BY TO_CHAR(TDH.TRAN_DATE, 'YYYYMM'), TDH.LOCATION, TDH.ITEM
