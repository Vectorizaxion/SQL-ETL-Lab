# SQL-ETL-Lab
เป็น Lab ทำกระบวนการ ETL : Extrack Transform Load เพื่อทำนำ Datasource ไปทำเป็น Data Warehouse พร้อมใช้งานด้วยภาษา PL/SQL โดยมีโจทย์ดังนี้ 

1. Create table target ชื่อ D_EMPLOYEE_ORA** โดยมี Structure ดังนี้
	EMPLOYEE_CD	 		NUMBER(6),
	EMPLOYEE_NAME	 		NVARCHAR2(200),
	EMPLOYEE_EMAIL	 		NVARCHAR2(50),
	EMPLOYEE_PHONE_NUMBER	 	NVARCHAR2(200),
	HIRE_DATE			DATE,
	LAST_DATE			NVARCHAR2(50),
	JOB_TITLE	 		NVARCHAR2(35),
	EMPLOYEE_COMMISSION		NUMBER(2,2),
	MANAGER_CD			NUMBER(6),
	MANAGER_NAME			NVARCHAR2(200),
	ETL_DATE			TIMESTAMP(6),
	ETL_LAST_UPDATE			TIMESTAMP(6)

2. Create table target ชื่อ D_DEPARTMENT_ORA** โดยมี Structure ดังนี้
	DEPARTMENT_CD	 		NUMBER(4),
	DEPARTMENT_NAME	 		NVARCHAR2(100),
	STREET_ADDRESS	 		NVARCHAR2(30), 
	POSTAL_CODE	 		NVARCHAR2(12),
	CITY				NVARCHAR2(30),
	STATE_PROVINCE	 		NVARCHAR2(25),
	COUNTRY_NAME			NVARCHAR2(40),
	REGION_NAME_EN			NVARCHAR2(25),
	REGION_NAME_TH			NVARCHAR2(25),
	ETL_DATE			TIMESTAMP(6),
	ETL_LAST_UPDATE			TIMESTAMP(6)

3. Create table target ชื่อ F_SALARY_ORA** โดยมี Structure ดังนี้
  	SEQ           			NUMBER(10),
        YEAR_CD			        NUMBER(4),
        MONTH_CD			NUMBER(6),
  	EMPLOYEE_CD              	NUMBER(6),
  	JOB_CD           		NVARCHAR2(20),
  	DEPARTMENT_CD        		NUMBER(4),
  	EMPLOYEE_SALARY        		NUMBER(8,2),
  	MAX_JOB_SALARY         		NUMBER(6,0),
  	MIN_JOB_SALARY     		NUMBER(6,0),
        MANAGER_SALARY			NUMBER(8,2),
  	JOB_SALARY_RANKING 		NUMBER(2),
  	ETL_DATE           		TIMESTAMP(6),
  	ETL_LAST_UPDATE    		TIMESTAMP(6)

4. Create view ชื่อ D_EMPLOYEE_ORA**_V รายละเอียดดังนี้
- Select ข้อมูลจาก Table EMPLOYEES, JOBS และ JOB_HISTORY
- สร้าง Column ทำการแปลงค่า Column ดังนี้
   Column EMPLOYEE_NAME --> ให้รวม Column FIRST_NAME กับ LAST_NAME โดยไม่ให้ชื่อและนามสกุลติดกัน และตัดช่องว่างหัวท้าย
   Column EMPLOYEE_EMAIL --> เพิ่ม @gmail.com ต่อท้ายชื่อ Email และตัดช่องว่างหัวท้าย
   Column EMPLOYEE_PHONE_NUMBER --> เปลี่ยนเครื่องหมาย "." เป็น "-" ทั้งหมด
   **Column LAST_DATE --> วันที่สิ้นสุดงาน (จากตาราง JOB_HISTORY) ถ้า Employee คนใดยังไม่มีวันที่สิ้นสุดงาน ให้ใส่ 'NA'
   Column JOB_TITLE --> จากตาราง JOBS
   Column EMPLOYEE_COMMISSION --> ถ้าค่าเป็น NULL ให้แสดงเป็น 0
   **Column MANAGER_NAME --> ให้รวม Column FIRST_NAME กับ LAST_NAME โดยไม่ให้ชื่อและนามสกุลติดกัน และตัดช่องว่างหัวท้าย
