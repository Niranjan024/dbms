CREATE TABLE locations (
    location_id   NUMBER PRIMARY KEY,
    city          VARCHAR2(50)
);

CREATE TABLE departments (
    department_id   NUMBER PRIMARY KEY,
    department_name VARCHAR2(50),
    location_id     NUMBER,
    CONSTRAINT fk_loc FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

CREATE TABLE job_grades (
    grade_level VARCHAR2(2),
    lowest_sal  NUMBER,
    highest_sal NUMBER
);
drop table employees;

CREATE TABLE employees (
    employee_id    NUMBER PRIMARY KEY,
    last_name      VARCHAR2(50),
    job_id         VARCHAR2(20),
    salary         NUMBER,
    commission_pct NUMBER,
    manager_id     NUMBER,
    department_id  NUMBER,
    hire_date      DATE,
    CONSTRAINT fk_dept FOREIGN KEY (department_id) REFERENCES departments(department_id),
    CONSTRAINT fk_mgr FOREIGN KEY (manager_id) REFERENCES employees(employee_id)
);

INSERT INTO locations VALUES (1000, 'Toronto');
INSERT INTO locations VALUES (1100, 'New York');
INSERT INTO locations VALUES (1200, 'London');

INSERT INTO departments VALUES (10, 'Administration', 1100);
INSERT INTO departments VALUES (20, 'Finance', 1200);
INSERT INTO departments VALUES (80, 'Sales', 1000);
INSERT INTO job_grades VALUES ('A', 0, 5000);
INSERT INTO job_grades VALUES ('B', 5001, 10000);
INSERT INTO job_grades VALUES ('C', 10001, 20000);

INSERT INTO employees VALUES (101, 'King', 'AD_PRES', 24000, NULL, NULL, 10, DATE '2003-06-17');
INSERT INTO employees VALUES (102, 'Davies', 'FI_MGR', 9000, NULL, 101, 20, DATE '2005-01-01');
INSERT INTO employees VALUES (103, 'Smith', 'SA_REP', 6000, 0.2, 102, 80, DATE '2006-03-15');
INSERT INTO employees VALUES (104, 'Taylor', 'SA_REP', 4500, NULL, 102, 80, DATE '2007-07-20');
INSERT INTO employees VALUES (105, 'Allen', 'FI_ACCOUNT', 4000, NULL, 102, 20, DATE '2008-09-10');

COMMIT;


SELECT e.last_name, e.department_id, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id;


SELECT DISTINCT e.job_id, l.city, l.location_id
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id
WHERE e.department_id = 80;

-- 3. Employees with commission
SELECT e.last_name, d.department_name, l.location_id, l.city
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id
WHERE e.commission_pct IS NOT NULL;

-- 4. Employees with 'a' in last name
SELECT e.last_name, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE LOWER(e.last_name) LIKE '%a%';

-- 5. Employees in Toronto
SELECT e.last_name, e.job_id, e.department_id, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id
WHERE l.city = 'Toronto';

-- 6. Employees with managers
SELECT e.last_name AS Employee, e.employee_id AS Emp#,
       m.last_name AS Manager, m.employee_id AS Mgr#
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.employee_id;

-- 7. Include King (no manager), order by Emp#
SELECT e.last_name AS Employee, e.employee_id AS Emp#,
       NVL(m.last_name, 'No Manager') AS Manager,
       NVL(TO_CHAR(m.employee_id), '---') AS Mgr#
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.employee_id
ORDER BY e.employee_id;

-- 8. Employees with same department
SELECT e.last_name AS Employee, e.department_id AS Dept#, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
ORDER BY e.department_id;

-- 9. Employee salary grade
SELECT e.last_name, e.job_id, d.department_name, e.salary, j.grade_level
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN job_grades j ON e.salary BETWEEN j.lowest_sal AND j.highest_sal;

-- 10. Employees hired after Davies
SELECT e.last_name, e.hire_date
FROM employees e
WHERE e.hire_date > (SELECT hire_date FROM employees WHERE last_name = 'Davies');

-- 11. Employees hired before their managers
SELECT e.last_name AS Employee, e.hire_date AS "Emp Hired",
       m.last_name AS Manager, m.hire_date AS "Mgr Hired"
FROM employees e
JOIN employees m ON e.manager_id = m.employee_id
WHERE e.hire_date < m.hire_date;
