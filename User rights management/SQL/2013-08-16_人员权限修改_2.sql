insert into rainy_user(user_id,user_name,id) values('R8706262055','赵博','2084');
insert into rainy_user(user_id,user_name,id) values('R770110401X','胡南','2085');
insert into rainy_user(user_id,user_name,id) values('R8702178326','谈欢','2086');
insert into rainy_user(user_id,user_name,id) values('R7910012048','彭伟香','2087');
insert into rainy_user(user_id,user_name,id) values('R8806050542','张帆','2088');
insert into rainy_user(user_id,user_name,id) values('R7402214018','刘城 ','2089');
insert into rainy_user(user_id,user_name,id) values('R7511102814','冯舟','2090');


--权限变更的用户修改ID列，从BBG_Security_Application_User_List表中获取
SELECT * FROM RAINY_USER
WHERE USER_ID IN ( 'R8706262055','R770110401X','R8702178326','R7910012048','R8806050542','R7402214018','R7511102814') FOR UPDATE;

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
   AND RU.ID BETWEEN 2084 AND 2090;

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
AND RU.ID BETWEEN 2084 AND 2090 ;

--用户大类权限删除
--查询出来的结果保存成txt文本文件，并且要把【”】去掉，然后用LDAP导入，file-->import
--SIM,RA/BIP系统的用户的创建、权限的修改，都是通过LDAP导入。
SELECT DISTINCT
'dn: cn=RA_DATA_SECURITY_DOMAIN@' ||MERCH || ',cn=Groups,dc=bbg'|| CHR ( 10 )||
'changetype: modify' ||CHR ( 10 )||
'delete: uniquemember' ||CHR ( 10 )||
'uniquemember: cn='||a.USER_ID ||',cn=users,dc=bbg' ||CHR ( 10 )
FROM RAINY_USER_MERCH a left join rainy_user ru on a.user_id =ru.user_id
where  RU.ID BETWEEN 2084 AND 2090 ;



--用户地点权限删除
--查询出来的结果保存成txt文本文件，并且要把【”】去掉，然后用LDAP导入，file-->import
--SIM,RA/BIP系统的用户的创建、权限的修改，都是通过LDAP导入。
SELECT DISTINCT
'dn: cn=RA_DATA_SECURITY_LOC@' ||a.LOC || ',cn=Groups,dc=bbg'|| CHR ( 10 )||
'changetype: modify' ||CHR ( 10 )||
'delete: uniquemember' ||CHR ( 10 )||
'uniquemember: cn='||a.USER_ID ||',cn=users,dc=bbg' ||CHR ( 10 )
FROM RAINY_USER_LOC a left join rainy_user ru on a.user_id =ru.user_id
where  RU.ID BETWEEN 2084 AND 2090 ;   
--删除表中用户数据，权限清除后需要删除的表
DELETE FROM RSM_USER_ROLE T WHERE EXISTS(SELECT 1 FROM RAINY_USER RU WHERE T.USER_ID=RU.USER_ID AND RU.ID BETWEEN 2084 AND 2090);
DELETE FROM SEC_USER_GROUP T WHERE EXISTS(SELECT 1 FROM RAINY_USER RU WHERE T.USER_ID=RU.USER_ID AND RU.ID BETWEEN 2084 AND 2090);
DELETE FROM RAINY_USER_LOC T WHERE EXISTS(SELECT 1 FROM RAINY_USER RU WHERE T.USER_ID=RU.USER_ID AND RU.ID BETWEEN 2084 AND 2090);
DELETE FROM RAINY_USER_MERCH T WHERE EXISTS(SELECT 1 FROM RAINY_USER RU WHERE T.USER_ID=RU.USER_ID AND RU.ID BETWEEN 2084 AND 2090);
DELETE FROM RAINY_USER_POSITION T WHERE EXISTS(SELECT 1 FROM RAINY_USER RU WHERE T.USER_ID=RU.USER_ID AND RU.ID BETWEEN 2084 AND 2090);


