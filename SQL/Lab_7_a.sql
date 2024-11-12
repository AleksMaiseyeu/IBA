-----==================
--Транзакции в T-SQL. Конспект

/*1.	Разработать скрипт, демонстрирующий работу в режиме неявной транзакции.*/

use [Maiseyeu_04]
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


/*4.	Разработать два скрипта A и B. Продемонстрировать неподтвержденное, неповторяющееся и фантомное чтение. 
Показать усиление уровней изолированности. */





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


