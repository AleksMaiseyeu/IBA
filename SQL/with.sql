-- рекурсивная конструкция общетабличные выражения
with cte_exp as
(select getdate() as p1, 1 as p2
union all
select p1 + 1, p2 + 1 from cte_exp where p2 <= 29)
select * from cte_exp;

select * from SALESREPS
-- 101 --> 104 --> 106 --> null

select s1.name, s2.NAME
from SALESREPS s1 join SALESREPS s2
on s1.MANAGER = s2.EMPL_NUM


-- 122 --> 102 --> 108 --> 106 --> 106 --> null

with cte_hierarchy (empl_num, name, MANAGER)
as (select empl_num, name, MANAGER from salesreps where empl_num = 122
union all
select s3.empl_num, s3.name, s3.manager
from cte_hierarchy s2 join salesreps s3
on s2.manager = s3.empl_num)
select * from cte_hierarchy;