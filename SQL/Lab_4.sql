USE [Maiseyeu_04]

---
---  CREATE TABLE statements
---

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
---  Inserts for sample schema
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

/*
Lab4
����������. �������� ��� �����������. DML. �������������.
1.	�������� ������ �� ��������� �������� � ����� ���� ������ (� ������������ ��������� ����� �������):*/

--1.1.	������� ��� ������, ����������� ������������ �����������.
SELECT * FROM ORDERS o
WHERE O.CUST=2103

--1.2.	������� ���� ����������� � ������� ���������� ����� ��������� �������.
SELECT C.CUST_NUM, C.COMPANY,
(SELECT  
   SUM(O.AMOUNT)
 FROM ORDERS O
 WHERE O.CUST = C.CUST_NUM) AS SUMM
FROM  CUSTOMERS C
ORDER BY 3 DESC

--1.3.	������� ��� ������, ������� ����������� ����������� �� ���������� �������.
SELECT * FROM ORDERS O
WHERE O.REP IN 
(SELECT S.EMPL_NUM 
FROM SALESREPS S
JOIN OFFICES F ON F.OFFICE = S.REP_OFFICE
WHERE F.REGION = 'EASTERN')

--1.4.	����� �������� �������, ������������� ����������� First Corp.
SELECT P.PRODUCT_ID, P.DESCRIPTION
FROM PRODUCTS P
JOIN ORDERS O ON O.PRODUCT = P.PRODUCT_ID
WHERE O.CUST =  
     (SELECT C.CUST_NUM 
	 FROM CUSTOMERS C WHERE C.COMPANY = 'First Corp.')

--1.5.	������� ���� ����������� �� ���������� ������� � ������������� �� ��������� Quota.
SELECT S.EMPL_NUM,S.NAME, S.QUOTA 
FROM SALESREPS S
JOIN OFFICES F ON F.OFFICE = S.REP_OFFICE
WHERE F.REGION = 'EASTERN'
ORDER BY 3

--1.6.	������� ������, ����� ������� ������ �������� ��������.
SELECT 
* 
FROM ORDERS O
WHERE O.AMOUNT>(SELECT AVG(AMOUNT) FROM ORDERS)


--1.7.	������� ����������, ������� ����������� ����� � ��� �� �����������.
SELECT * 
FROM SALESREPS S
WHERE s.EMPL_NUM in
 (SELECT distinct 
  o.REP 
  FROM ORDERS O 
  JOIN ORDERS O1 ON O1.CUST = O.CUST AND O.REP!=O1.REP)

--1.8.	������� ����������� � ���������� ��������� �������.
SELECT C.CUST_NUM, C.COMPANY,  c1.CUST_NUM,c1.COMPANY, c.CREDIT_LIMIT 
FROM CUSTOMERS C 
JOIN CUSTOMERS C1 ON C.CUST_NUM!=C1.CUST_NUM AND C.CREDIT_LIMIT = C1.CREDIT_LIMIT
WHERE C.CUST_NUM<C1.CUST_NUM

--1.9.	������� �����������, ��������� ������ � ���� ����.
SELECT * FROM CUSTOMERS C
WHERE C.CUST_NUM IN 
(SELECT O.CUST 
 FROM ORDERS O
JOIN ORDERS O1 ON O1.CUST<>O.CUST AND O1.ORDER_DATE = O.ORDER_DATE)


--1.10.	����������, �� ����� ����� ������ ���� �������� ������, � ������������� �� � ������� ��������.
SELECT F.OFFICE, F.CITY, SUM(O.AMOUNT) 
FROM ORDERS O
JOIN SALESREPS S ON S.EMPL_NUM = O.REP
JOIN OFFICES F ON F.OFFICE = S.REP_OFFICE
GROUP BY F.OFFICE, F.CITY
ORDER BY 3 DESC


