SELECT * FROM RAINY_USER WHERE USER_ID='R8307204587';
SELECT * FROM RAINY_USER_POSITION WHERE USER_ID='R8307204587' FOR UPDATE;
SELECT * FROM RAINY_USER_MERCH WHERE USER_ID='R8307204587';
SELECT * FROM RAINY_USER_LOC WHERE USER_ID='R8307204587' FOR UPDATE;

SELECT * FROM SEC_USER_GROUP WHERE USER_ID='R8307204587' FOR UPDATE;

--移除原职位权限
--查询出来的语句在sys用户下执行
SELECT 'revoke ' || rr.role_ext || ' from ' || ru.user_id || ';'
  FROM rainy_role          rr ,
       rainy_user          ru ,
       rainy_user_position rup ,
       rainy_position_role rpr
 WHERE rr.appl = 'RMS'
   AND rup.user_id = ru.user_id
   AND rup.position_id = rpr.position_id
   AND rpr.role_id = rr.role_id
   AND RU.ID =862;
   
   --RA/BIP权限删除
--查询出来的结果保存成txt文本文件，并且要把【”】去掉，然后用LDAP导入，file-->import
--SIM,RA/BIP系统的用户的创建、权限的修改，都是通过LDAP导入。
SELECT 'dn: cn=' || ra.role_name ||',cn=Groups,dc=bbg
changetype: modify
delete: uniquemember
uniquemember: cn='||ru.user_id ||',cn=users,dc=bbg
'
FROM RAINY_USER ru, RAINY_USER_POSITION rup,RAINY_POSITION_ROLE rpr ,rainy_role ra
WHERE ru.user_id= rup.user_id
and rpr.position_id= rup.position_id
and rpr.role_id= ra.role_id and ra.appl = 'RA/BIP'
AND RU.ID =862 ;

--用户地点权限删除
--查询出来的结果保存成txt文本文件，并且要把【”】去掉，然后用LDAP导入，file-->import
--SIM,RA/BIP系统的用户的创建、权限的修改，都是通过LDAP导入。
SELECT DISTINCT
'dn: cn=RA_DATA_SECURITY_LOC@' ||a.LOC || ',cn=Groups,dc=bbg'|| CHR ( 10 )||
'changetype: modify' ||CHR ( 10 )||
'delete: uniquemember' ||CHR ( 10 )||
'uniquemember: cn='||a.USER_ID ||',cn=users,dc=bbg' ||CHR ( 10 )
FROM RAINY_USER_LOC a left join rainy_user ru on a.user_id =ru.user_id
where  RU.ID =862 ;   




insert into rainy_user_position(user_id,position_id) values('R8307204587',5);


--添加新职位权限
--RMS系统权限
--查询出来的数据用sys用户名执行
SELECT 'grant ' || rr.role_ext || ' to ' || ru.user_id || ';'
  FROM rainy_role          rr  ,
       rainy_user          ru  ,
       rainy_user_position rup ,
       rainy_position_role rpr
 WHERE rr.appl = 'RMS'
   AND rup.user_id = ru.user_id
   AND rup.position_id = rpr.position_id
   AND rpr.role_id = rr.role_id
   AND RU.ID =862 ;

insert into rainy_user_loc (user_id,loc)values('R8307204587','120194');

--插入sec_user_group表，分二种情况插入
--Location地点
INSERT INTO sec_user_group
  SELECT sg.group_id , ru.user_id
    FROM rainy_user ru , rainy_user_loc rul , sec_group sg
   WHERE ru.user_id = rul.user_id
     AND sg.group_name LIKE '%Location%' || rul.loc || '%'
  AND NOT EXISTS(SELECT 1 FROM sec_user_group SUG WHERE SUG.USER_ID=RU.USER_ID AND SUG.GROUP_ID=SG.GROUP_ID)
     AND RU.ID =862 ;


--用户大类权限导入
--查询出来的结果保存成txt文本文件，并且要把【”】去掉，然后用LDAP导入，file-->import
--SIM,RA/BIP系统的用户的创建、权限的修改，都是通过LDAP导入。
SELECT DISTINCT
'dn: cn=RA_DATA_SECURITY_DOMAIN@' ||MERCH|| ',cn=Groups,dc=bbg'|| CHR (10 )||
'changetype: modify' ||CHR ( 10 )||
'add: uniquemember'||CHR (10 )||
'uniquemember: cn='||a.USER_ID||',cn=users,dc=bbg' ||CHR ( 10 )
FROM RAINY_USER_MERCH a left join rainy_user ru on a.user_id=ru.user_id
where  RU.ID =862 ;
