insert into rainy_user(user_id,user_name,id) values('R8411102610','孙振球','2159');
insert into rainy_user(user_id,user_name,id) values('R7411170425','夏海燕','2160');
insert into rainy_user(user_id,user_name,id) values('R7801281559','皮毅','2161');
insert into rainy_user(user_id,user_name,id) values('R7705200559','彭峰','2162');
insert into rainy_user(user_id,user_name,id) values('R7112073021','邓灿炬','2163');
insert into rainy_user(user_id,user_name,id) values('R7909221822','邓小芬','2164');
insert into rainy_user(user_id,user_name,id) values('R7203227210','曾建红','2165');
insert into rainy_user(user_id,user_name,id) values('R7004151022','刘顺娥','2166');
insert into rainy_user(user_id,user_name,id) values('R7409254965','范彩','2167');
insert into rainy_user(user_id,user_name,id) values('R7002270031','朱国民','2168');
insert into rainy_user(user_id,user_name,id) values('R7407237111','文军飞','2169');
insert into rainy_user(user_id,user_name,id) values('R7406136821','缪彩红','2170');
insert into rainy_user(user_id,user_name,id) values('R8111070038','何颖','2171');
insert into rainy_user(user_id,user_name,id) values('R7712183512','谢良武','2172');

--权限变更的用户修改ID列，从BBG_Security_Application_User_List表中获取
SELECT * FROM RAINY_USER
WHERE USER_ID IN( 'R8411102610','R7411170425','R7801281559','R7705200559','R7112073021','R7909221822','R7203227210','R7004151022','R7409254965',
'R7002270031','R7407237111','R7406136821','R8111070038','R7712183512') FOR UPDATE;

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
   AND RU.ID BETWEEN 2159 AND 2172;

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
AND RU.ID BETWEEN 2159 AND 2172 ;

--用户大类权限删除
--查询出来的结果保存成txt文本文件，并且要把【”】去掉，然后用LDAP导入，file-->import
--SIM,RA/BIP系统的用户的创建、权限的修改，都是通过LDAP导入。
SELECT DISTINCT
'dn: cn=RA_DATA_SECURITY_DOMAIN@' ||MERCH || ',cn=Groups,dc=bbg'|| CHR ( 10 )||
'changetype: modify' ||CHR ( 10 )||
'delete: uniquemember' ||CHR ( 10 )||
'uniquemember: cn='||a.USER_ID ||',cn=users,dc=bbg' ||CHR ( 10 )
FROM RAINY_USER_MERCH a left join rainy_user ru on a.user_id =ru.user_id
where  RU.ID BETWEEN 2159 AND 2172 ;



--用户地点权限删除
--查询出来的结果保存成txt文本文件，并且要把【”】去掉，然后用LDAP导入，file-->import
--SIM,RA/BIP系统的用户的创建、权限的修改，都是通过LDAP导入。
SELECT DISTINCT
'dn: cn=RA_DATA_SECURITY_LOC@' ||a.LOC || ',cn=Groups,dc=bbg'|| CHR ( 10 )||
'changetype: modify' ||CHR ( 10 )||
'delete: uniquemember' ||CHR ( 10 )||
'uniquemember: cn='||a.USER_ID ||',cn=users,dc=bbg' ||CHR ( 10 )
FROM RAINY_USER_LOC a left join rainy_user ru on a.user_id =ru.user_id
where  RU.ID BETWEEN 2159 AND 2172 ;   
--删除表中用户数据，权限清除后需要删除的表
DELETE FROM RSM_USER_ROLE T WHERE EXISTS(SELECT 1 FROM RAINY_USER RU WHERE T.USER_ID=RU.USER_ID AND RU.ID BETWEEN 2159 AND 2172);
DELETE FROM SEC_USER_GROUP T WHERE EXISTS(SELECT 1 FROM RAINY_USER RU WHERE T.USER_ID=RU.USER_ID AND RU.ID BETWEEN 2159 AND 2172);
DELETE FROM RAINY_USER_LOC T WHERE EXISTS(SELECT 1 FROM RAINY_USER RU WHERE T.USER_ID=RU.USER_ID AND RU.ID BETWEEN 2159 AND 2172);
DELETE FROM RAINY_USER_MERCH T WHERE EXISTS(SELECT 1 FROM RAINY_USER RU WHERE T.USER_ID=RU.USER_ID AND RU.ID BETWEEN 2159 AND 2172);
DELETE FROM RAINY_USER_POSITION T WHERE EXISTS(SELECT 1 FROM RAINY_USER RU WHERE T.USER_ID=RU.USER_ID AND RU.ID BETWEEN 2159 AND 2172);



