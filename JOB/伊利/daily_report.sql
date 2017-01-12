SELECT TDH.TRAN_DATE ��������,
       TDH.LY_TRAN_DATE ȥ��ͬ������,
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
       TDH.UNITS ��������,
       TDH.TOTAL_COST ���۳ɱ�,
       TDH.TOTAL_RETAIL ���۽��,
       TDH.TOTAL_RETAIL - TDH.TOTAL_COST ë����,
       TDH.LY_UNITS ȥ����������,
       TDH.LY_TOTAL_COST ȥ�����۳ɱ�,
       TDH.LY_TOTAL_RETAIL ȥ�����۽��,
       TDH.LY_TOTAL_RETAIL - TDH.LY_TOTAL_COST ȥ��ë����
  FROM (SELECT T.TRAN_DATE TRAN_DATE,
               NVL(L.TRAN_DATE, :TODAY - 366) LY_TRAN_DATE,
               T.SUBCLASS,
               T.ITEM,
               T.LOCATION,
               T.UNITS,
               T.TOTAL_COST,
               T.TOTAL_RETAIL,
               NVL(L.UNITS, 0) LY_UNITS,
               NVL(L.TOTAL_COST, 0) LY_TOTAL_COST,
               NVL(L.TOTAL_RETAIL, 0) LY_TOTAL_RETAIL
          FROM (SELECT TDH.TRAN_DATE,
                       TDH.SUBCLASS,
                       TDH.ITEM,
                       TDH.LOCATION,
                       SUM(TDH.UNITS) UNITS,
                       SUM(TDH.TOTAL_COST) TOTAL_COST,
                       SUM(TDH.TOTAL_RETAIL) TOTAL_RETAIL
                  FROM RMS.TRAN_DATA_HISTORY TDH
                 WHERE TDH.TRAN_DATE = :TODAY
                   AND EXISTS (SELECT 1
                          FROM uda_item_lov UIL
                         WHERE UIL.UDA_ID = 3
                           AND UIL.UDA_VALUE IN (5057, 8430)
                           AND TDH.ITEM = UIL.ITEM)
                   AND TDH.TRAN_CODE IN (1, 3)
                   AND TDH.CLASS = 215
                 GROUP BY TDH.TRAN_DATE, TDH.ITEM, TDH.LOCATION, TDH.SUBCLASS) T,
               (SELECT TDH.TRAN_DATE,
                       TDH.SUBCLASS,
                       TDH.ITEM,
                       TDH.LOCATION,
                       SUM(TDH.UNITS) UNITS,
                       SUM(TDH.TOTAL_COST) TOTAL_COST,
                       SUM(TDH.TOTAL_RETAIL) TOTAL_RETAIL
                  FROM TRAN_DATA_HISTORY TDH /*TRAN_DATA_HISTORY@RTKHIST*/
                 WHERE TDH.TRAN_DATE = :TODAY - 366
                   AND EXISTS (SELECT 1
                          FROM uda_item_lov UIL
                         WHERE UIL.UDA_ID = 3
                           AND UIL.UDA_VALUE IN (5057, 8430)
                           AND TDH.ITEM = UIL.ITEM)
                   AND TDH.TRAN_CODE IN (1, 3)
                   AND TDH.CLASS = 215
                 GROUP BY TDH.TRAN_DATE, TDH.ITEM, TDH.LOCATION, TDH.SUBCLASS) L
         WHERE T.ITEM = L.ITEM(+)
           AND T.LOCATION = L.LOCATION(+)
        UNION
		/*ȥ�������۶�����û������*/
        SELECT L.TRAN_DATE + 366 TRAN_DATE,
               NVL(L.TRAN_DATE, :TODAY - 366) LY_TRAN_DATE,
               L.SUBCLASS,
               L.ITEM,
               L.LOCATION,
               NVL(T.UNITS, 0) UNITS,
               NVL(T.TOTAL_COST, 0) TOTAL_COST,
               NVL(T.TOTAL_RETAIL, 0) TOTAL_RETAIL,
               L.UNITS LY_UNITS,
               L.TOTAL_COST LY_TOTAL_COST,
               L.TOTAL_RETAIL LY_TOTAL_RETAIL
          FROM (SELECT TDH.TRAN_DATE,
                       TDH.SUBCLASS,
                       TDH.ITEM,
                       TDH.LOCATION,
                       SUM(TDH.UNITS) UNITS,
                       SUM(TDH.TOTAL_COST) TOTAL_COST,
                       SUM(TDH.TOTAL_RETAIL) TOTAL_RETAIL
                  FROM RMS.TRAN_DATA_HISTORY TDH
                 WHERE TDH.TRAN_DATE = :TODAY
                   AND EXISTS (SELECT 1
                          FROM uda_item_lov UIL
                         WHERE UIL.UDA_ID = 3
                           AND UIL.UDA_VALUE IN (5057, 8430)
                           AND TDH.ITEM = UIL.ITEM)
                   AND TDH.TRAN_CODE IN (1, 3)
                   AND TDH.CLASS = 215
                 GROUP BY TDH.TRAN_DATE, TDH.ITEM, TDH.LOCATION, TDH.SUBCLASS) T,
               (SELECT TDH.TRAN_DATE,
                       TDH.SUBCLASS,
                       TDH.ITEM,
                       TDH.LOCATION,
                       SUM(TDH.UNITS) UNITS,
                       SUM(TDH.TOTAL_COST) TOTAL_COST,
                       SUM(TDH.TOTAL_RETAIL) TOTAL_RETAIL
                  FROM TRAN_DATA_HISTORY TDH /*TRAN_DATA_HISTORY@RTKHIST*/
                 WHERE TDH.TRAN_DATE = :TODAY - 366
                   AND EXISTS (SELECT 1
                          FROM uda_item_lov UIL
                         WHERE UIL.UDA_ID = 3
                           AND UIL.UDA_VALUE IN (5057, 8430)
                           AND TDH.ITEM = UIL.ITEM)
                   AND TDH.TRAN_CODE IN (1, 3)
                   AND TDH.CLASS = 215
                 GROUP BY TDH.TRAN_DATE, TDH.ITEM, TDH.LOCATION, TDH.SUBCLASS) L
         WHERE T.ITEM(+) = L.ITEM
           AND T.LOCATION(+) = L.LOCATION) TDH
 ORDER BY TDH.TRAN_DATE, TDH.LOCATION, TDH.ITEM
