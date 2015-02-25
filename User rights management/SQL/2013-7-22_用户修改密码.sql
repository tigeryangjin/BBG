--修改密码
update rainy_user t
set t.password =( select upper(dbms_random.string ('u' , 2 ))||dbms_random.string ('l' , 3 )|| trunc(dbms_random.value (0 ,10 ))||trunc ( dbms_random.value ( 0 ,10 ))|| trunc (dbms_random.value (0 , 10 ))
                   from rainy_user a
                  where t.user_id = a.user_id )
where /*t.password is null
AND*/ USER_ID IN ('R8301262089',
'R8607045071',
'R8706300562',
'R880814206X',
'R900508178X',
'R7906266439',
'R9010030043'
);

SELECT * FROM RAINY_USER WHERE USER_ID IN ('R8301262089',
'R8607045071',
'R8706300562',
'R880814206X',
'R900508178X',
'R7906266439',
'R9010030043'
);

--修改ORACLE用户的密码
SELECT 'ALTER USER '||T.USER_ID||' IDENTIFIED BY '||T.PASSWORD||';' FROM RAINY_USER T WHERE T.USER_ID IN ('R8301262089',
'R8607045071',
'R8706300562',
'R880814206X',
'R900508178X',
'R7906266439',
'R9010030043'
);
ALTER USER R8706300562 IDENTIFIED BY QUopd677


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
   AND EXISTS( SELECT 1 FROM RAINY_USER_LOC RULL WHERE RULL.USER_ID=RU.USER_ID AND RULL.LOC <> 'ALL')
   --AND ru.user_id NOT IN (SELECT rull.user_id FROM rainy_user_loc rull WHERE rull.loc <> 'ALL')
   --AND RU.ID in (901,902)
   AND RU. USER_ID IN ('R8301262089',
'R8607045071',
'R8706300562',
'R880814206X',
'R900508178X',
'R7906266439',
'R9010030043'
);






SELECT USER_ID,USER_NAME,PASSWORD FROM RAINY_USER WHERE USER_ID IN ('R8301262089',
'R8607045071',
'R8706300562',
'R880814206X',
'R900508178X',
'R7906266439',
'R9010030043'
);