insert into rainy_user_position(user_id,position_id) values('R8411102610',95);
insert into rainy_user_position(user_id,position_id) values('R7411170425',85);
insert into rainy_user_position(user_id,position_id) values('R7801281559',86);
insert into rainy_user_position(user_id,position_id) values('R7705200559',86);
insert into rainy_user_position(user_id,position_id) values('R7112073021',85);
insert into rainy_user_position(user_id,position_id) values('R7909221822',86);
insert into rainy_user_position(user_id,position_id) values('R7203227210',86);
insert into rainy_user_position(user_id,position_id) values('R7004151022',86);
insert into rainy_user_position(user_id,position_id) values('R7409254965',86);
insert into rainy_user_position(user_id,position_id) values('R7002270031',86);
insert into rainy_user_position(user_id,position_id) values('R8111070038',85);
insert into rainy_user_position(user_id,position_id) values('R7712183512',86);
-------------------------------------------------------------------------------
insert into rainy_user_merch(user_id,merch) values('R7411170425','11');
insert into rainy_user_merch(user_id,merch) values('R7411170425','12');
insert into rainy_user_merch(user_id,merch) values('R7411170425','13');
insert into rainy_user_merch(user_id,merch) values('R7411170425','14');
insert into rainy_user_merch(user_id,merch) values('R7411170425','15');
insert into rainy_user_merch(user_id,merch) values('R7411170425','16');
insert into rainy_user_merch(user_id,merch) values('R7411170425','17');
insert into rainy_user_merch(user_id,merch) values('R7411170425','18');
insert into rainy_user_merch(user_id,merch) values('R7411170425','19');
insert into rainy_user_merch(user_id,merch) values('R7411170425','21');
insert into rainy_user_merch(user_id,merch) values('R7411170425','22');
insert into rainy_user_merch(user_id,merch) values('R7411170425','23');
insert into rainy_user_merch(user_id,merch) values('R7411170425','24');
insert into rainy_user_merch(user_id,merch) values('R7411170425','25');
insert into rainy_user_merch(user_id,merch) values('R7411170425','26');
insert into rainy_user_merch(user_id,merch) values('R7411170425','29');
insert into rainy_user_merch(user_id,merch) values('R7411170425','75');
insert into rainy_user_merch(user_id,merch) values('R7411170425','76');
insert into rainy_user_merch(user_id,merch) values('R7801281559','11');
insert into rainy_user_merch(user_id,merch) values('R7801281559','12');
insert into rainy_user_merch(user_id,merch) values('R7801281559','13');
insert into rainy_user_merch(user_id,merch) values('R7801281559','14');
insert into rainy_user_merch(user_id,merch) values('R7801281559','15');
insert into rainy_user_merch(user_id,merch) values('R7801281559','16');
insert into rainy_user_merch(user_id,merch) values('R7801281559','17');
insert into rainy_user_merch(user_id,merch) values('R7801281559','18');
insert into rainy_user_merch(user_id,merch) values('R7801281559','19');
insert into rainy_user_merch(user_id,merch) values('R7801281559','29');
insert into rainy_user_merch(user_id,merch) values('R7801281559','75');
insert into rainy_user_merch(user_id,merch) values('R7801281559','76');
insert into rainy_user_merch(user_id,merch) values('R7705200559','21');
insert into rainy_user_merch(user_id,merch) values('R7705200559','22');
insert into rainy_user_merch(user_id,merch) values('R7705200559','23');
insert into rainy_user_merch(user_id,merch) values('R7705200559','24');
insert into rainy_user_merch(user_id,merch) values('R7705200559','25');
insert into rainy_user_merch(user_id,merch) values('R7705200559','26');
insert into rainy_user_merch(user_id,merch) values('R7112073021','31');
insert into rainy_user_merch(user_id,merch) values('R7112073021','32');
insert into rainy_user_merch(user_id,merch) values('R7112073021','33');
insert into rainy_user_merch(user_id,merch) values('R7112073021','34');
insert into rainy_user_merch(user_id,merch) values('R7112073021','35');
insert into rainy_user_merch(user_id,merch) values('R7112073021','36');
insert into rainy_user_merch(user_id,merch) values('R7112073021','37');
insert into rainy_user_merch(user_id,merch) values('R7112073021','38');
insert into rainy_user_merch(user_id,merch) values('R7112073021','39');
insert into rainy_user_merch(user_id,merch) values('R7112073021','40');
insert into rainy_user_merch(user_id,merch) values('R7112073021','41');
insert into rainy_user_merch(user_id,merch) values('R7112073021','42');
insert into rainy_user_merch(user_id,merch) values('R7909221822','31');
insert into rainy_user_merch(user_id,merch) values('R7909221822','34');
insert into rainy_user_merch(user_id,merch) values('R7909221822','39');
insert into rainy_user_merch(user_id,merch) values('R7909221822','40');
insert into rainy_user_merch(user_id,merch) values('R7203227210','27');
insert into rainy_user_merch(user_id,merch) values('R7203227210','32');
insert into rainy_user_merch(user_id,merch) values('R7203227210','33');
insert into rainy_user_merch(user_id,merch) values('R7203227210','35');
insert into rainy_user_merch(user_id,merch) values('R7203227210','38');
insert into rainy_user_merch(user_id,merch) values('R7203227210','42');
insert into rainy_user_merch(user_id,merch) values('R7004151022','36');
insert into rainy_user_merch(user_id,merch) values('R7004151022','37');
insert into rainy_user_merch(user_id,merch) values('R7004151022','41');
insert into rainy_user_merch(user_id,merch) values('R7409254965','21');
insert into rainy_user_merch(user_id,merch) values('R7409254965','22');
insert into rainy_user_merch(user_id,merch) values('R7409254965','23');
insert into rainy_user_merch(user_id,merch) values('R7409254965','24');
insert into rainy_user_merch(user_id,merch) values('R7409254965','25');
insert into rainy_user_merch(user_id,merch) values('R7409254965','26');
insert into rainy_user_merch(user_id,merch) values('R7002270031','27');
insert into rainy_user_merch(user_id,merch) values('R7002270031','33');
insert into rainy_user_merch(user_id,merch) values('R7002270031','36');
insert into rainy_user_merch(user_id,merch) values('R7002270031','37');
insert into rainy_user_merch(user_id,merch) values('R7002270031','38');
insert into rainy_user_merch(user_id,merch) values('R7002270031','40');
insert into rainy_user_merch(user_id,merch) values('R7002270031','41');
insert into rainy_user_merch(user_id,merch) values('R7407237111','ALL');
insert into rainy_user_merch(user_id,merch) values('R8111070038','30');
insert into rainy_user_merch(user_id,merch) values('R8111070038','31');
insert into rainy_user_merch(user_id,merch) values('R8111070038','32');
insert into rainy_user_merch(user_id,merch) values('R8111070038','33');
insert into rainy_user_merch(user_id,merch) values('R8111070038','34');
insert into rainy_user_merch(user_id,merch) values('R8111070038','35');
insert into rainy_user_merch(user_id,merch) values('R8111070038','36');
insert into rainy_user_merch(user_id,merch) values('R8111070038','37');
insert into rainy_user_merch(user_id,merch) values('R8111070038','38');
insert into rainy_user_merch(user_id,merch) values('R8111070038','39');
insert into rainy_user_merch(user_id,merch) values('R8111070038','40');
insert into rainy_user_merch(user_id,merch) values('R8111070038','41');
insert into rainy_user_merch(user_id,merch) values('R8111070038','42');
insert into rainy_user_merch(user_id,merch) values('R7712183512','31');
insert into rainy_user_merch(user_id,merch) values('R7712183512','40');
insert into rainy_user_merch(user_id,merch) values('R7712183512','42');
-----------------------------------------------------------------------
insert into rainy_user_loc (user_id,loc)values('R8411102610','130002');
insert into rainy_user_loc (user_id,loc)values('R7411170425','118001');
insert into rainy_user_loc (user_id,loc)values('R7411170425','120068');
insert into rainy_user_loc (user_id,loc)values('R7801281559','118001');
insert into rainy_user_loc (user_id,loc)values('R7801281559','120068');
insert into rainy_user_loc (user_id,loc)values('R7705200559','118001');
insert into rainy_user_loc (user_id,loc)values('R7705200559','120068');
insert into rainy_user_loc (user_id,loc)values('R7112073021','118001');
insert into rainy_user_loc (user_id,loc)values('R7112073021','118005');
insert into rainy_user_loc (user_id,loc)values('R7112073021','118011');
insert into rainy_user_loc (user_id,loc)values('R7112073021','118012');
insert into rainy_user_loc (user_id,loc)values('R7112073021','120068');
insert into rainy_user_loc (user_id,loc)values('R7909221822','118001');
insert into rainy_user_loc (user_id,loc)values('R7909221822','120068');
insert into rainy_user_loc (user_id,loc)values('R7203227210','118001');
insert into rainy_user_loc (user_id,loc)values('R7203227210','120068');
insert into rainy_user_loc (user_id,loc)values('R7004151022','118001');
insert into rainy_user_loc (user_id,loc)values('R7004151022','118005');
insert into rainy_user_loc (user_id,loc)values('R7004151022','118011');
insert into rainy_user_loc (user_id,loc)values('R7004151022','118012');
insert into rainy_user_loc (user_id,loc)values('R7004151022','120068');
insert into rainy_user_loc (user_id,loc)values('R7409254965','120021');
insert into rainy_user_loc (user_id,loc)values('R7002270031','120021');
insert into rainy_user_loc (user_id,loc)values('R7407237111','120159');
insert into rainy_user_loc (user_id,loc)values('R7406136821','120159');
insert into rainy_user_loc (user_id,loc)values('R8111070038','120159');
insert into rainy_user_loc (user_id,loc)values('R7712183512','120159');




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
   AND RU.ID BETWEEN 2159 AND 2172;

