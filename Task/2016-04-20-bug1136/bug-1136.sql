--1.会员卡号、姓名、手机号码、消费金额、消费频次
--2016.1.1~2016.3.31 累计购买进口食品金额300元以上或购买频次6次以上
SELECT A.VIP_NO,
       (select max(sv.会员编号)
          from BBG_GET_CS_HYCX@RMS_RA sv
         where sv.会员卡号 = a.VIP_NO) 会员编号,
       (select max(sv.会员姓名)
          from BBG_GET_CS_HYCX@RMS_RA sv
         where sv.会员卡号 = a.VIP_NO) 会员姓名,
       COUNT(DISTINCT A.TRAN_SEQ_NO) TRAN_CNT,
       SUM(A.TOTAL_RETAIL) TOTAL_RETAIL
  FROM (SELECT H.TRAN_SEQ_NO,
               H.REF_NO27 VIP_NO,
               SUM(NVL(STI.QTY, 0) * NVL(STI.UNIT_RETAIL, 0) -
                   NVL(DISC.DISC_AMT, 0)) TOTAL_RETAIL
          FROM SA_TRAN_ITEM STI,
               SA_TRAN_HEAD H,
               SA_STORE_DAY D,
               (SELECT TRAN_SEQ_NO,
                       ITEM_SEQ_NO,
                       STORE,
                       DAY,
                       SUM(NVL(STD.QTY, 0) * NVL(STD.UNIT_DISCOUNT_AMT, 0)) DISC_AMT
                  FROM SA_TRAN_DISC STD
                 GROUP BY TRAN_SEQ_NO, ITEM_SEQ_NO, STORE, DAY) DISC
         WHERE STI.TRAN_SEQ_NO = H.TRAN_SEQ_NO
           AND STI.STORE = H.STORE
           AND STI.DAY = H.DAY
           AND H.STORE_DAY_SEQ_NO = D.STORE_DAY_SEQ_NO
           AND D.BUSINESS_DATE BETWEEN &BEGIN_DATE AND &END_DATE
           AND STI.TRAN_SEQ_NO = DISC.TRAN_SEQ_NO(+)
           AND STI.ITEM_SEQ_NO = DISC.ITEM_SEQ_NO(+)
           AND STI.STORE = DISC.STORE(+)
           AND STI.DAY = DISC.DAY(+)
              --UDA:进口食品
           AND EXISTS (SELECT 1
                  FROM UDA_ITEM_LOV UIL
                 WHERE UIL.UDA_ID = 14
                   AND UIL.UDA_VALUE = 1
                   AND UIL.ITEM = STI.ITEM)
              --会员卡号
           AND H.REF_NO27 IS NOT NULL
         GROUP BY H.REF_NO27, H.TRAN_SEQ_NO) A
HAVING COUNT(DISTINCT A.TRAN_SEQ_NO) >= 6 OR SUM(A.TOTAL_RETAIL) >= 300
 GROUP BY A.VIP_NO;

