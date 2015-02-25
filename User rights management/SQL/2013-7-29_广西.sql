--全部已经新建
insert into rainy_user(user_id,user_name,id) values('R7008280813','易鸿仪','1040');
insert into rainy_user(user_id,user_name,id) values('R8906292121','王翠珍','1041');
insert into rainy_user(user_id,user_name,id) values('R7409210039','沈少军','1042');
insert into rainy_user(user_id,user_name,id) values('R7410120638','张广鸿','1043');
insert into rainy_user(user_id,user_name,id) values('R7704141035','彭林涛','1044');
insert into rainy_user(user_id,user_name,id) values('R8002104624','蒋冬梅','1045');
insert into rainy_user(user_id,user_name,id) values('R8304170026','宁晓','1046');
insert into rainy_user(user_id,user_name,id) values('R8601050062','黄诗','1047');
insert into rainy_user(user_id,user_name,id) values('R7811281443','刘莉','1048');
insert into rainy_user(user_id,user_name,id) values('R8812207290','唐晓明','1049');
insert into rainy_user(user_id,user_name,id) values('R8108031665','田娟','1050');
insert into rainy_user(user_id,user_name,id) values('R8109170059','田洪','1051');
insert into rainy_user(user_id,user_name,id) values('R8907012810','梁承刚','1052');
insert into rainy_user(user_id,user_name,id) values('R8703019223','梁玉玲','1053');
insert into rainy_user(user_id,user_name,id) values('R7909050071','章伟龙','1054');
insert into rainy_user(user_id,user_name,id) values('R7811205850','黄维忠','1055');
insert into rainy_user(user_id,user_name,id) values('R8312264015','韦锦电','1056');
insert into rainy_user(user_id,user_name,id) values('R8705252210','严乐','1057');
insert into rainy_user(user_id,user_name,id) values('R8511232032','零斌','1058');
insert into rainy_user(user_id,user_name,id) values('R790917003X','韦林','1059');
insert into rainy_user(user_id,user_name,id) values('R7211050410','谢江帆','1060');
insert into rainy_user(user_id,user_name,id) values('R7308210342','黄晓红','1061');
insert into rainy_user(user_id,user_name,id) values('R8205120310','唐敏','1062');
insert into rainy_user(user_id,user_name,id) values('R6708041534','周学军','1063');
insert into rainy_user(user_id,user_name,id) values('R8805240427','梁艳珍','1064');


--权限变更的用户修改ID列，从BBG_Security_Application_User_List表中获取
SELECT * FROM RAINY_USER
WHERE USER_ID= 'R7008280813' FOR UPDATE;




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
   AND RU.ID BETWEEN 1040 AND 1064;
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
AND RU.ID BETWEEN 1040 AND 1064;

--用户大类权限删除
--查询出来的结果保存成txt文本文件，并且要把【”】去掉，然后用LDAP导入，file-->import
--SIM,RA/BIP系统的用户的创建、权限的修改，都是通过LDAP导入。
SELECT DISTINCT
'dn: cn=RA_DATA_SECURITY_DOMAIN@' ||MERCH || ',cn=Groups,dc=bbg'||CHR ( 10 )||
'changetype: modify' ||CHR (10 )||
'delete: uniquemember' ||CHR (10 )||
'uniquemember: cn='||a.USER_ID ||',cn=users,dc=bbg' ||CHR (10 )
FROM RAINY_USER_MERCH a left join rainy_user ru on a.user_id =ru.user_id
where  RU.ID BETWEEN 1040 AND 1064;



--用户地点权限删除
--查询出来的结果保存成txt文本文件，并且要把【”】去掉，然后用LDAP导入，file-->import
--SIM,RA/BIP系统的用户的创建、权限的修改，都是通过LDAP导入。
SELECT DISTINCT
'dn: cn=RA_DATA_SECURITY_LOC@' ||a.LOC || ',cn=Groups,dc=bbg'||CHR ( 10 )||
'changetype: modify' ||CHR (10 )||
'delete: uniquemember' ||CHR (10 )||
'uniquemember: cn='||a.USER_ID ||',cn=users,dc=bbg' ||CHR (10 )
FROM RAINY_USER_LOC a left join rainy_user ru on a.user_id =ru.user_id
where  RU.ID BETWEEN 1040 AND 1064 ;   
 
