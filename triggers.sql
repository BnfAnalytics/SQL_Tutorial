/* *****************Story of Triggers in SQL****************        

    *******About myself…***********
1. Triggers are database objects that are designed to automatically execute a set of SQL statements or code when a specific event occurs within the database. 
2. These events can include actions like inserting, updating, or deleting rows in a table. 
3. Triggers are used to enforce business rules, maintain data integrity, and automate certain database tasks.
   
   
    ******Components of Triggers*******
1. Event: This defines the database action that triggers the execution of the trigger. 
          The events can be categorized into three main types:
        a. BEFORE: Triggered before the specified event occurs 
           (e.g., before an INSERT, UPDATE, or DELETE operation).
        b. AFTER: Triggered after the specified event occurs.
        c. INSTEAD OF: This type of trigger is used for views, allowing you to replace the default action with a custom action.
2. Action: This is the set of SQL statements or code that will be executed when the trigger is fired due to the specified event.
	
 */

#1
/* BEFORE Insert Trigger on Employee Table:
This trigger sets a default age of 18 for new employees if no age is specified during insertion.*/
DELIMITER //
CREATE TRIGGER before_insert_employee1
BEFORE INSERT ON employee
FOR EACH ROW
BEGIN
    IF NEW.age IS NULL THEN
        SET NEW.age = 18;
    END IF;
END;
//
DELIMITER ;



INSERT into employee values
(1200,'shivraj','sharma',NULL,'Male');
SELECT* FROM employee;
/* TRIGGER CHECK: You can insert a new employee without specifying the age to see if the trigger sets the default age to 18.*/


/* After Insert Trigger on Employee Table:
This trigger logs the insertion of a new employee in an audit table.*/
DELIMITER //
CREATE TRIGGER after_insert_employee
AFTER INSERT ON employee
FOR EACH ROW
BEGIN
    INSERT INTO employee_audit (empID, action, action_time)
    VALUES (NEW.employeeID, 'INSERT', NOW());
END;
//
DELIMITER ;


CREATE TABLE employee_audit
(EmpID int,
 action varchar(50) ,
 action_time datetime
 );
select*from employee_audit;
INSERT into employee values
(1201,'shivraj1','sharma1',20,'Male');
/* TRIGGER CHECK: Insert a new employee into the employee table and then check the employee_audit table to see if an entry has been added.*/




/* Before Update Trigger on Employee Salary Table:
This trigger ensures that the job title cannot be updated to 'Manager' for employees under the age of 30.   */
DELIMITER //
CREATE TRIGGER before_update_salary
BEFORE UPDATE ON empsalary
FOR EACH ROW
BEGIN
    IF NEW.jobtitle = 'Manager' AND (SELECT age 
                                     FROM employee 
									 WHERE employeeID = NEW.employeeID) < 30 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Only employees over 30 can have Manager title';
    END IF;
END;
//
DELIMITER ;
SELECT* from employee;
select* from empsalary;
/* TRIGGER CHECK: Update the job title of an employee in the employeesalary table to 'Manager' and observe whether the trigger prevents it when the employee's age is under 30.*/

UPDATE empsalary
SET jobtitle='Manager'
WHERE employeeID=1003 ;




/*After Update Trigger on Employee Salary Table:
This trigger logs salary updates in a separate audit table. */
DELIMITER //
CREATE TRIGGER after_update_salary
AFTER UPDATE ON empsalary
FOR EACH ROW
BEGIN
    INSERT INTO salary_changes (empID, old_salary, new_salary, change_time)
    VALUES (NEW.employeeID, OLD.salary, NEW.salary, NOW());
END;
//
DELIMITER ;
/* TRIGGER CHECK: Update the salary of an employee in the employeesalary table and then check the salary_changes table to see if a new entry has been added.*/

CREATE TABLE salary_changes
(EmpID int,
 old_salary int ,
 new_salary int,
 change_time datetime
 );
UPDATE empsalary
SET salary= 48000
WHERE employeeID=1001 ;

select* from salary_changes;

/* Before Delete Trigger on Employee Table:
This trigger prevents deletion of employees under the age of 25. */
DELIMITER //
CREATE TRIGGER before_delete_employee
BEFORE DELETE ON employee
FOR EACH ROW
BEGIN
    IF OLD.age < 25 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot delete employees under 25';
    END IF;
END;
//
DELIMITER ;
/* TRIGGER CHECK: Attempt to delete an employee with an age under 25, and observe whether the trigger prevents the deletion.*/






/* After Delete Trigger on Employee Table:
This trigger logs employee deletions in an audit table. */
 DELIMITER //
CREATE TRIGGER after_delete_employee
AFTER DELETE ON employee
FOR EACH ROW
BEGIN
    INSERT INTO employee_audit (empID, action, action_time)
    VALUES (OLD.empID, 'DELETE', NOW());
END;
//
DELIMITER ;
/* TRIGGER CHECK: Delete an employee from the employee table and then check the employee_audit table to see if a deletion entry has been added.*/