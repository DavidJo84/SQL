/*
조인- 2개 이상의 테이블을 관련된 속성으로 합치는 것
이너조인- 조인에 참여한 관련된 속성의 튜플만을 보여주는 조인
외부조인- 조인에 참여하지 않은 튜플도 보여주는 조인
셀프조인- 자신의 테이블을 조인
크로스조인- 2개 이상의 테이블의 관련된 속성값을 카다시안 곱으로 조인

실습
create table member(
id int primary key,
name varchar(8),
addr varchar(13),
point int default 10);​

create table carNum(
id int,  	-- 고객아이디
carnum varchar(4),
infonum int	 -- 차종
);​

create table carInfo(  -- 자동차정보
infonum int,  -- 정보번호
infoname varchar(10) -- 차종
);

insert into member values (1,'홍길동','천안시',100);
insert into member values (2,'고길두','수원시',200);
insert into member values (3,'일지매','천안시',default);
insert into member values (4,'오지옹','오산시',10000);
insert into member values (7,'삼천포','청주시',30);
insert into member values (6,'우러크','천안시',6000);
insert into member values (5,'광어크','수원시',60);
insert into carNum values (1,'1111',1);
insert into carNum values (2,'1221',1);
insert into carNum values (3,'1133',2);
insert into carNum values (1,'5511',2);
insert into carNum values (1,'1441',1);
insert into carNum values (4,'8989',1);
insert into carInfo values (1,'승용');
insert into carInfo values (2,'suv');
insert into carInfo values (3,'RV');

member테이블
 id, name, addr, point
'1', '홍길동', '천안시', '100'
'2', '고길두', '수원시', '200'
'3', '일지매', '천안시', '10'
'4', '오지옹', '오산시', '10000'
'5', '광어크', '수원시', '60'
'6', '우러크', '천안시', '6000'
'7', '삼천포', '청주시', '30'

carnum테이블
id, carnum, infonum
'1', '1111', '1'
'2', '1221', '1'
'3', '1133', '2'
'1', '5511', '2'
'1', '1441', '1'
'4', '8989', '1'

carinfo테이블
infonum, infoname
'1', '승용'
'2', 'suv'
'3', 'RV'

다음 문제를 해결하고 query문을 덧글로 작성하시오.​

1. 회원이 소유한 자동차 번호를 출력하시오. (id, 이름, 주소)
select m.id, m.name, m.addr, c.carnum
from member m, carnum c
where m.id=c.id;

 id, name, addr, carnum
'1', '홍길동', '천안시', '1111'
'2', '고길두', '수원시', '1221'
'3', '일지매', '천안시', '1133'
'1', '홍길동', '천안시', '5511'
'1', '홍길동', '천안시', '1441'
'4', '오지옹', '오산시', '8989'

2. 자동차를 소유하지 않은 회원의 아이디와 이름을 출력하시오.
select m.id, m.name
from member m
left outer join carnum c
on m.id=c.id 
where c.carnum is null;

 id, name
'5', '광어크'
'6', '우러크'
'7', '삼천포'

3. 천안 사는 사람이 소유한 자동차 번호를 출력하시오.
select c.carnum
from member m, carnum c
where m.id=c.id and m.addr like '%천안%';

 carnum
'1111'
'1133'
'5511'
'1441'

4. 1441 번호의 자동차의 소유자의 이름은 무엇인가?
select m.name
from member m, carnum c
where m.id=c.id and c.carnum = '1441';

name
'홍길동'

5. 회원의 id가 큰 것부터 회원의 멤버 테이블의 정보를 출력하시오.
select * from member order by id desc;

 id, name, addr, point
'7', '삼천포', '청주시', '30'
'6', '우러크', '천안시', '6000'
'5', '광어크', '수원시', '60'
'4', '오지옹', '오산시', '10000'
'3', '일지매', '천안시', '10'
'2', '고길두', '수원시', '200'
'1', '홍길동', '천안시', '100'


6. 천안에 거주 하는 회원의 이름을 출력하시오.
select name from member where addr like '%천안%';

 name
'홍길동'
'일지매'
'우러크'

7. 천안에 거주 하지 않는 회원의 이름과 주소를 출력하시오.
select name, addr from member where addr not like '%천안%';

 name, addr
'고길두', '수원시'
'오지옹', '오산시'
'광어크', '수원시'
'삼천포', '청주시'

8. 천안엔 거주하는 사람들의 포인트를 모두 합하시오.
select sum(point) from member where addr like '%천안%';

# sum(point)
'6110'
 
9. 수원에 거주하거나 천안에 거주 하는 사람들의 이름, 주소를 출력하시오.
select name,addr from member where addr like '%천안%' or addr like '%수원%';

 name, addr
'홍길동', '천안시'
'고길두', '수원시'
'일지매', '천안시'
'광어크', '수원시'
'우러크', '천안시'

10. 포인트가 높은 사람순으로 출력하되, 포인트가 동일일 경우 id가 낮은 사람부터 출력하시오.
select * from member order by point desc , id asc;

 id, name, addr, point
'4', '오지옹', '오산시', '10000'
'6', '우러크', '천안시', '6000'
'2', '고길두', '수원시', '200'
'1', '홍길동', '천안시', '100'
'5', '광어크', '수원시', '60'
'7', '삼천포', '청주시', '30'
'3', '일지매', '천안시', '10'

11. 200이상 1000이하 의 포인트를 소유한 사람의 이름과 포인트를 출력하시오.
select name, point from member where point between 200 and 1000;

 name, point
'고길두', '200'

12. 도시별(천안시, 수원시 등)자동차 등록된 자동차 수를 구하시오.
select m.addr, count(*) from member m, carnum c
where m.id=c.id group by m.addr;

 addr, count(*)
'천안시', '4'
'수원시', '1'
'오산시', '1'

13. 천안 사는 사람의 정보를 출력하되 포인트가 6000 이상이면 포인트란에 vip라고 출력하시오.​
select id, name, addr, if (point>=6000, 'vip', point) point 
from member where addr like '%천안%';

 id, name, addr, point
'1', '홍길동', '천안시', '100'
'3', '일지매', '천안시', '10'
'6', '우러크', '천안시', 'vip'

-- upgrade
14. 도시별(천안시, 수원시 등)자동차 등록된 자동차 수를 구하시오. 
(단, 등록된 자동차의 수가 2이상인 도시와 자동차수만 출력하시오.
select m.addr, count(*) from member m, carnum c
where m.id=c.id group by m.addr having count(*)>=2;

 addr, count(*)
'천안시', '4'

15. 자동차를 소유한 회원의 정보를 출력하세요..(이름, 주소, 차번호, 차종)
select m.name, m.addr, c.carnum, i.infoname
from member m
inner join carnum c on m.id=c.id
inner join carinfo i on c.infonum=i.infonum;

name, addr, carnum, infoname
'홍길동', '천안시', '1111', '승용'
'고길두', '수원시', '1221', '승용'
'일지매', '천안시', '1133', 'suv'
'홍길동', '천안시', '5511', 'suv'
'홍길동', '천안시', '1441', '승용'
'오지옹', '오산시', '8989', '승용'

16. 회원이 소유한 자동차의 종류를 차종기준으로 각각 몇 대인지 출력하시오.
select i.infoname, count(c.carnum)
from carnum c
right outer join carinfo i on c.infonum=i.infonum group by i.infoname;

infoname, count(c.carnum)
'승용', '4'
'suv', '2'
'RV', '0'


17. 회원이 소유하지 않은 차종을 출력하시오.
select i.infoname
from carnum c
right outer join carinfo i on c.infonum=i.infonum
where c.infonum is null;

 infoname
'RV'


오후 실습

CREATE TABLE EMP
(EMPNO int not null,
ENAME VARCHAR(10),
JOB VARCHAR(9),
MGR int,
HIREDATE datetime,
SAL int,
COMM int,
DEPTNO int);
--------------------------------
INSERT INTO EMP VALUES
(7369,'SMITH','CLERK',7902,'1980-12-17',800,null,20);
INSERT INTO EMP VALUES
(7499,'ALLEN','SALESMAN',7698,'1981-02-20',1600,300,30);
INSERT INTO EMP VALUES
(7521,'WARD','SALESMAN',7698,'1981-02-22',1250,200,30);
INSERT INTO EMP VALUES
(7566,'JONES','MANAGER',7839,'1981-04-02',2975,30,20);
INSERT INTO EMP VALUES
(7654,'MARTIN','SALESMAN',7698,'1981-09-28',1250,300,30);
INSERT INTO EMP VALUES
(7698,'BLAKE','MANAGER',7839,'1981-04-01',2850,null,30);
INSERT INTO EMP VALUES
(7782,'CLARK','MANAGER',7839,'1981-06-01',2450,null,10);
INSERT INTO EMP VALUES
(7788,'SCOTT','ANALYST',7566,'1982-10-09',3000,null,20);
INSERT INTO EMP VALUES
(7839,'KING','PRESIDENT',null,'1981-11-17',5000,3500,10);
INSERT INTO EMP VALUES
(7844,'TURNER','SALESMAN',7698,'1981-09-08',1500,0,30);
INSERT INTO EMP VALUES
(7876,'ADAMS','CLERK',7788,'1983-01-12',1100,null,20);
INSERT INTO EMP VALUES
(7900,'JAMES','CLERK',7698,'1981-10-03',950,null,30);
INSERT INTO EMP VALUES
(7902,'FORD','ANALYST',7566,'1981-10-3',3000,null,20);
INSERT INTO EMP VALUES
(7934,'MILLER','CLERK',7782,'1982-01-23',1300,null,10);
--------------------------------
CREATE TABLE DEPT
(DEPTNO int,
DNAME VARCHAR(14),
LOC VARCHAR(13) );
--------------------------------
INSERT INTO DEPT VALUES (10,'ACCOUNTING','NEW YORK');
INSERT INTO DEPT VALUES (20,'RESEARCH','DALLAS');
INSERT INTO DEPT VALUES (30,'SALES','CHICAGO');
INSERT INTO DEPT VALUES (40,'OPERATIONS','BOSTON');
--------------------------------
CREATE TABLE SALGRADE
( GRADE int,
LOSAL int,
HISAL int );
--------------------------------
INSERT INTO SALGRADE VALUES (1,700,1200);
INSERT INTO SALGRADE VALUES (2,1201,1400);
INSERT INTO SALGRADE VALUES (3,1401,2000);
INSERT INTO SALGRADE VALUES (4,2001,3000);
INSERT INTO SALGRADE VALUES (5,3001,9999);

emp테이블
EMPNO, ENAME, JOB(직위),MGR, HIREDATE,  SAL(월급), COMM, DEPTNO(부서번호)
'7369', 'SMITH', 'CLERK', '7902', '1980-12-17 00:00:00', '800', NULL, '20'
'7499', 'ALLEN', 'SALESMAN', '7698', '1981-02-20 00:00:00', '1600', '300', '30'
'7521', 'WARD', 'SALESMAN', '7698', '1981-02-22 00:00:00', '1250', '200', '30'
'7566', 'JONES', 'MANAGER', '7839', '1981-04-02 00:00:00', '2975', '30', '20'
'7654', 'MARTIN', 'SALESMAN', '7698', '1981-09-28 00:00:00', '1250', '300', '30'
'7698', 'BLAKE', 'MANAGER', '7839', '1981-04-01 00:00:00', '2850', NULL, '30'
'7782', 'CLARK', 'MANAGER', '7839', '1981-06-01 00:00:00', '2450', NULL, '10'
'7788', 'SCOTT', 'ANALYST', '7566', '1982-10-09 00:00:00', '3000', NULL, '20'
'7839', 'KING', 'PRESIDENT', NULL, '1981-11-17 00:00:00', '5000', '3500', '10'
'7844', 'TURNER', 'SALESMAN', '7698', '1981-09-08 00:00:00', '1500', '0', '30'
'7876', 'ADAMS', 'CLERK', '7788', '1983-01-12 00:00:00', '1100', NULL, '20'
'7900', 'JAMES', 'CLERK', '7698', '1981-10-03 00:00:00', '950', NULL, '30'
'7902', 'FORD', 'ANALYST', '7566', '1981-10-03 00:00:00', '3000', NULL, '20'
'7934', 'MILLER', 'CLERK', '7782', '1982-01-23 00:00:00', '1300', NULL, '10'

dept테이블
DEPTNO,DNAME,     LOC
'10', 'ACCOUNTING', 'NEW YORK'
'20', 'RESEARCH', 'DALLAS'
'30', 'SALES', 'CHICAGO'
'40', 'OPERATIONS', 'BOSTON'

salgrade테이블
GRADE, LOSAL, HISAL
'1', '700', '1200'
'2', '1201', '1400'
'3', '1401', '2000'
'4', '2001', '3000'
'5', '3001', '9999'

문제



--1. 사원테이블에서 직위별 최소 월급을 구하되 직위가 CLERK인 것만 출력하라.
select job,min(sal) from emp where job='clerk' group by job;

 job, min(sal)
'CLERK', '800'

--2. 커미션이 책정된 사원은 모두 몇 명인가?
select count(*) from emp where comm is not null;

count(*)
'6'

--3. 직위가 'SALESMAN'이고 월급이 1000이상인 사원의 이름과 월급을 출력하라.
select ename, sal from emp where job='salesman' and sal>=1000;

ename, sal
'ALLEN', '1600'
'WARD', '1250'
'MARTIN', '1250'
'TURNER', '1500'


--4. 부서별 평균월급을 출력하되, 평균월급이 2000보다
-- 큰 부서의 부서번호와 평균월급을 출력하라.
select deptno, avg(sal) from emp group by deptno having avg(sal)>2000;

deptno, avg(sal)
'20', '2175.0000'
'10', '2916.6667'


--5. 직위가 MANAGER인 사원을 뽑는데 월급이 높은 사람
-- 순으로 이름, 직위, 월급을 출력하라.
select ename, job, sal from emp where job='manager' order by sal desc;

ename, job, sal
'JONES', 'MANAGER', '2975'
'BLAKE', 'MANAGER', '2850'
'CLARK', 'MANAGER', '2450'

--6. 각 직위별로 총월급을 출력하되 월급이 낮은 순으로 출력하라.
select job,sum(sal) from emp group by job order by sum(sal) asc;

 job, sum(sal)
'CLERK', '4150'
'PRESIDENT', '5000'
'SALESMAN', '5600'
'ANALYST', '6000'
'MANAGER', '8275'

--7. 직위별 총월급을 출력하되, 직위가 'MANAGER'인 사원들은 제외하라.
-- 그리고 그 총월급이 5000보다 큰 직위와 총월급만 출력하라.
select job,sum(sal) from emp where job!='manager' group by job having sum(sal)>5000;

job, sum(sal)
'SALESMAN', '5600'
'ANALYST', '6000'

--8. 직위별 최대월급을 출력하되, 직위가 'CLERK'인 사원들은 제외하라.
-- 그리고 그 최대월급이 2000 이상인 직위와 최대월급을 최대 월급이
-- 높은 순으로 정렬하여 출력하라.
select job, max(sal) from emp where job!= 'calrk' 
group by job having max(sal)>2000 order by max(sal) desc;

job, max(sal)
'PRESIDENT', '5000'
'ANALYST', '3000'
'MANAGER', '2975'

-- 11. 사원들의 이름, 부서번호, 부서이름을 출력하라.
select e.ename, e.deptno, d.dname from emp e
left outer join dept d on e.deptno=d.deptno;

ename	deptno	dname
SMITH	20	RESEARCH
ALLEN	30	SALES
WARD	30	SALES
JONES	20	RESEARCH
MARTIN	30	SALES
BLAKE	30	SALES
CLARK	10	ACCOUNTING
SCOTT	20	RESEARCH
KING	10	ACCOUNTING
TURNER	30	SALES
ADAMS	20	RESEARCH
JAMES	30	SALES
FORD	20	RESEARCH
MILLER	10	ACCOUNTING

-- 12. DALLAS에서 근무하는 사원의 이름, 직위, 부서번호, 부서이름을 출력하라.
select e.ename, e.job, e.deptno, d.dname from emp e
left outer join dept d on e.deptno=d.deptno where d.loc='dallas';

ename	job	deptno	dname
SMITH	CLERK	20	RESEARCH
JONES	MANAGER20	RESEARCH
SCOTT	ANALYST	20	RESEARCH
ADAMS	CLERK	20	RESEARCH
FORD	ANALYST	20	RESEARCH

-- 13. 이름에 'A'가 들어가는 사원들의 이름과 부서이름을 출력하라.
select e.ename, d.dname from emp e
left outer join dept d on e.deptno=d.deptno
where e.ename like '%a%';

ename	dname
ALLEN	SALES
WARD	SALES
MARTIN	SALES
BLAKE	SALES
CLARK	ACCOUNTING
ADAMS	RESEARCH
JAMES	SALES

-- 14. 사원이름과 그 사원이 속한 부서의 부서명, 그리고 월급을 
--출력하는데 월급이 3000이상인 사원을 출력하라.
select e.ename, d.dname, e.sal from emp e
left outer join dept d on e.deptno=d.deptno where e.sal >=3000;

ename	dname	sal
SCOTT	RESEARCH	3000
KING	ACCOUNTING	5000
FORD	RESEARCH	3000

-- 15. 직위가 'SALESMAN'인 사원들의 직위와 그 사원이름, 그리고
-- 그 사원이 속한 부서 이름을 출력하라.
select e.job, e.ename, d.dname from emp e
left outer join dept d on e.deptno=d.deptno
where e.job ='salesman';

job	ename	dname
SALESMAN	ALLEN	SALES
SALESMAN	WARD	SALES
SALESMAN	MARTIN	SALES
SALESMAN	TURNER	SALES

-- 16. 커미션이 책정된 사원들의 사원번호, 이름, 연봉, 연봉+커미션,
-- 급여등급을 출력하되, 각각의 컬럼명을 '사원번호', '사원이름',
-- '연봉','실급여', '급여등급'(기본급)으로 하여 출력하라.
1. case문
select empno 사원번호 , ename 사원이름 , e.sal*12 연봉 , e.sal*12+e.comm 실급여, 
(case when sal between 700 and 1200 then '1' 
when sal between 1201 and 1400 then '2'
when sal between 1401 and 2000 then '3'
when sal between 2001 and 3000 then '4'
when sal between 3001 and 9999 then '5'end) 급여등급 
from emp where comm is not null;

2.cross join
select  e.empno 사원번호 , e.ename 사원이름 , e.sal*12 연봉 , e.sal*12+e.comm 실급여, 
s.grade 급여등급 
from emp e, salgrade s
where e.sal between s.losal and s.hisal and e.comm is not null;

3.inner join
select e.empno 사원번호 , e.ename 사원이름 , e.sal*12 연봉 , e.sal*12+e.comm 실급여, 
s.grade 급여등급 
from emp e inner join salgrade s 
where e.sal between s.losal and s.hisal and e.comm is not null;

사원번호	사원이름	연봉	실급여	급여등급
7499	ALLEN	19200	19500	3
7521	WARD	15000	15200	2
7566	JONES	35700	35730	4
7654	MARTIN	15000	15300	2
7839	KING	60000	63500	5
7844	TURNER	18000	18000	3

-- 16-1. 모든 사원들의 사원번호, 이름, 연봉, 연봉+커미션,
-- 급여등급을 출력하되, 각각의 컬럼명을 '사원번호', '사원이름',
-- '연봉','실급여', '급여등급'(기본급)으로 하여 출력하라.
1.if문 사용
select e.empno 사원번호 , e.ename 사원이름 , e.sal*12 연봉 , 
e.sal*12 + if(e.comm is null, 0,e.comm) 실급여, 
s.grade 급여등급 
from emp e inner join salgrade s 
where e.sal between s.losal and s.hisal ;

2.ifnull 사용
select e.empno 사원번호 , e.ename 사원이름 , e.sal*12 연봉 , 
e.sal*12 + ifnull(e.comm,0) 실급여, 
s.grade 급여등급 
from emp e inner join salgrade s 
where e.sal between s.losal and s.hisal;

사원번호	사원이름	연봉	실급여	급여등급
7369	SMITH	9600	9600	1
7499	ALLEN	19200	19500	3
7521	WARD	15000	15200	2
7566	JONES	35700	35730	4
7654	MARTIN	15000	15300	2
7698	BLAKE	34200	34200	4
7782	CLARK	29400	29400	4
7788	SCOTT	36000	36000	4
7839	KING	60000	63500	5
7844	TURNER	18000	18000	3
7876	ADAMS	13200	13200	1
7900	JAMES	11400	11400	1
7902	FORD	36000	36000	4
7934	MILLER	15600	15600	2

-- 17. 부서번호가 10번인 사원들의 부서번호, 부서이름, 사원이름,
-- 월급, 급여등급을 출력하라.
select e.deptno, d.dname, e.ename, e.sal, s.grade 
from emp e inner join salgrade s, dept d 
where e.sal between s.losal and s.hisal and e.deptno=d.deptno and e.deptno='10';

# deptno	dname	ename	sal	grade
10	ACCOUNTING	CLARK	2450	4
10	ACCOUNTING	KING	5000	5
10	ACCOUNTING	MILLER	1300	2

-- 18. 부서번호가 10번, 20번인 사원들의 부서번호, 부서이름, 사원이름,
-- 월급, 급여등급을 출력하라. 그리고 그 출력된 결과물을
-- 부서번호가 낮은 순으로, 월급이 높은 순으로 정렬하라.
select e.deptno, d.dname, e.ename, e.sal, s.grade 
from emp e inner join salgrade s, dept d 
where e.sal between s.losal and s.hisal and e.deptno=d.deptno and (e.deptno='10'
or d.deptno='20') order by d.deptno asc, e.sal desc;

deptno	dname		ename	sal	grade
10	ACCOUNTING	KING	5000	5
10	ACCOUNTING	CLARK	2450	4
10	ACCOUNTING	MILLER	1300	2
20	RESEARCH	FORD	3000	4
20	RESEARCH	SCOTT	3000	4
20	RESEARCH	JONES	2975	4
20	RESEARCH	ADAMS	1100	1
20	RESEARCH	SMITH	800	1


-- 19. 사원번호와 사원이름, 그리고 그 사원을 관리하는 관리자의 
-- 사원번호와 사원이름을 출력하되 각각의 컬럼명을 '사원번호',
-- '사원이름', '관리자번호', '관리자이름'으로 하여 출력하라.
select e.empno 사원번호, e.ename 사원이름, e.mgr 관리자번호, 
m.ename 관리자이름 from emp e left outer join emp m
on e.mgr=m.empno;

사원번호	사원이름	관리자번호	관리자이름
7369	SMITH	7902		FORD
7499	ALLEN	7698		BLAKE
7521	WARD	7698		BLAKE	
7566	JONES	7839		KING	
7654	MARTIN	7698		BLAKE
7698	BLAKE	7839		KING
7782	CLARK	7839		KING
7788	SCOTT	7566		JONES
7839	KING	NULL		NULL	
7844	TURNER	7698		BLAKE
7876	ADAMS	7788		SCOTT
7900	JAMES	7698		BLAKE
7902	FORD	7566		JONES
7934	MILLER	7782		CLARK
*/