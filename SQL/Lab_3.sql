-- переходим к нужной БД
use [Maiseyeu_03]

--DROP TABLE ORDERS;
--DROP TABLE CUSTOMERS;
--DROP TABLE SALESREPS;
--DROP TABLE OFFICES;
--DROP TABLE PRODUCTS;

CREATE TABLE PRODUCTS
     (MFR_ID CHAR(3) NOT NULL,
  PRODUCT_ID CHAR(5) NOT NULL,
 DESCRIPTION VARCHAR(20) NOT NULL,
       PRICE MONEY NOT NULL,
 QTY_ON_HAND INTEGER NOT NULL,
 PRIMARY KEY (MFR_ID, PRODUCT_ID));


CREATE TABLE OFFICES
     (OFFICE INT NOT NULL,
        CITY VARCHAR(15) NOT NULL,
      REGION VARCHAR(10) NOT NULL,
         MGR INT,
      TARGET DECIMAL(9,2),
       SALES DECIMAL(9,2) NOT NULL,
 PRIMARY KEY (OFFICE));

CREATE TABLE SALESREPS
   (EMPL_NUM INT NOT NULL,
             CHECK (EMPL_NUM BETWEEN 101 AND 199),
        NAME VARCHAR(15) NOT NULL,
         AGE INTEGER,
  REP_OFFICE INTEGER,
       TITLE VARCHAR(10),
   HIRE_DATE DATE NOT NULL,
     MANAGER INT,
       QUOTA DECIMAL(9,2),
       SALES DECIMAL(9,2) NOT NULL,
 PRIMARY KEY (EMPL_NUM),
 FOREIGN KEY (MANAGER) REFERENCES SALESREPS(EMPL_NUM),
 CONSTRAINT WORKSIN FOREIGN KEY (REP_OFFICE)  
  REFERENCES OFFICES(OFFICE));


CREATE TABLE CUSTOMERS
   (CUST_NUM INTEGER    NOT NULL,
    COMPANY VARCHAR(20) NOT NULL,
    CUST_REP INTEGER,
    CREDIT_LIMIT DECIMAL(9,2),
 PRIMARY KEY (CUST_NUM),
 CONSTRAINT HASREP FOREIGN KEY (CUST_REP)
  REFERENCES SALESREPS(EMPL_NUM));

CREATE TABLE ORDERS
  (ORDER_NUM INTEGER NOT NULL,
             CHECK (ORDER_NUM > 100000),
  ORDER_DATE DATE NOT NULL,
        CUST INTEGER NOT NULL,
         REP INTEGER,
         MFR CHAR(3) NOT NULL,
     PRODUCT CHAR(5) NOT NULL,
         QTY INTEGER NOT NULL,
      AMOUNT DECIMAL(9,2) NOT NULL,
 PRIMARY KEY (ORDER_NUM),
 CONSTRAINT PLACEDBY FOREIGN KEY (CUST)
  REFERENCES CUSTOMERS(CUST_NUM)
   ON DELETE CASCADE,
 CONSTRAINT TAKENBY FOREIGN KEY (REP)
  REFERENCES SALESREPS(EMPL_NUM),
 CONSTRAINT ISFOR FOREIGN KEY (MFR, PRODUCT)
  REFERENCES PRODUCTS(MFR_ID, PRODUCT_ID));

ALTER TABLE OFFICES
  ADD CONSTRAINT HASMGR
  FOREIGN KEY (MGR) REFERENCES SALESREPS(EMPL_NUM);
---
--- Inserts for sample schema
---

