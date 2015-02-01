/*
�ŵ���룺120124/120094/120165/120010/120011/120028     ��6���ŵ����Ʒ��Ϣ��
��ʽ���£��ŵ���� �ŵ�����  ��Ʒ���� ��Ʒ���� ����ģʽ ��Ӧ�̱��� ��Ӧ������ ������� ����
*/
SELECT ST.STORE �ŵ����,
       ST.STORE_NAME �ŵ�����,
       IM.ITEM ��Ʒ����,
       IM.ITEM_DESC ��Ʒ����,
       (SELECT WL_MODE
          FROM (SELECT A.SUPPLIER,
                       A.LOC,
                       A.ITEM,
                       CCD.CODE || CCD.CODE_DESC WL_MODE
                  FROM RMS.CMX_CODE_DETAIL           CCD,
                       RMS.CMX_ITEM_SUPP_COUNTRY_LOC A
                 WHERE A.LOGISTICS_DELIVERY_MODEL = CCD.CODE
                   AND CCD.CODE_TYPE = 'LDMD') B
         WHERE IL.PRIMARY_SUPP = B.SUPPLIER(+)
           AND IL.LOC = B.LOC(+)
           AND IL.ITEM = B.ITEM(+)) ����ģʽ,
       (select su.supplier || su.sup_name
          from rms.sups su
         where su.supplier(+) = IL.PRIMARY_SUPP) ��Ӧ��,
       SOH.STOCK_ON_HAND �������,
       SOH.AV_COST ����
  FROM RMS.ITEM_MASTER  IM,
       RMS.ITEM_LOC     IL,
       RMS.STORE        ST,
       RMS.ITEM_LOC_SOH SOH
 WHERE IM.ITEM = IL.ITEM
   AND IL.LOC = ST.STORE
   AND IL.ITEM = SOH.ITEM
   AND IL.LOC = SOH.LOC
   AND ST.STORE in
       ('120124', '120094', '120165', '120010', '120011', '120028');
