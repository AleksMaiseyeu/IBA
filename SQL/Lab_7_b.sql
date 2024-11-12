/*
B-часть 4 задания:
Разработать два скрипта A и B. 
Продемонстрировать 
  неподтвержденное
  неповторяющееся и 
  фантомное чтение. 

Показать усиление уровней изолированности.
*/
use [Maiseyeu_04]

--========7.2=========
--  SELECT TOP(5) * FROM AUDIT ORDER BY ID DESC
BEGIN TRAN
  DELETE FROM AUDIT WHERE ID = 32 

--========7.4=========
--ОТКАТИМ ТРАНЗАКЦИЮ
ROLLBACK TRAN

--========7.6=========
SELECT COUNT(*) FROM AUDIT --24


/*===================7.8=======================*/
BEGIN TRAN
  DELETE FROM AUDIT WHERE ID = 32 

/*===================7.10=======================*/
--откатим Тр-ю
rollback tran;



/*============7-12=============*/
BEGIN TRAN
  DELETE FROM AUDIT WHERE ID = 32 
COMMIT TRAN
--(1 row affected)


/*============ 7**15 =============*/
BEGIN TRAN
  DELETE FROM AUDIT WHERE ID = 36 
COMMIT TRAN
--ожидает...Executing query

--(1 row affected) после подтверженит Тр-и из параллеьной 7**16


/*============ 7**18 =============*/
BEGIN TRAN
  UPDATE AUDIT SET c='REPEATABLE READ LEVEL' WHERE ID = 37 
COMMIT TRAN
--ожидает...Executing query


/*============ 7**21 =============*/
BEGIN TRAN
  INSERT INTO AUDIT(ST,TRN,C) VALUES('INS','TRASACTION','Вставка записи при уровне REPEATABLE READ');
COMMIT TRAN

--(1 row affected)


/*============ 7/24 =============*/
BEGIN TRAN
  INSERT INTO AUDIT(ST,TRN,C) VALUES('INS','TRASACTION','Вставка записи при уровне: serializable');
COMMIT TRAN
--executing query....

