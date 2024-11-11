--Лабораторная работа №10 
--Курсоры в T-SQL.
/*Курсор – это особый временный объект SQL, предназначенный для использования в программах и хранимых процедурах.
С его помощью можно в цикле пройти по результирующему набору строк запроса, по отдельности считывая и обрабатывая каждую
его строку.
При этом курсор, позволяет обращаться к своим данным, как к данным обычного массива.
В хранимых процедурах с помощью курсоров можно выполнять сложные вычисления, которые трудно выразить с помощью
синтаксиса инструкции SELECT

SQL Server поддерживает три вида курсоров:
• курсоры SQL применяются в основном внутри триггеров, хранимых процедур и сценариев;
• курсоры сервера действуют на сервере и реализуют программный интерфейс приложений для ODBC, OLE DB, DB_Library;
• курсоры клиента реализуются на самом клиенте. Они выбирают весь результирующий набор строк из сервера и сохраняют его
локально, что позволяет ускорить операции обработки данных за счет снижения потерь времени на выполнение сетевых операций


Характеристики курсоров:
• Отражение изменений (чувствительностью курсора)
• Прокрутка• Обновление

Типы курсоров
Transact-SQL поддерживает четыре различных типа курсоров: 
 • статические 
 Статический курсор делает как бы моментальный снимок данных, задаваемых оператором SELECT, и хранит их в базе данных tempdb. Он "не чувствует" 
изменений в структуре или в значениях данных, а поскольку любые модификации будут отражены только в копии, этот курсор всегда открывается в 
режиме "только чтение". Статические курсоры, однако, могут быть объявлены как последовательные или как прокручиваемые.

•  ключевые
  Ключевой курсор копирует в базу tempdb только те столбцы, которые уникально идентифицируют каждую строку. Чтобы иметь возможность объявить ключевой 
курсор, каждая таблица, входящая в определение оператора SELECT, должна иметь уникальный индекс, который задает копируемый набор – ключ.
Ключевые курсоры могут быть как модифицируемыми, так и иметь режим "только для чтения". Они также могут быть прокручиваемыми или 
последовательными. Членство в ключевом курсоре фиксируется на момент объявления курсора. Если  в процессе открытого состояния курсора добавляется строка, удовлетворяющая 
условию отбора, она не будет добавлена во множество.

• динамические  
Динамический курсор ведет себя так, как если бы при каждом обращении к строке повторно выполнялся оператор SELECT. Динамические курсоры отражают изменения, 
связанные как с членством, так и со значениями исходных данных, независимо от того, сделаны ли эти изменения внутри курсора, либо внесены другим пользователем.
Для динамических курсоров действует одно ограничение: используемый для определения курсора оператор SELECT может содержать фразу ORDER BY только в том 
случае, если имеется индекс, включающий в себя столбцы, используемые в фразе ORDER BY. Если вы объявляете ключевой курсор с использованием фразы ORDER BY, не 
оперирующей индексом, SQL Server преобразует курсор в ключевой.


• курсоры быстрого доступа или "пожарные" (firehose)
SQL Server поддерживает специальную оптимизированную форму не прокручиваемого курсора, допускающего только чтение. Этот вид курсора объявляется с использованием 
ключевого слова FAST_FORWARD, и чаще всего его называют "пожарным" курсором (firehose).
"Пожарные" курсоры очень эффективны, но при их использовании имеются два важных ограничения.
Во-первых, если в операторе определения SELECT курсора вы использовали столбцы с типом данных text, ntext или image, а также фразу TOP, SQL Server преобразует курсор в ключевой.
Во-вторых, если оператор SELECT, который вы использовали для определения курсора, содержит таблицы, имеющие триггеры, и таблицы, не имеющие триггеров, курсор 
преобразуется в статический. Триггеры представляют собой сценарии Transact-SQL, которые автоматически исполняются сервером при выполнении для таблицы 
операторов Data Manipulation Language (DML). 

---https://sql-ex.ru/blogs/?/Primer_kursora_v_SQL_Server.html


*/

use [Maiseyeu_04]
--1.	Разработать курсор, который выводит все данные о клиенте.
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

--2.	 Разработать курсор, который выводит все данные о сотрудниках офисов и их количество.
  
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


--3.	Разработать локальный курсор, который выводит все сведения о товарах и их среднюю цену.
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

--4.	Разработать глобальный курсор, который выводит сведения о заказах, выполненныъ в 2008 году.
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

--5.	Разработать статический курсор, который выводит сведения о покупателях и их заказах.
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
		   print '------ без заказов------';
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

 --6.	Разработать динамический курсор, который обновляет данные о сотруднике в зависимости от суммы выполненных заказов 
 --(поле SALES).

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
	     
		 --- создадим вложенный курсор, в котором будем обновлять данные
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
 

--7.	Продемонстрировать свойства SCROLL.
