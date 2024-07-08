# employee 테이블에 salary 추가
ALTER TABLE employee
ADD COLUMN salary DECIMAL(10, 2);

# 컬럼 삽입 후 데이터 추가
UPDATE employee
SET salary = CASE Emp_no
    WHEN 'E01' THEN 42000.00
    WHEN 'E02' THEN 73000.00
    WHEN 'E03' THEN 43000.00
    WHEN 'E04' THEN 40000.00
    WHEN 'E05' THEN 52000.00
    WHEN 'E06' THEN 48000.00
    WHEN 'E07' THEN 38000.00
    WHEN 'E08' THEN 65000.00
    WHEN 'E09' THEN 62000.00
    WHEN 'E10' THEN 32000.00
    ELSE NULL
END;

# 직원 중 가장 급여가 높은 직원 조회
# 2개 샐러리, 직원
select emp_no, name, salary from employee
where salary = (select max(salary) from employee);

# 특정부서에서 가장 최근 들어온 직원 정보 조회
select date_of_emp as 입사날짜, timestampdiff('Day',date_of_emp, now()) as 근속일수
from employee
where timestampdiff('Day',date_of_emp, now()) = 
(select min(timestampdiff('Day',date_of_emp, now())) from employee);

# 강사님
# 날짜 정렬 date_of_emp
select emp_no, name, dept_no, date_of_emp
from employee
where date_of_emp = (select max(date_of_emp) from employee
where dept_no = 'A1');

# 문제 1: 가장 많은 주문을 한 고객의 정보를 조회
select customer_no, count(order_no) as 주문횟수
from orders
where customer_no = (select max(count(order_no)) from employee);

# 강사님 - 고객번호 기준으로 가장 많이 주문한 사람 확인
# customer_no, 회사이름
# 1. 그룹바이로 customer_no로 그룹생성하면 각 고객의 주문 횟수 알 수 있음
# 2. 내림차순 정렬
# 3. 가장 위의 고객 이름과 비교 
# 서브퀴리 작성
select customer_no from orders # count(order_no) as 주문횟수 넣으면 주문횟수도 볼 수 있음
group by customer_no
order by count(*) DESC
limit 1; # 맨 위의 값 출력

# 메인쿼리 
select customer_no, customer_comp_name from customer
where customer_no = (select customer_no from orders
group by customer_no
order by count(*) DESC
limit 1);

# 문제 2: 특정 부서에서 가장 높은 연봉을 받는 직원의 정보를 조회
# 부서 별 높은 연봉 확인
# 부서코드, 부서이름, 직원번호, 연봉
# 서브쿼리
select dept_no, emp_no, name, position, salary from employee
order by dept_no DESC;

# 메인쿼리
select dept_no, name, position, salary from employee
where salary = (select max(salary) from employee
where dept_no = 'A1');

 # 강사님
select emp_no, name, salary, dept_no from employee
where salary = (select max(salary) from employee
where dept_no = 'A1');

# 문제 3: 특정 제품을 가장 많이 주문한 고객의 정보를 조회
# order_details의 수량 확인 -> 가장 많이 주문한 오더 번호 체크
# 오더번호로 order에서 customer_no찾고 찾은 고객 번호로 customer에서 이름 찾기
select order_no from order_details
where product_no = 11
group by order_no
order by max(order_quantity) DESC
limit 1; 

select order_no, customer_no from orders
where order_no = (select order_no from order_details
where product_no = 11
group by order_no
order by max(order_quantity) DESC
limit 1);

-- select customer_no, customer_comp_name from customer
-- where customer_no = '1';


# 강사님 
# 1. 메인쿼리 - customer 
# 2. 가장 많이 주문한 -> order quantity (order_details)
# 3. join -> order_no비교(join = orders, order_details)
# 4. 메인에서 customer_no 비교 (join, customer)
# 메인쿼리
select customer_no, customer_comp_name from customer
where customer_no = (select customer_no from orders o
join order_details od on o.order_no = od.order_no
where od.product_no = '1' # 1번 제품 
group by customer_no
order by sum(od.order_quantity) DESC
limit 1);

