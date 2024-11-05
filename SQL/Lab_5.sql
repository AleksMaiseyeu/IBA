use [Maiseyeu_04]
--Lab 5
--���������������� T-SQL.
--Transact-SQL (T-SQL) � ����������� ���������� ����� SQL

/*DDL (Data Definition Language) � ��������� ����� ���� ������������ ��� �������� �������� � ���� ������. 
�������� ������������� ������� ������: 
CREATE � �������� ��������, 
ALTER � ��������� ��������, 
DROP � �������� ��������.

DCL (Data Control Language) � ��������� ����� ���� ������������� ��� ���������� ���� �� ������� ���� ������. 
�������� ������������� ������� ������: 
GRANT � ���������� �� ������, 
DENY � ������ �� ������, 
REVOKE � ������ ���������� � �������� �� ������.

DML (Data Manipulation Language) � ��������� ����� ���� ������������ ��� �������� � ��������� ������. 
�������� ������������� ������� ������: 
SELECT � ������� ������, 
INSERT � ������� ������, 
UPDATE � ��������� ������, 
DELETE � �������� ������.


� Transact-SQL ���������� ����������� �������, ������� ��������� ��������� ������� ���������� ��������, 
�������� ��� ��� ��������� � ������ �����.

���� ����������� � ���������, ������������ ������ ��������� � ���� ���������� ���� (BEGIN � END).
���� ������� � ���������, ����������� ���������� ������������ ������� (IF � ELSE).
���� ����� � ���������, ������������ ���������� ���������� ����������� ����� (WHILE � BREAK � CONTINUE).
������� � �������, ����������� ������� ������ ���������� �������� �� ��������� ����� (GOTO).
�������� � �������, ������������� ���������� �������� (WAITFOR).
����� ������ � �������, ������������ ������ ���������� �������� (RAISERROR).

*/

--1.	����������� T-SQL-������  ���������� ����������: 
--1.1.	�������� ���������� ����: char, varchar, datetime, time, int, smallint,  tinint, numeric(12, 5).
declare @char char;
declare @varchar varchar;
declare @datetime datetime;
declare @time time;
declare @int int;
declare @tinyint tinyint; /*-128 -- 127 ��� 0--255 */
declare @numeric numeric(13,5);
go


--1.2.	������ ��� ���������� ������������������� � ��������� ����������.
declare @char char = 'F' ;
declare @varchar varchar(5) = 'text';
print @char;
print @varchar;
go


--1.3.	���������  ������������ �������� ��������� ���� ���������� � ������� ��������� SET, 
--����� ��  ���� ����������  ��������� ��������, ���������� � ���������� ������� SELECT.
declare @datetime datetime, @time time;
set @datetime = '2024-10-10 15:03:15';
set @time = '15:05:00';
print @datetime;
set @datetime = (select TOP(1) o.ORDER_DATE from ORDERS o)
print @datetime;
print @time;
go


--1.4.	���� �� ���������� �������� ��� ������������� � �� ����������� �� ��������, 
--���������� ���������� ��������� ��������� �������� � ������� ��������� SELECT;. 
declare @char char;
declare @varchar varchar(3);
declare @datetime datetime;
declare @time time;
declare @int int;
declare @tinyint tinyint;
declare @numeric numeric(13,5);

select 
 @varchar ='MG',
 @datetime = getdate(),
 @time  ='15:30:32',
 @int  =9010 ,
 @tinyint = 113,
 @numeric = 12.98;



--1.5.	�������� �������� ���������� ������� � ������� ��������� SELECT, 
--�������� ������ �������� ���������� ����������� � ������� ��������� PRINT. 

 select  @varchar, @datetime, @time 
 print  @int 
 print  @tinyint 
 print  @numeric 
 go

--2. ����������� ������, � ������� ������������ ������� ��������� ��������. 
--���� ������� ��������� �������� ��������� 10, �� ������� ���������� ���������, 
--������� ��������� ��������, ������������ ��������� ��������. 
--���� ������� ��������� �������� ������ 10, �� ������� ����������� ��������� ��������. 

USE [Maiseyeu_04]

declare @avg_cost numeric(12,3) = (select AVG(p.PRICE) from products p);
declare @min_cost numeric(12,3) = (select min(p.PRICE) from products p);
declare @count_product INT = (select count(p.PRODUCT_ID) from PRODUCTS p);
declare @max_cost numeric(12,3) = (select max(p.PRICE) from products p);