- ทำการ Rename Column ให้เหมือน Match กับชื่อ Column ที่ Table D_EMPLOYEE_ORA**

5. Create view ชื่อ D_DEPARTMENT_ORA**_V รายละเอียดดังนี้
- Select ข้อมูลจาก Table DEPARTMENTS, LOCATIONS, COUNTRIES และ REGIONS
- สร้าง Column ทำการแปลงค่า Column ดังนี้
   Column STREET_ADDRESS --> จาก Table LOCATIONS และให้ตัดตัวอักษรเหลือ 30 ตัวอักษรจากหน้ามาหลัง
   Column REGION_NAME_EN --> ชื่อเต็มของ REGION เป็นภาษาอังกฤษ
   Column REGION_NAME_TH --> ชื่อเต็มของ REGION เป็นภาษาไทย
- ถ้า Column ไหนมีค่า NULL ให้แสดงค่านั้นเป็น 'NA' ทั้งหมด   
- ทำการ Rename Column ให้เหมือน Match กับชื่อ Column ที่ Table D_DEPARTMENT_ORA**

6. Create view ชื่อ F_SALARY_ORA**_V รายละเอียดดังนี้
- Select ข้อมูลจาก Table EMPLOYEES, JOBS และ DEPARTMENTS
- สร้าง Column ทำการแปลงค่า Column ดังนี้
  Column YEAR_CD --> ปีปัจจุบันในรูปแบบ ค.ศ. จำนวน 4 ตัว
  Colimn MONTH_CD --> เดือนปัจจุบันในรูปแบบ ปี ค.ศ. + เลขเดือนจำนวน 2 ตัว (Ex.201607)
  Column EMPLOYEE_SALARY --> ถ้ามีค่าเป็น NULL ให้แสดงเป็น 0
  Column MAX_JOB_SALARY --> ถ้ามีค่าเป็น NULL ให้แสดงเป็น 0
  Column MIN_JOB_SALARY --> ถ้ามีค่าเป็น NULL ให้แสดงเป็น 0
  Column MANAGER_SALARY --> ถ้ามีค่าเป็น NULL ให้แสดงเป็น 0
  **Column JOB_SALARY_RANKING --> ให้แสดงอันดับของ EMPLOYEE นั้นๆในแต่ละ JOB วัดตาม SALARY
- ทำการ Rename Column ให้เหมือน Match กับชื่อ Column ที่ Table F_SALARY_ORA**

5. Create Procedure ชื่อ DEL_F_SALARY_ORA** รายละเอียดดังนี้
    ให้ Delete ข้อมูลใน Table F_SALARY_ORA** โดยมีเงื่อนไข ต้องมี YEAR_CD และ MONTH_CD เท่ากับ YEAR_CD และ MONTH_CD ของ F_SALARY_ORA**_V

6. INSERT ข้อมูลจาก D_EMPLOYEE_ORA**_V เข้าตาราง D_EMPLOYEE_ORA** กำหนดรายละเอียดดังนี้
- ใช้ Script INSERT ในการนำเข้าข้อมูล
- ใส่วันปัจจุบันลงใน Column ETL_DATE และ ETL_LAST_UPDATE

7. INSERT ข้อมูลจาก D_DEPARTMENT_ORA**_V เข้าตาราง D_DEPARTMENT_ORA** กำหนดรายละเอียดดังนี้
- ใช้ Script INSERT ในการนำเข้าข้อมูล
- ใส่วันปัจจุบันลงใน Column ETL_DATE และ ETL_LAST_UPDATE

8. INSERT ข้อมูลจาก F_SALARY_ORA**_V เข้าตาราง F_SALARY_ORA** กำหนดรายละเอียดดังนี้
- ใช้ Script INSERT ในการนำเข้าข้อมูล
- ใส่วันปัจจุบันลงใน Column ETL_DATE และ ETL_LAST_UPDATE

9. ทดสอบ Run Procedure DEL_F_SALARY_ORA**  



