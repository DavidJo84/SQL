/*DCL 
Data Control Language
-계정생성, 권한부여, 회수, 제어, 복구
-create user: 계정생성
-grant: 권한부여
-rollback: 최근 커밋까지 복구(ram에서 작업 취소)
-commit: 물리적인 디스크로 저장, 작업완료(ram에서 hdd로 저장)
*mysql은 기본값이 autocommit으로 설정되어 자동 커밋을 한다.

계정생성과 권한이 필요한 이유
지금까지 우리가 사용한 계정은 root계정(프로그램의 최고 관리자)
만약 새로운 데이터베이스를 구축한다면 그 사용자에세 root를 알려주지 않음.
root는 모든 DB에 접근 가능하기 때문.
즉, 사요용자가 본인이 사용해야할 DB만 사용해야 함.
회사별로직급에 따라 조회 권한이 다를 수 있으므로 
DB에 접근할 수 있는 권한을 생성하고 부여해야 한다.
권한은 회사마다 지침이 있고 
이는 개별테이블 또는 데이터 베이스 전체가 대상이 될 수 있다.
권한은 CRUD 작업을 각각 부여할 수 있으며 이중 U D의 권한이 가장 높다.
예) 회원테이블이 있다면 관리자는 CRUD 모든 권한을 갖지만
조회만 하는 직원은 R 권한만 가져야 한다.
이것은 DB 전문가(DBA)가 해야할 일이므로 개발자는 개념만 이해해도 된다.


1.commit

오토커밋 on상태 확인
select @@autocommit;
+--------------+
| @@autocommit |
+--------------+
|            1 |
+--------------+

오토커밋 off
set @@autocommit=0;

오토커밋 off상태 확인
select @@autocommit;
+--------------+
| @@autocommit |
+--------------+
|            0 |
+--------------+

오토커밋 off 상태에서 자료 삽입
insert into t1 values(default,'park');

자료삽입 확인
select * from t1;
+----+------+
| no | name |
+----+------+
|  1 | lee  |
|  2 | kim  |
|  3 | park |
+----+------+

롤백
rollback;

삽입 자료 사라짐
select * from t1;
+----+------+
| no | name |
+----+------+
|  1 | lee  |
|  2 | kim  |
+----+------+

롤백은 최근 마지막 커밋작업까지 복구한다.

commit과 rollback은 DML에서만 가능 creat, drop, alter는 동작하지 않는다.
오토커밋의 시점은 쿼리문 하나당 자동 커밋.

mysql은 저장시점을 선택할 수 있다.
예) savepoint a; 라고 저장시점을 만든 후
rollback to savepoint a;하면 savepoint a 지점까지 복구 됨

사용자계정
root@localhost
(호스트이름, 도메인 주소(ip주소로변경 가능:127.0.0.1-루프백주소, 자기자신에 대한 주소))


JOIN 조인

데이터의 중복은 저장공간 낭비, 데이터 무결성에 문제가 된다.
그래서 테이블을 분리하여 이러한 문제를 해결하지만
실제 시스템을 사용하는 입장에서는 모든 자료가 한눈에 보이는게 좋을 수 있다.
그래서 정규화 된것을 다시 합쳐야 한다. 이것을 역정규화라고 하며
이 기술을 조인이라고 한다.

조인은 무엇인가?
데이터의 중복으로 발생되는 문제(저장공간 낭비, 데이터무결성)를 
해결하기 위해 나누어진 테이블(정규화)을 사용자가 보기 편하도록 
다시 합쳐서(역정규화) 보여주는 기술입니다.
2개 이상의 테이블을 관련된 속성으로 합칩니다.

조인의 종류
cross : 모든 경우의 수를 곱함(카다시안 곱)

inner : 같은 속성으로 테이블을 합친 것(조인이 된 튜플만 나옴)

outer : 같은 속성으로 테이블을 합치고 
         조인에 참여하지 않은 튜플까지 출력
left outer join : 조인에 참여한 튜플 외에 
왼쪽 테이블 기준으로 조인에 참여하지 않은 튜플도 출력
오른쪽은 NULL 값으로 대체
right outer join:  조인에 참여한 튜플 외에 
오른쪽 테이블 기준으로 조인에 참여하지 않은 튜플도 출력
왼쪽은 NULL 값으로 대체

self : 자기 자신을 자기 자신과 조인

테이블 작성
create table dept(
deptno varchar(4) primary key,
dname varchar(10),
loc varchar(10));

insert into dept values ('1111','영업','서울');
insert into dept values ('2222','개발','수원');
insert into dept values ('3333','기술지원','용인');
insert into dept values ('4444','유지보수','성남');

create table emp(
empno varchar(4),
ename varchar(10),
sal double,
deptno varchar(4),
constraint FK_emp_dept
foreign key (deptno) references dept(deptno)
);

insert into emp values ('3211','홍길동',2200.12,'1111');
insert into emp values ('3212','일지매',2400.11,'2222');
insert into emp values ('3213','이과수',3200.45,'3333');
insert into emp values ('3214','여기서',2200.99,null);
insert into emp values ('3215','비온후',2300.12,'2222');
insert into emp values ('3216','짱많이',2700.57,'1111');
insert into emp values ('3217','우당탕',3400.21,null);
insert into emp values ('3218','비대면',2600.77,'2222');
insert into emp values ('3219','아무나',4700.37,'1111');

create table city(
loc varchar(10),
info varchar(20));

insert into city values('서울','한국의수도');
insert into city values('수원','휴먼이있다');

조인의 예시
A. cross join
select emp.ename, emp.sal, emp.deptno, dept.deptno,dept.dname, dept.loc
from emp, dept;

B. inner join 

기본급이 2600 이상인 사람의 이름과 기본급, 직무, 근무지를 출력하시오.

1. where 사용
select emp.ename, emp.sal, emp.deptno, dept.deptno,dept.dname, dept.loc
from emp, dept
where emp.deptno=dept.deptno and emp.sal>=2600;

2. where 별칭 사용(가장 많이 쓰임)
select e.ename, e.sal, e.deptno, d.deptno, d.dname, d.loc
from emp e, dept d
where e.deptno=d.deptno and e.sal>=2600;

3. inner join, on 사용
select emp.ename, emp.sal, emp.deptno, dept.deptno,dept.dname, dept.loc
from emp
inner join dept
on emp.deptno=dept.deptno
where emp.sal>=2600;

4.inner join, on 별칭 사용
select e.ename, e.sal, e.deptno, d.deptno, d.dname, d.loc
from emp e
inner join dept d
on e.deptno=d.deptno
where e.sal>=2600;


C. outer join

모든 직원의 이름, 기본급, 직무와 근무지 출력

left outer join

select e.ename, e.sal, e.deptno, d.deptno, d.dname, d.loc
from emp e
left outer join dept d
on e.deptno=d.deptno;

right outer join
select e.ename, e.sal, e.deptno, d.deptno, d.dname, d.loc
from dept d
right outer join emp e
on e.deptno=d.deptno;


확인 문제

1. loc는 근무지이다. 근무지가 서울인 사람의 이름과 직무, 근무위치를 출력하시오.
select e.ename, d.dname, d.loc
from emp e, dept d
where e.deptno=d.deptno and d.loc = '서울';

아무나	영업	서울
홍길동	영업	서울
짱많이	영업	서울

2. 사원중 근무가 배정되지 않은 사람의 이름과 급여를 구하시오.
select e.ename, e.sal
from emp e
left outer join dept d
on e.deptno=d.deptno
where d.dname is null

우당탕	3400.21
여기서	2200.99

3. 근무가 배정되지 않은 사원중 급여가 3000이상인 사람의 이름을 구하시오.
select e.ename
from emp e
left outer join dept d
on e.deptno=d.deptno
where d.dname is null and e.sal >=3000;

우당탕

추가문제

1. 개발부 직무의 사람이름, 급여, 근무위치를 출력하시오
select e.ename, e.sal, d.loc
from emp e, dept d
where e.deptno=d.deptno and dname like '%개발%';

일지매	2400.11	수원
비온후	2300.12	수원
비대면	2600.77	수원

2. 모든직원의 평균급여를 출력하시오
select avg(sal) from emp;

avg(sal)
'2855.967777777778'

3. 서울에서 근무하는 직원의 평균 급여를 출력하시오
select avg(e.sal) from emp e, dept d 
where e.deptno=d.deptno and loc='서울';

avg(e.sal)
3200.353333333333

4. 직무를 담당하지 않는 사람의 이름은 무엇인가?
select e.ename from emp e
left outer join dept d on e.deptno=d.deptno
where d.dname is null

ename
여기서
우당탕

5. 영업을 담당하는 사람 중 최고 급여를 출력하시오
select max(e.sal) from emp e, dept d 
where e.deptno=d.deptno and d.dname='영업';

max(e.sal)
'4700.37'


6. 직무가 있는 직원 중 이름, 급여, 근무부서, 근무지, 근무지소개를 출력하되
근무지 소개가 없는 경우는 출력하지 마시오.
select e.ename, e.sal, d.dname, d.loc, c.info
from emp e, dept d, city c
where e.deptno=d.deptno and d.loc=c.loc;

ename,   sal,    dname,   loc,    info
'아무나', '4700.37', '영업', '서울', '한국의수도'
'홍길동', '2200.12', '영업', '서울', '한국의수도'
'짱많이', '2700.57', '영업', '서울', '한국의수도'
'일지매', '2400.11', '개발', '수원', '휴먼이있다'
'비온후', '2300.12', '개발', '수원', '휴먼이있다'
'비대면', '2600.77', '개발', '수원', '휴먼이있다'

7. 직무가 있는 직원 중 이름, 급여, 근무부서, 근무지, 근무지 소개를 출력하되 
근무지 소개가 없는 경우도 출력하시오
select e.ename, e.sal, d.dname, d.loc, c.info from emp e 
left outer join dept d on e.deptno=d.deptno
left outer join city c on d.loc=c.loc
where d.dname is not null;

ename,   sal,    dname,  loc,    info
'아무나', '4700.37', '영업', '서울', '한국의수도'
'홍길동', '2200.12', '영업', '서울', '한국의수도'
'짱많이', '2700.57', '영업', '서울', '한국의수도'
'일지매', '2400.11', '개발', '수원', '휴먼이있다'
'비온후', '2300.12', '개발', '수원', '휴먼이있다'
'비대면', '2600.77', '개발', '수원', '휴먼이있다'
'이과수', '3200.45', '기술지원', '용인', NULL


8. 직무가 있는 직원 중 직무별 근무자의 인원을 출력하시오. 출력은 직무인원
select e.dname, count(*) 직무인원 from emp e, dept d 
where e.deptno=d.deptno group by d.dname;

dname, 직무인원
'영업',      '3'
'개발',      '3'
'기술지원', '1'


9. 모든 직원의 이름, 급여, 부서명, 지역을 급여가 낮은 순서대로 출력하세요
select e.ename, e.sal, d.dname, d.loc from emp e
left outer join dept d 
on e.deptno=d.deptno order by e.sal asc;

# ename, sal, dname, loc
홍길동, 2200.12, 영업, 서울
여기서, 2200.99, null,  null
비온후, 2300.12, 개발, 수원
일지매, 2400.11, 개발, 수원
비대면, 2600.77, 개발, 수원
짱많이, 2700.57, 영업, 서울
이과수, 3200.45, 기술지원, 용인
우당탕, 3400.21, null , null
아무나, 4700.37, 영업, 서울


10. 급여가 2300이상인 사람의 수를 직무별로 카운팅 하세요. 출력은 직무 인원
select d.dname, count(*) 직무인원 from emp e, dept d 
where e.deptno=d.deptno and e.sal >=2300 group by d.dname;

dname, 직무인원
'영업',       '2'
'개발',       '3'
'기술지원',  '1'*/

