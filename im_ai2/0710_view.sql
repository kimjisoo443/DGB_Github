# 뷰 테이블
create view em_view as 
select * from employee;

# 각 제품의 재고가 10개 이하인 제품의 제품명과 재고 수량을 조회하세요.
create view inven as 
select inventory, product_name from products
where inventory <= 10;

# 문제 =======================================================================================
# 문제 1. (view)각 부서별로 직원 수를 조회하시오. 단, 부서 번호와 부서 이름, 그리고 직원 수를 포함하시오.
create view emp_count as 
select e.dept_no, d.dept_name
from employee e 
join department d on e.dept_no = d.dept_no
group by d.dept_name;

SELECT dept_no, dept_name ,count(*) as emp_count FROM tradingcomp.em_count
group by dept_no;

# 강사님 
#문제 1 sql :
create view v_dept_emp_cnt as
SELECT
    d.dept_no,
    d.dept_name,
    COUNT(e.Emp_no) AS employee_count
FROM
    department d
LEFT JOIN
    employee e ON d.dept_no = e.Dept_no
GROUP BY
    d.dept_no, d.dept_name;
    
# 문제 2. 특정 고객이 주문한 제품들의 총 금액을 조회하는 VIEW를 생성하시오. 
# 단, 고객 번호와 고객 이름, 그리고 총 금액을 포함하시오.
create view customer_cost as
select o.order_no, o.customer_no, od.unit_price, od.order_quantity, od.discount_rate,
c.customer_comp_name
from orders o
join order_details od on o.order_no = od.order_no
join customer c on o.customer_no = c.customer_no;

SELECT * FROM tradingcomp.customer_cost;

SELECT customer_no, customer_comp_name, sum(unit_price*(1-discount_rate)*order_quantity) as cost 
FROM tradingcomp.customer_cost
group by customer_no;

# 강사님 
#문제 2 sql :
create view v_customer_total_amount as
SELECT
    c.customer_no,
    c.customer_comp_name,
    SUM(od.unit_price * od.order_quantity * (1 - od.discount_rate)) AS total_amount
FROM
    customer c
JOIN
    orders o ON c.customer_no = o.customer_no
JOIN
    order_details od ON o.order_no = od.order_no
GROUP BY
    c.customer_no, c.customer_comp_name;

# 문제 3. 각 직원의 상사 이름과 직원 이름을 함께 조회하는 VIEW를 생성하시오. 단, 상사가 없는 직원도 포함하시오.
create view emp_with_boss as
select e1.emp_no, e1.name, e2.boss_number, e2.name 
from employee e1
join employee e2 on e1.emp_no = e2.emp_no;

SELECT * FROM tradingcomp.emp_with_boss;

# 강사님
#문제 3 sql :
create view v_emp_boss as
SELECT
    e1.name AS employee_name,
    e2.name AS boss_name
FROM
    employee e1
LEFT JOIN
    employee e2 ON e1.boss_number = e2.Emp_no;


# 문제 4. 모든 주문에 대해 주문 번호와 주문한 제품의 개수, 총 주문 금액을 조회하는 VIEW를 생성하시오.
-- create view t_order as
-- select 

# 강사님 
#문제 4 sql :
create view v_order_summary as
SELECT
    o.order_no,
    COUNT(od.product_no) AS product_count,
    SUM(od.unit_price * od.order_quantity * (1 - od.discount_rate)) AS total_order_amount
FROM
    orders o
JOIN
    order_details od ON o.order_no = od.order_no
GROUP BY
    o.order_no;

# 문제 5. 특정 직원이 담당한 주문 내역을 조회하는 VIEW를 생성하시오. 
# 단, 직원 번호와 이름, 주문 번호, 주문 날짜, 고객 이름을 포함하시오.