--1.11.	������� �����������, ������� �������� ������������ (� ������� ���� �����������).
SELECT * 
FROM SALESREPS S
WHERE s.EMPL_NUM in (
 SELECT DISTINCT
   S1.MANAGER
 FROM SALESREPS S1
 WHERE S1.MANAGER IS NULL or S1.MANAGER>0)

--1.12.	������� �����������, ������� �� �������� ������������ (� ������� ��� �����������).
SELECT * 
FROM SALESREPS S
WHERE s.EMPL_NUM NOT in (
 SELECT DISTINCT
   S1.MANAGER
 FROM SALESREPS S1
 WHERE S1.MANAGER>0)

--1.13.	������� ���� ��������, ����������� ����������� �� ���������� �������.
SELECT 
P.PRODUCT_ID,
P.DESCRIPTION
FROM ORDERS O
JOIN PRODUCTS P ON P.PRODUCT_ID = O.PRODUCT
JOIN SALESREPS S ON S.EMPL_NUM = O.REP
JOIN OFFICES F ON F.OFFICE = S.REP_OFFICE
WHERE F.REGION='EASTERN'
GROUP BY P.PRODUCT_ID, P.DESCRIPTION

--1.14.	������� ������� � ���� ����� ���� ����������� � ������������� �� ����� �������, ������� ��� ���������.
SELECT 
  S.NAME, 
  S.HIRE_DATE,
   (SELECT SUM(O.AMOUNT) 
    FROM ORDERS O 
    WHERE O.REP= S.EMPL_NUM) AS SUMRET
FROM SALESREPS S
ORDER BY 3 DESC


--1.15.	������� ������, ����������� ����������� ��  ���������� ������� � ������������� �� ���������� ����������� �� �����������.
SELECT *
FROM ORDERS O
JOIN SALESREPS S ON S.EMPL_NUM = O.REP
JOIN OFFICES F ON S.REP_OFFICE = F.OFFICE
WHERE F.REGION = 'EASTERN'
ORDER BY QTY


--1.16.	������� ������, ������� ������ �������, ���������� ��������� First Corp.
SELECT * FROM PRODUCTS P
WHERE P.PRICE>(
  SELECT 
    MAX(O.AMOUNT) 
  FROM ORDERS O 
  JOIN CUSTOMERS C ON C.CUST_NUM = O.CUST
  WHERE C.COMPANY =  'First Corp.')

--1.17.	������� ������, ������� �� ������ � ������, ���������� ��������� First Corp.
SELECT * FROM PRODUCTS P
WHERE P.PRODUCT_ID NOT IN (
  SELECT 
    O.PRODUCT
  FROM ORDERS O 
  JOIN CUSTOMERS C ON C.CUST_NUM = O.CUST
  WHERE C.COMPANY =  'First Corp.')


--1.18.	������� ������, ������� �� ��������� ���� �������� �������� ��������� ������ �� ����������.
SELECT 
 * 
FROM PRODUCTS P 
WHERE P.PRICE<(
SELECT 
  AVG(O.AMOUNT) 
FROM ORDERS O)


--1.19.	����� �����������, ��� �������� ������ � 2008, �� �� �������� � 2007 (��� ������� 2-�� ������� ���������).
SELECT * 
FROM SALESREPS S
WHERE S.EMPL_NUM IN (
SELECT 
  O.REP
FROM ORDERS O 
WHERE (O.ORDER_DATE BETWEEN '2008-01-01' AND '2008-12-31')
AND NOT EXISTS 
  (SELECT * FROM
    ORDERS O1 
  WHERE O1.REP = O.REP AND 
  O1.ORDER_DATE<'2008-01-01'))

---2 ������ ����������� EXCEPT
SELECT 
  O.REP 
FROM ORDERS O
WHERE YEAR(O.ORDER_DATE)=2008
EXCEPT 
SELECT 
  O.REP 
FROM ORDERS O
WHERE YEAR(O.ORDER_DATE)=2007