if (@avg_cost<10) 
   select @count_product, @avg_cost, @max_cost 
else if (@avg_cost>10)
    select @avg_cost, @min_cost
else
    print '@avg_cost=10'
go

--3.	���������� ���������� ������� ���������� � ������������ ������. 
declare @StartDate date, @EndDate date, @EmplNum int
set @StartDate= '2008-01-01' 
set @EndDate= '2008-12-31'
set @EmplNum = 101

declare @OrderCount int = (select COUNT(o.ORDER_NUM) from ORDERS o
                          where (o.ORDER_DATE between @StartDate and @EndDate)
						  and o.REP =@EmplNum)
select @EmplNum, @OrderCount


use [Maiseyeu_04]
--4.	����������� T-SQL-�������, �����������: 
--4.1.	�������������� ����� ���������� � ��������.
select * from SALESREPS s
declare @full_name varchar(20) 
  set  @full_name = (select top(1) name from SALESREPS)
declare @first_later varchar(1) = Left(@full_name, 1)
declare @surname varchar(20) =  right(@full_name, LEN(@full_name)-CHARINDEX(' ', @full_name));
declare @nikName varchar(20) =  @surname + ' ' + @first_later + '.';
select @full_name, @first_later,  @surname, @nikName
go

--- ��������� ��� ����� ������� SALESREPS � ������� ��������
declare @full_name varchar(30);

declare nickName_cursor cursor for
  select 
    name
  from SALESREPS

open nickName_cursor; 
fetch from nickName_cursor into @full_name;
while @@FETCH_STATUS=0
  begin
     select     
     @full_name, 
	 Left(@full_name, 1),  
	 right(@full_name, LEN(@full_name)-CHARINDEX(' ', @full_name)); 

  end
close nickName_cursor; 
deallocate nickName_cursor;


use [Maiseyeu_04]


--4.2.	����� �����������, � ������� ���� ����� � ��������� ������.
select * from SALESREPS s 
where month(s.HIRE_DATE) = Month(GETDATE()) +1;

--4.3.	����� �����������, ������� ����������� ����� 10 ���.
select * from SALESREPS s
where DATEDIFF(YY, s.HIRE_DATE, GETDATE())>10


--4.4.	����� ��� ������, � ������� �������� ������.
select DATENAME(dw, ORDER_DATE) as DayWeek, * from ORDERS 


--5.	������������������ ���������� ��������� IF� ELSE.
declare @firstN int =10;
declare @lastN int =20;
declare @variable int = 3;

if (@variable between @firstN and @lastN) 
   print '������ � �������� ��������'
else
   print '�� ������' 
go;


--6.	������������������ ���������� ��������� CASE.
declare @variable int = 3;
  select case 
    when (@variable<10) then '<10'
    when (@variable>10) then '>10'
	else '=10'
   end;

--7.	������������������ ���������� ��������� RETURN. 


--8.	����������� ������ � ��������, � ������� ������������ ��� ��������� ������ ����� TRY � CATCH. 
---��������� ������� ERROR_NUMBER (��� ��������� ������), 
---ERROR_MESSAGE (��������� �� ������), 
---ERROR_LINE(��� ��������� ������), 
---ERROR_PROCEDURE (���  ��������� ��� NULL), 
---ERROR_SEVERITY (������� ����������� ������), 
---ERROR_STATE (����� ������). 

declare @val int = 3
begin try 
   set @val = @val/0
end try
begin catch
 print error_number();
 print error_message();
 print error_line();
 print error_procedure();
 print error_severity();
 print error_state();
end catch
go

--- ��� ���
declare @val int = 3
begin try 
   set @val = @val/'text'
end try
begin catch
 select error_number(), error_message(), error_line(), error_procedure(), error_severity(),error_state();
end catch
go

--9.	������� ��������� ��������� ������� �� ���� ��������. �������� ������ (10 �����) � �������������� ��������� WHILE. 
--������� �� ����������.
use [Maiseyeu_04]
create table #tempTable
(ID INT IDENTITY,
 A_DATE DATE,
 numb VARCHAR(20)
)
declare @num int = 1;
while (@num<=10)
  begin
    insert into #tempTable (A_DATE, numb)
        values(GETDATE(), cast(@num as varchar(2)));
    set @num = @num +1;
  end 

  -- ��������, ��� ����������
  select * from #tempTable
