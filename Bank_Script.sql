-- -----------------------------------------------------
-- Drop the 'Bank' database/schema
-- -----------------------------------------------------

DROP SCHEMA IF EXISTS Bank;
-- -----------------------------------------------------
-- Create 'Bank' database/schema and use this database
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Create 'Bank' database/schema and use this database
-- -----------------------------------------------------

CREATE SCHEMA IF NOT EXISTS Bank;

USE Bank;

-- -----------------------------------------------------
-- Drop tables
-- -----------------------------------------------------


-- drop table Customer;
-- drop table Branch;
-- drop table Employee;
-- drop table CurrentAccount;
-- drop table SavingAccount;
-- drop table DebitCard;
-- drop table SavingCard;
-- drop table LoanType;
-- drop table Loan;
-- drop table LoanRepayment;
-- drop table Transaction;
-- drop table Manager;
-- drop table Serves;

-- ------------------------------------------------------- -----------------------------------------------------
-- Create table Customer
-- -----------------------------------------------------

CREATE TABLE Customer (
custID varchar(20) not null,
custFname varchar(15) not null,
custLname varchar(15) not null,
dob date,
gender char(1),
phoneNo varchar(20),
city varchar(20),
PRIMARY KEY (custID)
);

-- ------------------------------------------------------- -----------------------------------------------------
-- Create table Branch
-- -----------------------------------------------------

CREATE TABLE Branch (
branchNo varchar(15) not null,
branchName varchar(20) not null,
city varchar(20) not null,
street varchar(20),
eirCode varchar(20) not null,
PRIMARY KEY (branchNo)
);

-- ------------------------------------------------------- -----------------------------------------------------
-- Create table Serves
-- -----------------------------------------------------

CREATE TABLE Serves(
custID varchar(20) not null,
branchNo varchar(15) not null,
PRIMARY KEY (custID,branchNo),
constraint fk_services foreign key(branchNo) references Branch(branchNo) 
on update cascade on delete no action,
foreign key(custID) references Customer(custID) 
on update cascade on delete no action
);

-- ------------------------------------------------------- -----------------------------------------------------
-- Create table Employee
-- -----------------------------------------------------

CREATE TABLE Employee(
empID varchar(20) not null,
empFname varchar(15) not null,
empLname varchar(15) not null,
phoneNo varchar(20),
hireDate date,
title varchar(20),
salary decimal(10,2),
branchNo varchar(15) not null,
PRIMARY KEY (empID),
constraint fk_branch foreign key(branchNO) references Branch(branchNO) 
on update cascade 
on delete no action
);


-- ------------------------------------------------------- -----------------------------------------------------
-- Create table Manager
-- -----------------------------------------------------

CREATE TABLE Manager(
empID varchar(20) not null,
bonus varchar (11),
empFname varchar(15) not null,
empLname varchar(15) not null,
phoneNo varchar(20),
hireDate date,
salary decimal(10,2) not null,
branchNo varchar(15) not null,
PRIMARY KEY (empID),
constraint fk_br foreign key(branchNO) references Branch(branchNO) 
on update cascade 
on delete no action
);

-- ------------------------------------------------------- -----------------------------------------------------
-- Create table CurrentAccount
-- -----------------------------------------------------

CREATE TABLE CurrentAccount(
accID varchar(25) not null,
openDate date,
curBalance decimal(20,2) not null,
accFees decimal(5,2),
transferLimit decimal(10,2),
custID varchar(20) not null,
PRIMARY KEY (accID),
constraint fk_customer foreign key(custID) references Customer(custID) 
on update cascade 
on delete no action
);

-- ------------------------------------------------------- -----------------------------------------------------
-- Create table CurrentAccount
-- -----------------------------------------------------

CREATE TABLE SavingAccount(
accID varchar(25) not null,
openDate date,
curBalance decimal(20,2) not null,
accFees decimal(5,2),
interestEarned decimal(12,2),
custID varchar(20) not null,
PRIMARY KEY (accID),
constraint fk_customers foreign key(custID) references Customer(custID) 
on update cascade 
on delete no action
);

