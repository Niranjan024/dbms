CREATE TABLE MY_EMPLOYEE (
  ID NUMBER(4) NOT NULL,
  Last_name VARCHAR2(25),
  First_name VARCHAR2(25),
  Userid VARCHAR2(25),
  Salary NUMBER(9,2)
);

INSERT INTO MY_EMPLOYEE  VALUES(1, 'Patel', 'Ralph', 'rpatel', 895);
INSERT INTO MY_EMPLOYEE VALUES(2, 'Dancs', 'Betty', 'bdancs', 860);

select * from  MY_EMPLOYEE;
