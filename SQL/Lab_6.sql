use [Maiseyeu_04]
--Lab6
--���������������� T-SQL.
/*������� �������� �������� ��� ���������� �������������� �������� � ����������� �����������, 
��� ���� ��� ���������� ������ ������� ������.

�������� ��������� � ���� �������, ����� ��������� ������, ������� ������ �� ������ � ��������� ������� �������.

������� ������������� �� ����������, � �� ����� ��� �������� ��������� �������� ������������� ��������.


*/

-- ������� �������������� ��� � �������� + �������

create function split_name (@full_name varchar(50))
returns varchar(50)
begin
  declare @surname varchar(50), @first_letter varchar(1), @rc varchar(50);
  set @surname = PARSENAME(REPLACE(@full_name, ' ', '.'), 1);
  set @first_letter = SUBSTRING(@full_name,1,1);
  set @rc = CONCAT(@first_letter, '.', SPACE(1), @surname);
  return @rc
end;
go

-- ��������� ����� dbo ����� ������� �������
select name, dbo.split_name(name) from SALESREPS


--- ������, ������� ������� ������ ���� ������

--drop function full_year_at_work;
--go

create function full_year_at_work(@hiredate date)
returns int
begin
   declare @rc int;
   set @rc = DATEDIFF(month, @hiredate, GETDATE())/12;
   return @rc;
end;
go


select name, HIRE_DATE, dbo.full_year_at_work(HIRE_DATE) from SALESREPS


----���������
create procedure update_salesrep @empl_num int,@new_name varchar(15)
as
begin
   update SALESREPS set NAME = @new_name
   where EMPL_NUM = @empl_num;
end;
go;

select * from SALESREPS
exec update_salesrep @empl_num = 102, @new_name = 'Mr. Smith';

drop procedure update_salesrep;
go;

--- modify proc
create procedure update_salesrep @empl_num int, @new_name varchar(15), @new_rep_office int
as
begin
   update SALESREPS 
   set NAME = isNull(@new_name, NAME),
   REP_OFFICE= isNull(@new_rep_office, REP_OFFICE)
   where EMPL_NUM = @empl_num;
end;
go;

exec update_salesrep @empl_num = 110, @new_name = null, @new_rep_office=22;


create procedure update_salesrep 
   @empl_num int, 
   @new_name varchar(15),  
   @new_age int,
   @new_rep_office int,
   @new_title varchar(20),
   @new_hire_date date,
   @new_manager int,
   @new_quota decimal(9,2),
   @new_sales decimal(9,2)
as
begin
   update SALESREPS 
   set NAME = isNull(@new_name, NAME),
   AGE = isNull(@new_age, AGE),
   REP_OFFICE= isNull(@new_rep_office, REP_OFFICE),
   TITLE = isNull(@new_title, TITLE),
   HIRE_DATE = isNull(@new_hire_date, HIRE_DATE),
   MANAGER=ISNULL(@new_manager, MANAGER),
   QUOTA =isNull(@new_quota, QUOTA),
   SALES=isNull(@new_sales, SALES)
   where EMPL_NUM = @empl_num;
end;
go;

exec update_salesrep
   @empl_num =102, 
   @new_name ='Mrs. Smith Jn.',  
   @new_age =28,
   @new_rep_office =null,
   @new_title = null,
   @new_hire_date ='2020-12-10',
   @new_manager =null,
   @new_quota =37000.60,
   @new_sales =null

--������
select * from SALESREPS

-- �������� ��������� �������� ����������
--�������� ����� ����� ������ � ���� ����������

create procedure delete_salesrep @empl_num int
as
begin
  update orders set rep = null where REP = @empl_num;
  update SALESREPS set MANAGER = null where MANAGER =@empl_num;
  update CUSTOMERS set CUST_REP = null where CUST_REP = @empl_num;
  update OFFICES set MGR= null where  MGR = @empl_num;
  delete from SALESREPS where EMPL_NUM = @empl_num;
end;

go;

--������� ��� ������ ����� �� 1 �� 20
declare @value int =1;
while (@value<=20)
  begin
     if @value %  2 = 0
	  print @value;
	  set @value = @value+1;
  end

--������� ��� ������ ����� �� 3 �� 50
declare @value int =50;
while (@value>=3)
  begin
     if @value %  3 = 0
	  print @value;
	  set @value = @value-1;
  end

  --- ��������� ����� ������ � �������
declare @val varchar(50) = 'Hello, World'
print cast(Len(@val) as varchar(3)) + '  ' +  @val;


-- �����, ����� ���� ������ ����� ����� 20 ����
print datename(weekday, dateadd(d, 20, getdate()))