--新建用户插入用户属性表，lang字段8表示中文，1表示英文
SELECT 'insert into user_attrib(user_id,user_name,lang) values(' || chr( 39) ||
       ru.user_id || chr( 39 ) || ',' || chr (39 ) || ru.user_name || chr( 39) || ',' || 8 || ')' || ';'
  FROM rainy_user ru ;

insert into user_attrib( user_id, user_name, lang)
select user_id,user_name, '8'
from rainy_user ru
where  to_number (RU.id ) BETWEEN 2159 AND 2172
and user_id not in ( select user_id from user_attrib );

--插入sec_user_group表，分二种情况插入
--Location地点
INSERT INTO sec_user_group
  SELECT sg.group_id , ru.user_id
    FROM rainy_user ru , rainy_user_loc rul , sec_group sg
   WHERE ru.user_id = rul.user_id
     AND sg.group_name LIKE '%Location%' || rul.loc || '%'
  --AND NOT EXISTS(SELECT 1 FROM sec_user_group SUG WHERE SUG.USER_ID=RU.USER_ID AND SUG.GROUP_ID=SG.GROUP_ID)
     AND RU.ID BETWEEN 2159 AND 2172 ;
--Department大类   
INSERT INTO sec_user_group
  SELECT sg.group_id , ru.user_id
    FROM rainy_user ru , rainy_user_merch rul , sec_group sg
   WHERE ru.user_id = rul.user_id
     AND sg.group_name LIKE '%Department%' || rul.merch || '%'
     AND RU.ID BETWEEN 2159 AND 2172
    --AND NOT EXISTS(SELECT 1 FROM sec_user_group SUG WHERE SUG.USER_ID=RU.USER_ID AND SUG.GROUP_ID=SG.GROUP_ID)
     group by sg.group_id,ru.user_id;