--删除表中用户数据，权限清除后需要删除的表
DELETE FROM RSM_USER_ROLE A WHERE EXISTS (SELECT 1 FROM RAINY_USER RU WHERE A.USER_ID=RU.USER_ID AND RU.ID BETWEEN 1040 AND 1064);
DELETE FROM SEC_USER_GROUP A WHERE EXISTS (SELECT 1 FROM RAINY_USER RU WHERE A.USER_ID=RU.USER_ID AND RU.ID BETWEEN 1040 AND 1064);
DELETE FROM RAINY_USER_LOC A WHERE EXISTS (SELECT 1 FROM RAINY_USER RU WHERE A.USER_ID=RU.USER_ID AND RU.ID BETWEEN 1040 AND 1064);
DELETE FROM RAINY_USER_MERCH A WHERE EXISTS (SELECT 1 FROM RAINY_USER RU WHERE A.USER_ID=RU.USER_ID AND RU.ID BETWEEN 1040 AND 1064);
DELETE FROM RAINY_USER_POSITION A WHERE EXISTS (SELECT 1 FROM RAINY_USER RU WHERE A.USER_ID=RU.USER_ID AND RU.ID BETWEEN 1040 AND 1064);




insert into rainy_user_position(user_id,position_id) values('R7008280813',117);
insert into rainy_user_position(user_id,position_id) values('R8906292121',121);
insert into rainy_user_position(user_id,position_id) values('R7409210039',119);
insert into rainy_user_position(user_id,position_id) values('R7410120638',119);
insert into rainy_user_position(user_id,position_id) values('R7704141035',120);
insert into rainy_user_position(user_id,position_id) values('R8002104624',120);
insert into rainy_user_position(user_id,position_id) values('R8304170026',120);
insert into rainy_user_position(user_id,position_id) values('R8601050062',120);
insert into rainy_user_position(user_id,position_id) values('R7811281443',120);
insert into rainy_user_position(user_id,position_id) values('R8812207290',120);
insert into rainy_user_position(user_id,position_id) values('R8108031665',118);
insert into rainy_user_position(user_id,position_id) values('R8109170059',119);
insert into rainy_user_position(user_id,position_id) values('R8907012810',120);
insert into rainy_user_position(user_id,position_id) values('R8703019223',120);
insert into rainy_user_position(user_id,position_id) values('R7909050071',122);
insert into rainy_user_position(user_id,position_id) values('R7811205850',123);
insert into rainy_user_position(user_id,position_id) values('R8312264015',124);
insert into rainy_user_position(user_id,position_id) values('R8511232032',125);
insert into rainy_user_position(user_id,position_id) values('R790917003X',125);
insert into rainy_user_position(user_id,position_id) values('R7211050410',124);
insert into rainy_user_position(user_id,position_id) values('R7308210342',125);
insert into rainy_user_position(user_id,position_id) values('R8205120310',31);
insert into rainy_user_position(user_id,position_id) values('R8205120310',33);
insert into rainy_user_position(user_id,position_id) values('R8205120310',35);
insert into rainy_user_position(user_id,position_id) values('R8205120310',39);
insert into rainy_user_position(user_id,position_id) values('R8205120310',41);
insert into rainy_user_position(user_id,position_id) values('R8205120310',125);
insert into rainy_user_position(user_id,position_id) values('R6708041534',44);
insert into rainy_user_position(user_id,position_id) values('R6708041534',46);
insert into rainy_user_position(user_id,position_id) values('R6708041534',48);
insert into rainy_user_position(user_id,position_id) values('R6708041534',55);
insert into rainy_user_position(user_id,position_id) values('R8805240427',44);
insert into rainy_user_position(user_id,position_id) values('R8805240427',46);
insert into rainy_user_position(user_id,position_id) values('R8805240427',48);
insert into rainy_user_position(user_id,position_id) values('R8805240427',55);