--1.20.	����� �����������, ������� �� ������ ������ � 2008, �� ������ � 2007 (��� ������� 2-�� ������� ���������).
SELECT 
  O.CUST
FROM ORDERS O
WHERE YEAR(O.ORDER_DATE)=2007
and O.CUST not in (
 SELECT 
  O.CUST
FROM ORDERS O
WHERE YEAR(O.ORDER_DATE)=2008)


USE [Maiseyeu_04]
--1.21.	����� �����������, ������� ������ ������ � 2008 � � 2007 (��� ������� 2-�� ������� ���������).

SELECT DISTINCT
  O.CUST 
FROM ORDERS O
WHERE YEAR(O.ORDER_DATE)=2008 
AND EXISTS (
    SELECT  * 
    FROM ORDERS O1 
    WHERE 
	O1.CUST = O.CUST 
	AND Year(O1.ORDER_DATE)=2007) 


SELECT O.CUST FROM ORDERS O
WHERE O.ORDER_DATE BETWEEN '2008-01-01' AND '2008-12-31'
INTERSECT  /*�����������*/
SELECT O.CUST FROM ORDERS O
WHERE YEAR(O.ORDER_DATE)=2007



--2.	��������� DML ��������:
--2.1.	�������� ������� ����� (����, ��������, �������������, ���) � ��� ����� �������������� ��� �������� ������ � ������� PRODUCTS.
CREATE TABLE AUDIT_PROD(
ID INT IDENTITY,
OPER_DATE DATE,
OPER_NAME VARCHAR(20) CHECK (OPER_NAME IN ('INS', 'DEL','UPD')),
PROODUCER VARCHAR(60),
CODE VARCHAR(20))

--2.2.	�������� �� ��������� ������� ��� ������.
SELECT 
* 
INTO #TEMPGOODS
FROM PRODUCTS P


--2.3.	�������� � ��� �� ��������� ������� ������ � ������, ��������� ����������� NULL � DEFAULT.
SELECT * FROM #TEMPGOODS

ALTER TABLE #TEMPGOODS ALTER COLUMN DESCRIPTION VARCHAR(25) NOT NULL;

--������� ����²�� ����Ͳ��Ͳ� - Cannot find the object "#TEPMGOODS" because it does not exist or you do not have permissions.
ALTER TABLE #TEPMGOODS 
  ADD CONSTRAINT df_PRICE
  DEFAULT 1000.0 FOR price;

--������� ����²�� ����Ͳ��Ͳ� - Cannot find the object "#TEPMGOODS" because it does not exist or you do not have permissions.
ALTER TABLE #TEPMGOODS 
  ADD CONSTRAINT df_QUANT
  DEFAULT 2 FOR QTY_ON_HAND;


INSERT INTO #TEMPGOODS (MFR_ID, PRODUCT_ID, DESCRIPTION, PRICE,QTY_ON_HAND)
  VALUES('REI',9010,'Mercedes', 15900, 7)

INSERT INTO #TEMPGOODS (MFR_ID, PRODUCT_ID, DESCRIPTION, PRICE,QTY_ON_HAND)
  VALUES('REI',9110, 'GM', 11000, 3)



--2.4.	�������� � ��� �� ��������� ������� ������ � ������, � ������������ �������� ��� �� ������ � ������� ������ 
-- (� ������� �������� ������� INSERT, � ������� ���� � ������� ����).
INSERT INTO #TEMPGOODS (MFR_ID, PRODUCT_ID, DESCRIPTION, PRICE,QTY_ON_HAND)
  VALUES('IBA',1210, 'AUDIT', 860, 21)

INSERT INTO AUDIT_PROD (OPER_DATE,OPER_NAME,PROODUCER,CODE) 
  VALUES(GETDATE(), 'INS','IBA', 'INSERT DATE' )
  