insert into rainy_user_position(user_id,position_id) values('R8706262055',68);
insert into rainy_user_position(user_id,position_id) values('R770110401X',67);
insert into rainy_user_position(user_id,position_id) values('R8702178326',68);
insert into rainy_user_position(user_id,position_id) values('R7910012048',68);
insert into rainy_user_position(user_id,position_id) values('R8806050542',69);
insert into rainy_user_position(user_id,position_id) values('R7402214018',68);
insert into rainy_user_position(user_id,position_id) values('R7511102814',68);
----------------------------------------
insert into rainy_user_merch(user_id,merch) values('RR7910012048','21');
insert into rainy_user_merch(user_id,merch) values('RR7910012048','22');
insert into rainy_user_merch(user_id,merch) values('RR7910012048','23');
insert into rainy_user_merch(user_id,merch) values('RR7910012048','24');
insert into rainy_user_merch(user_id,merch) values('RR7910012048','25');
insert into rainy_user_merch(user_id,merch) values('RR7910012048','26');
insert into rainy_user_merch(user_id,merch) values('RR7910012048','29');
insert into rainy_user_merch(user_id,merch) values('R8706262055','27');
insert into rainy_user_merch(user_id,merch) values('R8706262055','32');
insert into rainy_user_merch(user_id,merch) values('R8706262055','33');
insert into rainy_user_merch(user_id,merch) values('R8706262055','35');
insert into rainy_user_merch(user_id,merch) values('R8706262055','36');
insert into rainy_user_merch(user_id,merch) values('R8706262055','37');
insert into rainy_user_merch(user_id,merch) values('R8706262055','38');
insert into rainy_user_merch(user_id,merch) values('R8706262055','42');
insert into rainy_user_merch(user_id,merch) values('R8702178326','12');
insert into rainy_user_merch(user_id,merch) values('R8702178326','13');
insert into rainy_user_merch(user_id,merch) values('R8702178326','14');
insert into rainy_user_merch(user_id,merch) values('R8702178326','15');
insert into rainy_user_merch(user_id,merch) values('R8702178326','16');
insert into rainy_user_merch(user_id,merch) values('R8702178326','17');
insert into rainy_user_merch(user_id,merch) values('R8702178326','18');
insert into rainy_user_merch(user_id,merch) values('R8702178326','19');
insert into rainy_user_merch(user_id,merch) values('R8806050542','ALL');
insert into rainy_user_merch(user_id,merch) values('R770110401X','ALL');
insert into rainy_user_merch(user_id,merch) values('R7402214018','12');
insert into rainy_user_merch(user_id,merch) values('R7402214018','13');
insert into rainy_user_merch(user_id,merch) values('R7402214018','14');
insert into rainy_user_merch(user_id,merch) values('R7402214018','15');
insert into rainy_user_merch(user_id,merch) values('R7402214018','16');
insert into rainy_user_merch(user_id,merch) values('R7402214018','17');
insert into rainy_user_merch(user_id,merch) values('R7402214018','18');
insert into rainy_user_merch(user_id,merch) values('R7402214018','19');
insert into rainy_user_merch(user_id,merch) values('R7402214018','21');
insert into rainy_user_merch(user_id,merch) values('R7402214018','22');
insert into rainy_user_merch(user_id,merch) values('R7402214018','23');
insert into rainy_user_merch(user_id,merch) values('R7402214018','24');
insert into rainy_user_merch(user_id,merch) values('R7402214018','25');
insert into rainy_user_merch(user_id,merch) values('R7402214018','26');
insert into rainy_user_merch(user_id,merch) values('R7402214018','27');
insert into rainy_user_merch(user_id,merch) values('R7402214018','29');
insert into rainy_user_merch(user_id,merch) values('R7511102814','31');
insert into rainy_user_merch(user_id,merch) values('R7511102814','34');
insert into rainy_user_merch(user_id,merch) values('R7511102814','39');
-----------------------------------------------
insert into rainy_user_loc (user_id,loc)values('R8706262055','118005');
insert into rainy_user_loc (user_id,loc)values('R8706262055','118011');
insert into rainy_user_loc (user_id,loc)values('R8706262055','118012');
insert into rainy_user_loc (user_id,loc)values('R8706262055','120029');
insert into rainy_user_loc (user_id,loc)values('R8706262055','120064');
insert into rainy_user_loc (user_id,loc)values('R8706262055','120085');
insert into rainy_user_loc (user_id,loc)values('R8706262055','120157');
insert into rainy_user_loc (user_id,loc)values('R8706262055','120161');
insert into rainy_user_loc (user_id,loc)values('R8706262055','120163');
insert into rainy_user_loc (user_id,loc)values('R8706262055','120170');
insert into rainy_user_loc (user_id,loc)values('R8706262055','120188');
insert into rainy_user_loc (user_id,loc)values('R770110401X','ALL');
insert into rainy_user_loc (user_id,loc)values('R770110401X','120029');
insert into rainy_user_loc (user_id,loc)values('R770110401X','120064');
insert into rainy_user_loc (user_id,loc)values('R770110401X','120085');
insert into rainy_user_loc (user_id,loc)values('R770110401X','120157');
insert into rainy_user_loc (user_id,loc)values('R770110401X','120161');
insert into rainy_user_loc (user_id,loc)values('R770110401X','120163');
insert into rainy_user_loc (user_id,loc)values('R770110401X','120170');
insert into rainy_user_loc (user_id,loc)values('R770110401X','120188');
insert into rainy_user_loc (user_id,loc)values('R8702178326','118001');
insert into rainy_user_loc (user_id,loc)values('R8702178326','120029');
insert into rainy_user_loc (user_id,loc)values('R8702178326','120064');
insert into rainy_user_loc (user_id,loc)values('R8702178326','120085');
insert into rainy_user_loc (user_id,loc)values('R8702178326','120157');
insert into rainy_user_loc (user_id,loc)values('R8702178326','120161');
insert into rainy_user_loc (user_id,loc)values('R8702178326','120163');
insert into rainy_user_loc (user_id,loc)values('R8702178326','120170');
insert into rainy_user_loc (user_id,loc)values('R8702178326','120188');
insert into rainy_user_loc (user_id,loc)values('R7910012048','118001');
insert into rainy_user_loc (user_id,loc)values('R7910012048','120029');
insert into rainy_user_loc (user_id,loc)values('R7910012048','120064');
insert into rainy_user_loc (user_id,loc)values('R7910012048','120085');
insert into rainy_user_loc (user_id,loc)values('R7910012048','120157');
insert into rainy_user_loc (user_id,loc)values('R7910012048','120161');
insert into rainy_user_loc (user_id,loc)values('R7910012048','120163');
insert into rainy_user_loc (user_id,loc)values('R7910012048','120170');
insert into rainy_user_loc (user_id,loc)values('R7910012048','120188');
insert into rainy_user_loc (user_id,loc)values('R8806050542','ALL');
insert into rainy_user_loc (user_id,loc)values('R8806050542','120029');
insert into rainy_user_loc (user_id,loc)values('R8806050542','120064');
insert into rainy_user_loc (user_id,loc)values('R8806050542','120085');
insert into rainy_user_loc (user_id,loc)values('R8806050542','120157');
insert into rainy_user_loc (user_id,loc)values('R8806050542','120161');
insert into rainy_user_loc (user_id,loc)values('R8806050542','120163');
insert into rainy_user_loc (user_id,loc)values('R8806050542','120170');
insert into rainy_user_loc (user_id,loc)values('R8806050542','120188');
insert into rainy_user_loc (user_id,loc)values('R7402214018','118001');
insert into rainy_user_loc (user_id,loc)values('R7402214018','120029');
insert into rainy_user_loc (user_id,loc)values('R7402214018','120064');
insert into rainy_user_loc (user_id,loc)values('R7402214018','120085');
insert into rainy_user_loc (user_id,loc)values('R7402214018','120157');
insert into rainy_user_loc (user_id,loc)values('R7402214018','120161');
insert into rainy_user_loc (user_id,loc)values('R7402214018','120163');
insert into rainy_user_loc (user_id,loc)values('R7402214018','120170');
insert into rainy_user_loc (user_id,loc)values('R7402214018','120188');
insert into rainy_user_loc (user_id,loc)values('R7511102814','118005');
insert into rainy_user_loc (user_id,loc)values('R7511102814','118012');
insert into rainy_user_loc (user_id,loc)values('R7511102814','120029');
insert into rainy_user_loc (user_id,loc)values('R7511102814','120064');
insert into rainy_user_loc (user_id,loc)values('R7511102814','120085');
insert into rainy_user_loc (user_id,loc)values('R7511102814','120157');
insert into rainy_user_loc (user_id,loc)values('R7511102814','120161');
insert into rainy_user_loc (user_id,loc)values('R7511102814','120163');
insert into rainy_user_loc (user_id,loc)values('R7511102814','120170');
insert into rainy_user_loc (user_id,loc)values('R7511102814','120188');


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
   AND RU.ID BETWEEN 2084 AND 2090;