--插入RSM_USER_ROLE表
--RPM系统权限写入
insert into RSM_USER_ROLE
select  rsm_user_role_seq.nextval, a.user_id, a.role_ext, SYSDATE - 720, null
from ( SELECT ru.user_id user_id ,ra.role_ext role_ext    
        FROM rainy_user ru , rainy_user_position rup , rainy_position_role rpr,RAINY_ROLE ra
       WHERE ru.user_id = rup.user_id
         AND rup.position_id = rpr.position_id
         and rpr.role_id =ra.role_id and ra.appl ='RPM'
         --注意以下条件
         AND RU.ID BETWEEN 2159 AND 2172
         group  by ru.user_id ,ra.role_ext ) a
where a.role_ext is not null ;

--LDAP建用户
--SIM系统,RA/BIP系统共用一个用户，建立一个就OK了。
--SIM系统中LOC为ALL的，在建用户和权限导入时要分店别或类别进行
--注意：userstores: storeId=ALL 时要替换。。。替换整行。。。
SELECT 'dn: cn=' || ru.user_id || ',cn=Users,dc=bbg
changetype: add
#RPM
objectclass: retailUser
#SIM
objectclass: simUser
#General
objectclass: inetOrgPerson
objectclass: orclUser
objectclass: orclUserV2
objectclass: organizationalPerson
objectclass: person
objectclass: top
uid: ' || ru.user_id || chr (13 ) || 'cn:' || ru.user_id || chr (13 ) ||
        'sn: ' || ru.user_id || chr ( 13) || 'description:' || rp.position ||
        chr( 13 ) || 'givenname: ' || ru.user_id || chr (13 ) || 'superUser: FALSE