---
---  PRODUCTS
---
INSERT INTO PRODUCTS VALUES('REI','2A45C','Ratchet Link',79.00,210);
INSERT INTO PRODUCTS VALUES('ACI','4100Y','Widget Remover',2750.00,25);
INSERT INTO PRODUCTS VALUES('QSA','XK47 ','Reducer',355.00,38);
INSERT INTO PRODUCTS VALUES('BIC','41627','Plate',180.00,0);
INSERT INTO PRODUCTS VALUES('IMM','779C ','900-LB Brace',1875.00,9);
INSERT INTO PRODUCTS VALUES('ACI','41003','Size 3 Widget',107.00,207);
INSERT INTO PRODUCTS VALUES('ACI','41004','Size 4 Widget',117.00,139);
INSERT INTO PRODUCTS VALUES('BIC','41003','Handle',652.00,3);
INSERT INTO PRODUCTS VALUES('IMM','887P ','Brace Pin',250.00,24);
INSERT INTO PRODUCTS VALUES('QSA','XK48 ','Reducer',134.00,203);
INSERT INTO PRODUCTS VALUES('REI','2A44L','Left Hinge',4500.00,12);
INSERT INTO PRODUCTS VALUES('FEA','112  ','Housing',148.00,115);
INSERT INTO PRODUCTS VALUES('IMM','887H ','Brace Holder',54.00,223);
INSERT INTO PRODUCTS VALUES('BIC','41089','Retainer',225.00,78);
INSERT INTO PRODUCTS VALUES('ACI','41001','Size 1 Wiget',55.00,277);
INSERT INTO PRODUCTS VALUES('IMM','775C ','500-lb Brace',1425.00,5);
INSERT INTO PRODUCTS VALUES('ACI','4100Z','Widget Installer',2500.00,28);
INSERT INTO PRODUCTS VALUES('QSA','XK48A','Reducer',177.00,37);
INSERT INTO PRODUCTS VALUES('ACI','41002','Size 2 Widget',76.00,167);
INSERT INTO PRODUCTS VALUES('REI','2A44R','Right Hinge',4500.00,12);
INSERT INTO PRODUCTS VALUES('IMM','773C ','300-lb Brace',975.00,28);
INSERT INTO PRODUCTS VALUES('ACI','4100X','Widget Adjuster',25.00,37);
INSERT INTO PRODUCTS VALUES('FEA','114  ','Motor Mount',243.00,15);
INSERT INTO PRODUCTS VALUES('IMM','887X ','Brace Retainer',475.00,32);
INSERT INTO PRODUCTS VALUES('REI','2A44G','Hinge Pin',350.00,14);
---
---  OFFICES
---
INSERT INTO OFFICES VALUES(22,'Denver','Western',null,300000.00,186042.00);
INSERT INTO OFFICES VALUES(11,'New York','Eastern',null,575000.00,692637.00);
INSERT INTO OFFICES VALUES(12,'Chicago','Eastern',null,800000.00,735042.00);
INSERT INTO OFFICES VALUES(13,'Atlanta','Eastern',null,350000.00,367911.00);
INSERT INTO OFFICES VALUES(21,'Los Angeles','Western',null,725000.00,835915.00);
---
---  SALESREPS
---
INSERT INTO SALESREPS VALUES (106,'Sam Clark',52,11,'VP Sales','2006-06-14',null,275000.00,299912.00);
INSERT INTO SALESREPS VALUES (109,'Mary Jones',31,11,'Sales Rep','2007-10-12',106,300000.00,392725.00);
INSERT INTO SALESREPS VALUES (104,'Bob Smith',33,12,'Sales Mgr','2005-05-19',106,200000.00,142594.00);
INSERT INTO SALESREPS VALUES (108,'Larry Fitch',62,21,'Sales Mgr','2007-10-12',106,350000.00,361865.00);
INSERT INTO SALESREPS VALUES (105,'Bill Adams',37,13,'Sales Rep','2006-02-12',104,350000.00,367911.00);
INSERT INTO SALESREPS VALUES (102,'Sue Smith',48,21,'Sales Rep','2004-12-10',108,350000.00,474050.00);
INSERT INTO SALESREPS VALUES (101,'Dan Roberts',45,12,'Sales Rep','2004-10-20',104,300000.00,305673.00);
INSERT INTO SALESREPS VALUES (110,'Tom Snyder',41,null,'Sales Rep','2008-01-13',101,null,75985.00);
INSERT INTO SALESREPS VALUES (103,'Paul Cruz',29,12,'Sales Rep','2005-03-01',104,275000.00,286775.00);
INSERT INTO SALESREPS VALUES (107,'Nancy Angelli',49,22,'Sales Rep','2006-11-14',108,300000.00,186042.00);
---
---   OFFICE MANAGERS
---
UPDATE OFFICES SET MGR=108 WHERE OFFICE=22;
UPDATE OFFICES SET MGR=106 WHERE OFFICE=11;
UPDATE OFFICES SET MGR=104 WHERE OFFICE=12;
UPDATE OFFICES SET MGR=105 WHERE OFFICE=13;
UPDATE OFFICES SET MGR=108 WHERE OFFICE=21;
---
---   CUSTOMERS
---
INSERT INTO CUSTOMERS VALUES(2111,'JCP Inc.',103,50000.00);
INSERT INTO CUSTOMERS VALUES(2102,'First Corp.',101,65000.00);
INSERT INTO CUSTOMERS VALUES(2103,'Acme Mfg.',105,50000.00);
INSERT INTO CUSTOMERS VALUES(2123,'Carter \& Sons',102,40000.00);
INSERT INTO CUSTOMERS VALUES(2107,'Ace International',110,35000.00);
INSERT INTO CUSTOMERS VALUES(2115,'Smithson Corp.',101,20000.00);
INSERT INTO CUSTOMERS VALUES(2101,'Jones Mfg.',106,65000.00);
INSERT INTO CUSTOMERS VALUES(2112,'Zetacorp',108,50000.00);
INSERT INTO CUSTOMERS VALUES(2121,'QMA Assoc.',103,45000.00);
INSERT INTO CUSTOMERS VALUES(2114,'Orion Corp.',102,20000.00);
INSERT INTO CUSTOMERS VALUES(2124,'Peter Brothers',107,40000.00);
INSERT INTO CUSTOMERS VALUES(2108,'Holm \& Landis',109,55000.00);
INSERT INTO CUSTOMERS VALUES(2117,'J.P. Sinclair',106,35000.00);
INSERT INTO CUSTOMERS VALUES(2122,'Three Way Lines',105,30000.00);
INSERT INTO CUSTOMERS VALUES(2120,'Rico Enterprises',102,50000.00);
INSERT INTO CUSTOMERS VALUES(2106,'Fred Lewis Corp.',102,65000.00);
INSERT INTO CUSTOMERS VALUES(2119,'Solomon Inc.',109,25000.00);
INSERT INTO CUSTOMERS VALUES(2118,'Midwest Systems',108,60000.00);
INSERT INTO CUSTOMERS VALUES(2113,'Ian \& Schmidt',104,20000.00);
INSERT INTO CUSTOMERS VALUES(2109,'Chen Associates',103,25000.00);
INSERT INTO CUSTOMERS VALUES(2105,'AAA Investments',101,45000.00);
---
---  ORDERS
---
INSERT INTO ORDERS VALUES (112961,'2007-12-17',2117,106,'REI','2A44L',7,31500.00);
INSERT INTO ORDERS VALUES (113012,'2008-01-11',2111,105,'ACI','41003',35,3745.00);
INSERT INTO ORDERS VALUES (112989,'2008-01-03',2101,106,'FEA','114',6,1458.00);
INSERT INTO ORDERS VALUES (113051,'2008-02-10',2118,108,'QSA','XK47',4,1420.00);
INSERT INTO ORDERS VALUES (112968,'2007-10-12',2102,101,'ACI','41004',34,3978.00);
INSERT INTO ORDERS VALUES (113036,'2008-01-30',2107,110,'ACI','4100Z',9,22500.00);
INSERT INTO ORDERS VALUES (113045,'2008-02-02',2112,108,'REI','2A44R',10,45000.00);
INSERT INTO ORDERS VALUES (112963,'2007-12-17',2103,105,'ACI','41004',28,3276.00);
INSERT INTO ORDERS VALUES (113013,'2008-01-14',2118,108,'BIC','41003',1,652.00);
INSERT INTO ORDERS VALUES (113058,'2008-02-23',2108,109,'FEA','112',10,1480.00);
INSERT INTO ORDERS VALUES (112997,'2008-01-08',2124,107,'BIC','41003',1,652.00);
INSERT INTO ORDERS VALUES (112983,'2007-12-27',2103,105,'ACI','41004',6,702.00);
INSERT INTO ORDERS VALUES (113024,'2008-01-20',2114,108,'QSA','XK47',20,7100.00);
INSERT INTO ORDERS VALUES (113062,'2008-02-24',2124,107,'FEA','114',10,2430.00);
INSERT INTO ORDERS VALUES (112979,'2007-10-12',2114,102,'ACI','4100Z',6,15000.00);
INSERT INTO ORDERS VALUES (113027,'2008-01-22',2103,105,'ACI','41002',54,4104.00);
INSERT INTO ORDERS VALUES (113007,'2008-01-08',2112,108,'IMM','773C',3,2925.00);
INSERT INTO ORDERS VALUES (113069,'2008-03-02',2109,107,'IMM','775C',22,31350.00);
INSERT INTO ORDERS VALUES (113034,'2008-01-29',2107,110,'REI','2A45C',8,632.00);
INSERT INTO ORDERS VALUES (112992,'2007-11-04',2118,108,'ACI','41002',10,760.00);
INSERT INTO ORDERS VALUES (112975,'2007-10-12',2111,103,'REI','2A44G',6,2100.00);
INSERT INTO ORDERS VALUES (113055,'2008-02-15',2108,101,'ACI','4100X',6,150.00);
INSERT INTO ORDERS VALUES (113048,'2008-02-10',2120,102,'IMM','779C',2,3750.00);
INSERT INTO ORDERS VALUES (112993,'2007-01-04',2106,102,'REI','2A45C',24,1896.00);
INSERT INTO ORDERS VALUES (113065,'2008-02-27',2106,102,'QSA','XK47',6,2130.00);
INSERT INTO ORDERS VALUES (113003,'2008-01-25',2108,109,'IMM','779C',3,5625.00);
INSERT INTO ORDERS VALUES (113049,'2008-02-10',2118,108,'QSA','XK47',2,776.00);
INSERT INTO ORDERS VALUES (112987,'2007-12-31',2103,105,'ACI','4100Y',11,27500.00);
INSERT INTO ORDERS VALUES (113057,'2008-02-18',2111,103,'ACI','4100X',24,600.00);
INSERT INTO ORDERS VALUES (113042,'2008-02-20',2113,101,'REI','2A44R',5,22500.00);


