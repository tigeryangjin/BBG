insert into RAINY_POSITION_ROLE(role_id,position_id) values(79,56);
insert into RAINY_POSITION_ROLE(role_id,position_id) values(80,56);
insert into RAINY_POSITION_ROLE(role_id,position_id) values(197,56);

select * from rainy_user t where USER_ID IN ('R6708041534','R8707132567','R8805240427','R7507194023');
SELECT * FROM RAINY_USER WHERE USER_NAME LIKE '%��%'
select * from RAINY_USER_POSITION T WHERE POSITION_ID=55;
select * from rainy_user_position where user_id='R8611030563'

--�����ְλȨ��
--RMSϵͳȨ��
--��ѯ������������sys�û���ִ��
SELECT 'grant ' || rr.role_ext || ' to ' || ru.user_id || ';'
  FROM rainy_role          rr  ,
       rainy_user          ru  ,
       rainy_user_position rup ,
       rainy_position_role rpr 
 WHERE rr.appl = 'RMS'
   AND rup.user_id = ru.user_id
   AND rup.position_id = rpr.position_id
   AND rpr.role_id = rr.role_id
   AND RPR.POSITION_ID=56
   AND RPR.ROLE_ID IN (79,80,197);
   
--RA/BIPȨ�޵���
--��ѯ�����Ľ�������txt�ı��ļ�������Ҫ�ѡ�����ȥ����Ȼ����LDAP���룬file-->import 
--SIM,RA/BIPϵͳ���û��Ĵ�����Ȩ�޵��޸ģ�����ͨ��LDAP���롣
SELECT 'dn: cn=' ||ra.role_name ||',cn=Groups,dc=bbg
changetype: modify
add: uniquemember
uniquemember: cn='||ru.user_id||',cn=users,dc=bbg
'
FROM RAINY_USER ru, RAINY_USER_POSITION rup,RAINY_POSITION_ROLE rpr,rainy_role ra
WHERE ru.user_id= rup.user_id
and rpr.position_id= rup.position_id
and rpr.role_id= ra.role_id and ra.appl = 'RA/BIP'
AND RPR.POSITION_ID=55
AND RPR.ROLE_ID IN (79,80,197);