empStatus: 0
preferredCountry: CN
preferredLanguage: zh
middleName: M1
mail: user0010@bbg.com
telephoneNumber: 800-111-2222
externalId: ' || ru.user_id || chr (13 ) || 'supervisor: X
startTimestamp: 20071026000000Z
#endTimestamp:
#defaultStore: storeId=' ||
        ( SELECT rul.loc
           FROM rainy_user_loc rul
          WHERE rul.user_id = ru.user_id
            AND rownum = 1) || ',cn=SIMStores,cn=SIM,dc=bbg,dc=com
userpassword: ' || ru.password || chr (13 ) ||
       to_char ( ( SELECT   wm_concat( 'userstores: storeId=' || rull.loc ||',cn=SIMStores,cn=SIM,dc=bbg' ||chr ( 13 ))
     
           FROM rainy_user_loc rull
          WHERE rull.user_id = ru.user_id
          GROUP BY rull.user_id ))
  FROM rainy_user ru , rainy_user_position rup , rainy_position rp
-- rainy_user_loc      rull
-- RAINY_LOC           rl
WHERE ru.user_id = rup.user_id
   AND rup.position_id = rp.position_id
--注意下面条件，当用户地点权限为ALL时才是=，不是ALL就是<>
   AND EXISTS( SELECT 1 FROM RAINY_USER_LOC RULL WHERE RULL.USER_ID=RU.USER_ID AND RULL.LOC<> 'ALL')
   --AND ru.user_id NOT IN (SELECT rull.user_id FROM rainy_user_loc rull WHERE rull.loc <> 'ALL')
   AND RU.ID BETWEEN 2159 AND 2172;

--SIM系统导入
--查询出来的结果保存成txt文本文件，并且要把【”】去掉，然后用LDAP导入，file-->import
--注意：userRoleStores为ALL时要替换。。。替换整行。。。
SELECT rr.role_name, ru.user_id, 'dn: roleName=' || rr.role_name || ',cn=' || ru.user_id ||
        ',cn=Users,dc=bbg
