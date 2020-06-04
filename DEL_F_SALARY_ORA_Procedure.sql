--Create Procedure
CREATE OR REPLACE PROCEDURE DEL_F_SALARY_ORA03 IS
-- Desination Table Value Cursor
    CURSOR c_year_cd IS SELECT year_cd FROM f_salary_ora03; 
    CURSOR c_month_cd IS SELECT  month_cd FROM f_salary_ora03;
-- View Table Value  Cursor
    CURSOR c_year_cd_v IS SELECT  year_cd FROM f_salary_ora03_v;
    CURSOR c_month_cd_v IS SELECT  month_cd FROM f_salary_ora03_v;
    v_year_cd NUMBER;
    v_month_cd NUMBER;
    v_year_cd_v NUMBER;
    v_month_cd_v NUMBER;
BEGIN   
-- OPEN Cursor
OPEN c_year_cd;
OPEN c_month_cd;
OPEN c_year_cd_v;
OPEN c_month_cd_v;
-- Fetch Cursor
FETCH c_year_cd into v_year_cd;
FETCH c_month_cd into v_month_cd;
FETCH c_year_cd_v into v_year_cd_v;
FETCH c_month_cd_v into v_month_cd_v;

    DELETE FROM F_SALARY_ORA03 
    WHERE v_year_cd = v_year_cd_v
    AND v_month_cd =  v_month_cd_v;
    DBMS_OUTPUT.PUT_LINE(' Inserted '|| SQL%ROWCOUNT ||' row ');
    
-- Close Cursor
CLOSE c_year_cd;
CLOSE c_month_cd;
CLOSE c_year_cd_v;
CLOSE c_month_cd_v;

END DEL_F_SALARY_ORA03 ;
/
-- EXECUTE Proceduce
BEGIN
    del_f_salary_ora03;
END;
/
SELECT * FROM f_salary_ora03