--2.5.	�������� ������ � ������� �� ��������� ������� � �������� 20% � ����.
UPDATE #TEMPGOODS SET PRICE = 1.2*PRICE
-- ������ ��� �����������
SELECT * FROM #TEMPGOODS

--2.6.	�������� ������ � �������, ������� ���������� First Corp. �� ��������� ������� � �������� 10% � ����.

update #TEMPGOODS set PRICE = 1.1*price 
 where PRODUCT_ID in (
select 
  o.PRODUCT
from ORDERS o
join CUSTOMERS c on c.CUST_NUM = o.CUST
where c.COMPANY = 'First Corp.')

--2.7.	�������� ������ � ������ �� ��������� �������, � ������������ �������� ��� �� ������ � ������� ������
--      (� ������� �������� ������� UPDATE, � ������� ���� � ������� ����).

BEGIN
  UPDATE #TEMPGOODS SET PRICE=99.99 WHERE PRODUCT_ID='41002';
  INSERT INTO AUDIT_PROD (OPER_DATE,OPER_NAME,PROODUCER,CODE) 
    VALUES(GETDATE(), 'UPD','USER', 'UPD 91.20->99.99' );   
END 


--2.8.	������� ������, ������� ���������� First Corp. �� ��������� �������.
DELETE FROM #TEMPGOODS 
WHERE PRODUCT_ID IN
(SELECT 
  O.PRODUCT 
FROM ORDERS O
LEFT JOIN CUSTOMERS C ON C.CUST_NUM = O.CUST
WHERE C.COMPANY = 'First Corp.')


--2.9.	������� ������ � �����-���� ������ �� ��������� �������, � ������������ �������� ��� ������ � ������� ������ 
--      (� ������� �������� ������� DELETE, � ������� ���� � ������� ����).

BEGIN
  DELETE FROM #TEMPGOODS WHERE QTY_ON_HAND = 0;
  INSERT INTO AUDIT_PROD (OPER_DATE,OPER_NAME,PROODUCER,CODE)
       VALUES(GETDATE(),'DEL','DEL RECORDS WHERE QUANTITY=0', '910');
END
-- ������ ���������
SELECT * FROM AUDIT_PROD

--3.	�������� �������������:
--3.1.	�����������, � ������� ���� ������ ���� ������������ �����.
CREATE VIEW V_CUSTOMER_ORDERS
AS
SELECT 
  C.COMPANY, 
  O.AMOUNT 
FROM CUSTOMERS C 
JOIN ORDERS O ON O.CUST = C.CUST_NUM
WHERE O.AMOUNT>10000

--- ������, ��� �����
SELECT * FROM V_CUSTOMER_ORDERS
ORDER BY AMOUNT

--3.2.	�����������, � ������� ����� ��������� � ��������� �������.
CREATE VIEW V_EASTREGION_SALERS
AS
SELECT 
  S.EMPL_NUM, 
  S.NAME AS EMPLNAME, 
  S.REP_OFFICE AS OFFICE 
FROM SALESREPS S
JOIN OFFICES F ON S.REP_OFFICE= F.OFFICE
WHERE F.REGION = 'EASTERN'

-- �����в�
SELECT * FROM V_EASTREGION_SALERS

--3.3.	������, ����������� � 2008 ����.
CREATE VIEW V_ORDERS_Y2008
AS
SELECT * FROM ORDERS O
WHERE YEAR(O.ORDER_DATE)=2008

-- �����в�
SELECT * FROM V_ORDERS_Y2008


--3.4.	����������, ������� �� �������� �� ������ ������.
CREATE VIEW V_EMPL_WITHOUTORDERS
AS
SELECT * FROM SALESREPS S
WHERE NOT EXISTS ( 
SELECT * 
FROM ORDERS O
WHERE O.REP = S.EMPL_NUM)

SELECT * FROM V_EMPL_WITHOUTORDERS


