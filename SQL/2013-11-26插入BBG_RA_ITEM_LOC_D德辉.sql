DECLARE
  CURSOR C_MAIN IS
    SELECT ROWID ROW_ID,
           GOODSID,
           SHOPID,
           TO_DATE(SALEDATE, 'yyyy-mm-dd') SALEDATE,
           BUSINESS_MODE,
           ROW_NUMBER() OVER(PARTITION BY GOODSID, SHOPID ORDER BY GOODSID, SHOPID, SALEDATE) RN,
           (SELECT TP.BUSINESS_MODE
              FROM BUSINESS_MODE1101_TEMP TP
             WHERE TP.GOODSID = T.GOODSID
               AND TP.SHOPID = T.SHOPID
               AND TP.SALEDATE_END IS NULL) LAST_BUSINESS_MODE
      FROM BUSINESS_MODE1101 T; ----�޸ı������ɣ� 
  V_LAST_BUSINESS_MODE BUSINESS_MODE1101.BUSINESS_MODE%TYPE;
BEGIN

  FOR J IN C_MAIN LOOP
    ---����ǵ�һ����¼��1������Դ���ݴ��ڣ�  2���������޸�Դ���ݣ������¼ 3���������򲻻���µ�����  �����¼�¼
    IF J.RN = 1 THEN
      --��һ����¼��
      IF J.LAST_BUSINESS_MODE IS NULL THEN
        -- ��ǰ����ģʽΪ�գ���ֱ�Ӳ����µļ�¼
        INSERT INTO BUSINESS_MODE1101_TEMP
          (GOODSID, SHOPID, BUSINESS_MODE, SALEDATE, SALEDATE_END, ROW_ID)
          SELECT J.GOODSID,
                 J.SHOPID,
                 J.BUSINESS_MODE,
                 J.SALEDATE,
                 NULL,
                 J.ROW_ID
            FROM DUAL;
      
      ELSIF J.LAST_BUSINESS_MODE IS NOT NULL THEN
        ---�����Ϊ�������
        IF J.LAST_BUSINESS_MODE <> J.BUSINESS_MODE THEN
          UPDATE BUSINESS_MODE1101_TEMP TP
             SET TP.SALEDATE_END = J.SALEDATE - (J.SALEDATE - TP.SALEDATE)
           WHERE TP.GOODSID = J.GOODSID
             AND TP.SHOPID = J.SHOPID
             AND TP.SALEDATE_END IS NULL;
        
          INSERT INTO BUSINESS_MODE1101_TEMP
            (GOODSID,
             SHOPID,
             BUSINESS_MODE,
             SALEDATE,
             SALEDATE_END,
             ROW_ID)
            SELECT J.GOODSID,
                   J.SHOPID,
                   J.BUSINESS_MODE,
                   J.SALEDATE,
                   NULL,
                   J.ROW_ID
              FROM DUAL;
        END IF;
      END IF;
    
    ELSE
      IF V_LAST_BUSINESS_MODE != J.BUSINESS_MODE THEN
        --������ǵ�һ��������һ����¼������ģʽ�Ƿ�һ�£�
        UPDATE BUSINESS_MODE1101_TEMP TP
           SET TP.SALEDATE_END = J.SALEDATE - (J.SALEDATE - TP.SALEDATE)
         WHERE TP.GOODSID = J.GOODSID
           AND TP.SHOPID = J.SHOPID
           AND TP.SALEDATE_END IS NULL;
      
        --�����һ��
        INSERT INTO BUSINESS_MODE1101_TEMP
          (GOODSID, SHOPID, BUSINESS_MODE, SALEDATE, SALEDATE_END, ROW_ID)
          SELECT J.GOODSID,
                 J.SHOPID,
                 J.BUSINESS_MODE,
                 J.SALEDATE,
                 NULL,
                 J.ROW_ID
            FROM DUAL;
      END IF;
    
    END IF;
    V_LAST_BUSINESS_MODE := J.BUSINESS_MODE;
  END LOOP;
END;
