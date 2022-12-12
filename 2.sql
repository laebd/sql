insert into levels(name)
select 'jun'
union
select 'middle'
union
select 'senior'
union
select 'lead';

select * from levels;

insert into posts(name)
select 'начальник отдела'
union 
select 'программист';

select * from posts;

insert into periods(name, datebegin, dateend)
select '1 квартал 2022', make_date(2022, 1, 1), make_date(2022, 3, 31)
union
select '2 квартал 2022', make_date(2022, 4, 1), make_date(2022, 6, 30)
union
select '3 квартал 2022', make_date(2022, 7, 1), make_date(2022, 9, 30)
union
select '4 квартал 2022', make_date(2022, 10, 1), make_date(2022, 12, 31);

select * from periods;

insert into departments(name, fiomanager, countemployees)
select 'отдел программирования', 'Лапина А.Е.', 3
union 
select 'отдел сопровождения', 'Ринчинова О.Ц.', 2;

select * from departments

insert into employees(firstname, surname, patronymic, datebirthday, datebeginwork, postid, levelid, salary, departmentid, driverlicense)
--7
select 'Цыренов', 'Ц', 'В', make_date(2000, 1, 1),  make_date(2020, 1, 1), 1, 3, 200, 1, True
union
--1
select 'Иванов', 'В', 'В', make_date(2000, 10, 8),  make_date(2021, 10, 1), 2, 3, 180, 1, False
union
--2
select 'Сидоров', 'А', 'К', make_date(1999, 1, 1),  make_date(2022, 8, 8), 2, 2, 120, 1, True
union
--5
select 'Немчинова', 'В', 'А', make_date(2001, 6, 1),  make_date(2022, 1, 1), 2, 1, 90, 1, False
union
--4
select 'Ринчинова', 'О', 'Ц', make_date(2000, 1, 1),  make_date(2020, 1, 1), 1, 3, 200, 2, True
union
--3
select 'Павлов', 'О', 'О', make_date(2001, 3, 4),  make_date(2022, 5, 1), 2, 3, 170, 2, True
union
--6
select 'Емельянов', 'Г', 'А', make_date(2002, 4, 1),  make_date(2021, 4, 1), 2, 2, 100, 2, True;

select * from employees

insert into marks(mark, rate)
select 'A' as name, 0.2 as rate
union 
select 'B', 0.1
union 
select 'C', 0.0
union 
select 'D', -0.1
union 
select 'E', -0.2
order by name

select * from marks

insert into employee_marks (employeeid, PeriodId, markid)
select 1, 1, 1
union
select 1, 2, 2
union
select 1, 3, 3
union
select 2, 1, 1
union
select 2, 2, 1
union
select 2, 3, 1
union
select 3, 1, 2
union
select 3, 2, 4
union
select 3, 3, 3
union
select 4, 1, 5
union
select 4, 2, 3
union
select 4, 3, 2
union
select 5, 1, 1
union
select 5, 2, 1
union
select 5, 3, 1
union
select 6, 1, 1
union
select 6, 2, 2
union
select 6, 3, 2
union
select 7, 1, 2
union
select 7, 2, 2
union
select 7, 3, 4

select * from employee_marks