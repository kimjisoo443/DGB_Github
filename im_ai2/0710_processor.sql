set global abc_glo = 100;
#show global variable like 'max_connections';
set session abc_session = 111;

#  프로시저는 여러 쿼리문을 하나로 합쳐서 사용하기 위해 주로 사용
#  여러 SQL문의 실행이 가능하다. (모듈화)
DELIMITER //
CREATE PROCEDURE CountEmployeesInDept()
BEGIN
    -- 로컬 변수 선언
    DECLARE deptNo CHAR(2) CHARSET utf8mb4 COLLATE utf8mb4_general_ci;
    DECLARE employeeCount INT;
    -- 변수 초기화
    SET deptNo = '01';
    SET employeeCount = 0;
    -- 특정 부서의 직원 수 계산
    SELECT COUNT(*)
    INTO employeeCount
    FROM employee
    WHERE dept_no = deptNo COLLATE utf8mb4_general_ci;
    -- 결과 출력
    SELECT CONCAT('Department ', deptNo, ' has ', employeeCount, ' employees.') AS Result;
END //
DELIMITER ;

# 호출 
CALL CountEmployeesInDept();

#==============================================================================
# 문제 1: 특정 고객의 총 주문 금액 계산
# 특정 고객의 모든 주문에 대한 총 금액을 계산하는 저장 프로시저를 작성할 것
# 프로시저는 고객 번호를 입력 매개변수로 받고, 해당 고객의 총 주문 금액을 반환

DELIMITER //
CREATE PROCEDURE CalCustomerCost()
BEGIN
    -- 로컬 변수 선언
    DECLARE cust_name varCHAR(20) CHARSET utf8mb4 COLLATE utf8mb4_general_ci;
    DECLARE cost decimal(10,2);
   
    -- 변수 초기화
    SET cust_name = 'ACDDR';
    SET cost = 0;
    -- 특정 부서의 직원 수 계산
    select 
			sum(od.unit_price*(1-od.discount_rate)*od.order_quantity) 
	into cost 
	from orders o
	join order_details od on o.order_no = od.order_no
    join customer c on o.customer_no = c.customer_no
    WHERE o.customer_no = cust_name COLLATE utf8mb4_general_ci;
    -- 결과 출력
    SELECT CONCAT('customer_no ', cust_name , ' cost : ', cost ) AS Result;
END //
DELIMITER ;

# 호출 
CALL CalCustomerCost();

# 강사님 
# - 특정 고객의 모든 주문에 대한 총 금액을 계산하는 저장 프로시저를 작성할 것
# - 프로시저는 고객 번호를 입력 매개변수로 받고, 해당 고객의 총 주문 금액을 반환
DELIMITER \\
CREATE PROCEDURE CalculateTotalOrderAmount(IN customerNo CHAR(5))
BEGIN
    DECLARE totalAmount DECIMAL(10, 2);
    SELECT SUM(od.unit_price * od.order_quantity * (1 - od.discount_rate))
    INTO totalAmount
    FROM orders o
    JOIN order_details od ON o.order_no = od.order_no
    WHERE o.customer_no COLLATE utf8mb4_general_ci = customerNo COLLATE utf8mb4_general_ci;
    SELECT customerNo AS 고객번호, totalAmount AS 총주문금액;
END \\
DELIMITER ;
#문제 1번 프로시저 호출 :
CALL calc_total_order_amount('CSURI');

# 문제 2: 특정 부서의 직원 평균 연봉 계산
# 특정 부서의 직원들의 평균 연봉을 계산하는 저장 프로시저를 작성
# 프로시저는 부서 번호를 입력 매개변수로 받고, 해당 부서의 직원 평균 연봉을 반환
DELIMITER //
CREATE PROCEDURE Cal_Avg_Salary(IN deptNo CHAR(10))
BEGIN
    -- 로컬 변수 선언
    DECLARE avg_salary decimal(10,2);
   
    -- 변수 초기화
    SET avg_salary = 0;
    -- 특정 부서의 직원 수 계산
    select avg(salary)
	into avg_salary
	from employee
	WHERE dept_no COLLATE utf8mb4_general_ci = deptNo COLLATE utf8mb4_general_ci;

    -- 결과 출력
    SELECT deptNo as dept_number, avg_salary;
END //
DELIMITER ;

# 호출 
CALL Cal_Avg_Salary('A1');

# 문제 3: 특정 제품의 총 판매량 계산
# 특정 제품의 총 판매량을 계산하는 저장 프로시저를 작성
# 프로시저는 제품 번호를 입력 매개변수로 받고, 해당 제품의 총 판매량을 반환
DELIMITER //
CREATE PROCEDURE Get_TotalAmount(IN proNo INT)
BEGIN
    -- 로컬 변수 선언
    DECLARE total_amount decimal(10,2);
   
    -- 변수 초기화
    SET total_amount = 0;
    -- 특정 부서의 직원 수 계산
    select sum(order_quantity)
	into total_amount
	from order_details
	WHERE product_no COLLATE utf8mb4_general_ci = proNo  COLLATE utf8mb4_general_ci;

    -- 결과 출력
    SELECT proNo as product_number, total_amount;
END //
DELIMITER ;

# 호출 
CALL Get_TotalAmount(1);
