--Уникальный номер сотрудника, его ФИО и стаж работы – для всех сотрудников компании
select id, firstname || ' ' || secondname || ' ' || patronymic  as fio, age(current_date, datebeginwork) as experience
from employees

--Уникальный номер сотрудника, его ФИО и стаж работы – только первых 3-х сотрудников
select id, firstname || ' ' || secondname || ' ' || patronymic  as fio, age(current_date, datebeginwork) as experience
from employees
order by datebeginwork
limit 3

--Уникальный номер сотрудников - водителей
select id
from employees
where driverlicense = true

--Выведите номера сотрудников, которые хотя бы за 1 квартал получили оценку D или E
select distinct e.id
from employees e 
	inner join employee_marks em on e.id = em.employeeid
where em.markid in (4,5)

--Выведите самую высокую зарплату в компании.
select salary
from employees
order by salary desc
limit 1

--  * Выведите название самого крупного отдела
select name
from departments
order by countemployees desc
limit 1

--  * Выведите номера сотрудников от самых опытных до вновь прибывших
select id, firstname || ' ' || secondname || ' ' || patronymic  as fio, age(current_date, datebeginwork) as experience
from employees
order by datebeginwork

--  * Рассчитайте среднюю зарплату для каждого уровня сотрудников
select l.name, avg(salary) as middle_salary
from employees e 
	inner join levels l on l.id = e.levelid
group by l.name

--  * Добавьте столбец с информацией о коэффициенте годовой премии к основной таблице. Коэффициент рассчитывается по такой схеме: базовое значение коэффициента – 1, каждая оценка действует на коэффициент так:
--       Е – минус 20%
--       D – минус 10%
--       С – без изменений
--       B – плюс 10%
--       A – плюс 20%
--Соответственно, сотрудник с оценками А, В, С, D – должен получить коэффициент 1.2.
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