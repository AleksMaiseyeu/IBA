-----==================
--���������� � T-SQL. ��������

/*1.	����������� ������, ��������������� ������ � ������ ������� ����������.*/
use [Maiseyeu_04]

 declare @state_Tr int = 0;
 SET IMPLICIT_TRANSACTIONS ON  --������������� ������� ����������

 INSERT INTO weather(w) VALUES('Implicit transaction');

 if (@state_Tr=1) commit tran else rollback tran;

 SET IMPLICIT_TRANSACTIONS OFF; -- ��������� �������������

select COUNT(*) from OFFICES


/*2.	����������� ������, ��������������� �������� ACID ����� ����������. 
� ����� CATCH ������������� ������ ��������������� ��������� �� �������. */
 
 --SET IMPLICIT_TRANSACTIONS ON | OFF
 /*
 ���� ����������� �������� ON, ������� ��������� � ������� ������ ����������. 
 ��� ��������, ��� ���� @@TRANCOUNT = 0, ����� �� ��������� ���������� Transact-SQL �������� ����� ����������. 
 ��� ������������ ���������� ��������� ���������� BEGIN TRANSACTION:
 
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

/*3.	����������� ������, ��������������� ���������� ��������� SAVETRAN. 
� ����� CATCH ������������� ������ ��������������� ��������� �� �������.  */

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
    PRINT '���� �� ����� ' + @stop_flag;
	rollback tran @stop_flag;
	commit tran;
   END
end catch


/*4.	����������� ��� ������� A � B. ������������������ 
    *����������������
	*��������������� 
	*��������� ������. 


�������� �������� ������� ���������������. */

use [Maiseyeu_04]

--========7.1=========
--������������� ������� �������� READ UNCOMMITTED - ����� ������
--������������ ������ ������� ������ (����������������)
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
BEGIN TRAN
  SELECT COUNT(*) FROM AUDIT --24

--========7.3=========
--���������
  SELECT COUNT(*) FROM AUDIT --23

--========7.5=========
SELECT COUNT(*) FROM AUDIT  --24
COMMIT TRAN;


/*==========================================
������� �������� READ COMMITTED
������������ (�� ��������� ������� ������)   */

/*===========7.7=============*/
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
BEGIN TRAN
  SELECT COUNT(*) FROM AUDIT --24

/*===========7.9=============*/
--���������
  SELECT COUNT(*) FROM AUDIT --����....Executing query...

-- ��� ������ ���������� � ������������ ������ ��������� - ������������� ��������� 
-- 24 �.�. ������������ ���������� ���������� rollback

COMMIT TRANSACTION;


/*==========================================
������� �������� READ COMMITTED
������������ (�������� ��������������� ������)              
���������  ����������/��������/��������� ������� � ������������� �������  */
/*============7-11=============*/
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
BEGIN TRAN
  SELECT COUNT(*) FROM AUDIT --24

/*============7-13=============*/

  SELECT COUNT(*) FROM AUDIT --23
--��������� ������ ������ ���� ������ ���������: 24 ������ � (7-11) � 23 ������ � (7-13)
COMMIT TRANSACTION;


/*==========================================
������� �������� REPEATABLE READ  
������������ (�������� ��������������� ������)              
���������  ����������  �� ��������� �������� � ��������� ������� � ������������� �������  */


INSERT INTO AUDIT(ST,TRN,C) VALUES('INS','TRASACTION','INSERT TRANSACTION'); 

/*============ 7**14 =============*/
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ 
BEGIN TRAN
  SELECT COUNT(*) FROM AUDIT ---24

/*============ 7**16 =============*/
commit tran;
/* �����:
�� �� ����� ������� ������ ��� ������������ ������� � ������� ��� ������ �������� REPEATABLE READ */

INSERT INTO AUDIT(ST,TRN,C) VALUES('INS','TRASACTION','INSERT TRANSACTION');



/* ��������� �������� ������
============ 7**17 =============*/
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ 
BEGIN TRAN
  SELECT COUNT(*) FROM AUDIT ---24

/*============ 7**19 =============*/
  commit tran;
 
SELECT TOP(5) * FROM AUDIT ORDER BY ID DESC
-- 37	INS	TRASACTION	REPEATABLE READ LEVEL 
--�������� ������ ����� commit
-- �����: REPEATABLE READ LEVEL  ��������� ������ ���� �� ���������!!!



/* ��������� �������� ������
============ 7**20 =============*/
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ 
BEGIN TRAN
  SELECT COUNT(*) FROM AUDIT ---24

/*============ 7**22 =============*/
 SELECT COUNT(*) FROM AUDIT  --25
 SELECT TOP(5) * FROM AUDIT ORDER BY ID DESC

 ---38	INS	TRASACTION	������� ������ ��� ������ REPEATABLE READ
 COMMIT TRAN;
/*�����: ������� ������ �� ������ �������� ������������ ���������� �����! */


/*==========================================
������� �������� serializable !!! ����� ������� !!! */
/*============ 7/23 =============*/
SET TRANSACTION ISOLATION LEVEL serializable 
BEGIN TRAN
  SELECT COUNT(*) FROM AUDIT --25

/*============ 7/25 =============*/
rollback tran;
 
 SELECT COUNT(*) FROM AUDIT --26
/*
  �����:
  ������� �������� serializable ��� �������� ������������ ��-� �� ��������� ��������� ������ 
  ��������, ��� ������ ������������ ���������� ������������ - ������ ������������������!
  ��� ����������� �� ���������� ������ ���������� (COMMIT ��� ROLLBACK)


*/


/*5.	����������� ������, ���������s������ �������� ��������� ����������.  */
-- ��������� ���������� ����� ���� ��� ���� �������
--�.�. ���� ���� ���������� ���������� ����������, �� ��� ���� ������� ������������,
--��� ��������� � �� ���������� �� �����������

USE [Maiseyeu_04]

BEGIN TRAN; -- ������� ��-�
  INSERT INTO AUDIT(ST,TRN,C) VALUES('INS','TRASACTION','INSERT GLOBAL TRANSACTION'); -- ������� ��-�

  BEGIN TRAN --��������� ��-�
    UPDATE AUDIT SET C='NEW VALUE IN TRANSACTION' WHERE ID = 6; 
	COMMIT; --��������� ��-� 
IF @@TRANCOUNT>0 
  ROLLBACK; -- ������� ��-�

--2 �������
BEGIN TRAN; 
  INSERT INTO AUDIT(ST,TRN,C) VALUES('INS','TRASACTION','INSERT GLOBAL TRANSACTION_2'); 

  BEGIN TRAN --��������� ��-�
    INSERT INTO AUDIT(ST,TRN,C) VALUES('UNIT','TRASACTION','INSERT INNER TRANSACTION'); 
	--////�������� ������ �.�. CHECK ��������� ������ INS/UPD/DEL
	COMMIT; 
IF @@TRANCOUNT>0 
  COMMIT; -- ������� ��-�

  -- ���������
  SELECT * FROM AUDIT
  --24	32	INS	TRASACTION	INSERT GLOBAL TRANSACTION
  --25	34	INS	TRASACTION	INSERT GLOBAL TRANSACTION_2
/* �����:
  *���� ���������� ���������� ��������� � ������� (ROLLBACK ���������� ��-�), 
  �� ��� ���� ������� ���������� ������� ����������, �� ��������� ����� 
  ���������(���������) ������ ���������� �� ������� ���������
  
  *���� �������� ���������� ��������� � ������� ��� ROLLBACK, ��
  ��� ����������� �� ���������� ���������� ����������, ��� ��������� ����� �������� �� 
  ��������������� ���������
*/