--------
select TOP(5) *
from ORDERS 
ORDER BY AMOUNT DESC;

--3.	Написать скрипт из следующих запросов к базе данных:
--3.1.	Выбрать фамилии и даты найма всех сотрудников.
SELECT 
  s.NAME as EmplName, 
  s.HIRE_DATE as DateIn
FROM SALESREPS s
ORDER BY s.HIRE_DATE DESC

--3.2.	Выбрать все заказы, выполненные после опреденной даты.
SELECT * FROM ORDERS O
WHERE O.ORDER_DATE>='2008-01-01'

--3.3.	Выбрать все офисы из определенного региона и управляемые определенным сотрудником.
SELECT o.*,
s.NAME as EmpName
FROM OFFICES o
left join SALESREPS s on o.MGR = s.MANAGER
WHERE o.region='Western'
and s.NAME like '%Nancy%'

--3.4.	Выбрать заказы, сумма которых больше определенного значения.
select * 
from ORDERS o
where o.AMOUNT>15000

--3.5.	Выбрать заказы определенного покупателя.
select 
o.*, c.COMPANY 
from orders o
left join customers c on o.CUST = c.CUST_NUM
where c.COMPANY like '%Sinclair%'
-- or c.CUST_NUM = 2117

--3.6.	Выбрать заказы, сделанные в определенный период.
select * from ORDERS o 
where o.ORDER_DATE between '2008-01-01' and '2008-01-31'