-- ------------------------------------------------------- -----------------------------------------------------
-- Create table DebitCard
-- -----------------------------------------------------

CREATE TABLE DebitCard(
cardNo varchar(20) not null,
withdrawalLimit decimal(7,2),
expDate date,
status varchar(12) not null, 
accID varchar(25) not null,
PRIMARY KEY (cardNo),
constraint fk_accs foreign key(accID) references CurrentAccount(accID) 
on update cascade on delete cascade
);

-- ------------------------------------------------------- -----------------------------------------------------
-- Create table SavingCard
-- -----------------------------------------------------

CREATE TABLE SavingCard(
cardNo varchar(20) not null,
noTransLimit int(5),
expDate date,
status varchar(12) not null, 
accID varchar(25) not null,
PRIMARY KEY (cardNo),
constraint fk_accsa foreign key(accID) references SavingAccount(accID) 
on update cascade on delete cascade
);
-- ------------------------------------------------------- -----------------------------------------------------
-- Create table LoanType
-- -----------------------------------------------------

CREATE TABLE LoanType(
loanTypeID varchar(30) not null,
loanName varchar(30) not null,
loanTypeLimit varchar(20) not null,
PRIMARY KEY (loanTypeID)
);

-- ------------------------------------------------------- -----------------------------------------------------
-- Create table Loan
-- -----------------------------------------------------

CREATE TABLE Loan(
loanNo varchar(20) not null,
startDate date not null,
dueDate date not null,
interestRate decimal(5,5) not null,
loanAmount decimal(15,2) not null,
accID varchar(25) not null,
loanTypeID varchar(30) not null,
PRIMARY KEY (loanNo),
constraint fk_accounts foreign key(accID) references CurrentAccount(accID) 
on update cascade on delete no action,
foreign key(loanTypeID) references LoanType(loanTypeID) 
on update cascade on delete no action
);

-- ------------------------------------------------------- -----------------------------------------------------
-- Create table LoanRepayment
-- -----------------------------------------------------

CREATE TABLE LoanRepayment(
loanRepNO varchar (30),
amount decimal(15,2),
date date,
loanNo varchar(20) not null,
PRIMARY KEY (loanRepNO),
constraint fk_loan foreign key(loanNo) references Loan(loanNo) 
on update cascade on delete no action
);

-- ------------------------------------------------------------------------------------------------------------
-- Create table curTrans
-- -----------------------------------------------------

CREATE TABLE curTrans(
transID varchar(30),
amount decimal(12,2),
description varchar(20),
date date,
freeTrans char(1),
accID varchar(25) not null,
PRIMARY KEY (transID),
constraint fk_ctrans foreign key(accID) references CurrentAccount(accID) 
on update cascade on delete no action
);
   
 -- ------------------------------------------------------------------------------------------------------------
-- Create table savTrans
-- -----------------------------------------------------
  
CREATE TABLE savTrans(
transID varchar(30),
amount decimal(12,2),
description varchar(20),
date date,
emergency char(1),
accID varchar(25) not null,
PRIMARY KEY (transID),
constraint fk_strans foreign key(accID) references SavingAccount(accID) 
on update cascade on delete no action
);
-- -----------------------------------------------------
-- Populate table Customer
-- -----------------------------------------------------

