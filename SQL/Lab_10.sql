--������������ ������ �10 
--������� � T-SQL.
/*������ � ��� ������ ��������� ������ SQL, ��������������� ��� ������������� � ���������� � �������� ����������.
� ��� ������� ����� � ����� ������ �� ��������������� ������ ����� �������, �� ����������� �������� � ����������� ������
��� ������.
��� ���� ������, ��������� ���������� � ����� ������, ��� � ������ �������� �������.
� �������� ���������� � ������� �������� ����� ��������� ������� ����������, ������� ������ �������� � �������
���������� ���������� SELECT

SQL Server ������������ ��� ���� ��������:
� ������� SQL ����������� � �������� ������ ���������, �������� �������� � ���������;
� ������� ������� ��������� �� ������� � ��������� ����������� ��������� ���������� ��� ODBC, OLE DB, DB_Library;
� ������� ������� ����������� �� ����� �������. ��� �������� ���� �������������� ����� ����� �� ������� � ��������� ���
��������, ��� ��������� �������� �������� ��������� ������ �� ���� �������� ������ ������� �� ���������� ������� ��������


�������������� ��������:
� ��������� ��������� (����������������� �������)
� ���������� ����������

���� ��������
Transact-SQL ������������ ������ ��������� ���� ��������: 
 � ����������� 
 ����������� ������ ������ ��� �� ������������ ������ ������, ���������� ���������� SELECT, � ������ �� � ���� ������ tempdb. �� "�� ���������" 
��������� � ��������� ��� � ��������� ������, � ��������� ����� ����������� ����� �������� ������ � �����, ���� ������ ������ ����������� � 
������ "������ ������". ����������� �������, ������, ����� ���� ��������� ��� ���������������� ��� ��� ��������������.

�  ��������
  �������� ������ �������� � ���� tempdb ������ �� �������, ������� ��������� �������������� ������ ������. ����� ����� ����������� �������� �������� 
������, ������ �������, �������� � ����������� ��������� SELECT, ������ ����� ���������� ������, ������� ������ ���������� ����� � ����.
�������� ������� ����� ���� ��� ���������������, ��� � ����� ����� "������ ��� ������". ��� ����� ����� ���� ��������������� ��� 
�����������������. �������� � �������� ������� ����������� �� ������ ���������� �������. ����  � �������� ��������� ��������� ������� ����������� ������, ��������������� 
������� ������, ��� �� ����� ��������� �� ���������.

� ������������  
������������ ������ ����� ���� ���, ��� ���� �� ��� ������ ��������� � ������ �������� ���������� �������� SELECT. ������������ ������� �������� ���������, 
��������� ��� � ���������, ��� � �� ���������� �������� ������, ���������� �� ����, ������� �� ��� ��������� ������ �������, ���� ������� ������ �������������.
��� ������������ �������� ��������� ���� �����������: ������������ ��� ����������� ������� �������� SELECT ����� ��������� ����� ORDER BY ������ � ��� 
������, ���� ������� ������, ���������� � ���� �������, ������������ � ����� ORDER BY. ���� �� ���������� �������� ������ � �������������� ����� ORDER BY, �� 
����������� ��������, SQL Server ����������� ������ � ��������.


� ������� �������� ������� ��� "��������" (firehose)
SQL Server ������������ ����������� ���������������� ����� �� ��������������� �������, ������������ ������ ������. ���� ��� ������� ����������� � �������������� 
��������� ����� FAST_FORWARD, � ���� ����� ��� �������� "��������" �������� (firehose).
"��������" ������� ����� ����������, �� ��� �� ������������� ������� ��� ������ �����������.
��-������, ���� � ��������� ����������� SELECT ������� �� ������������ ������� � ����� ������ text, ntext ��� image, � ����� ����� TOP, SQL Server ����������� ������ � ��������.
��-������, ���� �������� SELECT, ������� �� ������������ ��� ����������� �������, �������� �������, ������� ��������, � �������, �� ������� ���������, ������ 
������������� � �����������. �������� ������������ ����� �������� Transact-SQL, ������� ������������� ����������� �������� ��� ���������� ��� ������� 
���������� Data Manipulation Language (DML). 

---https://sql-ex.ru/blogs/?/Primer_kursora_v_SQL_Server.html


*/

