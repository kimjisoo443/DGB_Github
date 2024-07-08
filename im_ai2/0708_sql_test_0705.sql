# 문제 1. 각 직원별 및 전체 주문 처리 수와 평균 주문 처리 시간 조회
select ifnull(emp_no, '전체') as 직원번호, # null인 경우 전체로 대체해줌
count(order_no) as 총주문수,
case 
when avg(datediff(shipment_date, order_date)) >= 2 then '지연'
else avg(datediff(shipment_date, order_date))
end as 평균처리시간
from order
where shipment_date is not null and order_date is not null
group by emp_no with rollup
having count(order_no) >= 5 or emp_no is null;

# 문제 2: 각 부서별 및 전체 직원 수와 평균 입사 날짜 조회(employee 테이블)
select ifnull(dept_no, '전체') as 부서번호,
count(emp_no) as 직원수,
avg(date_format(date_of_emp, '%Y%m%d')) as 평균입사날짜
from employee
group by dept with rollup;

# 문제 3: 각 부서별 및 전체 직원 수와 평균 나이 조회 (employee 테이블)
select ifnull(dept_no, '전체') as 부서번호,
count(emp_no) as 직원수,
avg(year(curdate())- year(birthday)) as  평균나이
from employee 
group by dept_no with rollup;

# 예외문제(심화) : 각 제품별 및 전체 총 판매 수량, 평균 할인율, 총 판매 금액 조회 
# (총 판매 수량이 100 이상인 제품만, 할인율이 0인 경우 '할인 없음'으로 표시)
select ifnull(product_no, '전체') as 제품번호, 
sum(order_quantity) as 총판매수량,
case when avg(discount_rate) = 0 then '할인 없음'
else avg(discount_rate) 
end as 평균한인율, 
sum(order_quantity * unit_price * (1-discount_rate)) as 총판매금액
from order_details
where order_quantity > 0
group by product_no with rollup
having sum(order_quantity) >= 100 or product_no is null;

# 진짜 마지막 예외문제 : 각 직원별 총 주문 수와 전체 총 주문 수 조회 
# (총 주문 수가 5개 이상인 직원만, 평균 처리 시간이 2일 이상인 경우 '지연'으로 표시)
SELECT IFNULL(emp_no, '전체') AS 직원번호,
       COUNT(order_no) AS 총주문수,
       CASE
         WHEN AVG(DATEDIFF(shipment_date, order_date)) >= 2 THEN '지연'
         ELSE AVG(DATEDIFF(shipment_date, order_date))
       END AS 평균처리시간
FROM orders
WHERE shipment_date IS NOT NULL AND order_date IS NOT NULL
GROUP BY emp_no WITH ROLLUP
HAVING COUNT(order_no) >= 5 OR emp_no IS NULL;

