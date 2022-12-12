CREATE TABLE Departments
(
    Id SERIAL PRIMARY KEY,
    Name varchar(30),
    FIOManager varchar(90),
	CountEmployees integer
);
CREATE TABLE Posts
(
    Id SERIAL PRIMARY KEY,
    Name varchar(30)
);
CREATE TABLE Levels
(
    Id SERIAL PRIMARY KEY,
    Name varchar(30)
);
CREATE TABLE Periods
(
    Id SERIAL PRIMARY KEY,
    Name varchar(30),
	DateBegin date,
	DateEnd date
);
CREATE TABLE Employees
(
    Id SERIAL PRIMARY KEY,
    FirstName varchar(30),
    Surname varchar(30),
	Patronymic varchar(30),
    DateBirthday date,
	DateBeginWork date,
    PostId integer REFERENCES Posts (Id),
	LevelId integer REFERENCES Levels (Id),
	Salary decimal,
	DepartmentId integer REFERENCES Departments (Id),
	DriverLicense Boolean
);
create TABLE marks
(
    id SERIAL PRIMARY KEY,
    Mark varchar(1),
	rate float
);
CREATE TABLE employee_marks
(
    EmployeeId integer REFERENCES Employees (Id),
    PeriodId integer REFERENCES Periods (Id),
    MarkId integer REFERENCES marks (Id),
	PRIMARY KEY (EmployeeId, PertiodId)
);
