--1
--���ʱ��㣺19��30
--��������������ļ�¼���ֶν����ʾ����10��
--����UC4�е�ÿ�������һ�ε�CHAIN:BBG.IF.MOM.STATIC.DATA.EVERY5MINһֱ���ܻ�BLOCK
SELECT *
  FROM (SELECT log_text �������,
               log_date ����,
               log_result ��¼��,
               begin_time ���ʱ��,
               RANK() OVER(PARTITION BY log_text, log_date ORDER BY begin_time DESC) AS rank1
          FROM CMX_MONITOR_LOG
         WHERE log_date = get_vdate
           AND id = 1)
 WHERE rank1 = 1;

--2
--���ʱ��㣺19��30
--��������������ļ�¼���ֶν����ʾ����10��
--����UC4�е�ÿ�������һ�ε�CHAIN: BBG.IF.MOM.DOC.01.DATA.EVERY.5MINһֱ���ܻ�BLOCK
select count(*) ��¼��
  from V_CMX_OUT_INTERFACE
 where creation_time >= get_vdate
   and pub_status = 'N';

--3
--���ʱ��㣺19��30
--��������������ļ�¼���ֶν����ʾ����500��
--�����ȼ��FTP�Ƿ��л�ѹ���ݣ�FTP��鷽���ο�����1.5������
--����д�����ѹ������֪ͨ����껼�鹩Ӧ��Ӧ�÷�������FTP�Ƿ�������
--û�����ݻ�ѹ��֪ͨ����껼�鹩Ӧ����������̨���ݴ����Ƿ�������
SELECT *
  FROM (SELECT log_text �������,
               log_date ����,
               log_result ��¼��,
               begin_time ���ʱ��,
               RANK() OVER(PARTITION BY log_text, log_date ORDER BY begin_time DESC) AS rank1
          FROM CMX_MONITOR_LOG
         WHERE log_date = get_vdate
           AND id = 3)
 WHERE rank1 = 1;

--4
--���ʱ��㣺19��30      22��00 
SELECT *
  FROM (SELECT log_text �������,
               log_date ����,
               log_result ��¼��,
               begin_time ���ʱ��,
               RANK() OVER(PARTITION BY log_text, log_date ORDER BY begin_time DESC) AS rank1
          FROM CMX_MONITOR_LOG
         WHERE log_date = get_vdate
           AND id = 5)
 WHERE rank1 = 1;
--ֵ��ע��㣺��������������ļ�¼���ֶν����ʾ����500��
--����UC4�е�ÿ�������һ�ε�CHAIN:BBG.IF.OUTSIDE.SYSTEM.EVERY.5MINһֱ���ܻ�BLOCK

--5
--��Χϵͳ����IMPORT��ͼ���
--���ʱ��㣺19��30      22��00 
--�����䣺
SELECT *
  FROM (SELECT log_text �������,
               log_date ����,
               log_result ��¼��,
               begin_time ���ʱ��,
               RANK() OVER(PARTITION BY log_text, log_date ORDER BY begin_time DESC) AS rank1
          FROM CMX_MONITOR_LOG
         WHERE log_date = get_vdate
           AND id = 6)
 WHERE rank1 = 1;
--ֵ��ע��㣺��������������ļ�¼���ֶν����ʾ����500��
--����UC4�е�ÿ�������һ�ε�CHAIN:BBG.IF.OUTSIDE.SYSTEM.EVERY.5MINһֱ���ܻ�BLOCK����鷽���ο������2.2.2��

--6
--���ʱ��㣺19��30
SELECT *
  FROM (SELECT log_text �������,
               log_date ����,
               log_result ��¼��,
               begin_time ���ʱ��,
               RANK() OVER(PARTITION BY log_text, log_date ORDER BY begin_time DESC) AS rank1
          FROM CMX_MONITOR_LOG
         WHERE log_date = get_vdate
           AND id = 16)
 WHERE rank1 = 1;
--ֵ��ע��㣺��������������ļ�¼���ֶν����ʾ����0��������������ϵ��

--7
--���ʱ��㣺19��30      
select * from BBG_CONCURRENT_REQUESTS where status = 'E';
--ֵ��ע��㣺��������������м�¼���������������±���ļ�¼���´���
--��10���Ӻ��������������ѯ�Ƿ��Ա�������Ա������붡����ϵ
update BBG_CONCURRENT_REQUESTS set run_time = 0 where status = 'E';

--8
--���ʱ��㣺19��30   22��00    
select count(*) ��¼��
  from CMX_IF_PRICE_PUBLISH_DATA
 where pub_status = 'N';
--ֵ��ע��㣺��������������ļ�¼���ֶν����ʾ����2��
--����UC4�е�ÿ�������һ�ε�CHAIN:BBG.IF.MOM.DOC.01.DATA.EVERY.5MINһֱ���ܻ�BLOCK
