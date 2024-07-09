# insert 예제 
# 1, 'John', 'Doe', 'Sales', 50000
Insert into employee(emp_no, name, eng_name, Dept_no, salary) 
values(1, 'John', 'Doe', 'Sales', 50000);

# 잘못 넣은 데이터 삭제
# 데이터는 키 값을 기준으로 중복데이터는 넣어주지 않는다 -> 잘못넣었으면 삭제하고 넣어야함
delete from employee where name = 'john';

# 원본 테이블 체크 -> 수정사항 반영이 됬는지 
SELECT * FROM employee;

# 각 컬럼의 데이터 형태 보는 것
show columns from employee;

# insert 과정에서 dept_no가 char(2)형태여서 sales가 안들어감 
# text 형태로 바꿔줬다.
ALTER TABLE employee
MODIFY COLUMN dept_no TEXT;

# ===========================================================================================
# 문제 1. 제품 테이블에 제품 이름은 'Laptop', 포장 방식은 'Box', 단가는 1200, 재고는 50

# 문제 2 employee 테이블에 새로운 직원 'Jane Smith'를 추가하고, 
# 직원 번호는 '마지막 번호', 영어 이름은 'Smith', 직위는 'Manager', 성별은 'F', 생일은 '1985-07-19', 
# 입사일은 '2020-05-10', 주소는 '123 Maple St', 도시는 'New York', 지역은 'NY', 전화번호는 '555-1234', 
# 상사 번호는 'E5', 부서 번호는 'A2'로 설정하세요.
 INSERT INTO employee (emp_no, name, eng_name, position, gender, birthday, date_of_emp, address, city, area, telephone, boss_number, dept_no)
 VALUES ('E12', 'Jane Smith', 'Smith', 'Manager', '남', '1985-07-19', '2020-05-10', '123 Maple St', 'New York', 'NY', 555-1234, 'E5', 'A2');

# 문제3. customer 테이블에 새로운 고객을 추가하고, 고객 번호는 '마지막 번호', 회사 이름은 'Tech Solutions', 
# 담당자 이름은 'Tom Brown', 담당자 직위는 'CEO', 주소는 '456 Oak Ave', 도시는 'San Francisco', 
# 지역은 'CA', 전화번호는 '555-5678', 마일리지는 500으로 설정하세요.
 INSERT INTO customer (customer_no, customer_comp_name, person_in_charge_name, person_in_charge_pos, address, city, area, telephone, mileage)
 VALUES ('TESO', 'Tech Solutions', 'Tom Brown', 'CEO', '456 Oak Ave', 'San Francisco', 'CA', '555-5678', 500);
 
 
# 문제 4. orders 테이블에 새로운 주문을 추가하고, 주문 번호는 '마지막 번호', 고객 번호는 'C0001', 
# 직원 번호는 '임의', 주문 날짜는 '2023-07-01', 요청 날짜는 '2023-07-05', 배송 날짜는 '2023-07-04'로 설정하세요.
 INSERT INTO orders (order_no, customer_no, emp_no, order_date, request_date, shipment_date)
 VALUES ('H1078', 'TESO', 'E04', '2023-07-01', '2023-07-05', '2023-07-04');

# =============================================================================================
# 문제 1. employee 테이블에서 직원 번호가 'E02'인 직원의 주소를 '456 Elm St'로 업데이트하세요.
update employee
set address = '456 Elm St'
where emp_no = 'E02';

SELECT * FROM employee;

# 문제 2. products 테이블에서 제품 번호가 21인 제품의 재고를 70으로 업데이트하세요.
update products 
set inventory = 70
where product_no = 21;

SELECT * FROM products;
show columns from products;

# 문제 3. customer 테이블에서 고객 번호가 'ANRFR'인 고객의 마일리지를 1500으로 업데이트하세요.
update customer 
set mileage = 1500
where customer_no = 'ANRFR';

SELECT * FROM customer
where customer_no = 'ANRFR';
show columns from customer;

#employee 번호가 'E11'인 사람 삭제
delete from employee
where (emp_no = 'E11');

# =============================================================================================
-- INSERT INTO table2 (col1, col2, ...)
-- select col1_1, col1_2,...# value 자리에 select문을 넣는다
-- from table1
-- where 조건

# position이 매니저인 사람 행을 원본데이터에 중복해서 붙임
INSERT INTO employee(Emp_no, name, eng_name, position, gender, birthday, date_of_emp, address, city, area, telephone, boss_number, Dept_no)
SELECT Emp_no, name, eng_name, position, gender, birthday, date_of_emp, address, city, area, telephone, boss_number, Dept_no
FROM employee
WHERE position = 'Manager';

# emp_no 기본키 설정이라 중복 데이터 안 붙여짐 -> 기본키 설정 제거함 
ALTER TABLE employee DROP PRIMARY KEY;

# 체크
SELECT * FROM employee;

# update_select문 =======================================================================
# 문제 1. emp_no가 E01인 직원의 상사 번호를 'E2'로 변경하시오.
update employee e
set e.boss_number = (select boss_number from employee where emp_no = 'E01');

# 문제 2. 특정 기간 동안 주문한 모든 고객의 마일리지를 해당 기간의 최대 주문 금액으로 업데이트하세요.
# 2020-04-01 ~ 2020-04-10
update customer c
set c.mileage = (
	select max(od.unit_price * od.order_quantity * (1-od.discount_rate))
	from orders o
	join order_details od on o.order_no = od.order_no
	where o.order_date between '2020-04-01' and '2020-04-10') 
where c.customer_no in (
	select o.customer_no
    from orders o
    where o.order_date between '2020-04-01' and '2020-04-10'
);

-- 업데이트된 고객 정보를 조회하는 쿼리
SELECT c.customer_no, c.customer_comp_name, c.person_in_charge_name, c.mileage
FROM customer c
WHERE c.customer_no IN (
    SELECT o.customer_no
    FROM orders o
    WHERE o.order_date BETWEEN '2020-04-01' AND '2020-04-10'
);

# ========================================================================================4
# delete
# 문제 3 특정 마일리지 이하의 모든 고객을 삭제하세요.
delete from customer 
where mileage <= 10;

# 문제4. 특정 도시의 모든 고객을 삭제하세요. (도시: 'San Francisco')
# join을 사용

delete c 
from customer c
join orders o on c.cutomer_no = o.customer_no
where c.city = 'San Francisco'