INSERT INTO Customer (custID, custFname, custLname, dob, gender, phoneNo, city)
VALUES
('0006787213', 'John', 'Lee', '1982-11-25', 'M', '085-1047-433', 'Waterford'),
('0007895324', 'Mia', 'Johnston', '2002-01-22', 'F', '083-3334-546', 'Waterford'),
('0008916435', 'Mohamed', 'Youssef', '1990-03-19', 'M', '081-2342-447', 'Kilkenny'),
('0009127546', 'Abdullah', 'Zeeshan', '1967-12-23', 'M', '085-1145-089', 'Wexford'),
('0001238657', 'Rachael', 'Oliver', '1980-09-21', 'F', '089-8573-883', 'Kilkenny'),
('0002349768', 'Michael', 'Kent', '1984-12-01', 'M', '086-9674-396', 'kilkenny'),
('0003451879', 'Karenann', 'Coady', '1985-06-08', 'F', '085-3351-209', 'Waterford'),
('0004562981', 'Marta', 'Makovic', '1980-12-11', 'F', '083-1111-232', 'Waterford'),
('0005673192', 'Simon', 'Harrington', '1998-01-30', 'M', '055-4803-443', 'Wexford'),
('0006784213', 'Deirdre', 'Collins', '1979-02-11', 'F', '089-4653-009', 'Waterford'),
('0007895325', 'Sarah', 'Johns', '2004-06-22', 'F', '088-9048-009', 'KILKENNY'),
('0008916432', 'Lily', 'August', '2005-05-30', 'F', '082-4565-905', 'Waterford'),
('0009127541', 'Ted', 'Hobkinks', '1960-12-09', 'M', '089-0036-071', 'Wexford'),
('0001238650', 'Jordan', 'MacAllister', '1972-02-01', 'M', '085-0945-432', 'Waterford'),
('0002349762', 'Adam', 'Coofey', '1999-11-09-', 'M', '081-2345-432', 'Kilkenny')
;

-- -----------------------------------------------------
-- Populate table Branch
-- -----------------------------------------------------

INSERT INTO Branch (branchNo, branchName, city, street, eirCode)
VALUES
('000022', 'THE Quay', 'Waterford', 'Quay street', 'X91 NX66'),
('000023', 'Tent park', 'Kilkenny', 'Park street', 'X93 XN11'),
('000024', 'Spring market', 'Wexford', 'Market street', 'X90 XZ44')
;

-- -----------------------------------------------------
-- Populate table Serves
-- -----------------------------------------------------

INSERT INTO Serves (custID, branchNo)
VALUES
('0006787213', '000022'),
('0007895324', '000022'),
('0008916435', '000023'),
('0009127546', '000024'),
('0001238657', '000023'),
('0002349768', '000023'),
('0003451879', '000022'),
('0004562981', '000022'),
('0005673192', '000024'),
('0006784213', '000024'),
('0007895325', '000023'),
('0008916432', '000022'),
('0009127541', '000024'),
('0001238650', '000022'),
('0002349762', '000023'),
('0006787213', '000023'),
('0007895324', '000024'),
('0005673192', '000023'),
('0009127541', '000022'),
('0005673192', '000022')
;

-- -----------------------------------------------------
-- Populate table Employee
-- -----------------------------------------------------

INSERT INTO Employee (empID, empFname, empLname, title, salary, hireDate, phoneNo, branchNo)
VALUES
('0012984', 'Jason', 'Jacobs', 'Accountant', 2500, '2018-03-26', '089-6654-970', '000022'),
('0012985', 'Gerrard', 'Shaw', 'Accountant', 2800, '2015-02-23', '087-5543-091', '000022'),
('0012986', 'Fiona', 'Harris', 'Debt Analyst', 3200, '2022-10-30', '081-2134-9587', '000022'),
('0022940', 'Silvia', 'Gutto', 'Cleaner', 1200, '2011-12-12', '088-0999-936', '000022'),
('0022941', 'Mumabe', 'Ibeto', 'Security', 1350, '2016-10-11', '089-5543-097', '000022'),
('0012987', 'Duane', 'Nedved', 'Accountant', 2350, '2022-10-10', '082-9234-009', '000023'),
('0012988', 'Bukayo', 'Adebayo', 'Accountant', 2800, '2016-09-07', '089-9971-237', '000023'),
('0012989', 'Hugh', 'Fernandeez', 'Debt Analyst', 3500, '2020-05-22', '088-0796-664', '000023'),
('0022942', 'Michael', 'Liberman', 'Security', 1250, '2020-11-12', '088-3321-234', '000023'),
('0022943', 'Lucy', 'Richard', 'Cleaner', 950, '2023-12-12', '082-1192-335', '000023'),
('0012990', 'Joe', 'Organ', 'Accountant', 2650, '2020-11-12', '081-2212-334', '000024'),
('0012991', 'Daniel', 'Foley', 'Debt Analyst', 3300, '2021-12-05', '080-3098-331', '000024'),
('0022944', 'Tanya', 'Richard', 'Cleaner', 1100, '2022-12-12', '084-1192-335', '000024'),
('0022945', 'Dooley', 'Swissman', 'Security', 1300, '2020-01-12', '080-3321-264', '000024'),
('0012992', 'Jacob', 'Orly', 'Customer Service', 1900, '2021-11-05', '085-0098-331', '000022'),
('0012993', 'Lewis', 'Salt', 'Customer Service', 1870, '2022-12-05', '081-9898-331', '000023'),
('0012994', 'Maria', 'Zakarova', 'Customer Service', 1990, '2020-10-06', '082-4198-331', '000024')
;

