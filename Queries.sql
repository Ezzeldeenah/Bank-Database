-- -----------------------------------------------------
-- Frequently used queries the Bank database users
-- -----------------------------------------------------

USE Bank;

SHOW TABLES;


-- -----------------------------------------------------------------------------------
-- Branches the customers served by, and if a customer served by more than one branch
-- -----------------------------------------------------------------------------------

SELECT c.custID as 'Customer ID', CONCAT(custFname, ' ',custLname) AS 'Customer Name', c.city AS 'City', branchname AS 'Branch Name', b.city AS 'Branch City'
FROM customer c
JOIN serves s
ON c.custID = s.custID
JOIN branch b
ON s.branchNO = b.branchNO
ORDER BY CONCAT(custFname, ' ',custLname);

-- -----------------------------------------------------------------------------------
-- Average amount of interest paid out by each branch
-- -----------------------------------------------------------------------------------

SELECT b.city, ROUND(AVG(interestearned),2) AS 'Average interest amount paid'
FROM savingaccount a
JOIN customer c
ON a.custID = c.custID
JOIN serves s
ON c.custID  = s.custID
JOIN branch b
ON s.branchNO = b.branchNO
GROUP BY b.city;


-- ----------------------------------------------------------------------
-- Updating the interest rate of a student loan from .045 to .025
-- ----------------------------------------------------------------------

UPDATE loan
SET interestRate = .025
WHERE loanNO = 'PL000000248';


-- ------------------------------------------------------------------------------
-- The amount of interst payable by customer with account number ABB92 1006 114052
-- ------------------------------------------------------------------------------

SELECT ROUND((interestRate * loanAmount), 2)
FROM loan
WHERE accID = 'ABB92 1006 114052'
;


-- ----------------------------------------------------------------------
-- Total current accounts balances held by each customer
-- ----------------------------------------------------------------------

SELECT CONCAT(custFname, ' ',custLname) AS 'Customer Name', sum(curBalance) AS 'Total Current Account/s Balances'
FROM customer c 
JOIN currentAccount a
ON c.custID = a.custID
GROUP BY CONCAT(custFname, ' ',custLname)
ORDER BY sum(curBalance) DESC;

-- -------------------------------------------------------------
-- Subquery to find employees who earn more than 2000 
-- -------------------------------------------------------------

SELECT CONCAT(empFname, ' ',empLname) AS 'Employee Name', salary
FROM Employee
where empID IN 
            (SELECT empID
            FROM Employee
            WHERE salary > '2000');

-- ------------------------------------------------------------------------------
-- Subquery to retieve IDs and names of employees who work at kilkenny branch
-- ------------------------------------------------------------------------------

SELECT empID, CONCAT(empFname, ' ',empLname) AS 'Employee Name'
FROM employee
WHERE branchNO =
      (SELECT branchNO
      FROM branch
      WHERE city = 'Kilkenny');
      
-- -------------------------------------------------------------
-- Creating view for outstanding loan amounts of customers 
-- -------------------------------------------------------------

CREATE VIEW LoanOutstandingBalances
AS SELECT c.custID as 'Customer ID', CONCAT(custFname, ' ',custLname) AS 'Customer Name', loanAmount - r.amount as 'Oustanding Balance', city AS 'City'
FROM customer c
JOIN currentaccount a
on c.custID = a.custID
JOIN loan l
on a.accID = l.accID
JOIN loanrepayment r
on l.loanNO = r.loanNO
;

SELECT* FROM LoanOutstandingBalances;

-- -------------------------------------------------------------
-- Creating an index for customer ID 
-- -------------------------------------------------------------

create index custID_ind on customer(custID);

SHOW INDEX FROM
customer;

-- ------------------------------------------------------------------------
-- Creating a trigger for salaray raise and the table associated with it 
-- ------------------------------------------------------------------------

CREATE TABLE emp_salary_before_update(
updateID INT(11) NOT NULL AUTO_INCREMENT,
empID varchar(20) not null,
salary decimal(10,2) not null,
PRIMARY KEY(updateID)
);

DELIMITER $$
CREATE TRIGGER before_salary_update
      BEFORE UPDATE ON employee
      FOR EACH ROW
BEGIN
      INSERT INTO emp_salary_before_update (empID, salary)
      VALUES(
      old.empID,
      old.salary
      );
END $$
DELIMITER ;


UPDATE employee
SET salary = 1950
WHERE empID = '0012993';

select* from employee;

SELECT* FROM emp_salary_before_update;

show triggers;


-- ------------------------------------------------------------------------
-- Delete an employee who is no longer work for the bank
-- ------------------------------------------------------------------------

DELETE FROM Employee
WHERE empID = '0012994';