------------------------
insert into rainy_user_merch(user_id,merch) values('R7008280813','ALL');
insert into rainy_user_merch(user_id,merch) values('R8906292121','ALL');
insert into rainy_user_merch(user_id,merch) values('R7409210039','21');
insert into rainy_user_merch(user_id,merch) values('R7409210039','22');
insert into rainy_user_merch(user_id,merch) values('R7409210039','23');
insert into rainy_user_merch(user_id,merch) values('R7409210039','24');
insert into rainy_user_merch(user_id,merch) values('R7409210039','25');
insert into rainy_user_merch(user_id,merch) values('R7409210039','26');
insert into rainy_user_merch(user_id,merch) values('R7410120638','29');
insert into rainy_user_merch(user_id,merch) values('R7704141035','21');
insert into rainy_user_merch(user_id,merch) values('R7704141035','22');
insert into rainy_user_merch(user_id,merch) values('R8002104624','23');
insert into rainy_user_merch(user_id,merch) values('R8304170026','24');
insert into rainy_user_merch(user_id,merch) values('R8601050062','25');
insert into rainy_user_merch(user_id,merch) values('R8601050062','26');
insert into rainy_user_merch(user_id,merch) values('R7811281443','29');
insert into rainy_user_merch(user_id,merch) values('R8812207290','29');
insert into rainy_user_merch(user_id,merch) values('R8108031665','11');
insert into rainy_user_merch(user_id,merch) values('R8108031665','12');
insert into rainy_user_merch(user_id,merch) values('R8108031665','13');
insert into rainy_user_merch(user_id,merch) values('R8108031665','14');
insert into rainy_user_merch(user_id,merch) values('R8108031665','15');
insert into rainy_user_merch(user_id,merch) values('R8108031665','16');
insert into rainy_user_merch(user_id,merch) values('R8108031665','17');
insert into rainy_user_merch(user_id,merch) values('R8108031665','18');
insert into rainy_user_merch(user_id,merch) values('R8108031665','19');
insert into rainy_user_merch(user_id,merch) values('R8109170059','11');
insert into rainy_user_merch(user_id,merch) values('R8109170059','12');
insert into rainy_user_merch(user_id,merch) values('R8109170059','13');
insert into rainy_user_merch(user_id,merch) values('R8109170059','14');
insert into rainy_user_merch(user_id,merch) values('R8109170059','15');
insert into rainy_user_merch(user_id,merch) values('R8907012810','12');
insert into rainy_user_merch(user_id,merch) values('R8703019223','16');
insert into rainy_user_merch(user_id,merch) values('R8703019223','17');
insert into rainy_user_merch(user_id,merch) values('R7909050071','27');
insert into rainy_user_merch(user_id,merch) values('R7909050071','30');
insert into rainy_user_merch(user_id,merch) values('R7909050071','31');
insert into rainy_user_merch(user_id,merch) values('R7909050071','32');
insert into rainy_user_merch(user_id,merch) values('R7909050071','33');
insert into rainy_user_merch(user_id,merch) values('R7909050071','34');
insert into rainy_user_merch(user_id,merch) values('R7909050071','35');
insert into rainy_user_merch(user_id,merch) values('R7909050071','36');
insert into rainy_user_merch(user_id,merch) values('R7909050071','37');
insert into rainy_user_merch(user_id,merch) values('R7909050071','38');
insert into rainy_user_merch(user_id,merch) values('R7909050071','39');
insert into rainy_user_merch(user_id,merch) values('R7909050071','40');
insert into rainy_user_merch(user_id,merch) values('R7909050071','41');
insert into rainy_user_merch(user_id,merch) values('R7909050071','42');
insert into rainy_user_merch(user_id,merch) values('R7811205850','33');
insert into rainy_user_merch(user_id,merch) values('R7811205850','36');
insert into rainy_user_merch(user_id,merch) values('R7811205850','37');
insert into rainy_user_merch(user_id,merch) values('R8312264015','31');
insert into rainy_user_merch(user_id,merch) values('R8312264015','34');
insert into rainy_user_merch(user_id,merch) values('R8312264015','39');
insert into rainy_user_merch(user_id,merch) values('R8705252210','38');
insert into rainy_user_merch(user_id,merch) values('R8705252210','42');
insert into rainy_user_merch(user_id,merch) values('R8511232032','27');
insert into rainy_user_merch(user_id,merch) values('R790917003X','32');
insert into rainy_user_merch(user_id,merch) values('R790917003X','35');
insert into rainy_user_merch(user_id,merch) values('R7211050410','31');
insert into rainy_user_merch(user_id,merch) values('R7308210342','34');
insert into rainy_user_merch(user_id,merch) values('R7308210342','39');
insert into rainy_user_merch(user_id,merch) values('R8205120310','ALL');
insert into rainy_user_merch(user_id,merch) values('R6708041534','ALL');
insert into rainy_user_merch(user_id,merch) values('R8805240427','ALL');