use [Maiseyeu_04]
--1.	����������� ������, ������� ������� ��� ������ � �������.
declare full_customer_info cursor
for
 select c.CUST_NUM, c.COMPANY, c.CUST_REP, c.CREDIT_LIMIT from CUSTOMERS c
 declare @custNum int, @Company varchar(20), @rep int, @Limit decimal(9,2);

 open full_customer_info;
   fetch full_customer_info into @custNum, @Company, @rep, @Limit;
    while @@FETCH_STATUS =0
	  begin
	     
		 --select  @custNum, @Company, @rep, @Limit;
         print CAST(@custNum as varchar(5)) + '->' + @Company + '-->' +CAST(@rep as varchar(5)) +'--->'+ CAST(@Limit as varchar(11));
    
		 fetch full_customer_info into @custNum, @Company, @rep, @Limit;
	  end
    
 close full_customer_info;
 deallocate full_customer_info;

--2.	 ����������� ������, ������� ������� ��� ������ � ����������� ������ � �� ����������.
  
declare office_reps cursor
for
  select 
    isNull(o.OFFICE,0), isNull(o.CITY,''), s.EMPL_NUM, s.AGE, s.HIRE_DATE, s.NAME, s.QUOTA, s.SALES,s.TITLE
  from SALESREPS s
  left join OFFICES o on s.EMPL_NUM = o.MGR
  order by o.OFFICE, s.EMPL_NUM

  declare @defOfficeNum int=0;
  declare @officeNum int, @city varchar(15), @emplNum int, @age int, @hDate date, @RepName varchar(15), 
          @Quote decimal(9,2), @Sales decimal(9,2), @Title varchar(10);
  
  declare @counter int = 0;
  open office_reps;
  fetch office_reps into @officeNum, @city, @emplNum, @age, @hDate, @RepName, 
          @Quote, @Sales, @Title;
  
   while @@FETCH_STATUS =0
     begin

	   if @defOfficeNum!=@officeNum 
	     print '----------------------';
      
	   print CASt(@officeNum as varchar(5)) +'-->' + @city + '--->'+ CAST(@emplNum as varchar(10)) + '---->'+ 
	         CAST(@age as varchar(2)) +'----->'+ CAST(@hDate as varchar(9)) +'------->' + @RepName + '==>'+
             CAST(@Quote as varchar(11)) + '===>'+ CAST(@Sales as varchar(11)) + @Title;

	   fetch office_reps into @officeNum, @city, @emplNum, @age, @hDate, @RepName, 
          @Quote, @Sales, @Title;
      
  	  set @counter = @counter+ 1;
	 end 
     print 'All count salesreps:' + CAST(@counter as varchar(10));

close office_reps;
deallocate office_reps;


--3.	����������� ��������� ������, ������� ������� ��� �������� � ������� � �� ������� ����.
declare good_info cursor LOCAL
for
  select p.PRODUCT_ID, p.DESCRIPTION, p.MFR_ID, p.PRICE, p.QTY_ON_HAND, 
   (select avg(PRICE) from PRODUCTS) as AVGPrice
  from PRODUCTS p
  
  declare @GoodId varchar(5), @Description varchar(20), @MFR_ID varchar(3), @PRICE money, @quantity int, @avgPrice money
  open good_info;
     
     fetch good_info into @GoodId, @Description, @MFR_ID, @PRICE, @quantity, @avgPrice;
	 while @@FETCH_STATUS = 0
	   begin
	     
		 print CAST(@GoodId as varchar(10)) + 
		 '    ' +  @Description + 
		 '   MFR:' + CAST(@MFR_ID as varchar(3)) + 
		 '   price:' + CAST(@PRICE as varchar(15)) + 
		 '   q:' +  CAST(@quantity as VARCHAR(11)) + 
		 '   avgPrice:'+ CAST(@avgPrice as VARCHAR(15));
		  
		 fetch good_info into @GoodId, @Description, @MFR_ID, @PRICE, @quantity, @avgPrice;
	   end
  close good_info;
  deallocate good_info;

