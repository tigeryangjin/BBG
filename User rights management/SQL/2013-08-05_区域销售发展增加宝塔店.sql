insert into rainy_user_loc (user_id,loc)values('R6911201528','120081');
insert into rainy_user_loc (user_id,loc)values('R7508220284','120081');
insert into rainy_user_loc (user_id,loc)values('R8605048168','120081');
insert into rainy_user_loc (user_id,loc)values('R9009157484','120081');
insert into rainy_user_loc (user_id,loc)values('R8010017123','120081');
insert into rainy_user_loc (user_id,loc)values('R8108142575','120081');
insert into rainy_user_loc (user_id,loc)values('R6707282045','120081');

SELECT * FROM RAINY_USER WHERE USER_ID = 'R6911201528';


--插入sec_user_group表，分二种情况插入
--Location地点
INSERT INTO sec_user_group
  SELECT sg.group_id , ru.user_id
    FROM rainy_user ru , rainy_user_loc rul , sec_group sg
   WHERE ru.user_id = rul.user_id
     AND sg.group_name LIKE '%Location%' || rul.loc || '%'
     AND RU.USER_ID IN ('R6911201528','R7508220284','R8605048168','R9009157484','R8010017123'/*,'R8108142575'*/,'R6707282045') AND RUL.LOC='120081';
     
SELECT * FROM sec_user_group WHERE USER_ID='R8108142575' AND GROUP_ID=1357;

