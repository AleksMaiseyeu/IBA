use [Maiseyeu_04]
--Lab 5
--Программирование T-SQL.
--Transact-SQL (T-SQL) — процедурное расширение языка SQL

/*DDL (Data Definition Language) — выражения этого типа используются для создания объектов в базе данных. 
Основные представители данного класса: 
CREATE — создание объектов, 
ALTER — изменение объектов, 
DROP — удаление объектов.

DCL (Data Control Language) — выражения этого типа предназначены для назначения прав на объекты базы данных. 
Основные представители данного класса: 
GRANT — разрешение на объект, 
DENY — запрет на объект, 
REVOKE — отмена разрешений и запретов на объект.

DML (Data Manipulation Language) — выражения этого типа используются для запросов и изменения данных. 
Основные представители данного класса: 
SELECT — выборка данных, 
INSERT — вставка данных, 
UPDATE — изменение данных, 
DELETE — удаление данных.


В Transact-SQL существуют специальные команды, которые позволяют управлять потоком выполнения сценария, 
прерывая его или направляя в нужную ветвь.

Блок группировки — структура, объединяющая список выражений в один логический блок (BEGIN … END).
Блок условия — структура, проверяющая выполнения определённого условия (IF … ELSE).
Блок цикла — структура, организующая повторение выполнения логического блока (WHILE … BREAK … CONTINUE).
Переход — команда, выполняющая переход потока выполнения сценария на указанную метку (GOTO).
Задержка — команда, задерживающая выполнение сценария (WAITFOR).
Вызов ошибки — команда, генерирующая ошибку выполнения сценария (RAISERROR).

*/

--1.	Разработать T-SQL-скрипт  следующего содержания: 
--1.1.	объявить переменные типа: char, varchar, datetime, time, int, smallint,  tinint, numeric(12, 5).
declare @char char;
declare @varchar varchar;
declare @datetime datetime;
declare @time time;
declare @int int;
declare @tinyint tinyint; /*-128 -- 127 или 0--255 */
declare @numeric numeric(13,5);
go


--1.2.	первые две переменные проинициализировать в операторе объявления.
declare @char char = 'F' ;
declare @varchar varchar(5) = 'text';
print @char;
print @varchar;
go


--1.3.	присвоить  произвольные значения следующим двум переменным с помощью оператора SET, 
--одной из  этих переменных  присвоить значение, полученное в результате запроса SELECT.
declare @datetime datetime, @time time;
set @datetime = '2024-10-10 15:03:15';
set @time = '15:05:00';
print @datetime;
set @datetime = (select TOP(1) o.ORDER_DATE from ORDERS o)
print @datetime;
print @time;
go


--1.4.	одну из переменных оставить без инициализации и не присваивать ей значения, 
--оставшимся переменным присвоить некоторые значения с помощью оператора SELECT;. 
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



--1.5.	значения половины переменных вывести с помощью оператора SELECT, 
--значения другой половины переменных распечатать с помощью оператора PRINT. 

 select  @varchar, @datetime, @time 
 print  @int 
 print  @tinyint 
 print  @numeric 
 go

--2. Разработать скрипт, в котором определяется средняя стоимость продукта. 
--Если средняя стоимость продукта превышает 10, то вывести количество продуктов, 
--среднюю стоимость продукта, максимальную стоимость продукта. 
--Если средняя стоимость продукта меньше 10, то вывести минимальную стоимость продукта. 

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

--3.	Подсчитать количество заказов сотрудника в определенный период. 
declare @StartDate date, @EndDate date, @EmplNum int
set @StartDate= '2008-01-01' 
set @EndDate= '2008-12-31'
set @EmplNum = 101

declare @OrderCount int = (select COUNT(o.ORDER_NUM) from ORDERS o
                          where (o.ORDER_DATE between @StartDate and @EndDate)
						  and o.REP =@EmplNum)
select @EmplNum, @OrderCount


use [Maiseyeu_04]
--4.	Разработать T-SQL-скрипты, выполняющие: 
--4.1.	преобразование имени сотрудника в инициалы.
select * from SALESREPS s
declare @full_name varchar(20) 
  set  @full_name = (select top(1) name from SALESREPS)
declare @first_later varchar(1) = Left(@full_name, 1)
declare @surname varchar(20) =  right(@full_name, LEN(@full_name)-CHARINDEX(' ', @full_name));
declare @nikName varchar(20) =  @surname + ' ' + @first_later + '.';
select @full_name, @first_later,  @surname, @nikName
go

--- переделаю для всего массива SALESREPS с помощью курсоров
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


--4.2.	поиск сотрудников, у которых дата найма в следующем месяце.
select * from SALESREPS s 
where month(s.HIRE_DATE) = Month(GETDATE()) +1;

--4.3.	поиск сотрудников, которые проработали более 10 лет.
select * from SALESREPS s
where DATEDIFF(YY, s.HIRE_DATE, GETDATE())>10


--4.4.	поиск дня недели, в который делались заказы.
select DATENAME(dw, ORDER_DATE) as DayWeek, * from ORDERS 


--5.	Продемонстрировать применение оператора IF… ELSE.
declare @firstN int =10;
declare @lastN int =20;
declare @variable int = 3;

if (@variable between @firstN and @lastN) 
   print 'Входит в заданный диапазон'
else
   print 'Не входит' 
go;


--6.	Продемонстрировать применение оператора CASE.
declare @variable int = 3;
  select case 
    when (@variable<10) then '<10'
    when (@variable>10) then '>10'
	else '=10'
   end;

--7.	Продемонстрировать применение оператора RETURN. 


--8.	Разработать скрипт с ошибками, в котором используются для обработки ошибок блоки TRY и CATCH. 
---Применить функции ERROR_NUMBER (код последней ошибки), 
---ERROR_MESSAGE (сообщение об ошибке), 
---ERROR_LINE(код последней ошибки), 
---ERROR_PROCEDURE (имя  процедуры или NULL), 
---ERROR_SEVERITY (уровень серьезности ошибки), 
---ERROR_STATE (метка ошибки). 

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

--- или так
declare @val int = 3
begin try 
   set @val = @val/'text'
end try
begin catch
 select error_number(), error_message(), error_line(), error_procedure(), error_severity(),error_state();
end catch
go

--9.	Создать локальную временную таблицу из трех столбцов. Добавить данные (10 строк) с использованием оператора WHILE. 
--Вывести ее содержимое.
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

  -- проверим, что получилось
  select * from #tempTable