-- ������� ������� ������ Bob Dylan �������� � ����� ������
print upper(' Bob Dylan') + ' ' + lower('Bob Dylan') 


---   bbbooob dyyylaaann	---> bob dylan	
use [Maiseyeu_04]
declare @start_text varchar(50)='bbbooob dyyylaaann';
declare @end_text varchar(50)=substring(@start_text,1,1);
declare @start_text_lenght int = len(@start_text);
declare @i int =1;
while (@i<=@start_text_lenght)
  begin
    if substring(@start_text,@i,1) <> substring(@start_text,(@i +1),1)
	  set @end_text = @end_text + substring(@start_text,(@i +1),1);
	  set @i = @i +1;
  end
print @end_text;


--1.	����������� �������� ���������: 
--1.1.	���������� ������ �������; ��� ������� ������������ ������ � ������� ��������� �� ������.

create procedure addNewCustomer @new_cust_num int, @new_company varchar(20), @cust_rep int, @creditLimit decimal(9,2)
as
begin
  if exists (select * from CUSTOMERS where CUST_NUM=@new_cust_num or COMPANY=@new_company)
    print '������ � ����� ��� ����������� ����������� ��� ���� � �������'
  else
    insert into CUSTOMERS (CUST_NUM, COMPANY, CUST_REP, CREDIT_LIMIT) 
	     values(@new_cust_num, @new_company, @cust_rep, @creditLimit);
  
end;

exec addNewCustomer @new_cust_num = 201, @new_company = 'Roga&KopbIta', @cust_rep=106, @creditLimit=999910.99

select * from CUSTOMERS

--1.2.	������ ������� �� ����� ��������; ���� ������ �� ������� � ������� ���������.
create procedure findCustomerByPartName @part_name varchar(20)
as
begin
   if not exists (select * from CUSTOMERS where upper(COMPANY) like '%' + upper(@part_name)+ '%')
     print '������ �� �������. ���������� �������� ���������';
   else
     select * from  CUSTOMERS where upper(COMPANY) like '%' + upper(@part_name)+ '%';
end;

--drop procedure findCustomerByPartName;
exec findCustomerByPartName @part_name = 'ho'



--1.3.	���������� ������ �������.
create procedure UpdateCustomer @cust_num int, @new_company varchar(20), @new_cust_rep int, @new_CreditLimit decimal(9,2)
as
begin
  update CUSTOMERS 
    set COMPANY = ISNULL(@new_company, COMPANY),
	CUST_REP = isNull(@new_cust_rep, CUST_REP),
	CREDIT_LIMIT =isNull(@new_CreditLimit, CREDIT_LIMIT)
	where CUST_NUM = @cust_num;
end;

exec UpdateCustomer 
  @cust_num=201, 
  @new_company =null, 
  @new_cust_rep=null, 
  @new_CreditLimit =900000.00

select * from CUSTOMERS

--1.4.	�������� ������ � �������; ���� � ������� ���� ������, � ��� ������ ������� � ������� ���������. 

drop procedure DeleteCustomer;

create procedure DeleteCustomer @cust_num int
as
begin
  if exists(select * from ORDERS o where o.CUST = @cust_num)
    print '������� ' + CAST(@cust_num as varchar(5)) + '  ������� ������, �.�. � ���� ���� ������' 
  else
    delete from CUSTOMERS where CUST_NUM = @cust_num;
  
end;
-- �������� �� 2101 � 201
exec DeleteCustomer @cust_num = 2101
go;
--2.	������� ������������� ��������� � ���������� ����������� ��� ������������.

--3.	����������� ���������������� �������: 
--3.1.	���������� ���������� ������� ���������� � ������������ ������. ���� ������ ���������� ��� � ������� -1. 
--���� ��������� ����, � ������� ��� � ������� 0.

use [Maiseyeu_04]

create function getOrderByCustomer(@cust_num int, @dateBegin date, @dateEnd date)
returns int
begin
  declare @result int;
  set @result = (select count(*) from ORDERS o where o.CUST = @cust_num and (o.ORDER_DATE between @dateBegin and @dateEnd));
  return @result;
end;

select c.company, dbo.getOrderByCustomer(c.cust_num, '2000-01-01', '2024-12-31') as CountOrder from CUSTOMERS c


--3.2.	���������� ���������� ������� ��������� �������������� ����� ���� ���������. 

select * from PRODUCTS  order by 1

select p.MFR_ID, count(*) from products p
group by p.MFR_ID

drop function CountProductByCost;