-----------------------
insert into rainy_user_loc (user_id,loc)values('R8812207290','120195');
insert into rainy_user_loc (user_id,loc)values('R8108031665','120195');
insert into rainy_user_loc (user_id,loc)values('R8109170059','120195');
insert into rainy_user_loc (user_id,loc)values('R8907012810','120195');
insert into rainy_user_loc (user_id,loc)values('R8703019223','120195');
insert into rainy_user_loc (user_id,loc)values('R7909050071','120195');
insert into rainy_user_loc (user_id,loc)values('R7811205850','120195');
insert into rainy_user_loc (user_id,loc)values('R8312264015','120195');
insert into rainy_user_loc (user_id,loc)values('R8705252210','120195');
insert into rainy_user_loc (user_id,loc)values('R8511232032','120195');
insert into rainy_user_loc (user_id,loc)values('R790917003X','120195');
insert into rainy_user_loc (user_id,loc)values('R7211050410','120195');
insert into rainy_user_loc (user_id,loc)values('R7308210342','120195');
insert into rainy_user_loc (user_id,loc)values('R8205120310','120195');
insert into rainy_user_loc (user_id,loc)values('R6708041534','120195');
insert into rainy_user_loc (user_id,loc)values('R8805240427','120195');
insert into rainy_user_loc (user_id,loc)values('R7008280813','120195');
insert into rainy_user_loc (user_id,loc)values('R8906292121','120195');
insert into rainy_user_loc (user_id,loc)values('R7409210039','120195');
insert into rainy_user_loc (user_id,loc)values('R7410120638','120195');
insert into rainy_user_loc (user_id,loc)values('R7704141035','120195');
insert into rainy_user_loc (user_id,loc)values('R8002104624','120195');
insert into rainy_user_loc (user_id,loc)values('R8304170026','120195');
insert into rainy_user_loc (user_id,loc)values('R8601050062','120195');
insert into rainy_user_loc (user_id,loc)values('R7811281443','120195');

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
   AND RU.ID BETWEEN 1040 AND 1064;
--新建用户插入用户属性表，lang字段8表示中文，1表示英文
SELECT 'insert into user_attrib(user_id,user_name,lang) values(' || chr( 39) ||
       ru.user_id || chr( 39) || ',' || chr (39 ) || ru.user_name || chr( 39) || ',' || 8 || ')' ||';'
  FROM rainy_user ru ;

insert into user_attrib( user_id, user_name, lang) 
select user_id,user_name, '8' 
from rainy_user 
where  to_number (id )  BETWEEN 1040 AND 1064
and user_id not in ( select user_id from user_attrib );

--插入sec_user_group表，分二种情况插入
--Location地点
INSERT INTO sec_user_group
  SELECT sg.group_id , ru.user_id
    FROM rainy_user ru , rainy_user_loc rul , sec_group sg
   WHERE ru.user_id = rul.user_id
     AND sg.group_name LIKE '%Location%' || rul.loc || '%'
     AND RU.ID BETWEEN 1040 AND 1064;