--2.会员卡号、姓名、手机号码、消费金额、消费频次
--2016.3.1~2016.3.31 累计购买进口食品金额100元以上或购买频次2次以上
SELECT A.VIP_NO,
       (select max(sv.会员编号)
          from BBG_GET_CS_HYCX@RMS_RA sv
         where sv.会员卡号 = a.VIP_NO) 会员编号,
       (select max(sv.会员姓名)
          from BBG_GET_CS_HYCX@RMS_RA sv
         where sv.会员卡号 = a.VIP_NO) 会员姓名,
       COUNT(DISTINCT A.TRAN_SEQ_NO) TRAN_CNT,
       SUM(A.TOTAL_RETAIL) TOTAL_RETAIL
  FROM (SELECT H.TRAN_SEQ_NO,
               H.REF_NO27 VIP_NO,
               SUM(NVL(STI.QTY, 0) * NVL(STI.UNIT_RETAIL, 0) -
                   NVL(DISC.DISC_AMT, 0)) TOTAL_RETAIL
          FROM SA_TRAN_ITEM STI,
               SA_TRAN_HEAD H,
               SA_STORE_DAY D,
               (SELECT TRAN_SEQ_NO,
                       ITEM_SEQ_NO,
                       STORE,
                       DAY,
                       SUM(NVL(STD.QTY, 0) * NVL(STD.UNIT_DISCOUNT_AMT, 0)) DISC_AMT
                  FROM SA_TRAN_DISC STD
                 GROUP BY TRAN_SEQ_NO, ITEM_SEQ_NO, STORE, DAY) DISC
         WHERE STI.TRAN_SEQ_NO = H.TRAN_SEQ_NO
           AND STI.STORE = H.STORE
           AND STI.DAY = H.DAY
           AND H.STORE_DAY_SEQ_NO = D.STORE_DAY_SEQ_NO
           AND D.BUSINESS_DATE BETWEEN &BEGIN_DATE AND &END_DATE
           AND STI.TRAN_SEQ_NO = DISC.TRAN_SEQ_NO(+)
           AND STI.ITEM_SEQ_NO = DISC.ITEM_SEQ_NO(+)
           AND STI.STORE = DISC.STORE(+)
           AND STI.DAY = DISC.DAY(+)
              --UDA:进口食品
           AND EXISTS (SELECT 1
                  FROM UDA_ITEM_LOV UIL
                 WHERE UIL.UDA_ID = 14
                   AND UIL.UDA_VALUE = 1
                   AND UIL.ITEM = STI.ITEM)
              --会员卡号
           AND H.REF_NO27 IS NOT NULL
         GROUP BY H.REF_NO27, H.TRAN_SEQ_NO) A
HAVING COUNT(DISTINCT A.TRAN_SEQ_NO) >= 2 OR SUM(A.TOTAL_RETAIL) >= 100
 GROUP BY A.VIP_NO;

--3.RA中出

--4.会员销售年龄层
--2016.1.1~2016.3.31
--RMS
CREATE TABLE YJ_BUG1136_4 AS
  SELECT /*+PARALLEL(16)*/
   H.REF_NO27 VIP_NO,
   STI.SUBCLASS,
   SUM(NVL(STI.QTY, 0) * NVL(STI.UNIT_RETAIL, 0) - NVL(DISC.DISC_AMT, 0)) TOTAL_RETAIL
    FROM SA_TRAN_ITEM STI,
         SA_TRAN_HEAD H,
         SA_STORE_DAY D,
         (SELECT TRAN_SEQ_NO,
                 ITEM_SEQ_NO,
                 STORE,
                 DAY,
                 SUM(NVL(STD.QTY, 0) * NVL(STD.UNIT_DISCOUNT_AMT, 0)) DISC_AMT
            FROM SA_TRAN_DISC STD
           GROUP BY TRAN_SEQ_NO, ITEM_SEQ_NO, STORE, DAY) DISC
   WHERE STI.TRAN_SEQ_NO = H.TRAN_SEQ_NO
     AND STI.STORE = H.STORE
     AND STI.DAY = H.DAY
     AND H.STORE_DAY_SEQ_NO = D.STORE_DAY_SEQ_NO
     AND D.BUSINESS_DATE BETWEEN &BEGIN_DATE AND &END_DATE
     AND STI.TRAN_SEQ_NO = DISC.TRAN_SEQ_NO(+)
     AND STI.ITEM_SEQ_NO = DISC.ITEM_SEQ_NO(+)
     AND STI.STORE = DISC.STORE(+)
     AND STI.DAY = DISC.DAY(+)
        --UDA:进口食品
     AND EXISTS (SELECT 1
            FROM UDA_ITEM_LOV UIL
           WHERE UIL.UDA_ID = 14
             AND UIL.UDA_VALUE = 1
             AND UIL.ITEM = STI.ITEM)
        --会员卡号
     AND H.REF_NO27 IS NOT NULL
   GROUP BY H.REF_NO27, STI.SUBCLASS;

DROP TABLE RMS.YJ_BUG1136_4;

--RA
create table radm.YJ_BUG1136_4 as
  SELECT * FROM RMS.YJ_BUG1136_4@RA_RMS_DBLINK;

drop table radm.YJ_BUG1136_4;

