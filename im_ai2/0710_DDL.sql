# DDL
# DB생성 및 테이블 생성, 수정, 타입변경 ... 
# 문제 1. 다음 요구사항을 만족하는 MySQL 데이터베이스를 생성하고, 테이블을 만드세요.
create database company_db;
 
use company_db;

CREATE TABLE test( 
	id INT PRIMARY KEY AUTO_INCREMENT,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	email VARCHAR(100) UNIQUE,
	date_of_birth DATE,
	date_of_joining DATE,
	department VARCHAR(50),
	salary DECIMAL(10, 2)
);

show columns from test;

# 문제 2. test 테이블에 직원의 직급을 저장할 rank 컬럼을 추가하세요. 
# 이 컬럼은 최대 20자의 가변 길이 문자열을 저장할 수 있어야 합니다.
ALTER TABLE test ADD COLUMN em_rank varchar(20) NOT NULL;
ALTER TABLE test ADD COLUMN `rank` varchar(20) NOT NULL; # 예약어 변수로 쓸 때 esc키 밑에 어퍼스트로 키 사용

# 문제 3. test 테이블의 salary 컬럼의 데이터 타입을 변경하여 
# 최대 15자리 숫자를 소수점 이하 두 자리까지 저장할 수 있도록 수정하세요.
alter table test modify salary decimal(15,2);

# 문제 4. test 테이블의 date_of_joining 컬럼의 이름을 hire_date로 변경하고, 
# 데이터 타입을 TIMESTAMP로 변경하세요.
alter table test change column date_of_joining hire_date TIMESTAMP;

# 문제 5. test 테이블에서 rank 컬럼을 삭제하세요.
alter table test drop column em_rank;

# 문제 6. test 테이블의 이름을 staff로 변경하세요.
alter table test rename staff;

#=============================================================================================