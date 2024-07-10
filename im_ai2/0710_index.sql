# index 
create index idx_dept_name on department(dept_name);
show index from department;

# orders 테이블의 order_date 컬럼에 보조 인덱스 추가
#index 생성(order테이블에 order_date 컬럼)
CREATE INDEX idx_order_date ON orders(order_date);
#특정 테이블 내 인덱스 정보 조회
show index from orders;

explain select * from employee where name = '이소미';

select d.dept_name
from department d
join (
	select dept_no, avg(salary) as avg_salary
    from employee
    group by dept_no
) stats
on d.dept_no = stats.dept_no
where stats.avg_salary >= 50000;

# 변수 설정 
set @abc = 100;
set @exam = 10;

select @from := 100;

set @var_name = '이소미';

select * from employee where name=@var_name;

#사용자변수 사용 문제
# 특정 직원의 이름을 입력받아 해당 직원과 상사 명을 출력하는 sql
set @em_name = '배재용';
select 
	e1.name as employee_name, 
    e2.emp_no AS boss_no, e2.name as boss_name 
from employee e1 
join employee e2 on e1.boss_number = e2.emp_no
where e1.name = @em_name;



SET @employee_name = '이소미';
SELECT
    e.name AS employee_name,
    e.boss_number AS manager_no
    #m.name AS manager_name
FROM
    employee e
LEFT JOIN
    employee m ON e.boss_number = m.Emp_no
WHERE
    e.name = @employee_name;