--3.5.	����� ���������� �����.
---? ����� ���������� �����:
---- ������ ����� ������� �� ����������?
---- ��� ������ ����� ������� ��� ���������� ������ �����?

select top(1) 
  o.PRODUCT, 
  p.DESCRIPTION, 
  sum(o.QTY)
from ORDERS o
join PRODUCTS p on p.PRODUCT_ID = o.PRODUCT
group by o.PRODUCT,p.DESCRIPTION
order by 3 desc

/*������ ����� ������� � ������ �������*/
select top(1) 
  o.PRODUCT,
  count(o.ORDER_NUM)
from ORDERS o
group by o.PRODUCT
order by 2 desc

--4.����������������� ���������� DML �������� ��� ���������������.

alter view v_orders_y2008
as
SELECT 
  o.ORDER_DATE, 
  o.ORDER_NUM, 
  c.COMPANY as customer, 
  s.NAME as saler, 
  o.QTY, o.AMOUNT  
FROM ORDERS O
left join CUSTOMERS c on c.CUST_NUM = o.CUST
join SALESREPS s on s.EMPL_NUM = o.REP
WHERE YEAR(O.ORDER_DATE)=2008

select * from v_orders_y2008

/*������� ������� ������������� �� ������ 1 ������� ��� ������.������� ������*/
CREATE VIEW V_ORDERSLite_2008
AS
SELECT * FROM ORDERS O
WHERE YEAR(O.ORDER_DATE)=2008

/* ��������, ��� ���� */
select * from V_ORDERSLite_2008

/* ������� ������ � ������� ����� ������� �������������*/
INSERT INTO V_ORDERSLite_2008 
  VALUES(900010, '2024-10-23',2101,106,'FEA',114, 90, 14520.99)

/* ��������, ��� ���������� ������*/
select * from ORDERS where year(ORDER_DATE)=2024

/*��������� ������ ����� �������������*/
UPDATE V_ORDERSLite_2008 SET AMOUNT= 1.5*AMOUNT
WHERE ORDER_NUM=112989

/*��������*/
DELETE FROM V_ORDERSLite_2008 WHERE QTY =4




--5. ����������������� � ��������� ���������� ����� CHECK OPTION � SCHEMABINDING. ??????????
/*������������*/
ALTER VIEW V_ORDERSLite_2008
AS
SELECT * FROM ORDERS O
WHERE YEAR(O.ORDER_DATE)=2008
WITH CHECK OPTION

/* �� ���� ��������, �.�. ���� ����������� 
YEAR(O.ORDER_DATE)=2008
WITH CHECK OPTION

The attempted insert or update failed because the target view either specifies WITH CHECK OPTION or 
spans a view that specifies WITH CHECK OPTION 
and one or more rows resulting from the operation did not qualify under the CHECK OPTION constraint.
*/
INSERT INTO V_ORDERSLite_2008 
  VALUES(900011, '2024-10-23',2101,106,'FEA',114, 90, 14520.99)

/*������ �������������*/
drop view V_ORDERSLite_2008





--6.	����������������� ������ ���������� �������� ��� �����������.
-- �� ������� 1.19.	����� �����������, ��� �������� ������ � 2008, �� �� �������� � 2007
SELECT 
  O.REP 
FROM ORDERS O
WHERE YEAR(O.ORDER_DATE)=2008
EXCEPT -- ���������� EXCEPT
SELECT 
  O.REP 
FROM ORDERS O
WHERE YEAR(O.ORDER_DATE)=2007

use [Maiseyeu_04]

--7.	����������������� ���������� ������� TRUNCATE.
/* TRUNCATE � ��� ������� DDL, ������ � ������� ��������� �������.
� ��� ������� ����������� ������������, ���������� ��������, ��������� ��� ����� �� �������.
� ������� �� ��������� ��������� ������ � �� ������������ ��� ��������, ��� �����, �� ������� ������������ ��������������.
� TRUNCATE �� ���������� �������� �� ������ �����, ��� ��� �� ��������������� � ���� �� �����������.
� �������� � ������������ ����������� �� ���������� ���� ��������.
� � ������ ���������������� ����� � �������� ��������.
� ��������� �������������� ����� �������, ����� �� �������� � ����������� �������������.
*/
-- �������� ��������� �������
select * 
into ##tempOrders
from ORDERS
select * from ##tempOrders

