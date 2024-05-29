
CREATE TABLE employee (
  emp_id INT PRIMARY KEY,
  first_name VARCHAR(40),
  last_name VARCHAR(40),
  birth_day DATE,
  sex VARCHAR(1),
  salary INT,
  super_id INT,
  branch_id INT
);

CREATE TABLE branch (
  branch_id INT PRIMARY KEY,
  branch_name VARCHAR(40),
  mgr_id INT,
  mgr_start_date DATE,
  FOREIGN KEY(mgr_id) REFERENCES employee(emp_id) ON DELETE SET NULL
);

ALTER TABLE employee
ADD FOREIGN KEY(branch_id)
REFERENCES branch(branch_id)
ON DELETE SET NULL;

ALTER TABLE employee
ADD FOREIGN KEY(super_id)
REFERENCES employee(emp_id)
ON DELETE SET NULL;

CREATE TABLE client (
  client_id INT PRIMARY KEY,
  client_name VARCHAR(40),
  branch_id INT,
  FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL
);

CREATE TABLE works_with (
  emp_id INT,
  client_id INT,
  total_sales INT,
  PRIMARY KEY(emp_id, client_id),
  FOREIGN KEY(emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE,
  FOREIGN KEY(client_id) REFERENCES client(client_id) ON DELETE CASCADE
);

CREATE TABLE branch_supplier (
  branch_id INT,
  supplier_name VARCHAR(40),
  supply_type VARCHAR(40),
  PRIMARY KEY(branch_id, supplier_name),
  FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE CASCADE
);


-- -----------------------------------------------------------------------------

-- Corporate
INSERT INTO employee VALUES(100, 'David', 'Wallace', '1967-11-17', 'M', 250000, NULL, NULL);

INSERT INTO branch VALUES(1, 'Corporate', 100, '2006-02-09');

UPDATE employee
SET branch_id = 1
WHERE emp_id = 100;

INSERT INTO employee VALUES(101, 'Jan', 'Levinson', '1961-05-11', 'F', 110000, 100, 1);

-- Scranton
INSERT INTO employee VALUES(102, 'Michael', 'Scott', '1964-03-15', 'M', 75000, 100, NULL);

INSERT INTO branch VALUES(2, 'Scranton', 102, '1992-04-06');

UPDATE employee
SET branch_id = 2
WHERE emp_id = 102;

INSERT INTO employee VALUES(103, 'Angela', 'Martin', '1971-06-25', 'F', 63000, 102, 2);
INSERT INTO employee VALUES(104, 'Kelly', 'Kapoor', '1980-02-05', 'F', 55000, 102, 2);
INSERT INTO employee VALUES(105, 'Stanley', 'Hudson', '1958-02-19', 'M', 69000, 102, 2);

-- Stamford
INSERT INTO employee VALUES(106, 'Josh', 'Porter', '1969-09-05', 'M', 78000, 100, NULL);

INSERT INTO branch VALUES(3, 'Stamford', 106, '1998-02-13');

UPDATE employee
SET branch_id = 3
WHERE emp_id = 106;

INSERT INTO employee VALUES(107, 'Andy', 'Bernard', '1973-07-22', 'M', 65000, 106, 3);
INSERT INTO employee VALUES(108, 'Jim', 'Halpert', '1978-10-01', 'M', 71000, 106, 3);


-- BRANCH SUPPLIER
INSERT INTO branch_supplier VALUES(2, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Patriot Paper', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'J.T. Forms & Labels', 'Custom Forms');
INSERT INTO branch_supplier VALUES(3, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(3, 'Stamford Lables', 'Custom Forms');

-- CLIENT
INSERT INTO client VALUES(400, 'Dunmore Highschool', 2);
INSERT INTO client VALUES(401, 'Lackawana Country', 2);
INSERT INTO client VALUES(402, 'FedEx', 3);
INSERT INTO client VALUES(403, 'John Daly Law, LLC', 3);
INSERT INTO client VALUES(404, 'Scranton Whitepages', 2);
INSERT INTO client VALUES(405, 'Times Newspaper', 3);
INSERT INTO client VALUES(406, 'FedEx', 2);

-- WORKS_WITH
INSERT INTO works_with VALUES(105, 400, 55000);
INSERT INTO works_with VALUES(102, 401, 267000);
INSERT INTO works_with VALUES(108, 402, 22500);
INSERT INTO works_with VALUES(107, 403, 5000);
INSERT INTO works_with VALUES(108, 403, 12000);
INSERT INTO works_with VALUES(105, 404, 33000);
INSERT INTO works_with VALUES(107, 405, 26000);
INSERT INTO works_with VALUES(102, 406, 15000);
INSERT INTO works_with VALUES(105, 406, 130000);

select * from employee;
drop table employee;

select * from branch;
drop table branch;

select * from client;
drop table client;

select * from works_with;
drop table works_with;

select * from branch_supplier;
drop table branch_supplier;
/* __________________________________________________________________________________________________ */

/* Some basic queries */
  /* Find all clients.
     Find all employees ordered by salary
     Find all employees ordered by sex then name 
     Find the first 5 employees in the table
     Find the forenames and surnames of all the employees
     Find out all the different genders
     Find the number of employees
     Find the number of female employees born after 1970 
     Find the average of all employee's salaries 
     Find the average of all employee's salaries who all are male
     Find the sum of all employee's salaries
     Find out how many males and how many females are there 
     Find the total sales of each sales man
     How much money each client actually spent with the branch? */
  
select client_name from client;
select * from employee Order by salary desc;
select * from employee order by sex, first_name, last_name;
select * from employee limit 5;
select first_name as forname, last_name as surname from employee;
select distinct(sex) from employee;
select count(emp_id) from employee;
select count(emp_id) from employee where sex = 'F' and birth_day > '1971-01-01';
select avg(salary) from employee;
select avg(salary) from employee where sex = 'M';
select sum(salary) from employee;
select count(sex), sex from employee group by sex;
select sum(total_sales), emp_id from works_with group by emp_id;
select sum(total_sales), client_id from works_with group by client_id;

---- WILDCARD----
  /*  Wildcards are basically a way of defining different patterns that we want to match the specific pieces of data to. 
         So this would be a way to kind of like grab data that matches a specific pattern. */
   -- % = any # characters,    _ = one character.
   -- LIKE is a special SQL keyword which we are going to use with wildcards. 
 
  /* Find any client's who are an LLC 
     Find any branch suppliers who are in the label business
     Find any employee born in October. 
     Find any clients who are schools. */
     
select * from client where client_name like  '% LLC';
select * from branch_supplier where supplier_name like '% labels%';
select * from employee where birth_day like '____-10%';
select * from client where client_name like '%school%';

-- Union --
    -- Union is basically a special SQL operator which we can use to combine the results of multiple select statements into one. 
	-- REMEMBER: First rule -  Number of column names mentioned in each table should be same. Otherwise, it will be getting an error.  
	--           Second rule - the field names mentioned in the union tables should be the same data type.
	--                         If they were different data types, there might be a chance that it may be worked well.   
     
          /* Find the list of employee and the branch name
             Find the list of all the clients and the branch supplier's names.
             Find the list of all money spent or earned by the company */

select first_name from employee  union  select branch_name from branch;
select client_name from client union  select supplier_name from branch_supplier;
select total_sales from works_with union select salary from employee;

-- Joins --
    -- Rows from one table combined to Rows from another table using JOINS. 
    -- Inner Join is otherwise known as 'General Join'.
    -- Unfortunately we can’t do FULL OUTER JOIN in MySQL.
    
/* important : Find all branches and the names of their managers */

select employee.emp_id, employee.first_name, branch.branch_name
from employee
join branch
on employee.emp_id = branch.mgr_id;

-- Nested Queries / SubQueries

/* Find names of all employees who have sold over 30,000 to a single client
   Find all clients who are handled by the branch that Michael Scott manages. Assume you know his mgr_id.*/

select emp_id, first_name from employee 
where (select sum(total_sales) > 30000 , client_id from works_with group by client_id);

/* Find all clients who are handled by the branch that Michael Scott manages. Assume you know his mgr_id.*/
select client_name from client
where branch_id = (select branch_id from branch where mgr_id  = 102);

--  ON DELETE 
     /* a) On Delete Set Null
           b) On Delete Cascade. 
          If a table ‘B’ has a FOREIGN KEY that is linked referred to an another table’s ‘A’s Primary key – when we delete one of the line item under the FOREIGN KEY field in table ‘A’ – that would definitely affected the table ‘B’s FOREIGN KEY field. 

Example: If we delete Michael Scott in the ‘Employee’ table , we delete the Employee with id 102, The manager id is supposed to be linking us to an actual row in the Employee table. But if we delete Michael Scott, then all of a sudden 102, that doesn’t mean anything. Right? Because Michael Scott is gone. His employee ID is no longer inside of our employee table. 
We can do two things here to handle this situation. First thing is called ‘On delete set null’ -  And ‘on delete set null’ is basically where if we delete one of these employees in the employee table, that means that the manager ID in the branch table that was associated to that employee is going to get set NULL. (foreign key)
On Delete Cascade – is essentially where if we delete the employee (from ‘Employee’ table) whose ID is stored in the ‘Manager Id’ (foreign key) column, then we are going to delete the entire row (under the ‘Branch’ table) in the database. 
*/

Delete from Employee where emp_id = 102;
select * from branch;

delete from branch where branch_id = 2;
select * from branch_supplier;

-- TRIGGERS: 
      /* A Trigger is basically a block of SQL code which we can write which will define a certain action that should happen when a certain operation  gets performed on a Database. */
      
create table trigger_test (message varchar(100));

-- Example : 1
DELIMITER $$
create 
    trigger my_trigger before insert
    on employee
    for each row begin
        insert into trigger_test values ('Added New Employee');
	 end $$
 DELIMITER ;
 
 INSERT INTO employee values (109, 'Oscar', 'Martinez', '1968-02-19','M', 69000, 106, 3);
 select * from trigger_test;
 
 -- Example : 2
 DELIMITER $$
   CREATE 
      TRIGGER my_trigger1 BEFORE INSERT 
      ON employee
      FOR EACH ROW BEGIN
           INSERT INTO trigger_test VALUES(NEW.FIRST_NAME);
   END$$
DELIMITER ;

INSERT INTO employee VALUES (110, 'Malvin', 'Malone', '1978-02-19', 'M', 60000, 107, 3);
select * from trigger_test;
 
 -- CONDITIONAL TRIGGER 
 DELIMITER $$
CREATE 
     TRIGGER my_trigger3 BEFORE INSERT 
     ON employee
     FOR EACH ROW BEGIN
     IF NEW.sex = 'M' THEN
        INSERT INTO trigger_Test Values ('Added Male Employee');
        ELSEIF NEW.sex = 'F' THEN
        INSERT INTO trigger_test Values ('Added Female Employee');
        ELSE 
        INSERT INTO trigger_test Values ('Added Other Employee');
        END IF;
END $$
DELIMITER ;
INSERT INTO employee VALUES (111, 'Pam', 'Beesly', '1988-02-19', 'F', 69000, 106, 3);
select * from trigger_test;

-- You can also drop trigger . You should write this in 'MySQL 8.0 client command line’
DROP TRIGGER my_trigger








  
  