--Department大类    
INSERT INTO sec_user_group
  SELECT sg.group_id , ru.user_id
    FROM rainy_user ru , rainy_user_merch rul , sec_group sg
   WHERE ru.user_id = rul.user_id
     AND sg.group_name LIKE '%Department%' || rul.merch || '%'
     AND RU.ID BETWEEN 1040 AND 1064
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
         AND RU.ID BETWEEN 1040 AND 1064
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
uid: ' || ru.user_id || chr (13 ) || 'cn:' || ru.user_id || chr(13 ) ||
        'sn: ' || ru.user_id || chr( 13) || 'description:' || rp.position ||
        chr( 13) || 'givenname: ' || ru.user_id || chr (13 ) || 'superUser: FALSE
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
        (SELECT rul.loc
           FROM rainy_user_loc rul
          WHERE rul.user_id = ru.user_id
            AND rownum = 1) || ',cn=SIMStores,cn=SIM,dc=bbg,dc=com
userpassword: ' || ru.password || chr (13 ) ||
       to_char ( (SELECT   wm_concat( 'userstores: storeId=' || rull.loc ||',cn=SIMStores,cn=SIM,dc=bbg' ||chr (13 ))
      
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
   --AND RU.ID in (901,902)
   AND RU.ID BETWEEN 1040 AND 1064;

--SIM系统导入
--查询出来的结果保存成txt文本文件，并且要把【”】去掉，然后用LDAP导入，file-->import 
--注意：userRoleStores为ALL时要替换。。。替换整行。。。 
SELECT rr.role_name, ru.user_id, 'dn: roleName=' || rr.role_name || ',cn=' || ru.user_id ||
        ',cn=Users,dc=bbg
changetype: add
objectclass: simUserRole
roleName: ' || rr.role_name || chr (13 ) || 'userRole: roleName=' ||
        rr.role_name || ',cn=SIMRoles,cn=SIM,dc=bbg
userRoleStores: ' || wm_concat( 'storeId=' || rul.loc || ',cn=SIMStores,cn=SIM,dc=bbg'||chr (13 ))
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
AND RU.ID BETWEEN 1040 AND 1064
GROUP BY   rr.role_name, ru.user_id;

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
AND RU.ID BETWEEN 1040 AND 1064;

--用户大类权限导入
--查询出来的结果保存成txt文本文件，并且要把【”】去掉，然后用LDAP导入，file-->import 
--SIM,RA/BIP系统的用户的创建、权限的修改，都是通过LDAP导入。
SELECT DISTINCT
'dn: cn=RA_DATA_SECURITY_DOMAIN@'||MERCH|| ',cn=Groups,dc=bbg'||CHR (10 )||
'changetype: modify'||CHR (10 )||
'add: uniquemember'||CHR (10 )||
'uniquemember: cn='||a.USER_ID||',cn=users,dc=bbg' ||CHR (10 )
FROM RAINY_USER_MERCH a left join rainy_user ru on a.user_id=ru.user_id
where  RU.ID BETWEEN 1040 AND 1064;



--用户地点权限导入
--查询出来的结果保存成txt文本文件，并且要把【”】去掉，然后用LDAP导入，file-->import 
--SIM,RA/BIP系统的用户的创建、权限的修改，都是通过LDAP导入。
SELECT DISTINCT
'dn: cn=RA_DATA_SECURITY_LOC@'||a.LOC|| ',cn=Groups,dc=bbg'||CHR (10 )||
'changetype: modify'||CHR (10 )||
'add: uniquemember'||CHR (10 )||
'uniquemember: cn='||a.USER_ID||',cn=users,dc=bbg' ||CHR (10 )
FROM RAINY_USER_LOC a left join rainy_user ru on a.user_id=ru.user_id
where  RU.ID BETWEEN 1040 AND 1064 ;

--用户名和密码导出成EXCEL表格发邮件
SELECT USER_ID, USER_NAME, PASSWORD
FROM RAINY_USER
WHERE ID BETWEEN 1040 AND 1064;
