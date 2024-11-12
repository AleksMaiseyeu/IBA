/*
B-����� 4 �������:
����������� ��� ������� A � B. 
������������������ 
  ����������������
  ��������������� � 
  ��������� ������. 

�������� �������� ������� ���������������.
*/
use [Maiseyeu_04]

--========7.2=========
--  SELECT TOP(5) * FROM AUDIT ORDER BY ID DESC
BEGIN TRAN
  DELETE FROM AUDIT WHERE ID = 32 

--========7.4=========
--������� ����������
ROLLBACK TRAN

--========7.6=========
SELECT COUNT(*) FROM AUDIT --24


/*===================7.8=======================*/
BEGIN TRAN
  DELETE FROM AUDIT WHERE ID = 32 

/*===================7.10=======================*/
--������� ��-�
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
--�������...Executing query

--(1 row affected) ����� ������������ ��-� �� ����������� 7**16


/*============ 7**18 =============*/
BEGIN TRAN
  UPDATE AUDIT SET c='REPEATABLE READ LEVEL' WHERE ID = 37 
COMMIT TRAN
--�������...Executing query


/*============ 7**21 =============*/
BEGIN TRAN
  INSERT INTO AUDIT(ST,TRN,C) VALUES('INS','TRASACTION','������� ������ ��� ������ REPEATABLE READ');
COMMIT TRAN

--(1 row affected)


/*============ 7/24 =============*/
BEGIN TRAN
  INSERT INTO AUDIT(ST,TRN,C) VALUES('INS','TRASACTION','������� ������ ��� ������: serializable');
COMMIT TRAN
--executing query....

