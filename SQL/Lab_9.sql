use [Maiseyeu_04]
--������������ ������ � 9
--https://habr.com/ru/articles/247373/
/*������� ����������� ��������:
1.�������, ������� ����� ������������
  -���� ������ � ������������ - ����� �����������
  -���� ������������ ��� �������, �� ����� ������ �� ��������������
2.����������� ��� �������, ������� ����� � ������� WHERE --> ORDER BY --> ��, ��� ����� ��� �������� �������


!!! ���������� �������� �������, ��� � JOIN

*/
--������� � T-SQL.
--1.	������� ��� ������� ��� ������ ���� ������.
--2.	�������� ������ ��� ������� ��� ������ ������� � ����������������� ��� ����������.

--0,0032886, 0,0032842
select  
 o.REGION 
from OFFICES o
where o.REGION= 'Western'


--3.	�������� ������ ��� ������� ��� ���������� �������� � ����������������� ��� ����������.
-- 0,0033095, --0,0032853
SELECT 
  P.DESCRIPTION, 
  P.PRICE, 
  P.QTY_ON_HAND 
FROM PRODUCTS P
WHERE P.DESCRIPTION = 'REDUCER'


--4.	�������� ����������� ������ ��� ������� � ����������������� ��� ����������.
-- 0,0033139, --0,0032919
SELECT 
  O.ORDER_DATE, O.ORDER_NUM
FROM ORDERS O
WHERE O.ORDER_DATE BETWEEN '2007-01-01' AND '2007-12-31'


--5.	�������� ������ �������� ��� ������� � ����������������� ��� ����������.
--0,0031051, 0,0032842
SELECT 
  C.COMPANY, C.CREDIT_LIMIT
FROM CUSTOMERS C
WHERE C.CUST_REP =105


--6.	�������� ������ ��� ������� � ����������� ������ � ����������������� ��� ����������.
--0,0066151, 0,0065704
Select 
  c.COMPANY,o.CUST, o.AMOUNT 
from ORDERS o
left join CUSTOMERS c on c.CUST_NUM = o.CUST
where o.CUST =2117 

--7.	�������� ��������� �������� ��� ������� � ����������������� �� ����������� � �������������.
EXEC sp_helpindex Orders

SELECT 
  i.name, i.is_disabled, i.has_filter, i.is_unique
FROM sys.indexes i 
JOIN sys.tables t ON t.object_id = i.object_id 
WHERE t.name = 'ORDERS';

/*������������� ������� ������� ������ ��������, ��� ��� ������������. 
������� ������� ������� �� ���������������� ������� ��� ������������ �������, 
���� ��� ������ ������ ������������ ������������ �������. 
--https://sql-ex.ru/blogs/?/Skript_SQL_Server_dlJa_perestrojki_vseh_indeksov_dlJa_vseh_tablic_vo_vseh_bazah_dannyh.html
������������� ������ ����������� � ����������� �����������. 
��� ��������, ��� �� ��������� ������������ ���������� ������ � ������� ��� ���������� ������� ������� 
�� ����� ���������� �������� ALTER INDEX ... REORGANIZE ����� ������������.

���� �������� ������������� ���������� ������������� ��� ����������� ���� �������, 
��� ��� ����������� ��������� ����������� � ���� ������. 
��� ������������� ������� �������� ����� ����������� ��������� � ������������� ��������, 
���� �� ����� ��������� ��� ������.
*/

/*
*****������������� �������, ���� ������� ������������ ��������� 30%. 
     ���, �� ����, ������ ��������� ��������� ������� "� ����".

*****������������� ������� ��� ������������ �� 5% �� 30%, ��� ���������� ���������� ������.
*/

-- �������� ��������� ��������:
SELECT OBJECT_NAME(ind.OBJECT_ID) AS TableName,
    ind.name AS IndexName, indexstats.index_type_desc AS IndexType,
    indexstats.avg_fragmentation_in_percent
FROM sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, NULL) AS indexstats
INNER JOIN sys.indexes AS ind ON ind.object_id = indexstats.object_id
    AND ind.index_id = indexstats.index_id
--WHERE indexstats.avg_fragmentation_in_percent > 5
ORDER BY indexstats.avg_fragmentation_in_percent DESC;

--EXEC sp_updatestats; -- ���������� ���������� ���������� ���������� ������� ����� ��������

---!!!!!!!!!!!!!!!!!��� ����������� ���� �������� ������������ SQL!!!!!!!!!!!!!!!!!
DECLARE @SQL NVARCHAR(MAX) = '';
SELECT @SQL += 'ALTER INDEX ' + QUOTENAME(name) + ' ON ' + 
  QUOTENAME(OBJECT_SCHEMA_NAME(object_id)) + '.' + 
  QUOTENAME(OBJECT_NAME(object_id)) + ' REBUILD;' + CHAR(10)
FROM sys.indexes
WHERE index_id > 0 AND OBJECTPROPERTY(object_id, 'IsUserTable') = 1;

EXEC sp_executesql @SQL; -- ��������� � ������� ����������� ���������� ��� ���������� ������ ��������



--8.	��� ��������, ������������� � ������������ ������ � 3, �������� � ��������������� ����� ��������.
use[Maiseyeu_03]

--9.	�������� ������� ��� ����������� �������� �� ������������ ������ � 3.
--10.	�������� ����������� ������� ��� ���� ������ ������ ��������.
