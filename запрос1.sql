--���������� ����� ����������, ��� ��� � ���� ������ � ��� ���� ����������� ��������
select id, firstname || ' ' || secondname || ' ' || patronymic  as fio, age(current_date, datebeginwork) as experience
from employees

--���������� ����� ����������, ��� ��� � ���� ������ � ������ ������ 3-� �����������
select id, firstname || ' ' || secondname || ' ' || patronymic  as fio, age(current_date, datebeginwork) as experience
from employees
order by datebeginwork
limit 3

--���������� ����� ����������� - ���������
select id
from employees
where driverlicense = true

--�������� ������ �����������, ������� ���� �� �� 1 ������� �������� ������ D ��� E
select distinct e.id
from employees e 
	inner join employee_marks em on e.id = em.employeeid
where em.markid in (4,5)

--�������� ����� ������� �������� � ��������.
select salary
from employees
order by salary desc
limit 1

--  * �������� �������� ������ �������� ������
select name
from departments
order by countemployees desc
limit 1

--  * �������� ������ ����������� �� ����� ������� �� ����� ���������
select id, firstname || ' ' || secondname || ' ' || patronymic  as fio, age(current_date, datebeginwork) as experience
from employees
order by datebeginwork

--  * ����������� ������� �������� ��� ������� ������ �����������
select l.name, avg(salary) as middle_salary
from employees e 
	inner join levels l on l.id = e.levelid
group by l.name

--  * �������� ������� � ����������� � ������������ ������� ������ � �������� �������. ����������� �������������� �� ����� �����: ������� �������� ������������ � 1, ������ ������ ��������� �� ����������� ���:
--       � � ����� 20%
--       D � ����� 10%
--       � � ��� ���������
--       B � ���� 10%
--       A � ���� 20%
--��������������, ��������� � �������� �, �, �, D � ������ �������� ����������� 1.2.
ALTER TABLE employees ADD COLUMN year_bonus decimal;

update employees
	set year_bonus = sum_rate
from (select e.id, sum(rate)+1 as sum_rate
	from employees e 
		inner join employee_marks em on em.employeeid = e.id
		inner join marks m on m.id = em.markid
		inner join periods p on p.id = em.periodid
	where date_part('year', p.datebegin) = 2022
	group by e.id
	)  e_s
where employees.id = e_s.id

select * from employees