-- -----------------------------------------------------
-- Populate table Manager
-- -----------------------------------------------------

INSERT INTO Manager (empID, bonus, empFname, empLname, salary, hireDate, phoneNo , branchNo)
VALUES
('0012030', '20000', 'Alen', 'Duane', 8500, '2010-03-22', '087-999-0099', '000022'),
('0012031', '12000', 'Patrick', 'Organ', 7200, '2014-10-10', '088-112-2221', '000023'),
('0012032', '6000', 'Aoife', 'Dowd', 6500, '2016-10-10', '089-1231-992', '000024')
;

-- -----------------------------------------------------
-- Populate table CurrentAccount
-- -----------------------------------------------------

INSERT INTO CurrentAccount(accID, openDate, curBalance, accFees, transferLimit, custID)
VALUES
('ABB92 1006 114048', '2008-12-11', 32577, 20, 10000, '0006787213'),
('ABB92 1006 114049', '2015-11-10', 2594, 20, 10000, '0006787213'),
('ABB92 1006 114050', '2019-09-06', 1809, 5, 1000, '0007895324'),
('ABB92 1006 114051', '2022-08-02', 159.33, 20, 10000, '0008916435'),
('ABB92 1006 114052', '2014-12-22', 40658.43, 50, 100000, '0009127546'),
('ABB92 1006 114053', '2011-01-22', 12034.44, 50, 100000, '0001238657'),
('ABB92 1006 114054', '2023-04-12', 657.34, 20, 10000, '0002349768'),
('ABB92 1006 114055', '2011-02-05', 2227.14, 20, 10000, '0003451879'),
('ABB92 1006 114056', '2017-12-09', 143.02, 20, 10000, '0004562981'),
('ABB92 1006 114057', '2019-12-09', 2834.90, 20, 10000, '0005673192'),
('ABB92 1006 114058', '2006-12-09', 120.11, 20, 10000, '0006784213'),
('ABB92 1006 114059', '2022-11-11', 1768.64, 20, 10000, '0004562981')
;

-- -----------------------------------------------------
-- Populate table SavingAccount
-- -----------------------------------------------------

INSERT INTO SavingAccount (accID, openDate, curBalance, accFees, interestEarned, custID)
VALUES
('ABS22 1006 114020', '2022-12-04', 15200, 25, 2600, '0007895325'),
('ABS22 1006 114021', '2011-12-04', 240000, 25, 45288, '0008916432'),
('ABS22 1006 114022', '2021-12-04', 6000, 25, 820, '0001238650'),
('ABS22 1006 114023', '2024-10-04', 3000, 25, 220, '0009127541'),
('ABS22 1006 114024', '2018-10-04', 57000, 25, 13400, '0002349762'),
('ABS22 1006 114025', '2020-10-07', 16000, 25, 2480, '0007895324'),
('ABS22 1006 114026', '2022-10-07', 12000, 25, 1700, '0009127546'),
('ABS22 1006 114027', '2023-11-22', 10000, 25, 1100, '0002349768'),
('ABS22 1006 114028', '2013-10-07', 120000, 25, 24660, '0003451879')
;

-- -----------------------------------------------------
-- Populate table DebitCard
-- -----------------------------------------------------

