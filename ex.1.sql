create table DEPT(
    ID number(7),NAME Varchar2(25)
);
select table_name from user_tables where table_name='DEPT';
desc DEPT;

create table EMP(ID number(7),LAST_NAME varchar2(25),FIRST_NAME VARCHAR2(25),DEPT_ID NUMBER(7));
select table_name from user_tables where table_name='EMP';
desc EMP;

ALTER TABLE EMP MODIFY LAST_NAME VARCHAR2(50);

create table Employees2(
    Id NUMBER(6) NOT NULL,
    First_Name VARCHAR2(20),
    Last_Name VARCHAR2(25) NOT NULL,
    Salary NUMBER(8,2),
    DepT_id NUMBER(4)
);

DROP TABLE EMP;

RENAME Employees2 TO EMP;

COMMENT ON TABLE DEPT IS 'Department table';
desc DEPT;
COMMENT ON TABLE EMP IS 'Employee table';
SELECT comments FROM user_tab_comments WHERE table_name = 'DEPT' or table_name = 'EMP';

alter table EMP drop column First_Name;
desc EMP;
