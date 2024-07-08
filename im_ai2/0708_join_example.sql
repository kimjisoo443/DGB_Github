# inner join
select o.order_no, o.customer_no, od.product_no, od.order_quantity
from orders o # 첫번째 테이블
inner join order_details od # 두번째 테이블 
on o.order_no = od.order_no; # 조건걸기 열이 일치하는 행 join하기

# left join
select o.order_no, o.customer_no, od.product_no, od.order_quantity
from orders o # 첫번째 테이블
left join order_details od # 두번째 테이블 - 왼쪽테이블에 일치하는 행 반환
on o.order_no = od.order_no; # 조건걸기 열이 일치하는 행 join하기

# full join(버젼 7 이하) 일치하지 않아도 행 반환하는데 null값 반환
-- select o.order_no, o.customer_no, od.product_no, od.order_quantity
-- from orders o # 첫번째테이블
-- full outer join order_details od 
-- on o.order_no = od.order_no; 

# 문제1
# employee 테이블과 department 테이블을 조인하여 각 직원의 이름과 부서명을 조회하세요.
# 부서명이 다 나오도록(직원 x 부서명도) 
select e.name as 직원명, d.dept_name as 부서명
from employee e
right join department d on e.dept_no = d.dept_no;

# 부서없는 직원도 보려면
select e.name as 직원명, d.dept_name as 부서명
from employee e
left join department d on e.dept_no = d.dept_no;

# 문제 1-2 : orders 테이블과 customer 테이블을 조인하여 각 주문의 고객명을 조회하세요.
select o.order_no as 주문번호, c.person_in_charge_name as 고객명, c.customer_comp_name as 고객회사
from orders o
inner join customer c on o.customer_no = c.customer_no;

# 문제 1-3 : 주문이 없는 고객도 포함하여 각 주문의 고객명을 조회하세요.
select o.order_no as 주문번호, c.person_in_charge_name as 고객명, c.customer_comp_name as 고객회사
from orders o
right join customer c on o.customer_no = c.customer_no;

# 문제 1-4. 각 주문 상세의 제품 이름을 조회하세요.
select od.* , p.product_name, p.packaging
from order_details od
inner join products p on od.product_no = p.product_no;

# 문제 1-5. 재고가 0인 제품도 포함하여 각 주문 상세의 제품 이름을 조회하세요.
select od.* , p.product_name, p.packaging
from order_details od
right join products p on od.product_no = p.product_no;

# 문제 1-6. 각 주문의 고객명을 조회하세요.
# 주문과 고객 테이블
select o.order_no as 주문번호, c.person_in_charge_name as 고객명, c.customer_comp_name as 고객회사
from orders o
inner join customer c on o.customer_no = c.customer_no;

# 문제 1-7. 각 주문을 처리한 직원의 이름을 조회하세요.
select o.order_no as 주문번호 , e.name as 직원명
from orders o
left join employee e on o.Emp_no = e.emp_no;

# cross join 
# 테이블 A * 테이블 B 
# 두 테이블 사이 모든 가능한 조합 만듬
select p.product_name, d.dept_name
from products p
cross join department d;

select o.order_no, ml.grade_name
from orders o
cross join mileage_level ml;

# self.join : 한테이블에서 병합
# 예제1. employee에서 각 직원과 그 직원의 상사 정보 조회
select e1.name as 직원명, e2.name as 상사명
from employee e1
inner join employee e2 on e1.boss_number = e2.Emp_no;

# 예제2. employee에서 각 직원과 동일한 부서에 속한 다른 직원 정보 조회
select e1.name as 직원명, e2.name as 같은부서직원명
from employee e1
inner join employee e2 on e1.Dept_no = e2.Dept_no
where e1.emp_no <> e2.emp_no; # 본인 제외 출력

# 2-1. 각 직원과 동일한 성별을 가진 다른 직원 정보를 조회하세요.
select e1.name as 직원명, e2.name as 동일성별직원명
from employee e1
inner join employee e2 on e1.gender = e2.gender
where e1.emp_no <> e2.emp_no;

# 2-2. employee 테이블에서 각 직원과 동일한 지역에 사는 다른 직원 정보를 조회하고 지역명도 함께 보이시오.
select e1.name as 직원명, e2.name as 동지역직원명, e2.area as 지역명
from employee e1
inner join employee e2 on e1.area = e2.area
where e1.emp_no <> e2.emp_no;

# 길이단축 방식
select e.name as 직원명, d.dept_name as 부서명
from employee e, department d # 쉼표로 구분함
where e.dept_no = d.dept_no; # join조건도 where에 넣는다

# 문제 3-1. 특정 고객의 주문과 주문 상세를 조회하세요.
select c.customer_comp_name as 고객명, od.order_no as 주문번호, p.product_name as 제품명,
od.discount_rate as 할인율, od.order_quantity as 수량, od.unit_price as 단가
from order_details od, products p, customer c, orders o
where od.product_no = p.product_no and c.customer_no = o.customer_no;

# 강사님 : 주문번호와 제품번호와 연결 -> 특정고객이 주문한 것 볼 수 o
select o.order_no, od.product_no
from orders o, order_details od
where o.order_no = od.order_no and o.customer_no = 'CTUCA'; # 특정고객


# 문제 3-2(응용문제). 각 주문에 대해 해당 주문의 고객 정보와 주문에 포함된 모든 제품의 정보(제품명, 단가)를 조회하되, 
# 주문에 포함된 제품의 총 금액(수량 * 단가)을 계산하여 결과에 포함하세요.
# 응용문제 사용 테이블 : orders o, customer c, order_details od, products p
# 문제 3-1. 특정 고객의 주문과 주문 상세를 조회하세요.
select c.customer_comp_name as 고객명, od.order_no as 주문번호, p.product_name as 제품명,
od.discount_rate as 할인율, od.order_quantity as 수량, od.unit_price as 단가,
(1-od.discount_rate)*od.unit_price*od.order_quantity as 총금액
from order_details od, products p, customer c, orders o
where od.product_no = p.product_no and c.customer_no = o.customer_no;

# 강사님 
select o.order_no, c customer_comp_name, p.product_name,
p.unit_price, od_order_quantity, (od_order_quantity * p.unity_price) as 총금액
from orders o, customer c, order_details, odproducts p
where o.customer_no = c.customer_no and o.order_no = od.order_no


# 응용문제 2. 각 직원의 상사 이름과 해당 직원이 처리한 주문의 총 금액을 조회하세요. 
# 직원이 처리한 주문이 없는 경우도 포함하세요.
select e1.name as 직원명, e2.name as 상사명, (1-od.discount_rate)*od.order_quantity*od.unit_price as 총금액
from employee e1, employee e2, order_details od, products p, customer c, orders o
where e1.boss_number = e2.Emp_no and 
o.emp_no = (1-od.discount_rate)*od.order_quantity*od.unit_price;

# 강사님
# colesce 함수 
select e.name as 직원명, b.name as 상사명, coalesce(sum(od.order_quantity * p.unit_price))
from employee e 
left join employee b on e.boss_number = b.emp_no
left join orders o on e.emp_no = o.emp_no
left join order_details od on o.order_no = od.order_no
left join products p on od.product_no = p.product_no
group by e.name, b.name;