--小类编码、购买人数、消费金额
--163388张会员卡号，3805张没有出生日期
-- <=20,21-30,31-40,41-50,51-60,>=61
select d.subclass,
       sum(nvl(d.vip_count_20, 0)) vip_count_20,
       sum(nvl(d.total_retail_20, 0)) total_retail_20,
       sum(nvl(d.vip_count_21_30, 0)) vip_count_21_30,
       sum(nvl(d.total_retail_21_30, 0)) total_retail_21_30,
       
       sum(nvl(d.vip_count_31_40, 0)) vip_count_31_40,
       sum(nvl(d.total_retail_31_40, 0)) total_retail_31_40,
       sum(nvl(d.vip_count_41_50, 0)) vip_count_41_50,
       sum(nvl(d.total_retail_41_50, 0)) total_retail_41_50,
       sum(nvl(d.vip_count_51_60, 0)) vip_count_51_60,
       sum(nvl(d.total_retail_51_60, 0)) total_retail_51_60,
       sum(nvl(d.vip_count_61, 0)) vip_count_61,
       sum(nvl(d.total_retail_61, 0)) total_retail_61
  from (select
        --<=20
         c.subclass,
         case
           when c.age <= 20 then
            count(c.vip_id)
         end vip_count_20,
         case
           when c.age <= 20 then
            sum(c.total_retail)
         end total_retail_20,
         --21-30
         case
           when c.age >= 21 and c.age <= 30 then
            count(c.vip_id)
         end vip_count_21_30,
         case
           when c.age >= 21 and c.age <= 30 then
            sum(c.total_retail)
         end total_retail_21_30,
         --31-40
         case
           when c.age >= 31 and c.age <= 40 then
            count(c.vip_id)
         end vip_count_31_40,
         case
           when c.age >= 31 and c.age <= 40 then
            sum(c.total_retail)
         end total_retail_31_40,
         --41-50
         case
           when c.age >= 41 and c.age <= 50 then
            count(c.vip_id)
         end vip_count_41_50,
         case
           when c.age >= 41 and c.age <= 50 then
            sum(c.total_retail)
         end total_retail_41_50,
         --51-60
         case
           when c.age >= 51 and c.age <= 60 then
            count(c.vip_id)
         end vip_count_51_60,
         case
           when c.age >= 51 and c.age <= 60 then
            sum(c.total_retail)
         end total_retail_51_60,
         -->=61
         case
           when c.age >= 61 then
            count(c.vip_id)
         end vip_count_61,
         case
           when c.age >= 61 then
            sum(c.total_retail)
         end total_retail_61
          from (select a.subclass,
                       a.total_retail,
                       b.会员编号 vip_id,
                       --如果没有出生日期，则默认为出生日期为:1980-01-01,
                       round((trunc(sysdate) -
                             nvl(b.出生日期, date '1980-01-01')) / 365,
                             0) age
                  from radm.YJ_BUG1136_4 a, BBG_GET_CS_HYCX b
                 where a.vip_no = b.会员卡号(+)) c
         group by c.subclass, c.age) d
 group by d.subclass
 order by d.subclass;

