--������������ ������ �8
--�������� � T-SQL.
/*
1.�����
2.����������� �����������
3.������-��������
*/
use [Maiseyeu_04]
GO

--1.	����������� ��������� DML �������� � ������������������ ����������������� ���������: 
--1.1.	��� ���������� ������ ����� ��������� ������ � ������� ����� � ������� Audit.

--drop trigger TR_OFFICE_INS;

create trigger TR_OFFICE_INS 
on OFFICES AFTER INSERT
as
  declare @in varchar(300);
  PRINT 'INSERT';          
  set @in = (select CAST(i.OFFICE as varchar(10))+ '-' + 
                         i.CITY + '-' + 
						 i.REGION from INSERTED i);
  insert into AUDIT(ST, TRN, C) values('INS', 'TR_OFFICE_INS', @in);
  RETURN;
go

insert into OFFICES(office, city, REGION, MGR, TARGET,SALES) 
         values(33, 'Grodno', 'RepBelarus',106 ,298475, 390800.00);
-- �������
select * from OFFICES;
select * from AUDIT

--1.2.	��� ���������� ������ ����� ��������� ������ � ����������� ������� ����� � ������� Audit.

create trigger TR_OFFICE_UPD
on OFFICES AFTER UPDATE
AS
  declare @up varchar(300);
  set @up = (select CAST(OFFICE as varchar(5)) + '-' +
                    CITY + '-' +
					CAST(MGR as varchar(5)) + '-' +
					REGION + '-' +  
					CAST(SALES as varchar(13))+ '-' +
					CAST(TARGET as varchar(13))
					from deleted)
  INSERT INTO AUDIT(ST, TRN, C) VALUES('UPD', 'TR_OFFICE_UPD', @up);
  return;
go;

select * from OFFICES;
update OFFICES set CITY='Brest', REGION='Republic' where OFFICE=31;
--���������
select * from AUDIT;

--1.3.	��� �������� ������ � ����� ��������� ������ � ������� ����� � ������� Audit. 

create trigger TR_OFFICE_DEL
on OFFICES AFTER DELETE
AS
  declare @d varchar(300);
  set @d = (select 
         CAST(d.OFFICE as Varchar(5)) + '-' +
		 d.CITY + '-' +
		 CAST(d.MGR as varchar(5)) + '-' + 
		 d.REGION + '-' +
		 CAST(d.SALES as varchar(13)) + '-' +
		 CAST(d.TARGET as varchar(13))
  from deleted d);

  insert into AUDIT (ST, TRN, C) values ('DEL', 'TR_OFFICE_DEL', @d);
  return;

select * from OFFICES;
delete from OFFICES where OFFICE=33;
select * from AUDIT;

-- ��������/ ��������� �������
DISABLE Trigger TR_OFFICE_DEL on OFFICES; 
ENABLE TRIGGER TR_OFFICE_DEL on OFFICES; 

/* softDelete - ������ �������� 
� ��� ����� ������, ��� ������� ������ � ���� ������ ������ ���������� ��� ���������, 
�� �� ����� ��� �������� �� ������� ������.*/

/*INSTEAD OF: ����������� ������ �������� 
(�� ���� �� ���� �������� - ����������, ��������� ��� �������� - ������ �� �����������). 
������������ ��� ������ � �������������
*/


--drop trigger TR_OFFICE_INSTEAD_OF;
create trigger TR_OFFICE_INSTEAD_OF
on OFFICES INSTEAD OF UPDATE
AS
  RAISERROR(N'Cannot update offices', 10, 1);
  return;

update OFFICES set CITY='!!-Brest-!!!', REGION='Republic' where OFFICE=11;

select * from OFFICES;
select * from AUDIT

--2.	����������� ������, ������� �������������, ��� �������� ����������� ����������� 
--  ����������� �� ������������ AFTER-��������.
/*
    �������� AFTER ������� �� �����������, ���� ���������� ��������� �����������, 
	������� ��� �������� ������ ������������ ��� �����-���� ���������, 
	������� ����� �� ������������� ��������� �����������.
*/
--=====������=====--
-- ������ ������� ������ ������� ������  � ���������� ������ ������, � ���������� ���� ������
-- ������ ������ �� ���� �������� ������ ��������

----???????? ��� ������� ���������� �� �������� CASCADE ???????????????????


select * from ORDERS o

select c.CUST_NUM from CUSTOMERS c

create trigger TR_DEL_Customer
on orders after update
as
  declare @custNum int;
  set @custNum = (select CUST from deleted);
  delete from CUSTOMERS where CUST_NUM = @custNum;
  return;

-- ������ �������� ������ ��������, ������� ������ ������ ������ ������
update ORDERS set QTY = 6 where ORDER_NUM = 113048; 
/* ���� ��� 
 113048	2008-02-10	2120	102	IMM	779C 	2	3750.00
 */
select * from ORDERS o where ORDER_NUM = 113048
select * from CUSTOMERS where CUST_NUM =2120


--3.	 ������� 3 ��������, ������������� �� ������� �������� � ������� � ����������� ��.
create trigger TR_Office_del_1
on offices after delete
as
  print 'Trigger 1'
  return;

create trigger TR_Office_del_2
on offices after delete
as
  print 'Trigger 2'
  return;

create trigger TR_Office_del_3
on offices after delete
as
  print 'Trigger 3'
  return;

-- ������ ��� ����������
select * from OFFICES 
delete  from OFFICES where OFFICE=31

/*��������� ������������ ������� ���������� ���������: First/Last  
@stmttype- ��������� ���������� Transact-SQL, ������� ��������� �������. @stmttype � 
varchar(50) � ����� ���� INSERT, UPDATE��� LOGONDELETE ����� �������� ���������� T-SQL, ������������� � �������� DDL.*/

EXEC sp_settriggerorder @triggername = 'TR_Office_del_3',
    @order = 'First',
    @stmttype = 'DELETE';

delete  from OFFICES where OFFICE=33

/*  result
Trigger 3

(1 row affected)
Trigger 1
Trigger 2

(1 row affected)
*/


--4.����������� ������, ���������������, ��� AFTER-������� �������� ������ ����������, 
--� ������ �������� ����������� ��������, ���������������� �������.



--5.������� ������� �� ���������� ��� �������������. ������������������ ����������������� ��������.
--https://sql-ex.ru/blogs/?/Ispolzovanie_triggera_INSTEAD_OF_dlJa_obnovleniJa_predstavleniJa.html 

--drop view MaxCostProduct;
create view MaxCostProduct
as
  select top 5 product_id, PRICE AS MaxCost from PRODUCTS 
  order by PRICE desc

-- �������, ��� ������ ������
select * from MaxCostProduct

-- �������� ��� ��� ������������� ������� ������� INSTEAD OF
create trigger Tr_MaxCostProduct_UPD
on MaxCostProduct instead of update
as
 begin
   update p
   set p.PRICE = i.MaxCost
   from inserted i
   join PRODUCTS p on p.PRODUCT_ID = i.product_id
   print 'Update new Cost' 
   return;
 end
go

-- ��������� ������ � �������������  
update MaxCostProduct set MaxCost=5350.00  where PRODUCT_ID = '2A44L';

--������� ���������
 select * from MaxCostProduct 



--6.������� ������� ������ ���� ������. ������������������ ����������������� ��������.

--- ?????? ��� ����� ������� ����� ????---


--7.������� ��� ��������. -- �� ������ ��������
drop trigger Tr_MaxCostProduct_UPD; 
