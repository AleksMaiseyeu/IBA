use [Maiseyeu_04]
--Лабораторная работа № 9
--https://habr.com/ru/articles/247373/
/*ПОРЯДОК ОПТИМИЗАЦИИ ЗАПРОСОВ:
1.смотрим, сколько строк возвращается
  -если близко к уникальности - будет оптимизация
  -если возвращается пол таблицы, то такой запрос не соптимизируешь
2.индексируем все столбцы, которые стоят в условии WHERE --> ORDER BY --> то, что стоит под внешними ключами


!!! подзапросы работают быстрее, чем с JOIN

*/
--Индексы в T-SQL.
--1.	Найдите все индексы для таблиц базы данных.
--2.	Создайте индекс для таблицы для одного столбца и продемонстрируйте его применение.

--0,0032886, 0,0032842
select  
 o.REGION 
from OFFICES o
where o.REGION= 'Western'


--3.	Создайте индекс для таблицы для нескольких столбцов и продемонстрируйте его применение.
-- 0,0033095, --0,0032853
SELECT 
  P.DESCRIPTION, 
  P.PRICE, 
  P.QTY_ON_HAND 
FROM PRODUCTS P
WHERE P.DESCRIPTION = 'REDUCER'


--4.	Создайте фильтрующий индекс для таблицы и продемонстрируйте его применение.
-- 0,0033139, --0,0032919
SELECT 
  O.ORDER_DATE, O.ORDER_NUM
FROM ORDERS O
WHERE O.ORDER_DATE BETWEEN '2007-01-01' AND '2007-12-31'


--5.	Создайте индекс покрытия для таблицы и продемонстрируйте его применение.
--0,0031051, 0,0032842
SELECT 
  C.COMPANY, C.CREDIT_LIMIT
FROM CUSTOMERS C
WHERE C.CUST_REP =105


--6.	Создайте индекс для запроса с соединением таблиц и продемонстрируйте его применение.
--0,0066151, 0,0065704
Select 
  c.COMPANY,o.CUST, o.AMOUNT 
from ORDERS o
left join CUSTOMERS c on c.CUST_NUM = o.CUST
where o.CUST =2117 

--7.	Покажите состояние индексов для таблицы и продемонстрируйте их перестройку и реорганизацию.
EXEC sp_helpindex Orders

SELECT 
  i.name, i.is_disabled, i.has_filter, i.is_unique
FROM sys.indexes i 
JOIN sys.tables t ON t.object_id = i.object_id 
WHERE t.name = 'ORDERS';

/*Реорганизация индекса требует меньше ресурсов, чем его перестроение. 
Поэтому следует считать ее предпочтительным методом для обслуживания индекса, 
если нет веских причин использовать перестроение индекса. 
--https://sql-ex.ru/blogs/?/Skript_SQL_Server_dlJa_perestrojki_vseh_indeksov_dlJa_vseh_tablic_vo_vseh_bazah_dannyh.html
Реорганизация всегда выполняется с сохранением подключения. 
Это означает, что не создаются долгосрочные блокировки таблиц и запросы или обновления базовой таблицы 
во время выполнения операции ALTER INDEX ... REORGANIZE могут продолжаться.

Если операция реорганизации отменяется пользователем или прерывается иным образом, 
все уже достигнутые улучшения сохраняются в базе данных. 
Для реорганизации больших индексов можно многократно запускать и останавливать операцию, 
пока не будет завершена вся работа.
*/

/*
*****Переставляйте индексы, если уровень фрагментации превышает 30%. 
     Это, по сути, полная установка состояния индекса "с нуля".

*****Реорганизуйте индексы при фрагментации от 5% до 30%, что аналогично ежедневной уборке.
*/

-- Проверка состояния индексов:
SELECT OBJECT_NAME(ind.OBJECT_ID) AS TableName,
    ind.name AS IndexName, indexstats.index_type_desc AS IndexType,
    indexstats.avg_fragmentation_in_percent
FROM sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, NULL) AS indexstats
INNER JOIN sys.indexes AS ind ON ind.object_id = indexstats.object_id
    AND ind.index_id = indexstats.index_id
--WHERE indexstats.avg_fragmentation_in_percent > 5
ORDER BY indexstats.avg_fragmentation_in_percent DESC;

--EXEC sp_updatestats; -- Обновление статистики аналогично проведению осмотра после операции

---!!!!!!!!!!!!!!!!!Для перестройки всех индексов динамическим SQL!!!!!!!!!!!!!!!!!
DECLARE @SQL NVARCHAR(MAX) = '';
SELECT @SQL += 'ALTER INDEX ' + QUOTENAME(name) + ' ON ' + 
  QUOTENAME(OBJECT_SCHEMA_NAME(object_id)) + '.' + 
  QUOTENAME(OBJECT_NAME(object_id)) + ' REBUILD;' + CHAR(10)
FROM sys.indexes
WHERE index_id > 0 AND OBJECTPROPERTY(object_id, 'IsUserTable') = 1;

EXEC sp_executesql @SQL; -- Убедитесь в наличии необходимых привилегий для выполнения данной операции



--8.	Для запросов, разработанных в лабораторной работе № 3, покажите и проанализируйте планы запросов.
use[Maiseyeu_03]

--9.	Создайте индексы для оптимизации запросов из лабораторной работы № 3.
--10.	Создайте необходимые индексы для базы данных своего варианта.