--5.会员卡号、姓名、手机号码、累计消费金额、销售频次
--单笔购买卡士酸奶25元以上，2016.1.1~3.31
SELECT A.VIP_NO,
       (select max(sv.会员编号)
          from BBG_GET_CS_HYCX@RMS_RA sv
         where sv.会员卡号 = a.VIP_NO) 会员编号,
       (select max(sv.会员姓名)
          from BBG_GET_CS_HYCX@RMS_RA sv
         where sv.会员卡号 = a.VIP_NO) 会员姓名,
       COUNT(DISTINCT A.TRAN_SEQ_NO) TRAN_CNT,
       SUM(A.TOTAL_RETAIL) TOTAL_RETAIL
  FROM (SELECT H.TRAN_SEQ_NO,
               H.REF_NO27 VIP_NO,
               SUM(NVL(STI.QTY, 0) * NVL(STI.UNIT_RETAIL, 0) -
                   NVL(DISC.DISC_AMT, 0)) TOTAL_RETAIL
          FROM SA_TRAN_ITEM STI,
               SA_TRAN_HEAD H,
               SA_STORE_DAY D,
               (SELECT TRAN_SEQ_NO,
                       ITEM_SEQ_NO,
                       STORE,
                       DAY,
                       SUM(NVL(STD.QTY, 0) * NVL(STD.UNIT_DISCOUNT_AMT, 0)) DISC_AMT
                  FROM SA_TRAN_DISC STD
                 GROUP BY TRAN_SEQ_NO, ITEM_SEQ_NO, STORE, DAY) DISC
         WHERE STI.TRAN_SEQ_NO = H.TRAN_SEQ_NO
           AND STI.STORE = H.STORE
           AND STI.DAY = H.DAY
           AND H.STORE_DAY_SEQ_NO = D.STORE_DAY_SEQ_NO
           AND D.BUSINESS_DATE BETWEEN &BEGIN_DATE AND &END_DATE
           AND STI.TRAN_SEQ_NO = DISC.TRAN_SEQ_NO(+)
           AND STI.ITEM_SEQ_NO = DISC.ITEM_SEQ_NO(+)
           AND STI.STORE = DISC.STORE(+)
           AND STI.DAY = DISC.DAY(+)
              --卡士酸奶
           AND EXISTS (SELECT 1
                  FROM UDA_ITEM_LOV UIL
                 WHERE UIL.UDA_ID = 3
                   AND UIL.UDA_VALUE = 3906
                   AND UIL.ITEM = STI.ITEM)
              --会员卡号
           AND H.REF_NO27 IS NOT NULL
         GROUP BY H.REF_NO27, H.TRAN_SEQ_NO) A
--单笔购买25元以上
 WHERE A.TOTAL_RETAIL >= 25
 GROUP BY A.VIP_NO;

--6.会员卡号、姓名、手机号码、累计消费金额、销售频次
--单笔购买桶装水30元以上，2016.1.1~3.31
SELECT A.VIP_NO,
       (select max(sv.会员编号)
          from BBG_GET_CS_HYCX@RMS_RA sv
         where sv.会员卡号 = a.VIP_NO) 会员编号,
       (select max(sv.会员姓名)
          from BBG_GET_CS_HYCX@RMS_RA sv
         where sv.会员卡号 = a.VIP_NO) 会员姓名,
       COUNT(DISTINCT A.TRAN_SEQ_NO) TRAN_CNT,
       SUM(A.TOTAL_RETAIL) TOTAL_RETAIL
  FROM (SELECT H.TRAN_SEQ_NO,
               H.REF_NO27 VIP_NO,
               SUM(NVL(STI.QTY, 0) * NVL(STI.UNIT_RETAIL, 0) -
                   NVL(DISC.DISC_AMT, 0)) TOTAL_RETAIL
          FROM SA_TRAN_ITEM STI,
               SA_TRAN_HEAD H,
               SA_STORE_DAY D,
               (SELECT TRAN_SEQ_NO,
                       ITEM_SEQ_NO,
                       STORE,
                       DAY,
                       SUM(NVL(STD.QTY, 0) * NVL(STD.UNIT_DISCOUNT_AMT, 0)) DISC_AMT
                  FROM SA_TRAN_DISC STD
                 GROUP BY TRAN_SEQ_NO, ITEM_SEQ_NO, STORE, DAY) DISC
         WHERE STI.TRAN_SEQ_NO = H.TRAN_SEQ_NO
           AND STI.STORE = H.STORE
           AND STI.DAY = H.DAY
           AND H.STORE_DAY_SEQ_NO = D.STORE_DAY_SEQ_NO
           AND D.BUSINESS_DATE BETWEEN &BEGIN_DATE AND &END_DATE
           AND STI.TRAN_SEQ_NO = DISC.TRAN_SEQ_NO(+)
           AND STI.ITEM_SEQ_NO = DISC.ITEM_SEQ_NO(+)
           AND STI.STORE = DISC.STORE(+)
           AND STI.DAY = DISC.DAY(+)
              --桶装水
           AND STI.ITEM IN ('101952887',
                            '102316196',
                            '800107135',
                            '800236914',
                            '800084424')
              --会员卡号
           AND H.REF_NO27 IS NOT NULL
         GROUP BY H.REF_NO27, H.TRAN_SEQ_NO) A
--单笔购买30元以上
 WHERE A.TOTAL_RETAIL >= 30
 GROUP BY A.VIP_NO;