--3.7.	Выбрать офисы из 12, 13 и 21 региона.
select * from OFFICES o
where  o.OFFICE = 12 or  
       o.OFFICE=13 or 
	   o.OFFICE=21
-- or  o.OFFICE in (12,13,21)

--3.8.	Выбрать сотрудника, у которого нет менеджера (самого главного).
select * from SALESREPS s where s.MANAGER is null

--3.9.	Выбрать офисы из региона, который начинается на East.
select * from OFFICES o
where o.REGION like 'East%'

--3.10.	Выбрать всех продукты с ценой больше определенного значения и отсортировать в порядке убывания цены.
select * from PRODUCTS p
where p.PRICE>1000 
order by p.PRICE desc

--3.11.	Выбрать фамилии и даты найма всех сотрудников и отсортировать по возрасту.
SELECT 
  s.NAME as EmplName, 
  s.HIRE_DATE as DateIn, s.AGE
FROM SALESREPS s
ORDER BY s.Age asc

--3.12.	Выбрать все заказы и отсортировать вначале по стоиомсти по убыванию, а затем по количеству заказанного по возрастанию.
select * from ORDERS o 
order by o.AMOUNT desc, o.QTY asc

--3.13.	Выбрать 5 самых дорогих товаров.
select top(5) * from PRODUCTS p
order by p.PRICE desc
--- WITH TIES