INSERT INTO DebitCard (cardNo, withdrawalLimit, expDate, status, accID)
VALUES
('123342567865', 1000, '2028-10-01', 'Active', 'ABB92 1006 114048'),
('123342567866', 1000, '2029-10-01', 'Active', 'ABB92 1006 114049'),
('123342567867', 1000, '2028-07-01', 'Active', 'ABB92 1006 114050'),
('123342567868', 1000, '2029-08-01', 'Active', 'ABB92 1006 114051'),
('123342567869', 1000, '2025-02-01', 'Blocked', 'ABB92 1006 114052'),
('123342567870', 1000, '2028-01-01', 'Active', 'ABB92 1006 114053'),
('123342567871', 1000, '2024-12-31', 'Active', 'ABB92 1006 114054'),
('123342567872', 1000, '2026-10-31', 'Active', 'ABB92 1006 114055'),
('123342567820', 1000, '2025-12-31', 'Active', 'ABB92 1006 114056'),
('123342567873', 1000, '2027-12-31', 'Active', 'ABB92 1006 114057'),
('123342567874', 1000, '2028-12-31', 'Blocked', 'ABB92 1006 114058'),
('123342567875', 1000, '2026-10-31', 'Active', 'ABB92 1006 114059')
;

-- -----------------------------------------------------
-- Populate table SavingCard
-- -----------------------------------------------------

INSERT INTO SavingCard (cardNo, noTransLimit, expDate, status, accID)
VALUES
('123342567876', 6, '2025-12-31', 'Active', 'ABS22 1006 114020'),
('123342567877', 4, '2029-7-31', 'Active', 'ABS22 1006 114021'),
('123342567878', 6, '2026-11-30', 'Active', 'ABS22 1006 114022'),
('123342567879', 6, '2027-12-01', 'Active', 'ABS22 1006 114023'),
('123342567880', 4, '2024-12-31', 'Active', 'ABS22 1006 114024'),
('123342567881', 4, '2028-01-01', 'Active', 'ABS22 1006 114025'),
('123342567882', 6, '2027-06-30', 'Active', 'ABS22 1006 114026'),
('123342567883', 6, '2029-08-01', 'Active', 'ABS22 1006 114027'),
('123342567884', 6, '2027-06-30', 'Active', 'ABS22 1006 114028')
;

-- -----------------------------------------------------
-- Populate table LoanType
-- -----------------------------------------------------

INSERT INTO LoanType (loanTypeID, loanName, loanTypeLimit)
VALUES
('11015', 'PersonalLoan', '1000000'),
('11016', 'BusinessLoan', '20000000'),
('11017', 'StudentLoan', '20000')
;

-- -----------------------------------------------------
-- Populate table Loan
-- -----------------------------------------------------

INSERT INTO Loan (loanNo, startDate, dueDate, interestRate, loanAmount, accID, loanTypeID)
VALUES
('PL000000247', '2020-06-01', '2025-05-31', 0.045, 20000, 'ABB92 1006 114048', '11015'),
('BL000000016', '2017-06-01', '2027-05-31', 0.0375, 2000000, 'ABB92 1006 114052', '11016'),
('BL000000017', '2022-01-01', '2028-05-31', 0.035, 100000, 'ABB92 1006 114053', '11016'),
('PL000000248', '2021-04-01', '2025-03-31', 0.045, 10000, 'ABB92 1006 114057', '11015'),
('SL000000004', '2021-08-01', '2025-06-30', 0.045, 12000, 'ABB92 1006 114050', '11017')
;

-- -----------------------------------------------------
-- Populate table LoanRepayment
-- -----------------------------------------------------

INSERT INTO LoanRepayment (loanRepNO, amount, date, loanNo)
VALUES
('100067012', 10500, '2022-06-30', 'BL000000017'),
('100067013', 3000, '2022-12-31', 'SL000000004'),
('100067016', 250000, '2020-06-30', 'BL000000016'),
('100067017', 3500, '2021-05-31', 'PL000000247'),
('100067018', 2000, '2022-06-30', 'PL000000248')
;

