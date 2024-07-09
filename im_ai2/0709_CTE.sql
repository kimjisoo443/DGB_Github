# join 서브쿼리
select d.dept_name, stats.avg_salary
from department d 
join ( # 부서의 평균 연봉
	select dept_no, avg(salary) as avg_salary
    from employee
    group by dept_no
) stats
on d.dept_no = stats.dept_no # 같은 부서일 떄
where stats.avg_salary >= 50000; # 연봉이 5만 이상인 경우

# select문에 서브쿼리
# 각 직원의 정보와 그 직원이 속한 부서 조회
select e.emp_no, e.name, e.salary,
	(select d.dpet_name
     from department d
     where d.dept_no = e.dept_no) as dept_name
from employee e;

# ==================================================================================
# CTE - 가독성, 재사용성
# 부서명과 평균연봉 조회 (단, 평균 연봉이 50000 이상인 부서만)
with dept_avg_sal as (
	select dept_no, avg(salary) as avg_sal
    from employee
    group by dept_no
) # CTE
select d.dept_name, a.avg_sal
from department d
join dept_avg_sal a on d.dept_no = a.dept_no # CTE랑 조인함
where a.avg_sal >= 50000;

# CTE 예제
# 각 직원의 상사 정보 조회
with employee_hierarchy as (
	select e.emp_no, e.name as emp_name, e.boss_number, b.name as boss_name 
	from employee e 
	left join employee b on e.boss_number = b.emp_no
	# left join 해야 보스가 없는 사람도 나온다 
)
select emp_no, emp_name, boss_name
from employee_hierarchy ;


# 문제 1. 부서별로 직원 수가 5명 이상인 부서의 부서명과 직원 수를 조회하세요.
# employee - department 
# 설계 
# 1. e에서 부서넘버 별로 그룹화하면 명수 나옴 -> CTE로 둠
# 2. d와 조인
with emp_count as (
	select dept_no, count(emp_no) as count
	from employee
	group by dept_no
) 
select e.dept_no, d.dept_name, e.count
from emp_count e 
right join department d on e.dept_no = d.dept_no
having e.count>=5;

# 잘못된 접근
select e.emp_no, e.name, e.dept_no, d.dept_name
from employee e 
left join department d on e.dept_no = d.dept_no
group by e.dept_no;
#=====================================================================

# 문제 2. 모든 주문의 총 금액을 계산하는 쿼리를 작성하세요.
with get_cost as (
	select od.order_quantity, od.unit_price, od.discount_Rate, 
	(1-od.discount_Rate)*od. unit_price*od.order_quantity as cost
	from order_details od
)
select sum(cost)
from get_cost;

# 강사님
with order_total as ( 
	select sum((1-od.discount_Rate)*od. unit_price*od.order_quantity) as total_amount
	from order_details od
	group by order_no # 주문 별 총 합 금액
)
select sum(total_amount) as all_total
from order_total;

# 문제 3. 각 제품의 재고가 10개 이하인 제품의 제품명과 재고 수량을 조회하세요.

# 표에 대한 이해 부족으로 잘못 접근 (inventory - 오더 수량) 해야 되는 줄암
# products - order_details
# 재고수량 조회
# 10개 이하인 제품의 제품명 출력
with product_count as (
	select p.product_no, p.product_name as p_name, p.inventory, od.order_quantity, 
    (p.inventory - od.order_quantity) as count 
	from products p 
	left join order_details od on p.product_no = od.product_no
)
select p_name, count
from product_count;

with count_inv as(
select product_no, product_name, inventory
from products
)
select product_name, inventory
from count_inv
where inventory <= 10;

# 강사님 
with check_inven as (
select product_no, product_name, inventory
from products
where inventory <= 10
)
select product_name, inventory
from check_inven;




# 문제 4 - CTE 2개
# 모든 직원의 연봉과 그 연봉의 평균 연봉을 함께 조회하는 쿼리를 작성하세요.
# employee 
with get_avg_sal as (
	select ceiling(avg(salary)) as avg_sal
	from employee
) 
select e.name, e.salary, a.avg_sal
from get_avg_sal a
join employee e; 


with get_avg_sal as (
	select ceiling(avg(salary)) as avg_sal
	from employee
),
get_sal as(
	select name , ceiling(salary) as sal
    from employee
)
select b.name, b.sal, a.avg_sal
from get_avg_sal a
join get_sal b;


# 강사님
# cte1. 각 직원에 대한 연봉정보 조회(계산)
# cte2. 전체 직원의 평균연봉 조회(계산)
with emp_sal as (
	select emp_no, name, salary
    from employee
), avg_sal as (
	select avg(salary) as a_s
    from emp_sal
)
select e.emp_no, e.name, e.salary, a.a_s
from emp_sal e, avg_sal a;

# 응용문제 1. 각 고객의 주문 수와 총 주문 금액을 조회하세요. 단, 총 주문 금액이 1000 이상인 고객만 조회하세요.
# order order_details 
# cte1. 고객의 주문수 - order에서 order_no가지고 주문수 
# cte2. 총 주문 금액 - order_details에서 order_no 별 금액 계산
with get_order as (
	select customer_no, count(order_no)
	from orders
	group by customer_no
), get_cost as (
	select unit_price * order_quantity * (1-discount_rate) as cost
    from order_details
    group by order_no
)

select order_no, unit_price * order_quantity * (1-discount_rate) as cost
from order_details
group by order_no;

 # 강사님
 with cust_order as (
	select c.customer_no, c.customer_comp_name,
			count(o.order_no) as order_cnt,
			sum(od.unit_price * od.order_quantity * (1-od.discount_rate)) as total_amount
    from customer c 
    join orders o on c.customer_no = o.customer_no
    join order_details od on o.order_no = o.customer_no
    group by c.customer_no, c.customer_comp_name
)
select customer_no, customer_comp_name, order_cnt, total_amount
from cust_order
where total_amount >= 1000;

# 상관 서브쿼리 문제 1 : 각 부서에서 가장 높은 연봉을 받는 직원의 이름과 연봉을 조회하세요.
# employee
select dept_no, name, salary
from employee
where salary in (select max(e.salary) as m_sal
				from employee as e
				group by dept_no
			);
            
# 강사님
# 일반 서브쿼리 - 독립적으로 진행됨 
select emp_no, name, salary
from employee
where salary = (select max(salary) from employee);
            
# 상관서브쿼리
select e.name, e.salary
from employee e
where e.salary = (
				select max(salary)
				from employee
				where dept_no = e.dept_no
			);


#다중서브쿼리 예제 sql문
#주문번호, 주문날짜 조회
select o.order_no, o.order_date
from orders o
join order_details od on o.order_no = od.order_no
#서브쿼리의 결과와 일치하는 행을 필터링하기 위한 구간
where (od.product_no, od.order_quantity) in (
#제품번호와 재고량 파악(재고량 10 이하만)
select product_no, inventory
from products
where inventory <= 10)