select TOP(5) *
from ORDERS 
ORDER BY AMOUNT DESC;

--OFFSET 
--FETCH


--3.14.	Выбрать 3 самых молодых сотрудников.
SELECT TOP(3) *
FROM SALESREPS 
ORDER BY AGE ASC;

select * from SALESREPS
order by age
offset 0 rows
fetch first 3 rows only;

--3.15.	Выбрать 20% самых дорогих заказов.
select top 20 percent * from orders
order by amount desc;

--3.16.	Выбрать 11 покупателей с самым высоким кредитным лимитом.
select top 11 * from customers
order by credit_limit desc;

--3.17.	Выбрать сотрудников с 4 по 7, отсортированных по дате найма. ???????????????????????????????????
select * from salesreps s where s.EMPL_NUM between 104 and 107 
order by hire_date;


--3.18.	Выбрать сотрудников с 4 по 7, отсортированных по возрасту и тех, кто с ними одного возраста.?????????????
select * from salesreps s
join salesreps s1 on s1.
where s.EMPL_NUM between 104 and 107 

order by hire_date;

--3.19.	Выбрать уникальные товары в заказах.
select distinct mfr, product from orders;

--3.20.	Подсчитать количество заказов для каждого покупателя.
select count(*) count_of_orders 
from orders;

select cust, count(*) count_of_orders from orders group by cust;

--3.21.	Подсчитать итоговую сумму заказа для каждого покупателя.

select sum(amount) count_of_orders 
from orders;

select cust, sum(amount) sum_of_orders from orders group by cust;

--3.22.	Подсчитать среднюю цену заказа для каждого сотрудника.

select avg(amount) count_of_orders 
from orders;

select rep, count(*) count_oforders,
             avg(amount) avg_amount
from orders
group by rep;

select cust, avg(amount) avg_of_orders from orders group by cust;



--3.23.	Найти сотрудников, у которых есть заказ стоимости выше определенного значения.
select cust, amount from orders 
where amount >1000;

--3.24.	Найти количество продуктов для каждого производителя.
select mfr_id, count(product_id) from products
group by mfr_id


--3.25.	Найти самый дорогой товар каждого производителя.
select mfr_id, product_id, max(price) from products
group by mfr_id, product_id

select 
  o.order_num,
  o.order_date,
  c.company,
  s.name,
  s.Title,
  o.mfr,
  o.product,
  p.description,
  p.price,
  o.qty,
  o.amount
from orders o
join salesreps s on o.REP=s.EMPL_NUM
join customers c on o.CUST = c.CUST_NUM
join products p on o.product = p.product_id and o.mfr = p.mfr_id

select 
  s.empl_num,
  s.name,
  s.age,
  o.city,
  s.title,
  s.hire_date
from salesreps s
join offices o on s.rep_office = o.office;



--3.26.	Найти покупателей и их заказы (в результирующем наборе должны быть: 
--наименование покупателя, наименование товара, производитель, количество и итоговая сумма).
select 
  c.COMPANY,
  p.DESCRIPTION,
  o.MFR,
  o.QTY,
  o.AMOUNT
from ORDERS o 
join CUSTOMERS c on c.CUST_NUM = o.CUST
join PRODUCTS p on p.PRODUCT_ID = o.PRODUCT and o.MFR = p.MFR_ID
order by c.COMPANY, p.DESCRIPTION


--3.27.	Найти всех покупателей и их заказы.
select 
  c.COMPANY,
  p.DESCRIPTION,
  o.MFR,
  o.QTY,
  o.AMOUNT
