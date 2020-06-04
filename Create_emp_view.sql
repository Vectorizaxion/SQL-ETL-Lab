CREATE OR REPLACE VIEW  D_EMPLOYEE_ORA03_V AS 
    SELECT 
        emp.employee_id AS "EMPLOYEE_CD",
        emp.first_name ||' ' || emp.last_name AS "EMPLOYEE_NAME",
        emp.email ||'@gmail.com' AS "EMPLOYEE_EMAIL",
        REPLACE(emp.phone_number,'.','-') AS "EMPLOYEE_PHONE_NUMBER",
        emp.hire_date AS "HIRE_DATE",
        NVL(TO_CHAR(j_his.end_date),'NA') AS "LAST_DATE",
        job.job_title AS "JOB_TITLE",
        TO_NUMBER(NVL(emp.commission_pct,0)) AS "EMPLOYEE_COMMISSION",
        mgr.employee_id AS "MANAGER_CD",
        mgr.first_name||' '||mgr.last_name AS "MANAGER_NAME"
    FROM Employees emp
    
    JOIN JOBS job
    ON (job.job_id =  emp.job_id)
    
    FULL OUTER JOIN JOB_HISTORY j_his
    ON (emp.employee_id = j_his.employee_id)
        
    JOIN Employees mgr 
    ON (emp.manager_id = mgr.employee_id)
    
    ORDER BY 1;   
/
SELECT * FROM D_EMPLOYEE_ORA03_V;/
SELECT * FROM JOB_HISTORY;/
SELECT * FROM JOBS;/
SELECT * FROM departments;/
SELECT * FROM employees;

SELECT * FROM employees emp
LEFT JOIN JOB_HISTORY j_his
ON (emp.employee_id = j_his.employee_id)
AND NOT manager_id IS NULL; /

SELECT * 
FROM employees emp JOIN departments dept
ON (emp.department_id = dept.department_id);