/*������ ��� � �������*/
Truncate table ##tempOrders

--�������, ��� ����������
select * from ##tempOrders


--8.	�������� ������ �� ����������� �������� � ���� ������ �� ��������. � �������� ����������� ������� ������� �������.
use [2024_Maiseyeu]


-- �������� �������������, ������������ ������� ���������� �������
CREATE VIEW V_SALEGOODS (GOODNAME, QUANTITY, AMOUNT)
AS
select 
  g.GOOD_NAME, 
  sum(ol.QUANTITY) as quantity,
  SUM(ol.QUANTITY*ol.FACT_COST) as amount
from ORDERSLINE ol
left join GOODS g on g.ID = ol.GOOD_ID
group by g.GOOD_NAME

-- ��������� �����������, ����� �������� ���� �� ���������, ���� �� ����������
-- ��������, ��� 3 ������ ���������� ������� �����

SELECT TOP(3) * FROM V_SALEGOODS VS
ORDER BY AMOUNT DESC

-- ��� ���� ����� �����������
SELECT * FROM V_SALEGOODS
ORDER BY QUANTITY DESC 

--�������������, ������������ ������� ������ �� ��������(��������)
CREATE VIEW V_REGIONSALES
AS
SELECT 
R.CITY,
R.DISTRICT AS DISTRICT,
SUM(OL.QUANTITY) AS QUANTITY,
SUM(OL.QUANTITY*OL.FACT_COST) AS AMOUNT
FROM ORDERSLINE OL
LEFT JOIN ORDERS O ON OL.MASTERKEY = O.ID
LEFT JOIN CUSTOMER C ON C.ID = O.CUSTOMER_ID
LEFT JOIN REGION R ON R.ID = C.REGIONID 
GROUP BY R.CITY, R.DISTRICT

-- ������
SELECT * FROM V_REGIONSALES  VS
ORDER BY VS.AMOUNT DESC

-- �������� ������������� � ������� � ���, ��� ��� ����������, �� ��������� �������� ����� ����� ������ ������

CREATE VIEW V_ORDERS
AS
SELECT 
O.ID AS ORDERID, 
O.CUSTOMER_ID, 
O.DRIVER_ID,
O.KIND_DEL_ID,
O.LOADING_ID,
O.NUMBER,
O.ORDERDATE,
O.TRANSPORT_ID,
O.TYPE_DEL_ID,
OL.FACT_COST,
OL.GOOD_ID,
OL.ID AS LINEID,
OL.MASTERKEY,
OL.QUANTITY
FROM ORDERS O
JOIN ORDERSLINE OL ON OL.MASTERKEY = O.ID

--- ������������� ������������ ��� �������� �������� -)
CREATE VIEW V_DRIVERSALES
AS
SELECT 
D.SURNAME, D.FIRSTNAME,  D.LASTNAME,
SUM(VO.QUANTITY*VO.FACT_COST) AS AMOUNT
FROM V_ORDERS VO
JOIN DRIVER D ON D.ID = VO.DRIVER_ID
GROUP BY D.SURNAME, D.FIRSTNAME,  D.LASTNAME

SELECT 
  CAST(D.SURNAME AS VARCHAR(20)) + ' ' + CAST(D.FIRSTNAME AS VARCHAR(20)) + ' ' +  CAST( D.LASTNAME AS VARCHAR(20)),
  D.AMOUNT
FROM V_DRIVERSALES D
ORDER BY  D.AMOUNT DESC
 
 
--9.	����������������� ��� ������� �������������.