--新建用户插入用户属性表，lang字段8表示中文，1表示英文
SELECT 'insert into user_attrib(user_id,user_name,lang) values(' || chr( 39) ||
       ru.user_id || chr( 39 ) || ',' || chr (39 ) || ru.user_name || chr( 39) || ',' || 8 || ')' || ';'
  FROM rainy_user ru ;

insert into user_attrib( user_id, user_name, lang)
select user_id,user_name, '8'
from rainy_user ru
where  to_number (RU.id ) BETWEEN 2084 AND 2090
and user_id not in ( select user_id from user_attrib );

--插入sec_user_group表，分二种情况插入
--Location地点
INSERT INTO sec_user_group
  SELECT sg.group_id , ru.user_id
    FROM rainy_user ru , rainy_user_loc rul , sec_group sg
   WHERE ru.user_id = rul.user_id
     AND sg.group_name LIKE '%Location%' || rul.loc || '%'
     AND RU.ID BETWEEN 2084 AND 2090 ;
--Department大类   
INSERT INTO sec_user_group
  SELECT sg.group_id , ru.user_id
    FROM rainy_user ru , rainy_user_merch rul , sec_group sg
   WHERE ru.user_id = rul.user_id
     AND sg.group_name LIKE '%Department%' || rul.merch || '%'
     AND RU.ID BETWEEN 2084 AND 2090
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
         AND RU.ID BETWEEN 2084 AND 2090
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
   AND RU.ID BETWEEN 2084 AND 2090;

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
and rul.loc = 'ALL'
AND RU.ID BETWEEN 2084 AND 2090
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
AND RU.ID BETWEEN 2084 AND 2090 ;

