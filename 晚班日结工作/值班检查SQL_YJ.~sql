--1
--检查时间点：19：30
--如果上面的语句查出的记录数字段结果提示超过10万，
--请检查UC4中的每五分钟跑一次的CHAIN:BBG.IF.MOM.STATIC.DATA.EVERY5MIN一直在跑或被BLOCK
SELECT *
  FROM (SELECT log_text 检查内容,
               log_date 日期,
               log_result 记录数,
               begin_time 检查时间,
               RANK() OVER(PARTITION BY log_text, log_date ORDER BY begin_time DESC) AS rank1
          FROM CMX_MONITOR_LOG
         WHERE log_date = get_vdate
           AND id = 1)
 WHERE rank1 = 1;

--2
--检查时间点：19：30
--如果上面的语句查出的记录数字段结果提示超过10万，
--请检查UC4中的每五分钟跑一次的CHAIN: BBG.IF.MOM.DOC.01.DATA.EVERY.5MIN一直在跑或被BLOCK
select count(*) 记录数
  from V_CMX_OUT_INTERFACE
 where creation_time >= get_vdate
   and pub_status = 'N';

--3
--检查时间点：19：30
--如果上面的语句查出的记录数字段结果提示超过500，
--请首先检查FTP是否有积压数据（FTP检查方法参考下面1.5步），
--如果有大量积压数据请通知任重昊检查供应链应用服务器的FTP是否正常，
--没有数据积压请通知任重昊检查供应链服务器后台数据处理是否正常；
SELECT *
  FROM (SELECT log_text 检查内容,
               log_date 日期,
               log_result 记录数,
               begin_time 检查时间,
               RANK() OVER(PARTITION BY log_text, log_date ORDER BY begin_time DESC) AS rank1
          FROM CMX_MONITOR_LOG
         WHERE log_date = get_vdate
           AND id = 3)
 WHERE rank1 = 1;

--4
--检查时间点：19：30      22：00 
SELECT *
  FROM (SELECT log_text 检查内容,
               log_date 日期,
               log_result 记录数,
               begin_time 检查时间,
               RANK() OVER(PARTITION BY log_text, log_date ORDER BY begin_time DESC) AS rank1
          FROM CMX_MONITOR_LOG
         WHERE log_date = get_vdate
           AND id = 5)
 WHERE rank1 = 1;
--值班注意点：如果上面的语句查出的记录数字段结果提示超过500，
--请检查UC4中的每五分钟跑一次的CHAIN:BBG.IF.OUTSIDE.SYSTEM.EVERY.5MIN一直在跑或被BLOCK

--5
--外围系统单据IMPORT视图检查
--检查时间点：19：30      22：00 
--检查语句：
SELECT *
  FROM (SELECT log_text 检查内容,
               log_date 日期,
               log_result 记录数,
               begin_time 检查时间,
               RANK() OVER(PARTITION BY log_text, log_date ORDER BY begin_time DESC) AS rank1
          FROM CMX_MONITOR_LOG
         WHERE log_date = get_vdate
           AND id = 6)
 WHERE rank1 = 1;
--值班注意点：如果上面的语句查出的记录数字段结果提示超过500，
--请检查UC4中的每五分钟跑一次的CHAIN:BBG.IF.OUTSIDE.SYSTEM.EVERY.5MIN一直在跑或被BLOCK，检查方法参考下面第2.2.2步

--6
--检查时间点：19：30
SELECT *
  FROM (SELECT log_text 检查内容,
               log_date 日期,
               log_result 记录数,
               begin_time 检查时间,
               RANK() OVER(PARTITION BY log_text, log_date ORDER BY begin_time DESC) AS rank1
          FROM CMX_MONITOR_LOG
         WHERE log_date = get_vdate
           AND id = 16)
 WHERE rank1 = 1;
--值班注意点：如果上面的语句查出的记录数字段结果提示大于0，请与王勇昱联系。

--7
--检查时间点：19：30      
select * from BBG_CONCURRENT_REQUESTS where status = 'E';
--值班注意点：如果上面的语句查出有记录，则用以下语句更新报错的记录重新处理，
--隔10分钟后再用上面的语句查询是否仍报错，如果仍报错请与丁勇联系
update BBG_CONCURRENT_REQUESTS set run_time = 0 where status = 'E';

--8
--检查时间点：19：30   22：00    
select count(*) 记录数
  from CMX_IF_PRICE_PUBLISH_DATA
 where pub_status = 'N';
--值班注意点：如果上面的语句查出的记录数字段结果提示大于2万，
--请检查UC4中的每五分钟跑一次的CHAIN:BBG.IF.MOM.DOC.01.DATA.EVERY.5MIN一直在跑或被BLOCK
