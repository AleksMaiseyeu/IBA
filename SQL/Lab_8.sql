--Лабораторная работа №8
--Триггеры в T-SQL.
/*
1.аудит
2.обеспечение целостности
3.бизнес-процессы
*/
use [Maiseyeu_04]
GO

--1.	Разработать следующие DML триггеры и продемонстрировать работоспособность триггеров: 
--1.1.	При добавлении нового офиса добавлять строку с данными офиса в таблицу Audit.

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
-- проверім
select * from OFFICES;
select * from AUDIT

--1.2.	При обновлении данных офиса добавлять строку с предыдущими данными офиса в таблицу Audit.

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
--проверяем
select * from AUDIT;

--1.3.	При удалении данных о офиса добавлять строку с данными офиса в таблицу Audit. 

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

-- включаем/ отключаем тріггеры
DISABLE Trigger TR_OFFICE_DEL on OFFICES; 
ENABLE TRIGGER TR_OFFICE_DEL on OFFICES; 

/* softDelete - Мягкое удаление 
— это такой подход, при котором записи в базе данных просто помечаются как удаленные, 
но по факту они остаются на прежних местах.*/

/*INSTEAD OF: выполняется вместо действия 
(то есть по сути действие - добавление, изменение или удаление - вообще не выполняется). 
Определяется для таблиц и представлений
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

--2.	Разработать скрипт, который демонстрирует, что проверка ограничения целостности 
--  выполняется до срабатывания AFTER-триггера.
/*
    Триггеры AFTER никогда не выполняются, если происходит нарушение ограничения, 
	поэтому эти триггеры нельзя использовать для какой-либо обработки, 
	которая могла бы предотвратить нарушение ограничения.
*/
--=====решеніе=====--
-- напішем простой тріггер удаленіе кліента  і попытаемся удаліть кліента, у коготорого есть заказы
-- тріггер должен не дать выполніть данную операцію

----???????? Где глянуть разрешение на удаление CASCADE ???????????????????


select * from ORDERS o

select c.CUST_NUM from CUSTOMERS c

create trigger TR_DEL_Customer
on orders after update
as
  declare @custNum int;
  set @custNum = (select CUST from deleted);
  delete from CUSTOMERS where CUST_NUM = @custNum;
  return;

-- теперь проверим работу триггера, обновив данные какого нибудь заказа
update ORDERS set QTY = 6 where ORDER_NUM = 113048; 
/* было так 
 113048	2008-02-10	2120	102	IMM	779C 	2	3750.00
 */
select * from ORDERS o where ORDER_NUM = 113048
select * from CUSTOMERS where CUST_NUM =2120


--3.	 Создать 3 триггера, срабатывающих на событие удаления в таблице и упорядочить их.
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

-- глянем что получілось
select * from OFFICES 
delete  from OFFICES where OFFICE=31

/*процедура устанавлівает порядок выполнения триггеров: First/Last  
@stmttype- Указывает инструкцию Transact-SQL, которая запускает триггер. @stmttype — 
varchar(50) и может быть INSERT, UPDATEили LOGONDELETE любым событием инструкции T-SQL, перечисленным в событиях DDL.*/

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


--4.Разработать скрипт, демонстрирующий, что AFTER-триггер является частью транзакции, 
--в рамках которого выполняется оператор, активизировавший триггер.



--5.Создать триггер на обновление для представления. Продемонстрировать работоспособность триггера.
--https://sql-ex.ru/blogs/?/Ispolzovanie_triggera_INSTEAD_OF_dlJa_obnovleniJa_predstavleniJa.html 

--drop view MaxCostProduct;
create view MaxCostProduct
as
  select top 5 product_id, PRICE AS MaxCost from PRODUCTS 
  order by PRICE desc

-- смотрим, что вернет вьюшка
select * from MaxCostProduct

-- создадим для нее представления триггер подмены INSTEAD OF
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

-- обновляем данные в представлении  
update MaxCostProduct set MaxCost=5350.00  where PRODUCT_ID = '2A44L';

--смотрим результат
 select * from MaxCostProduct 



--6.Создать триггер уровня базы данных. Продемонстрировать работоспособность триггера.

--- ?????? что здесь имеется ввиду ????---


--7.Удалить все триггеры. -- по такому принципу
drop trigger Tr_MaxCostProduct_UPD; 