--7.会员卡号、姓名、手机号码、累计消费金额、销售频次
--单笔购买进口红酒200元以上，2016.1.1~3.31
SELECT A.VIP_NO,
       (select max(sv.会员编号)
          from BBG_GET_CS_HYCX@RMS_RA sv
         where sv.会员卡号 = a.VIP_NO) 会员编号,
       (select max(sv.会员姓名)
          from BBG_GET_CS_HYCX@RMS_RA sv
         where sv.会员卡号 = a.VIP_NO) 会员姓名,
       COUNT(DISTINCT A.TRAN_SEQ_NO) TRAN_CNT,
       SUM(A.TOTAL_RETAIL) TOTAL_RETAIL
  FROM (SELECT H.TRAN_SEQ_NO,
               H.REF_NO27 VIP_NO,
               SUM(NVL(STI.QTY, 0) * NVL(STI.UNIT_RETAIL, 0) -
                   NVL(DISC.DISC_AMT, 0)) TOTAL_RETAIL
          FROM SA_TRAN_ITEM STI,
               SA_TRAN_HEAD H,
               SA_STORE_DAY D,
               (SELECT TRAN_SEQ_NO,
                       ITEM_SEQ_NO,
                       STORE,
                       DAY,
                       SUM(NVL(STD.QTY, 0) * NVL(STD.UNIT_DISCOUNT_AMT, 0)) DISC_AMT
                  FROM SA_TRAN_DISC STD
                 GROUP BY TRAN_SEQ_NO, ITEM_SEQ_NO, STORE, DAY) DISC
         WHERE STI.TRAN_SEQ_NO = H.TRAN_SEQ_NO
           AND STI.STORE = H.STORE
           AND STI.DAY = H.DAY
           AND H.STORE_DAY_SEQ_NO = D.STORE_DAY_SEQ_NO
           AND D.BUSINESS_DATE BETWEEN &BEGIN_DATE AND &END_DATE
           AND STI.TRAN_SEQ_NO = DISC.TRAN_SEQ_NO(+)
           AND STI.ITEM_SEQ_NO = DISC.ITEM_SEQ_NO(+)
           AND STI.STORE = DISC.STORE(+)
           AND STI.DAY = DISC.DAY(+)
              --进口红酒
           AND STI.ITEM IN ('100142858',
                            '100142882',
                            '100363757',
                            '100723732',
                            '100723783',
                            '100723791',
                            '100724137',
                            '100724241',
                            '100755953',
                            '100755996',
                            '100756032',
                            '100758345',
                            '100758417',
                            '100759111',
                            '100759153',
                            '100759217',
                            '100759233',
                            '100759276',
                            '100759292',
                            '100759313',
                            '101328371',
                            '101328401',
                            '101328435',
                            '101328460',
                            '101328494',
                            '101328515',
                            '101328531',
                            '101328558',
                            '101328574',
                            '101328603',
                            '101328620',
                            '101328646',
                            '101703961',
                            '101824800',
                            '101838945',
                            '101838961',
                            '101838988',
                            '101839008',
                            '101920519',
                            '101920535',
                            '101920551',
                            '101920578',
                            '101920594',
                            '101920631',
                            '101920658',
                            '101920674',
                            '101920691',
                            '102007879',
                            '102139521',
                            '102613115',
                            '102613131',
                            '102613158',
                            '102613174',
                            '102613191',
                            '102613211',
                            '102613238',
                            '102613254',
                            '102613297',
                            '102613326',
                            '102613342',
                            '102613369',
                            '102613385',
                            '102613406',
                            '102616244',
                            '102616261',
                            '102616287',
                            '102631401',
                            '102631444',
                            '102631461',
                            '102631487',
                            '102631516',
                            '102631532',
                            '102631559',
                            '102631583',
                            '102631639',
                            '102631698',
                            '102760086',
                            '102760140',
                            '102800640',
                            '102800711',
                            '102800746',
                            '102800762',
                            '102800789',
                            '102800800',
                            '102800826',
                            '102800842',
                            '102800869',
                            '102833311',
                            '102833337',
                            '102886404',
                            '102886421',
                            '102886447',
                            '102886463',
                            '102886480',
                            '102979838',
                            '102979862',
                            '102979889',
                            '102979900',
                            '102979926',
                            '102979942',
                            '102979969',
                            '102979985',
                            '102980011',
                            '102980038',
                            '102980062',
                            '700007424',
                            '700007425',
                            '700007426',
                            '700007427',
                            '700007428',
                            '700007429',
                            '700007430',
                            '700007431',
                            '700007432',
                            '800019471',
                            '800019775',
                            '800019783',
                            '800019835',
                            '800020071',
                            '800020076',
                            '800020948',
                            '800021583',
                            '800184732',
                            '800184733',
                            '800184734',
                            '800184735',
                            '800184736',
                            '800203955',
                            '800203956',
                            '800203957',
                            '800207301',
                            '800207302',
                            '800207303',
                            '800209408',
                            '800209409',
                            '800209410',
                            '800209411',
                            '800209412',
                            '800209413',
                            '800209414',
                            '800209415',
                            '800209416',
                            '800209417',
                            '800209418',
                            '800209419',
                            '800209420',
                            '800209421',
                            '800209422',
                            '800209423',
                            '800209424',
                            '800209425',
                            '800209426',
                            '800209427',
                            '800209428',
                            '800209429',
                            '800209430',
                            '800209431',
                            '800209432',
                            '800209433',
                            '800209434',
                            '800209435',
                            '800209957',
                            '800209958',
                            '800209959',
                            '800209960',
                            '800209961',
                            '800209962',
                            '800209963',
                            '800209964',
                            '800209965',
                            '800209966',
                            '800209967',
                            '800209968',
                            '800209969',
                            '800209972',
                            '800209973',
                            '800209974',
                            '800209975',
                            '800209976',
                            '800209977',
                            '800209978',
                            '800209979',
                            '800210002',
                            '800212349',
                            '800231571',
                            '800231572',
                            '800231575',
                            '800231576',
                            '800231577',
                            '800231578',
                            '800231580',
                            '800231581',
                            '800231582',
                            '800231583',
                            '800231584',
                            '800231585',
                            '800231586',
                            '800231587',
                            '800231588',
                            '800231589',
                            '800231590',
                            '800235281',
                            '800235282',
                            '800235283',
                            '800235284',
                            '800235285',
                            '800235286',
                            '800235287',
                            '800235288',
                            '800235289',
                            '800235290',
                            '800235291',
                            '800235292',
                            '800235294',
                            '800235295',
                            '800235296',
                            '800235297',
                            '800235298',
                            '800235299',
                            '800248671',
                            '800249488',
                            '800249489',
                            '800309375',
                            '800309376',
                            '800309377',
                            '800321883',
                            '800321884',
                            '800321885',
                            '800321886',
                            '800321887',
                            '800322544',
                            '800326405',
                            '800333732',
                            '800333733',
                            '800335513',
                            '800335514',
                            '800335515',
                            '800335516',
                            '800335517',
                            '800335518',
                            '800335519',
                            '800335520',
                            '800335521',
                            '800335522',
                            '800335523',
                            '800335524',
                            '800335525',
                            '800335526',
                            '800335527',
                            '800335528',
                            '800335529',
                            '800335530',
                            '800335531',
                            '800335532',
                            '800335533',
                            '800335534',
                            '800335535',
                            '800335536',
                            '800335537',
                            '800335538',
                            '800335539',
                            '800335540',
                            '800335541',
                            '800335542',
                            '800335543',
                            '800335544',
                            '800335545',
                            '800335546',
                            '800335547',
                            '800335548',
                            '800335549',
                            '800335550',
                            '800335551',
                            '800335552',
                            '800335553',
                            '800335554',
                            '800335555',
                            '800335556',
                            '800335557',
                            '800335558',
                            '800335559',
                            '800335560',
                            '800335561',
                            '800335562',
                            '800335563',
                            '800335564',
                            '800335565',
                            '800335597',
                            '800335598',
                            '800335599',
                            '800335600',
                            '800335601',
                            '800335602',
                            '800335603',
                            '800341744',
                            '800341745',
                            '800345773',
                            '800347930',
                            '800347931',
                            '800347932',
                            '800347934',
                            '800347936',
                            '800347937',
                            '800347940',
                            '800347941',
                            '800347942',
                            '800347943',
                            '800347944',
                            '800347946',
                            '800347947',
                            '800371895',
                            '800371896',
                            '800371897',
                            '800371898',
                            '800376802',
                            '800376803',
                            '800376804',
                            '800376805',
                            '800376806',
                            '800376807',
                            '800376808',
                            '800376809',
                            '800376810',
                            '800376811',
                            '800376812',
                            '800376813',
                            '800376814',
                            '800376815',
                            '800376816',
                            '800376817',
                            '800382117',
                            '800382118',
                            '800382119',
                            '800382120',
                            '800385910',
                            '800385911',
                            '800385912',
                            '800385913',
                            '800385914',
                            '800385915',
                            '800385916',
                            '800385917',
                            '800385919',
                            '800385920',
                            '800385921',
                            '800385926',
                            '800385927',
                            '800385928',
                            '800385929',
                            '800385930',
                            '800385931',
                            '800385932',
                            '800385933',
                            '800386036',
                            '800392407',
                            '800403766',
                            '800403767',
                            '800403768',
                            '800403769',
                            '800403770',
                            '800403771',
                            '800403772',
                            '800403773',
                            '800403774',
                            '800403775',
                            '800403776',
                            '800403777',
                            '800403778',
                            '800403779',
                            '800403780',
                            '800403781',
                            '800406666',
                            '800406667',
                            '800406668',
                            '800406669',
                            '800406670',
                            '800406671',
                            '800406672',
                            '800406673',
                            '800406674',
                            '800406675',
                            '800406676',
                            '800406677',
                            '800406678',
                            '800406679',
                            '800406680',
                            '800406681',
                            '800406682',
                            '800406683',
                            '800406684',
                            '800406685',
                            '800406686',
                            '800406687',
                            '800406688',
                            '800406689',
                            '800406690',
                            '800406691',
                            '800406692',
                            '800406693',
                            '800406694',
                            '800406695',
                            '800406696',
                            '800406697',
                            '800406698',
                            '800406699',
                            '800406700',
                            '800406701',
                            '800406702',
                            '800406703',
                            '800406704',
                            '800406705',
                            '800406706',
                            '800406707',
                            '800406708',
                            '800406709',
                            '800406710',
                            '800406711',
                            '800406712',
                            '800406713',
                            '800406714',
                            '800406715',
                            '800406716',
                            '800406717',
                            '800406718',
                            '800406719',
                            '800406720',
                            '800406721',
                            '800406722',
                            '800411348',
                            '800411349',
                            '800411350',
                            '800411351',
                            '800411352',
                            '800411353',
                            '800411354',
                            '800411355',
                            '800414763',
                            '800414764',
                            '800414765',
                            '800414767')
              --会员卡号
           AND H.REF_NO27 IS NOT NULL
         GROUP BY H.REF_NO27, H.TRAN_SEQ_NO) A
