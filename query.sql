create table employee (empid int primary key, firstname varchar(30), lastname varchar(30));
insert into employee values (101, 'Steven', 'Strange'),
(102, 'Tony', 'Strak'),
(103, 'Thor', 'Asgaurd'),
(104, 'Steven', 'Strange'),
(105, 'Natasha', 'Ramanoff'),
(106, 'Hulk', 'Banner'),
(107, 'Robin', 'Sabashky'),
(108, 'Jake', 'Paralto'),
(109, 'Satwik', 'Das'),
(110, 'satin', 'parol'),
(111, 'joey', 'tribbaiani'),
(112, 'moica', 'gellar'),
(113, 'pheebe', 'buffe');
CREATE TABLE manager (mid INT ,empid INT, FOREIGN KEY (empid) REFERENCES employee(empid) ON DELETE CASCADE,FOREIGN KEY (mid) REFERENCES employee(empid) ON DELETE CASCADE);
insert into manager values(101,  102),
(101,110),
(101,107),
(101,108),
(105,106),
(105,109),
(105,103),
(105,111),
(105,112);


1)
SELECT e.firstname AS manager,emp.firstname AS employee FROM manager m JOIN employee e ON m.mid = e.empid JOIN employee emp ON m.empid = emp.empid ORDER BY m.mid;


2)
SELECT COUNT(emp.empid) AS employee_count FROM manager m JOIN employee manager_emp ON m.mid = manager_emp.empid JOIN employee emp ON m.empid = emp.empid WHERE manager_emp.firstname 'Steven';


3)
SELECT m.mid AS manager_id, manager.firstname AS manager_firstname,manager.lastname AS manager_lastname, COUNT(emp.empid) AS employee_count FROM manager m JOIN  employee manager ON m.mid = manager.empid LEFT JOIN  employee emp ON m.empid = emp.empid GROUP BY  m.mid, manager.firstname, manager.lastname;


4)
SELECT e.empid, e.firstname, e.lastname FROM employee e left JOIN manager m ON e.empid = m.empid WHERE m.empid IS NULL;

5)
DELIMITER $$
CREATE FUNCTION get_full_name(emp_id INT)
RETURNS VARCHAR(60) DETERMINISTIC
BEGIN
DECLARE full_name VARCHAR(60);
SELECT CONCAT(firstname, ' ', lastname) INTO full_name
FROM employee
WHERE empid = emp_id;
RETURN full_name;
END $$
DELIMITER ;

SELECT get_full_name(101) AS employee_full_name;  