create function CountProductByCost(@Customer char(3), @minGoodCost decimal(9, 2))
returns int
begin
  declare @res int;
    set @res = (select count(*) from PRODUCTS where MFR_ID = @Customer and PRICE>=@minGoodCost);
  return @res;
end;

select pr.MFR_ID, dbo.CountProductByCost(pr.MFR_ID, 220.00) as CountGood from PRODUCTS pr group by pr.MFR_ID



--3.3.	���������� ���������� ���������� ������� ��� ������������� �������������.
create function GetOrderCountByProducer(@MFR varchar(3))
returns int
begin
  declare @res int;
  set @res = (select sum(o.QTY) from ORDERS o where o.MFR = @MFR);
  return @res;
end;

select p.MFR_ID, dbo.GetOrderCountByProducer(p.MFR_ID) as GoodQuantity from PRODUCTS p group by p.MFR_ID

--4.	������� ������������� ������� ���������� ��������� � ���������� ����������� ��� ������������.
select 

select dbo.GetOrderCountByProducer('ACI');

print dbo.GetOrderCountByProducer('BIC');


/*
������� �������� ��� ��������� ��
*/

use [2024_Maiseyeu]
-- �-� ������ ������������� ������ �� ������� - 
/*
INSERT INTO ORDERS(ID,NUMBER,ORDERDATE,CUSTOMER_ID,DRIVER_ID,TRANSPORT_ID,TYPE_DEL_ID,LOADING_ID,KIND_DEL_ID)
		VALUES(8,101,'2024-09-15',107,103,14002,32,41,1002);
	INSERT INTO ORDERSLINE(ID,MASTERKEY,GOOD_ID,QUANTITY,FACT_COST)
		VALUES(16,8,3,2,555.00); 
*/
---select * from ORDERS
---select * from customer

drop function GetMaxCostOrderByCustomer;

create function GetMaxCostOrderByCustomer (@cust_ID int, @part_cust_name varchar(20))
returns decimal(9, 4)
begin
  declare @res decimal(9,4) = 0;
    if not (@cust_ID is null) 
	  set @res = 
	  (select 
	    max(m.SumOrder)
      from
	     (select 
            O.ID, 
		    SUM(OL.QUANTITY*OL.FACT_COST) as SumOrder
		  from ORDERS o
          join ORDERSLINE ol on ol.MASTERKEY = o.ID
		  join CUSTOMER c on c.ID = o.customer_ID
          WHERE O.CUSTOMER_ID = @cust_ID  
		    or upper(c.surname) like '%' + upper(@part_cust_name) + '%'
		  group by O.ID) as m)
	  
 return @res;
end; 
-- ������ , ��� �����
select dbo.GetMaxCostOrderByCustomer(103, ''); 

---������� ������ ������ �������
create function SalesGoodQuantity (@GoodKey int)
returns int
begin
  declare @res int;
   set @res = 
   (Select 
     sum(ol.QUANTITY) 
   from ORDERSLINE ol 
   where ol.GOOD_ID = @GoodKey);

 return @res;
end;

select g.GOOD_NAME, g.PRICECOST,  dbo.SalesGoodQuantity(g.ID) as SalesQuant from GOODS g

--- ������� ������� ����� ������������ �������

create function CountOrdersByDriver (@driverKey int, @db date, @de date)
returns int
begin
  declare @res int;  
  set @res = 
    (select count(*) 
	 from ORDERS r 
     where r.DRIVER_ID = @driverKey
     and r.ORDERDATE between @db and @de)
  
  if @res is null 
    set @res = 0;

  return @res;
end;

--- ��������
select d.FIRSTNAME, d.SURNAME, dbo.CountOrdersByDriver(d.id, '2000-01-01', '2024-12-31') as CountOrderDelivery from DRIVER d


--��������� ����� ����� ������ �� ������� �� ������
create function FullSumByCustomer(@CustomerKey int, @db date, @de date)
returns decimal(9, 4)
begin
  declare @res decimal(9, 4);
  set @res = 
    (select 
     sum(el.FACT_COST*el.QUANTITY)
     from ORDERS e
     join ORDERSLINE el on el.MASTERKEY = e.ID  
     join DELIVERY_RESULT dr on dr.ORDERSLINE_ID = el.ID
     where e.CUSTOMER_ID = @CustomerKey
     and e.ORDERDATE between @db and @de
     and dr.ISDELIVERED = 1)

return @res;
end;

select c.ID, c.FIRSTNAME, c.SURNAME, dbo.FullSumByCustomer(c.ID, '2000-01-01', '2024-12-31') as SumSales from CUSTOMER c 