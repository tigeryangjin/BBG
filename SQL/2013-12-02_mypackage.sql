--package head
create or replace package mypackage
    is
    procedure sp_emp_insert;
    function f_getename(i_empno number) return varchar2;
    end mypackage;
--package body		
create or replace package body mypackage
    is
    procedure sp_emp_insert
    is
    begin
    insert into emp(empno,ename,job,mgr,hiredate,sal,comm,deptno)
    values(7384,'WangYi','SALESMAN',7698,to_date('2011-07-29','yyyy-mm-dd'),1250.00,1400.00,30);
    commit;
    end;
   function f_getename(i_empno number)
   return varchar2
   is
   v_ename varchar2(200);
   begin
   select ename into v_ename from emp where empno=i_empno;
   return v_ename;
   end;
   end;
	 
--package call
select mypackage.sp_emp_insert from dual;
select mypackage.f_getename(7384) from dual;