--单笔购买200元以上
 WHERE A.TOTAL_RETAIL >= 200
 GROUP BY A.VIP_NO;

--8.会员卡号、姓名、手机号码、累计消费金额、销售频次
--单笔购买沙宣洗护产品100元以上，2016.1.1~3.31
SELECT A.VIP_NO,
       (select max(sv.会员编号)
          from BBG_GET_CS_HYCX@RMS_RA sv
         where sv.会员卡号 = a.VIP_NO) 会员编号,
       (select max(sv.会员姓名)
          from BBG_GET_CS_HYCX@RMS_RA sv
         where sv.会员卡号 = a.VIP_NO) 会员姓名,
       COUNT(DISTINCT A.TRAN_SEQ_NO) TRAN_CNT,
       SUM(A.TOTAL_RETAIL) TOTAL_RETAIL
  FROM (SELECT H.TRAN_SEQ_NO,
               H.REF_NO27 VIP_NO,
               SUM(NVL(STI.QTY, 0) * NVL(STI.UNIT_RETAIL, 0) -
                   NVL(DISC.DISC_AMT, 0)) TOTAL_RETAIL
          FROM SA_TRAN_ITEM STI,
               SA_TRAN_HEAD H,
               SA_STORE_DAY D,
               (SELECT TRAN_SEQ_NO,
                       ITEM_SEQ_NO,
                       STORE,
                       DAY,
                       SUM(NVL(STD.QTY, 0) * NVL(STD.UNIT_DISCOUNT_AMT, 0)) DISC_AMT
                  FROM SA_TRAN_DISC STD
                 GROUP BY TRAN_SEQ_NO, ITEM_SEQ_NO, STORE, DAY) DISC
         WHERE STI.TRAN_SEQ_NO = H.TRAN_SEQ_NO
           AND STI.STORE = H.STORE
           AND STI.DAY = H.DAY
           AND H.STORE_DAY_SEQ_NO = D.STORE_DAY_SEQ_NO
           AND D.BUSINESS_DATE BETWEEN &BEGIN_DATE AND &END_DATE
           AND STI.TRAN_SEQ_NO = DISC.TRAN_SEQ_NO(+)
           AND STI.ITEM_SEQ_NO = DISC.ITEM_SEQ_NO(+)
           AND STI.STORE = DISC.STORE(+)
           AND STI.DAY = DISC.DAY(+)
              --沙宣洗护
           AND EXISTS (SELECT 1
                  FROM UDA_ITEM_LOV UIL
                 WHERE UIL.UDA_ID = 3
                   AND UIL.UDA_VALUE = 6174
                   AND UIL.ITEM = STI.ITEM)
              --会员卡号
           AND H.REF_NO27 IS NOT NULL
         GROUP BY H.REF_NO27, H.TRAN_SEQ_NO) A
