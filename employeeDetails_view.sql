-- Tüm çalışanların detaylarını almak için hotel_employees adlı bir görünüm oluştur
CREATE OR REPLACE VIEW hotel_employees AS
	SELECT emp_first_name AS 'First Name', emp_last_name AS 'Last Name', emp_email_address AS 'Email Address', emp_contact_number AS 'Contact Number', department_name AS 'Department'
	FROM employees
	JOIN department
	ON department.department_id = employees.department_department_id;