# 서브쿼리
select customer_no from orders o
join order_details od on o.order_no = od.order_no
where od.product_no = '1' # 1번 제품 
group by customer_no
order by sum(od.order_quantity) DESC
limit 1;

# 문제 4: 특정 부서에서 가장 많은 주문을 처리한 직원의 정보를 조회
# order_details - 수량 , orders - emp_no, employee - emp_no, name
select emp_no, name from employee
where dept_no = 'A1';

select o.order_no, od.order_quantity from order_details
join orders o, order_details od
group by o.order_no
order by sum(od.order_quantity) DESC
limit 1;


# 강사님
# 메인쿼리
select emp_no, name, date_of_emp 
from employee
where emp_no = ('sub');

# 서브쿼리
select emp_no from orders
where emp_no in (select emp_no from employee where dept_no = 'A1')
group by emp_no
order by count(*) 
limit 1;

# 전체
select emp_no, name, date_of_emp 
from employee
where emp_no = (select emp_no from orders
where emp_no in (select emp_no from employee where dept_no = 'A1')
group by emp_no
order by count(*) DESC
limit 1);

# 가장 최근에 입사한 직원보다 먼저 입사한 직원 정보 조회
select emp_no, name, date_of_emp
from employee
where date_of_emp < (select max(date_of_emp) from employee);

# 문제 1 : 가장 많이 주문한 제품 상위 3개를 주문한 고객들의 정보를 조회
select customer_comp_name, customer_no from customer
where customer_no in (select o.customer_no from order_details od,orders o
where o.order_no = od.order_no
order by order_quantity DESC);

# 강사님
# 메인쿼리 : 서브쿼리에서 반환된 고객 번호를 이용한 'customer' 테이블 내 해당 고객 정보 조회
select customer_comp_name, customer_no from customer
where customer_no in (
		# sub
		# 상위 3개 제품번호를 사용해서 orders와 order_details 테이블 조인
		# 각 주문에 대한 고객번호 반환
		select customer_no from orders o
		join order_details od on o.order_no = od.order_no
		where od.product_no in(
				# subsub
                # order_details 테이블에서 각 제품의 총 주문수량 계산
                # 상위 3개의 제품 번호를 선택
				select product_no from (
					select product_no from order_details 
					group by product_no
					order by sum(order_quantity) DESC
					limit 3
					) as top_products
				)
);


# 특정 제품을 주문한고객들 중에서, 해당 제품을 주문한 모든 고객의 평균 주문수량 보다 
# 더 많은 수량을 주문한 고객의 정보를 조회
# 'customer' 테이블의 첫번째 서브쿼리에 대한 결과를 바탕으로 'customer_no'를 가진 고객 조회
SELECT customer_no, customer_comp_name # 고객명단 추출 
FROM customer
WHERE customer_no IN ( # 조건 - 고객번호로 비교
	# sub
    # 각 주문에 대한 고객번호 반환
    # 각 고객의 총 주문수량을 확인(having)
    # # order_details, orders 조인하여 원하는 특정 제품을 주문한 각 고객의 주문번호를 확인
    SELECT customer_no
    FROM orders o
    JOIN order_details od ON o.order_no = od.order_no 
    WHERE od.product_no = '1' # 특정 제품
    GROUP BY customer_no # 고객번호 별 정보 확인
    HAVING SUM(od.order_quantity) > ( # 조건 - 고객번호 별 수량의 합 
        SELECT AVG(total_quantity) # avg_quantity 서브쿼리 내 각 고객의 총 주문수량의 평균 계산
        FROM (
			# subsub
            # 상위 3개의 제품 번호를 선택
            # 특정 제품을 주문한 각 고객의 총 주문량 계산json_table
            # group by를 통해서 고객별 그룹화 진행 및 고객의 총 주문수량을 total_quantity로 계산
            SELECT customer_no, SUM(order_quantity) AS total_quantity # 고객번호랑 수량
            FROM orders o
            JOIN order_details od ON o.order_no = od.order_no # order_details, orders 조인
            WHERE od.product_no = '1'
            GROUP BY customer_no
        ) AS avg_quantities
    )
);

# 메인쿼리 1개 
# 서브쿼리 2개 