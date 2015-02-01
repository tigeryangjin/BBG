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
      FROM BUSINESS_MODE1101 T; ----修改表名即可； 
  V_LAST_BUSINESS_MODE BUSINESS_MODE1101.BUSINESS_MODE%TYPE;
BEGIN

  FOR J IN C_MAIN LOOP
    ---如果是第一条记录。1、查找源数据存在；  2、存在则修改源数据；插入记录 3、不存在则不会更新到数据  插入新记录
    IF J.RN = 1 THEN
      --第一条记录：
      IF J.LAST_BUSINESS_MODE IS NULL THEN
        -- 以前物流模式为空；则直接插入新的记录
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
        ---如果不为空则插入
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
        --如果不是第一条。则看上一条记录的物流模式是否一致；
        UPDATE BUSINESS_MODE1101_TEMP TP
           SET TP.SALEDATE_END = J.SALEDATE - (J.SALEDATE - TP.SALEDATE)
         WHERE TP.GOODSID = J.GOODSID
           AND TP.SHOPID = J.SHOPID
           AND TP.SALEDATE_END IS NULL;
      
        --插入第一条
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