changetype: add
objectclass: simUserRole
roleName: ' || rr.role_name || chr (13 ) || 'userRole: roleName=' ||
        rr.role_name || ',cn=SIMRoles,cn=SIM,dc=bbg
userRoleStores: ' || wm_concat( 'storeId=' || rul.loc || ',cn=SIMStores,cn=SIM,dc=bbg' ||chr ( 13 ))
        /*(SELECT wm_concat(decode(rul.loc,
                                 'ALL',
                                 'storeId='||rl.loc_id || ',cn=SIMStores,cn=SIM,dc=bbg'||chr(13),
                                 'storeId='|| rul.loc || ',cn=SIMStores,cn=SIM,dc=bbg'||chr(13)))
           FROM rainy_loc rl)*/ text
  FROM rainy_role          rr ,
       rainy_user          ru ,
       rainy_user_position rup ,
       rainy_position_role rpr ,
       rainy_user_loc      rul
--  rainy_loc           rl
 WHERE rr.appl = 'SIM'
   AND ru.user_id = rup.user_id
   AND rr.role_id = rpr.role_id
   AND rup.position_id = rpr.position_id
   AND ru.user_id = rul.user_id
--注意下面条件，当用户地点权限为ALL时才是=，不是ALL就是<>
and rul.loc <> 'ALL'
AND RU.ID BETWEEN 2159 AND 2172
GROUP BY    rr.role_name, ru.user_id;

--RA/BIP权限导入
--查询出来的结果保存成txt文本文件，并且要把【”】去掉，然后用LDAP导入，file-->import
--SIM,RA/BIP系统的用户的创建、权限的修改，都是通过LDAP导入。
SELECT 'dn: cn=' ||ra.role_name ||',cn=Groups,dc=bbg
changetype: modify
add: uniquemember
uniquemember: cn='||ru.user_id||',cn=users,dc=bbg
'
FROM RAINY_USER ru, RAINY_USER_POSITION rup,RAINY_POSITION_ROLE rpr,rainy_role ra
WHERE ru.user_id= rup.user_id
and rpr.position_id= rup.position_id
and rpr.role_id= ra.role_id and ra.appl = 'RA/BIP'
AND RU.ID BETWEEN 2159 AND 2172 ;

--用户大类权限导入
--查询出来的结果保存成txt文本文件，并且要把【”】去掉，然后用LDAP导入，file-->import
--SIM,RA/BIP系统的用户的创建、权限的修改，都是通过LDAP导入。
SELECT DISTINCT
'dn: cn=RA_DATA_SECURITY_DOMAIN@' ||MERCH|| ',cn=Groups,dc=bbg'|| CHR (10 )||
'changetype: modify' ||CHR ( 10 )||
'add: uniquemember'||CHR (10 )||
'uniquemember: cn='||a.USER_ID||',cn=users,dc=bbg' ||CHR ( 10 )
FROM RAINY_USER_MERCH a left join rainy_user ru on a.user_id=ru.user_id
where  RU.ID BETWEEN 2159 AND 2172 ;



--用户地点权限导入
--查询出来的结果保存成txt文本文件，并且要把【”】去掉，然后用LDAP导入，file-->import
--SIM,RA/BIP系统的用户的创建、权限的修改，都是通过LDAP导入。
SELECT DISTINCT
'dn: cn=RA_DATA_SECURITY_LOC@' ||a.LOC|| ',cn=Groups,dc=bbg'|| CHR (10 )||
'changetype: modify' ||CHR ( 10 )||
'add: uniquemember'||CHR (10 )||
'uniquemember: cn='||a.USER_ID||',cn=users,dc=bbg' ||CHR ( 10 )
FROM RAINY_USER_LOC a left join rainy_user ru on a.user_id=ru.user_id
where  RU.ID BETWEEN 2159 AND 2172 ;

--用户名和密码导出成EXCEL表格发邮件
SELECT USER_ID, USER_NAME, PASSWORD
FROM RAINY_USER ru
WHERE RU.ID BETWEEN 2159 AND 2172 
ORDER BY RU.ID;

