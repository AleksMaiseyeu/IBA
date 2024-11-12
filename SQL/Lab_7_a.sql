-----==================
--Транзакции в T-SQL. Конспект

/*1.	Разработать скрипт, демонстрирующий работу в режиме неявной транзакции.*/
use [Maiseyeu_04]

 declare @state_Tr int = 0;
 SET IMPLICIT_TRANSACTIONS ON  --подтверждение неявных транзакций

 INSERT INTO weather(w) VALUES('Implicit transaction');

 if (@state_Tr=1) commit tran else rollback tran;

 SET IMPLICIT_TRANSACTIONS OFF; -- отключаем подтверждение

select COUNT(*) from OFFICES


/*2.	Разработать скрипт, демонстрирующий свойства ACID явной транзакции. 
В блоке CATCH предусмотреть выдачу соответствующих сообщений об ошибках. */
 
 --SET IMPLICIT_TRANSACTIONS ON | OFF
 /*
 Если установлено значение ON, система находится в неявном режиме транзакции. 
 Это означает, что если @@TRANCOUNT = 0, любая из следующих инструкций Transact-SQL начинает новую транзакцию. 
 Это эквивалентно выполнению невидимой инструкции BEGIN TRANSACTION:
 
 */
 SELECT * FROM weather;
 
 BEGIN TRY
    BEGIN TRANSACTION;
    update weather set w='gfg' where id=3;
    INSERT INTO weather(w) VALUES('STORM6');
	COMMIT TRAN;
  END TRY
  BEGIN CATCH
    print '--------';
    PRINT ERROR_MESSAGE() + ' DUBLICATE RECORDS';
	if @@TRANCOUNT>0 print @@trancount ROLLBACK tran;
  END CATCH

/*3.	Разработать скрипт, демонстрирующий применение оператора SAVETRAN. 
В блоке CATCH предусмотреть выдачу соответствующих сообщений об ошибках.  */

declare @stop_flag varchar(10);
begin try
  BEGIN TRANSACTION;
  update weather set w='Rain' where id = 3;
  set @stop_flag = 'update Rain';
  save tran @stop_flag;
  update weather set w='Fog' where w='storm2';
  set @stop_flag = 'update fog';
  save tran @stop_flag;
  insert into weather values('Sun');
  set @stop_flag = 'insert sun';
  save tran @stop_flag;
  insert into weather values('Fog');
  set @stop_flag = 'insert fog';
  save tran @stop_flag;
  commit tran;
end try
begin catch
 print 'There is an Error';
 IF @@TRANCOUNT>0
   BEGIN
    PRINT 'Стоп на флаге ' + @stop_flag;
	rollback tran @stop_flag;
	commit tran;
   END
end catch


/*4.	Разработать два скрипта A и B. Продемонстрировать 
    *неподтвержденное
	*неповторяющееся 
	*фантомное чтение. 


Показать усиление уровней изолированности. */

use [Maiseyeu_04]

--========7.1=========
--устанавливаем уровень изоляции READ UNCOMMITTED - самый слабый
--ДЕМОНСТРАЦИЯ ОШИБОК ГРЯЗНОЕ ЧТЕНИЕ (неподтвержденное)
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
BEGIN TRAN
  SELECT COUNT(*) FROM AUDIT --24

--========7.3=========
--ПРОВЕРЯЕМ
  SELECT COUNT(*) FROM AUDIT --23

--========7.5=========
SELECT COUNT(*) FROM AUDIT  --24
COMMIT TRAN;


/*==========================================
уровень изоляции READ COMMITTED
ДЕМОНСТРАЦИЯ (НЕ ДОПУСКАЕТ ГРЯЗНОЕ ЧТЕНИЕ)   */

/*===========7.7=============*/
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
BEGIN TRAN
  SELECT COUNT(*) FROM AUDIT --24

/*===========7.9=============*/
--ПРОВЕРЯЕМ
  SELECT COUNT(*) FROM AUDIT --ЖДЕТ....Executing query...

-- как только транзакция в параллельной сессии завершена - сформировался результат 
-- 24 т.к. параллельная транзакция откатилась rollback

COMMIT TRANSACTION;


/*==========================================
уровень изоляции READ COMMITTED
ДЕМОНСТРАЦИЯ (допускат неповторяющееся чтение)              
разрешает  добавление/удаление/изменение записей в парраллельных сессиях  */
/*============7-11=============*/
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
BEGIN TRAN
  SELECT COUNT(*) FROM AUDIT --24

/*============7-13=============*/

  SELECT COUNT(*) FROM AUDIT --23
--ПОВТОРНОЕ ЧТЕНИЕ ДАННЫХ ДАЛО РАЗНЫЙ РЕЗУЛЬТАТ: 24 записи в (7-11) и 23 записи в (7-13)
COMMIT TRANSACTION;


/*==========================================
уровень изоляции REPEATABLE READ  
ДЕМОНСТРАЦИЯ (допускат неповторяющееся чтение)              
разрешает  добавление  но ЗАПРЕЩАЕТ удаление и изменение записей в парраллельных сессиях  */


INSERT INTO AUDIT(ST,TRN,C) VALUES('INS','TRASACTION','INSERT TRANSACTION'); 

/*============ 7**14 =============*/
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ 
BEGIN TRAN
  SELECT COUNT(*) FROM AUDIT ---24

/*============ 7**16 =============*/
commit tran;
/* ВЫВОД:
мы не можем удалить запись при параллальном доступе к записям при уровне изоляции REPEATABLE READ */

