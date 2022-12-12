--a.     ���������� ������� �� ������ ����� ������� �������� �� ���� �������, � ������� ������ ������� ���������� � ����� ������� ���������.
select firstname
from employees
order by salary desc
limit 1

--b.     ���������� ������� ������� ����������� � ���������� �������
select firstname
from employees
order by firstname

--c.     ����������� ������� ���� ��� ������� ������ �����������
select l.name, avg(age(datebeginwork)) as middle_experience 
from employees e 
	inner join levels l on l.id = e.levelid
group by l.name

--d.     �������� ������� ���������� � �������� ������, � ������� �� ��������
select e.firstname, t.name as department_name 
from employees e 
	inner join departments t on t.id = e.departmentid
	
--e.     �������� �������� ������ � ������� ���������� � ����� ������� ��������� � ������ ������ � ���� �������� �����.
select e.firstname, d.name as department_name, dep_max_salary.salary_max
from employees e 
	inner join (select max(e.salary) as salary_max, e.departmentid 
		from employees e 
		group by e.departmentid) as dep_max_salary on dep_max_salary.departmentid = e.departmentid
														and dep_max_salary.salary_max = e.salary
	inner join departments d on d.id = e.departmentid

--f.      *�������� �������� ������, ���������� �������� ������� ���������� ������ �� ������ ����. 
--��� ���������� ������ ����� ������ � ��������� ������� ���������� �������� ������
select d.name as department_name, sum(e.salary*(e.year_bonus-1)) as bonus
from employees e
	inner join departments d on d.id = e.departmentid
group by d.name
order by bonus desc
limit 1

--g.    *��������������� �������� ����������� � ������ ������������ ������. 
--��� ����������� � ������������� ������ ������ 1.2 � ������ ���������� �������� 20%,
--��� ����������� � ������������� ������ �� 1 �� 1.2 ������ ���������� �������� 10%. 
--��� ���� ��������� ����������� ���������� �� �������������.
ALTER TABLE employees ADD COLUMN index_salary decimal;

update employees
	set index_salary = case when year_bonus > 1.2 then salary*1.2
						when year_bonus >= 1 and year_bonus <= 1.2 then salary*1.1
						else salary
					end;

--h.    ***�� ������ ���������� ����� �������� ����� �������� ��������� �����: 
--��� ���������� �� ������� ������� ������ ������� ��������� ����������:
--    i.     �������� ������
--    ii.     ������� ������������
--    iii.     ���������� �����������
--    iv.     ������� ����
--    v.     ������� ������� ��������
--    vi.     ���������� ����������� ������ junior
--    vii.     ���������� ����������� ������ middle
--    viii.     ���������� ����������� ������ senior
--    ix.     ���������� ����������� ������ lead
--    x.     ����� ������ ������ ����� ���� ����������� �� ����������
--    xi.     ����� ������ ������ ����� ���� ����������� ����� ����������
--    xii.     ����� ���������� ������ �
--    xiii.     ����� ���������� ������ B
--    xiv.     ����� ���������� ������ C
--    xv.     ����� ���������� ������ D
--    xvi.     ����� ���������� ������ �
--    xvii.     ������� ���������� ������������ ������
--    xviii.     ����� ������ ������.
--    xix.     ����� ����� �������(+ ������) �� ����������
--    xx.     ����� ����� �������(+ ������) ����� ����������(������ �� �������������)
--    xxi.     ������� � % ����� ����������� ����� �������(������/������)
select d.name as department, d.fiomanager, d.countemployees, 
	avg(age(e.datebeginwork)) as avg_experience, 
	avg(e.index_salary) as avg_salary, 
	sum(case when l.name = 'jun' then 1 else 0 end) as count_jun,
	sum(case when l.name = 'middle' then 1 else 0 end) as count_middle,
	sum(case when l.name = 'senior' then 1 else 0 end) as count_senior,
	sum(case when l.name = 'lead' then 1 else 0 end) as count_lead,
	sum(e.salary) as salary_until_index,
	sum(e.index_salary) as index_salary,
	sum(em.count_A) as count_A,
	sum(em.count_B) as count_B,
	sum(em.count_C) as count_C,
	sum(em.count_D) as count_D,
	sum(em.count_E) as count_E,
	avg(e.year_bonus) as avg_year_bonus,
	sum(e.year_bonus*salary) as sum_year_bonus,
	sum(e.year_bonus*salary + salary) as sum_salary_and_bonus,
	sum(e.year_bonus*salary + index_salary) as sum_index_salary_and_bonus,
	sum(e.year_bonus*salary + index_salary) - sum(e.year_bonus*salary + salary) as diff
from departments d
	inner join employees e on e.departmentid = d.id
	inner join levels l on l.id = e.levelid
	inner join (select em.employeeid, 
					sum(case when m.mark = 'A' then 1 else 0 end) as count_A,
					sum(case when m.mark = 'B' then 1 else 0 end) as count_B,
					sum(case when m.mark = 'C' then 1 else 0 end) as count_C,
					sum(case when m.mark = 'D' then 1 else 0 end) as count_D,
					sum(case when m.mark = 'E' then 1 else 0 end) as count_E
				from employee_marks em 
					inner join marks m on m.id = em.markid
					inner join periods p on p.id = em.periodid
				where date_part('year', p.datebegin) = 2022
				group by em.employeeid) as em on em.employeeid = e.id
group by d.name, d.fiomanager, d.countemployees