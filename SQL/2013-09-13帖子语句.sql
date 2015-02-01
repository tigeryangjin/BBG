create table table_a (
row_wid number(10),
item varchar2(25),
loc number(10),
effective_from_dt date,
effective_to_dt date);

insert into table_a (row_wid,item,loc,effective_from_dt,effective_to_dt) values (4,'800188132',120135, date'2011-01-28',date'2013-05-06');
insert into table_a (row_wid,item,loc,effective_from_dt,effective_to_dt) values (7,'800188132',120135, date'2011-04-18',date'2013-05-06');
insert into table_a (row_wid,item,loc,effective_from_dt,effective_to_dt) values (5,'800188132',120135, date'2011-05-23',date'2013-05-06');
insert into table_a (row_wid,item,loc,effective_from_dt,effective_to_dt) values (8,'800188132',120135, date'2011-06-11',date'2013-05-06');
insert into table_a (row_wid,item,loc,effective_from_dt,effective_to_dt) values (1,'100622763',120086, date'2011-02-05',date'2013-05-06');
insert into table_a (row_wid,item,loc,effective_from_dt,effective_to_dt) values (6,'100622763',120086, date'2011-03-11',date'2013-05-06');
insert into table_a (row_wid,item,loc,effective_from_dt,effective_to_dt) values (2,'100622763',120086, date'2011-05-09',date'2013-05-06');
insert into table_a (row_wid,item,loc,effective_from_dt,effective_to_dt) values (3,'100622763',120086, date'2011-05-12',date'2013-05-06');

SELEE


drop table table_a;
--帖子回复:
--1.Create  Table
Create Table Table_A
(
Row_Wid       Number(10) Not Null Primary Key,
Item          Varchar2(25) Not Null,
Loc           number(10) Not Null,
Effective_From_Date     Date,
effective_to_date       date
);

--2.Insert the records

Insert Into Table_A (Row_Wid,Item,Loc,Effective_From_Date,effective_to_date) Values (4,'800188132',120135, Date'2011-01-28',Date'2013-05-06');

Insert Into Table_A (Row_Wid,Item,Loc,Effective_From_Date,Effective_To_Date) Values (7,'800188132',120135, Date'2011-04-18',Date'2013-05-06');

Insert Into Table_A (Row_Wid,Item,Loc,Effective_From_Date,Effective_To_Date) Values (5,'800188132',120135, Date'2011-05-23',Date'2013-05-06');

Insert Into Table_A (Row_Wid,Item,Loc,Effective_From_Date,Effective_To_Date) Values (8,'800188132',120135, Date'2011-06-11',Date'2013-05-06');

Insert Into Table_A (Row_Wid,Item,Loc,Effective_From_Date,Effective_To_Date) Values (1,'100622763',120086, Date'2011-02-05',Date'2013-05-06');

Insert Into Table_A (Row_Wid,Item,Loc,Effective_From_Date,Effective_To_Date) Values (6,'100622763',120086, Date'2011-03-11',Date'2013-05-06');

Insert Into Table_A (Row_Wid,Item,Loc,Effective_From_Date,Effective_To_Date) Values (2,'100622763',120086, Date'2011-05-09',Date'2013-05-06');

Insert Into Table_A (Row_Wid,Item,Loc,Effective_From_Date,Effective_To_Date) Values (3,'100622763',120086, Date'2011-05-12',Date'2013-05-06');

--3. commit
commit;

--4. select all the records to confim
Select
*
from table_A;

--5. 最后用SQL处理的结果。
Select Row_Wid,      
Item,      
Loc,      
Rn,       
Effective_From_Date,       
Lead(Previous_Date) Over(Partition By Item, Loc Order By Effective_From_Date) To_Date  
From (Select Xt.Row_Wid,              
Xt.Item,              
Xt.Loc,               
Row_Number() Over(Partition By Item, Loc Order By Effective_From_Date) Rn,              
Xt.Effective_From_Date - 1 Previous_Date,               
Xt.Effective_From_Date          
From Table_a Xt)
ORDER BY ITEM,LOC,EFFECTIVE_FROM_DATE;
--我想到了这里你应该知道该怎么处理了。如果说数据量很大的话，可以考虑使用Procedure,然后使用批处理方法。

--看过帖子后修改语句
CREATE TABLE TABLE_B AS 
Select Xt.Row_Wid,              
Xt.Item,              
Xt.Loc,               
Xt.Effective_From_Date,
XT.EFFECTIVE_TO_DATE,
XT.CURRENT_FLG,
LEAD(Effective_From_Date) Over(Partition By Item, Loc Order By Effective_From_Date)-1 NEW_DT       
From Table_a Xt
ORDER BY XT.ITEM,XT.LOC,XT.EFFECTIVE_FROM_DATE;

--TABLE_B
SELECT * FROM TABLE_B;

--table_a add column Current_Flg
alter table table_a add  CURRENT_FLG char(1);

select * from table_a for update;

--UPDATE
UPDATE TABLE_A T 
SET T.EFFECTIVE_TO_DATE=(SELECT B.NEW_DT FROM TABLE_B B WHERE T.ROW_WID=B.ROW_WID)
WHERE T.CURRENT_FLG='N';
--此语句OK~
UPDATE TABLE_A T 
SET T.EFFECTIVE_TO_DATE=(SELECT B.NEW_EFFECTIVE_TO_DT 
                           FROM (SELECT ROW_WID,
                                        LEAD(Effective_From_Date) Over(Partition By Item, Loc Order By Effective_From_Date)-1 NEW_EFFECTIVE_TO_DT
                                   FROM TABLE_A) B 
                           WHERE T.ROW_WID=B.ROW_WID)
WHERE T.CURRENT_FLG='N';

--TEST
UPDATE TABLE_A T
SET T.EFFECTIVE_TO_DATE=(SELECT LEAD(Effective_From_Date) Over(Partition By Item, Loc Order By Effective_From_Date)-1
                           FROM TABLE_A B
                           WHERE T.ROW_WID=B.ROW_WID)
WHERE T.CURRENT_FLG='N';