--4.	����������� ���������� ������, ������� ������� �������� � �������, ����������� � 2008 ����.
declare Sales_2008 cursor 
for
  select 
    o.ORDER_NUM, o.ORDER_DATE, o.CUST, o.REP,o.PRODUCT, o.QTY, o.AMOUNT 
  from ORDERS o where year(o.ORDER_DATE) = 2008
  order by o.ORDER_DATE 

  declare @orderNum int, @orderDate date, @custNum int, @REP int, @product varchar(5), @quantity int, @amount decimal(9, 2);

  open Sales_2008;
    fetch Sales_2008 into @orderNum, @orderDate, @custNum, @REP, @product, @quantity, @amount;

	while @@FETCH_STATUS= 0
	  begin
	    
		print 
		 '   O_Num:' + cast(@orderNum as VARCHAR(10)) + 
		 '   O_Date:' + CAST(@orderDate as VARCHAR(10)) + 
		 '   CustNum:' + CAST(@custNum as VARCHAR(10)) + 
		 '   REP:' + CAST(@REP as VARCHAR(10)) + 
		 '   Product:' + CAST(@product as VARCHAR(15)) + 
		 '   Quantity:' + CAST(@quantity as VARCHAR(15)) + 
		 '   AMOUNT:' + CAST(@amount as VARCHAR(15));

	    fetch Sales_2008 into @orderNum, @orderDate, @custNum, @REP, @product, @quantity, @amount;
	  end
   
  close Sales_2008;
  deallocate Sales_2008;

--5.	����������� ����������� ������, ������� ������� �������� � ����������� � �� �������.
declare customerInfo cursor STATIC 
for
  select c.CUST_NUM, c.COMPANY, isNull(o.ORDER_DATE,getdate()), isNull(o.ORDER_NUM,0), isNull(o.AMOUNT,0)
  from CUSTOMERS c
  left join ORDERS o on c.CUST_NUM = o.CUST
  order by o.ORDER_DATE desc
 
  declare @cust int, @company varchar(20), @oDate date, @oNumb int, @Summ decimal(9, 2);

 open customerInfo;
   fetch customerInfo into  @cust, @company, @oDate, @oNumb, @Summ;  
     while @@FETCH_STATUS = 0
	   begin
	     if @oNumb=0 
		   print '------ ��� �������------';
		 print 
		  '    Cust:'+cast(@cust as varchar(10)) + 
		  '    ComName:'+ @company +
		  '    ODate:' + CAST(@oDate as VARCHAR(12)) + 
		  '    oNum:'+ CAST(@oNumb as varchar(12)) +
		  '    OrderSum:' + Cast(@Summ as varchar(12));  
	     fetch customerInfo into  @cust, @company, @oDate, @oNumb, @Summ;  
	   end

 close customerInfo;
 deallocate customerInfo;

 --6.	����������� ������������ ������, ������� ��������� ������ � ���������� � ����������� �� ����� ����������� ������� 
 --(���� SALES).

 declare UpdateSalesRepSum cursor 
 for
   select o.rep, sum(o.AMOUNT) from ORDERS o 
   where o.REP = 101
   group by o.rep

   declare @repID int, @SumSales decimal(9,2);

   open UpdateSalesRepSum;
     fetch UpdateSalesRepSum into @repID, @SumSales; 

	 while @@FETCH_STATUS = 0
	   begin
	     
		 --- �������� ��������� ������, � ������� ����� ��������� ������
		  declare UPD_SalesRep cursor 
		  for
		    select distinct c.EMPL_NUM, c.SALES from SALESREPS c 
			group by EMPL_NUM, c.SALES
		    
			declare  @emplID int, @Summ decimal(9, 2);
            
			open UPD_SalesRep;
			  fetch UPD_SalesRep into @emplID,  @Summ;
			   while @@FETCH_STATUS=0
			    begin
				   update SALESREPS set @Summ = @SumSales
				     where @emplID = @repID;
				end
			 
			close UPD_Customer;
			deallocate UPD_Customer;

	   end
   close UpdateSalesRepSum;
   deallocate UpdateSalesRepSum;
 

--7.	������������������ �������� SCROLL.
