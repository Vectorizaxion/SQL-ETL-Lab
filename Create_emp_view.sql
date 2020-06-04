-- Create Employee View
CREATE OR REPLACE VIEW d_employee_ora03_v AS
    SELECT
        emp.employee_id   AS "EMPLOYEE_CD",
        emp.first_name
        || ' '
        || emp.last_name AS "EMPLOYEE_NAME",
        emp.email || '@gmail.com' AS "EMPLOYEE_EMAIL",
        replace(emp.phone_number, '.', '-') AS "EMPLOYEE_PHONE_NUMBER",
        emp.hire_date     AS "HIRE_DATE",
        nvl(to_char(j_his.end_date), 'NA') AS "LAST_DATE",
        job.job_title     AS "JOB_TITLE",
        to_number(nvl(emp.commission_pct, 0)) AS "EMPLOYEE_COMMISSION",
        mgr.employee_id   AS "MANAGER_CD",
        mgr.first_name
        || ' '
        || mgr.last_name AS "MANAGER_NAME"
    FROM
        employees     emp
        JOIN jobs          job ON ( job.job_id = emp.job_id )
        FULL OUTER JOIN job_history   j_his ON ( emp.employee_id = j_his.employee_id )
        JOIN employees     mgr ON ( emp.manager_id = mgr.employee_id )
    ORDER BY
        1;
/
-- Create Salary View

CREATE OR REPLACE VIEW f_salary_ora03_v AS
    SELECT
        ROW_NUMBER() OVER(
            ORDER BY
                1
        ) AS "SEQ",
        to_number(to_char(sysdate, 'YYYY')) AS "YEAR_CD",
        to_number(to_char(sysdate, 'YYYYmm')) AS "MONTH_CD",
        emp.employee_id     AS "EMPLOYEE_CD",
        emp.job_id          AS "JOB_CD",
        mgr.department_id   AS "DEPARTMENT_CD",
        nvl2(emp.salary, emp.salary, 0) AS "EMPLOYEE_SALARY",
        nvl2(j.max_salary, j.max_salary, 0) AS "MAX_JOB_SALARY",
        nvl2(j.min_salary, j.min_salary, 0) AS "MIN_JOB_SALARY",
        mgr.salary          AS "MANAGER_SALARY",
        RANK() OVER(
            PARTITION BY emp.job_id
            ORDER BY
                emp.salary DESC
        ) AS "JOB_SALARY_RANKING"
    FROM
        employees     emp
        JOIN employees     mgr ON ( emp.manager_id = mgr.employee_id )
        JOIN jobs          j ON ( emp.job_id = j.job_id )
        JOIN departments   dept ON ( emp.department_id = dept.department_id );
/
-- Create Department View

CREATE OR REPLACE VIEW d_department_ora03_v AS
    SELECT
        d.department_id     AS department_cd,
        d.department_name   AS department_name,
        nvl2(SUBSTR(l.street_address,1,30), SUBSTR(l.street_address,1,30), 'NA') AS street_address,
        nvl2(l.postal_code, l.postal_code, 'NA') AS postal_code,
        l.city              AS city,
        nvl2(l.state_province, l.state_province, 'NA') AS state_province,
        nvl2(c.country_name, c.country_name, 'NA') AS country_name,
        nvl2(r.region_name, r.region_name, 'NA') AS region_name_en,
        nvl2(r.region_name,
             CASE
                 WHEN r.region_name = 'Europe'                 THEN
                     '?????'
                 WHEN r.region_name = 'Americas'               THEN
                     '???????'
                 WHEN r.region_name = 'Asia'                   THEN
                     '??????'
                 WHEN r.region_name = 'Middle East and Africa' THEN
                     '??????????????????????'
             END, 'NA') AS region_name_th
    FROM
        departments   d
        JOIN locations     l ON d.location_id = l.location_id
        JOIN countries     c ON l.country_id = c.country_id
        JOIN regions       r ON c.region_id = r.region_id
    ORDER BY
        1;
/