-- -----------------------------------------------------
-- Populate table curTrans
-- -----------------------------------------------------

INSERT INTO curTrans (transID, amount, description, date, freeTrans, accID)
VALUES
('3000045565', 120, 'between accounts out', '2022-12-11', 'Y', 'ABB92 1006 114050'),
('3000045566', 27.23, 'out', '2024-10-11', 'N', 'ABB92 1006 114049'),
('3000045567', 150, 'in', '2023-12-11', 'N', 'ABB92 1006 114048'),
('3000045568', 690, 'in', '2024-06-10', 'N', 'ABB92 1006 114059'),
('3000045569', 16.67, 'out', '2023-11-11', 'N', 'ABB92 1006 114051'),
('3000045570', 15000, 'out', '2016-12-11', 'N', 'ABB92 1006 114053'),
('3000045571', 209.33, 'out', '2022-12-11', 'N', 'ABB92 1006 114049'),
('3000045572', 114.28, 'in', '2024-01-11', 'N', 'ABB92 1006 114054'),
('3000045573', 120.90, 'out', '2024-12-11', 'N', 'ABB92 1006 114055'),
('3000045574', 374.09, 'in', '2024-12-10', 'N', 'ABB92 1006 114056'),
('3000045575', 1097.12, 'in', '2020-12-11', 'N', 'ABB92 1006 114057'),
('3000045576', 612.50, 'out', '2018-01-12', 'N', 'ABB92 1006 114055'),
('3000045577', 6750, 'between accounts out', '2022-12-11', 'N', 'ABB92 1006 114055'),
('3000045578', 374.09, 'out', '2024-10-10', 'N', 'ABB92 1006 114056'),
('3000045579', 120, 'out', '2024-04-11', 'N', 'ABB92 1006 114054'),
('3000045580', 620, 'in', '2020-12-11', 'N', 'ABB92 1006 114057'),
('3000045581', 127.23, 'in', '2024-10-15', 'N', 'ABB92 1006 114049'),
('3000045582', 160, 'in', '2023-10-11', 'N', 'ABB92 1006 114048'),
('3000045583', 650, 'out', '2024-07-10', 'N', 'ABB92 1006 114059'),
('3000045584', 26.65, 'out', '2023-11-16', 'N', 'ABB92 1006 114051'),
('3000045585', 9000, 'in', '2016-12-31', 'N', 'ABB92 1006 114053'),
('3000045586', 50.33, 'out', '2022-12-21', 'N', 'ABB92 1006 114049'),
('3000045587', 159, 'in', '2024-01-17', 'N', 'ABB92 1006 114054'),
('3000045588', 160.90, 'out', '2024-12-12', 'N', 'ABB92 1006 114055'),
('3000045589', 120.87, 'in', '2024-12-22', 'N', 'ABB92 1006 114056'),
('3000045590', 569.09, 'out', '2020-12-26', 'N', 'ABB92 1006 114057')
;


-- -----------------------------------------------------
-- Populate table savTrans
-- -----------------------------------------------------

INSERT INTO savTrans (transID, amount, description, date, emergency, accID)
VALUES
('S4000045580', 150, 'in', '2023-12-04', 'N', 'ABS22 1006 114020'),
('S4000045581', 2000, 'between accounts in', '2019-09-06', 'N', 'ABS22 1006 114021'),
('S4000045582', 1450, 'in', '2023-11-05', 'N', 'ABS22 1006 114022'),
('S4000045583', 1000, 'out', '2024-11-11', 'Y', 'ABS22 1006 114023'),
('S4000045584', 20000, 'in', '2021-12-09', 'N', 'ABS22 1006 114024'),
('S4000045585', 850, 'in', '2022-03-04', 'N', 'ABS22 1006 114025'),
('S4000045586', 1200, 'in', '2023-10-01', 'N', 'ABS22 1006 114026'),
('S4000045587', 300, 'in', '2023-12-01', 'N', 'ABS22 1006 114027'),
('S4000045588', 15000, 'between accounts in', '2022-12-11', 'N', 'ABS22 1006 114028')
; 