from CUSTOMERS  c 
left join ORDERS o on c.CUST_NUM = o.CUST
left join PRODUCTS p on p.PRODUCT_ID = o.PRODUCT and o.MFR = p.MFR_ID
order by c.COMPANY, p.DESCRIPTION

--3.28.	Найти покупателей, у которых нет заказов.
select 
  c.COMPANY
from CUSTOMERS  c 
left join ORDERS o on c.CUST_NUM = o.CUST
where o.cust is null

--3.29.	Найти покупателей, у которых есть заказы в определенный период.
select 
  c.COMPANY
from ORDERS o
join CUSTOMERS c on c.CUST_NUM = o.CUST
where o.ORDER_DATE between '2000-01-01' and '2000-03-31'



--3.30.	Найти покупателей, у которых есть заказы выше определенной суммы.
select 
  c.COMPANY, o.AMOUNT
from ORDERS o
join CUSTOMERS c on c.CUST_NUM = o.CUST
where o.AMOUNT>5000

--3.31.	Найти заказы, которые оформляли менеджеры из региона EAST.
select 
o.*
from ORDERS o
join SALESREPS s on s.EMPL_NUM = o.REP
join OFFICES f on f.MGR = s.MANAGER
where left(f.REGION,4) = 'East'


--3.32.	Найти товары, которые купили покупатели с кредитным лимитом больше 40000.
select * from ORDERS o
join CUSTOMERS c on c.CUST_REP= o.REP
where c.CREDIT_LIMIT>40000


--3.33.	Найти всех сотрудников из региона EAST и все их заказы.
select s.EMPL_NUM, s.NAME, o.ORDER_NUM, o.AMOUNT
from SALESREPS s 
join OFFICES f on f.MGR = s.MANAGER
join ORDERS o on o.REP = s.EMPL_NUM
where f.REGION like '%East%'
order by s.EMPL_NUM

--3.34.	Найти сотрудников, которые не оформили ни одного заказа.
select s.EMPL_NUM, s.NAME 
from SALESREPS s
where not exists 
	(select * from ORDERS o 
	where o.REP = s.EMPL_NUM)

--3.35.	Найти сотрудников одного возраста.
/*изменим данные, чтобы увидеть одинакового возраста*/

update SALESREPS set AGE = 31
where EMPL_NUM = 110

select 
  s1.NAME, s2.NAME, s1.AGE
from SALESREPS s1 
join SALESREPS s2 on s1.AGE = s2.AGE
where s1.NAME<s2.NAME

--4.	Поместить результирующие наборы из запроса 3.30 в локальную временную таблицу.
select 
  c.COMPANY, o.AMOUNT
into #tempCompanyAmount
from ORDERS o
join CUSTOMERS c on c.CUST_NUM = o.CUST
where o.AMOUNT>5000

--5.	Просмотреть данные из локальной временной таблицы.
select * from #tempCompanyAmount

--6.	Поместить результирующие наборы из запроса 3.31 в глобальную временную таблицу.
select 
o.*
into ##OrdersEastRegion
from ORDERS o
join SALESREPS s on s.EMPL_NUM = o.REP
join OFFICES f on f.MGR = s.MANAGER
where left(f.REGION,4) = 'East'

--7.	Просмотреть данные из глобальных временных таблиц.
select * from ##OrdersEastRegion

--8.	Написать скрипт из аналогичных запросов к базе данных по варианту. В качестве комментария указать условие запроса.

--9.	Продемонстрировать оба скрипта преподавателю.


--Выбрать все заказы, выполненные определенным покупателем.
SELECT * FROM ORDERS O
JOIN CUSTOMER C ON C.ID = O.CUSTOMER_ID
WHERE C.SURNAME = 'ВОЛКОВ'

--Выбрать всех покупателей в порядке уменьшения обшей стоимости заказов.
SELECT 
C.SURNAME, C.FIRSTNAME,
SUM(OL.FACT_COST*OL.QUANTITY) AS AMOUNT
FROM ORDERS O
JOIN ORDERSLINE OL ON OL.MASTERKEY= O.ID
JOIN CUSTOMER C ON C.ID = O.CUSTOMER_ID
GROUP BY C.SURNAME, C.FIRSTNAME
ORDER BY 3 DESC