--用户大类权限导入
--查询出来的结果保存成txt文本文件，并且要把【”】去掉，然后用LDAP导入，file-->import
--SIM,RA/BIP系统的用户的创建、权限的修改，都是通过LDAP导入。
SELECT DISTINCT
'dn: cn=RA_DATA_SECURITY_DOMAIN@' ||MERCH|| ',cn=Groups,dc=bbg'|| CHR (10 )||
'changetype: modify' ||CHR ( 10 )||
'add: uniquemember'||CHR (10 )||
'uniquemember: cn='||a.USER_ID||',cn=users,dc=bbg' ||CHR ( 10 )
FROM RAINY_USER_MERCH a left join rainy_user ru on a.user_id=ru.user_id
where  RU.ID BETWEEN 2084 AND 2090 ;



--用户地点权限导入
--查询出来的结果保存成txt文本文件，并且要把【”】去掉，然后用LDAP导入，file-->import
--SIM,RA/BIP系统的用户的创建、权限的修改，都是通过LDAP导入。
SELECT DISTINCT
'dn: cn=RA_DATA_SECURITY_LOC@' ||a.LOC|| ',cn=Groups,dc=bbg'|| CHR (10 )||
'changetype: modify' ||CHR ( 10 )||
'add: uniquemember'||CHR (10 )||
'uniquemember: cn='||a.USER_ID||',cn=users,dc=bbg' ||CHR ( 10 )
FROM RAINY_USER_LOC a left join rainy_user ru on a.user_id=ru.user_id
where  RU.ID BETWEEN 2084 AND 2090 ;

--用户名和密码导出成EXCEL表格发邮件
SELECT USER_ID, USER_NAME, PASSWORD
FROM RAINY_USER ru
WHERE RU.ID BETWEEN 2084 AND 2090 
ORDER BY RU.ID;
