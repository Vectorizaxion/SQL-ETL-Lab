-- Insert D_EMPLOYEE_ORA03
INSERT INTO D_EMPLOYEE_ORA03
    SELECT  d_employee_ora03_v.*,
            SYSDATE,
            SYSDATE
    FROM d_employee_ora03_v;
/
-- Insert f_salary_ora03 
INSERT INTO f_salary_ora03 
    SELECT  f_salary_ora03_v.*,
            SYSDATE,
            SYSDATE
    FROM f_salary_ora03_v;
/
-- d_department_ora03
INSERT INTO D_DEPARTMENT_ORA03
    SELECT  d_department_ora03_v.*,
            SYSDATE,
            SYSDATE
    FROM d_department_ora03_v