--单笔购买100元以上
 WHERE A.TOTAL_RETAIL >= 100
 GROUP BY A.VIP_NO;

--9.会员卡号、姓名、手机号码、累计消费金额、销售频次
--单笔购买水果60元以上，2016.1.1~3.31
SELECT A.VIP_NO,
       (select max(sv.会员编号)
          from BBG_GET_CS_HYCX@RMS_RA sv
         where sv.会员卡号 = a.VIP_NO) 会员编号,
       (select max(sv.会员姓名)
          from BBG_GET_CS_HYCX@RMS_RA sv
         where sv.会员卡号 = a.VIP_NO) 会员姓名,
       COUNT(DISTINCT A.TRAN_SEQ_NO) TRAN_CNT,
       SUM(A.TOTAL_RETAIL) TOTAL_RETAIL
  FROM (SELECT H.TRAN_SEQ_NO,
               H.REF_NO27 VIP_NO,
               SUM(NVL(STI.QTY, 0) * NVL(STI.UNIT_RETAIL, 0) -
                   NVL(DISC.DISC_AMT, 0)) TOTAL_RETAIL
          FROM SA_TRAN_ITEM STI,
               SA_TRAN_HEAD H,
               SA_STORE_DAY D,
               (SELECT TRAN_SEQ_NO,
                       ITEM_SEQ_NO,
                       STORE,
                       DAY,
                       SUM(NVL(STD.QTY, 0) * NVL(STD.UNIT_DISCOUNT_AMT, 0)) DISC_AMT
                  FROM SA_TRAN_DISC STD
                 GROUP BY TRAN_SEQ_NO, ITEM_SEQ_NO, STORE, DAY) DISC
         WHERE STI.TRAN_SEQ_NO = H.TRAN_SEQ_NO
           AND STI.STORE = H.STORE
           AND STI.DAY = H.DAY
           AND H.STORE_DAY_SEQ_NO = D.STORE_DAY_SEQ_NO
           AND D.BUSINESS_DATE BETWEEN &BEGIN_DATE AND &END_DATE
           AND STI.TRAN_SEQ_NO = DISC.TRAN_SEQ_NO(+)
           AND STI.ITEM_SEQ_NO = DISC.ITEM_SEQ_NO(+)
           AND STI.STORE = DISC.STORE(+)
           AND STI.DAY = DISC.DAY(+)
              --37水果大类
           AND EXISTS (SELECT 1
                  FROM ITEM_MASTER IM
                 WHERE IM.DEPT = 37
                   AND IM.ITEM = STI.ITEM)
              --会员卡号
           AND H.REF_NO27 IS NOT NULL
         GROUP BY H.REF_NO27, H.TRAN_SEQ_NO) A
--单笔购买60元以上
 WHERE A.TOTAL_RETAIL >= 60
 GROUP BY A.VIP_NO;