INSERT INTO AUDIT(ST,TRN,C) VALUES('INS','TRASACTION','INSERT TRANSACTION');



/* попробуем обновить данные
============ 7**17 =============*/
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ 
BEGIN TRAN
  SELECT COUNT(*) FROM AUDIT ---24

/*============ 7**19 =============*/
  commit tran;
 
SELECT TOP(5) * FROM AUDIT ORDER BY ID DESC
-- 37	INS	TRASACTION	REPEATABLE READ LEVEL 
--обновілісь только после commit
-- ВЫВОД: REPEATABLE READ LEVEL  Изменения делать тоже не позволяет!!!



/* попробуем ВСТАВИТЬ данные
============ 7**20 =============*/
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ 
BEGIN TRAN
  SELECT COUNT(*) FROM AUDIT ---24

/*============ 7**22 =============*/
 SELECT COUNT(*) FROM AUDIT  --25
 SELECT TOP(5) * FROM AUDIT ORDER BY ID DESC

 ---38	INS	TRASACTION	Вставка записи при уровне REPEATABLE READ
 COMMIT TRAN;
/*Вывод: вставку делать на момент открытой параллельной транзакции МОЖНО! */


/*==========================================
уровень изоляции serializable !!! самый высокий !!! */
/*============ 7/23 =============*/
SET TRANSACTION ISOLATION LEVEL serializable 
BEGIN TRAN
  SELECT COUNT(*) FROM AUDIT --25

/*============ 7/25 =============*/
rollback tran;
 
 SELECT COUNT(*) FROM AUDIT --26
/*
  ВЫВОД:
  уровень изоляции serializable при открытой параллельной ТР-И НЕ ПОЗВОЛЯЕТ вставлять данные 
  отданако, как только параллельная транзакция прекращается - доступ восстанаваливается!
  ВНЕ ЗАВИСИМОСТИ ОТ РЕЗУЛЬТАТА ДРУГОЙ ТРАНЗАКЦИИ (COMMIT или ROLLBACK)


*/


/*5.	Разработать скрипт, демонстриsрующий свойства вложенных транзакций.  */
-- ВЛОЖЕННАЯ ТРАНЗАКЦИЯ ВЕДЕТ СЕБЯ КАК ОДНА БОЛЬШАЯ
--Т.Е. ДАЖЕ ЕСЛИ ВНУТРЕННАЯ ТРАНЗАКЦИЯ ЗАКОМИЧЕНА, НО ПРИ ЭТОМ ВНЕШНЯЯ ОТКАТЫВАЕТСЯ,
--ВСЕ ИЗМЕНЕНИЯ И ВО ВНУТРЕННЕЙ НЕ СОХРАНЯЮТСЯ

USE [Maiseyeu_04]

BEGIN TRAN; -- ВНЕШНЯЯ ТР-Я
  INSERT INTO AUDIT(ST,TRN,C) VALUES('INS','TRASACTION','INSERT GLOBAL TRANSACTION'); -- ВНЕШНЯЯ ТР-Я

  BEGIN TRAN --ВНУТРЕННЯ ТР-Я
    UPDATE AUDIT SET C='NEW VALUE IN TRANSACTION' WHERE ID = 6; 
	COMMIT; --ВНУТРЕННЯ ТР-Я 
IF @@TRANCOUNT>0 
  ROLLBACK; -- ВНЕШНЯЯ ТР-Я

--2 ВАРИАНТ
BEGIN TRAN; 
  INSERT INTO AUDIT(ST,TRN,C) VALUES('INS','TRASACTION','INSERT GLOBAL TRANSACTION_2'); 

  BEGIN TRAN --ВНУТРЕННЯ ТР-Я
    INSERT INTO AUDIT(ST,TRN,C) VALUES('UNIT','TRASACTION','INSERT INNER TRANSACTION'); 
	--////ЗАВЕДОМО ОШИБКА Т.К. CHECK ПРОВЕРЯЕТ ТОЛЬКО INS/UPD/DEL
	COMMIT; 
IF @@TRANCOUNT>0 
  COMMIT; -- ВНЕШНЯЯ ТР-Я

  -- ПРОВЕРЯЕМ
  SELECT * FROM AUDIT
  --24	32	INS	TRASACTION	INSERT GLOBAL TRANSACTION
  --25	34	INS	TRASACTION	INSERT GLOBAL TRANSACTION_2
/* ВЫВОД:
  *ЕСЛИ ВНУТРЕННЯЯ ТРАНЗАКЦИЯ ЗАВЕРШЕНА С ОШИБКОЙ (ROLLBACK ВНУТРЕННЕЙ ТР-И), 
  НО ПРИ ЭТОМ ВНЕШНЯЯ ТРАНЗАКЦИЯ УСПЕШНО ОТРАБОТАНА, ТО ИЗМЕНЕНИЯ БУДУТ 
  ВЫПОЛЕННЫ(СОХРАНЕНЫ) ТОЛЬКО ИНСТРУКЦИИ ИЗ ВНЕШНЕЙ ТРАНЗАЦИИ
  
  *ЕСЛИ ВНЕШНАЯЯ ТРАНЗАКЦИЯ ЗАВЕРШЕНА С ОШИБКОЙ ИЛИ ROLLBACK, ТО
  ВНЕ ЗАВИСИМОСТИ ОТ УСПЕШНОСТИ ВНУТРЕННЕЙ ТРАНЗАКЦИИ, ВСЕ ИЗМЕНЕНИЯ БУДУТ ОТКАТАНЫ ДО 
  ПЕРВОНАЧАЛЬНОГО СОСТОЯНИЯ
*/


