/*A.distinct: select 절에 사용하며 중복된 튜플은 하나만 출력한다.

예)
직원들의 급여를 출력(중복된 튜플은 대표 1개만)하시오. 단 deptno가 null인 값은 제외.
select distinct sal from emp where deptno is not null;

손코딩 문제
1.직무가 있는 직원들의 dname과 loc를 출력하시오
select d.dname, d.loc from emp e, dept d where e.deptno=d.deptno;

2. 연봉이 2500 이상인 직원이 있는 부서(deptno)를 출력하시오. 
중복된 튜플은 대표 하나만 출력하시오.
select distinct deptno from emp where sal >=2500;

3. 부서가 있는 직원 중 연봉이 2500이상인 직원의 deptno와 그 인원수를 출력하시오
select deptno,count(*) from emp 
where deptno is not null and sal>=2500 group by deptno;

B.서브쿼리
서브쿼리는 본쿼리 내부에 괄호로 작성

select절               스칼라서브쿼리(결과값이 반드시 하나여야 한다)
from절                인라인뷰(서브쿼리 결과값을 테이블로 사용, 별칭지정해야함)
where절               서브쿼리 결과값을 조건으로 사용, 
                         서브쿼리 결과가 단일행이면 =,<,> 등의 단일 비교 연산자를 사용,
                         단일행이 아닌 두개 이상이면 in/not in, any/all  연산자를 사용.
group by having절
order by절           서브쿼리 사용할 수 없음.

서브쿼리(=자식 쿼리, 내부쿼리)- 메인쿼리의 컬럼을 사용할 수 있다.
메인쿼리(=부모쿼리, 외부쿼리)- 서브쿼리의 컬럼을 사용할 수 없다.

연습문제
1. 홍길동과 같은 부서에 속한 사람의 이름을 출력하시오.
select ename from emp where deptno = 
(select deptno from emp where ename='홍길동');

ename
아무나
홍길동
짱많이

2. 평균급여보다 높은 급여를 받는 사람의 이름과 급여를 출력하시오.
select ename, sal from emp where sal>(select avg(sal) from emp);

ename	sal
아무나	4700.37
이과수	3200.45
우당탕	3400.21

3. 짱많이 보다 높은 급여를 받는 사람의 이름과 급여를 출력하시오.
select ename, sal from emp where sal>(select sal from emp where ename='짱많이');

ename	sal
아무나	4700.37
이과수	3200.45
우당탕	3400.21

4. 부서가 있는 사람중 평균급여보다 높은 사람이 부서별로 몇명있는가? 
부서번호, 인원수로 출력
select deptno, count(*) from emp 
where sal>(select avg(sal) from emp) and deptno is not null group by deptno;

deptno	count(*)
1111	1
3333	1

5.일지매보다 높은 급여를 받는 사람은 부서별로 몇명있습니까?(부서 null은 제외)
select deptno, count(*) from emp where sal>
(select sal from emp where ename='일지매') and deptno is not null 
group by deptno;

deptno	count(*)
1111	2
2222	1
3333	1

6.부서가 있는 모든 부서의 (deptno)의 인원수를 출력하시오. 
단 부서의 평균이 전체평균보다 높은 부서만 출력하시오.
select deptno, count(*) from emp 
where deptno is not null 
group by deptno having avg(sal)>(select avg(sal) from emp);

deptno	count(*)
1111	3
3333	1

7. 홍길동하고 같은 부서에 속한 사람의 이름을 인라인뷰로 구하시오
select e.ename from emp e,(select * from emp) e1
where e.deptno=e1.deptno and e1.ename='홍길동';

8. 직원들의 정보 출력 ename, sal, dname (스칼라서브쿼리)
select e.ename, e.sal, 
(select d.dname from dept d where d.deptno=e.deptno ) dname
 from emp e;

ename	sal	dname
아무나	4700.37	영업
홍길동	2200.12	영업
일지매	2400.11	개발
이과수	3200.45	기술지원
여기서	2200.99	NULL
비온후	2300.12	개발
짱많이	2700.57	영업
우당탕	3400.21	NULL
비대면	2600.77	개발

9. 각부서별(deptno) 최고급여를 받는 사람이름(null 제외)
select ename from emp where sal in (select max(sal) from emp where deptno is not null
 group by deptno);

ename
아무나
이과수
비대면


오후 실습

emp 테이블
EMPNO	ENAME	JOB		MGR	HIREDATE		SAL	COMM	DEPTNO
7369	SMITH	CLERK		7902	1980-12-17 00:00:00	800		20
7499	ALLEN	SALESMAN	7698	1981-02-20 00:00:00	1600	300	30
7521	WARD	SALESMAN	7698	1981-02-22 00:00:00	1250	200	30
7566	JONES	MANAGER	7839	1981-04-02 00:00:00	2975	30	20
7654	MARTIN	SALESMAN	7698	1981-09-28 00:00:00	1250	300	30
7698	BLAKE	MANAGER	7839	1981-04-01 00:00:00	2850		30
7782	CLARK	MANAGER	7839	1981-06-01 00:00:00	2450		10
7788	SCOTT	ANALYST		7566	1982-10-09 00:00:00	3000		20
7839	KING	PRESIDENT		1981-11-17 00:00:00	5000	3500	10
7844	TURNER	SALESMAN	7698	1981-09-08 00:00:00	1500	0	30
7876	ADAMS	CLERK		7788	1983-01-12 00:00:00	1100		20
7900	JAMES	CLERK		7698	1981-10-03 00:00:00	950		30
7902	FORD	ANALYST		7566	1981-10-03 00:00:00	3000		20
7934	MILLER	CLERK		7782	1982-01-23 00:00:00	1300		10


dept 테이블
DEPTNO	DNAME		LOC
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	CHICAGO
40	OPERATIONS	BOSTON

salgrade 테이블
GRADE	LOSAL	HISAL
1	700	1200
2	1201	1400
3	1401	2000
4	2001	3000
5	3001	9999

1. 평균 급여보다 높은 사람의 급여를 받는 사람의 이름과 급여
select ename, sal from emp where sal>(select avg(sal) from emp);
ename	sal
JONES	2975
BLAKE	2850
CLARK	2450
SCOTT	3000
KING	5000
FORD	3000

2. 각 직무별 급여가 1000이상인 직무와 인원수
select job, count(*) from emp where sal>=1000 group by job;
job		count(*)
SALESMAN	4
MANAGER	3
ANALYST		2
PRESIDENT	1
CLERK		2

3. deptno가 20인 사람중에 평균(20그룹평균)급여보다 많이 받는 사람의 이름과, 급여와 부서번호
select ename, sal, deptno from emp where deptno='20'and sal>(select avg(sal) from emp where deptno='20');
ename	sal	deptno
JONES	2975	20
SCOTT	3000	20
FORD	3000	20

4. deptno가 20인 사람중의 평균(전체평균)급여보다 많이 받는 사람의 이름과, 급여와 부서번호
select ename, sal, deptno from emp where deptno='20'and sal>
 (select avg(sal) from emp);
ename	sal	deptno
JONES	2975	20
SCOTT	3000	20
FORD	3000	20

5. deptno가 20인 사람중의 평균(전체평균)급여보다 많이 받는 사람의 이름과, 급여와 부서번호와 부서명
 select e.ename, e.sal, e.deptno, d.dname from emp e, dept d 
 where e.deptno=d.deptno and e.deptno='20' and e.sal>
 (select avg(sal) from emp);
ename	sal	deptno	dname
FORD	3000	20	RESEARCH
SCOTT	3000	20	RESEARCH
JONES	2975	20	RESEARCH

6. smith보다 높은 급여를 받는 사람의 이름과 급여
select ename, sal from emp where sal>(select sal from emp where ename='smith');
ename	sal
ALLEN	1600
WARD	1250
JONES	2975
MARTIN	1250
BLAKE	2850
CLARK	2450
SCOTT	3000
KING	5000
TURNER	1500
ADAMS	1100
JAMES	950
FORD	3000
MILLER	1300

7. 모든 직원의 이름과 직무, 입사년도(hiredata)를 출력하시오. 입사년도는 년월일만 출력한다.
select ename, job, date_format(hiredate, '%Y-%m-%d') hiredate from emp;
ename	job		hiredate
SMITH	CLERK		1980-12-17
ALLEN	SALESMAN	1981-02-20
WARD	SALESMAN	1981-02-22
JONES	MANAGER	1981-04-02
MARTIN	SALESMAN	1981-09-28
BLAKE	MANAGER	1981-04-01
CLARK	MANAGER	1981-06-01
SCOTT	ANALYST		1982-10-09
KING	PRESIDENT	1981-11-17
TURNER	SALESMAN	1981-09-08
ADAMS	CLERK		1983-01-12
JAMES	CLERK		1981-10-03
FORD	ANALYST		1981-10-03
MILLER	CLERK		1982-01-23

8. 각 직원이 받는 급여의 grade를 서브쿼리로 해결하세요.   직원명, 급여, 급여등급
select e.ename,e.sal,
 (select grade from salgrade s where e.sal between s.losal and s.hisal) grade 
 from emp e; 
ename	sal	grade
SMITH	800	1
ALLEN	1600	3
WARD	1250	2
JONES	2975	4
MARTIN	1250	2
BLAKE	2850	4
CLARK	2450	4
SCOTT	3000	4
KING	5000	5
TURNER	1500	3
ADAMS	1100	1
JAMES	950	1
FORD	3000	4
MILLER	1300	2

9. 각 직원이 받는 급여와 동일한 grade의 최저급여와 최고급여도 같이 출력하시오. 직원명, 급여, 등급, 최저급여, 최고급여 
   (서브쿼리로 해결하시오)
select e.ename,e.sal,
(select s.grade from salgrade s where e.sal between s.losal and s.hisal) grade,
(select s.losal from salgrade s where e.sal between s.losal and s.hisal) losal,
(select s.hisal from salgrade s where e.sal between s.losal and s.hisal) hisal
from emp e; 
ename	sal	grade	losal	hisal
SMITH	800	1	700	1200
ALLEN	1600	3	1401	2000
WARD	1250	2	1201	1400
JONES	2975	4	2001	3000
MARTIN	1250	2	1201	1400
BLAKE	2850	4	2001	3000
CLARK	2450	4	2001	3000
SCOTT	3000	4	2001	3000
KING	5000	5	3001	9999
TURNER	1500	3	1401	2000
ADAMS	1100	1	700	1200
JAMES	950	1	700	1200
FORD	3000	4	2001	3000
MILLER	1300	2	1201	1400

10. 직원을 모두 출력하시오.. 직원명 직무 상급자명(MGR의 ename) 기본급, 관리자가 없는 사람 제외
select e1.ename 직원명, e1.job 직무, e2.ename 상급자명, e1.sal 기본급 
 from emp e1 inner join emp e2
 where e1.mgr=e2.emptno;
직원명	직무		상급자명	기본급
FORD	ANALYST		JONES	3000
SCOTT	ANALYST		JONES	3000
JAMES	CLERK		BLAKE	950
TURNER	SALESMAN	BLAKE	1500
MARTIN	SALESMAN	BLAKE	1250
WARD	SALESMAN	BLAKE	1250
ALLEN	SALESMAN	BLAKE	1600
MILLER	CLERK		CLARK	1300
ADAMS	CLERK		SCOTT	1100
CLARK	MANAGER	KING	2450
BLAKE	MANAGER	KING	2850
JONES	MANAGER	KING	2975
SMITH	CLERK		FORD	800

11. 10번문제를 서브쿼리로 해결하시오.
select e1.ename 직원명, e1.job 직무, 
 (select e2.ename from emp e2 where e1.mgr=e2.empno) 상급자명, e1.sal 기본급 
 from emp e1 where mgr is not null;
직원명	직무		상급자명	기본급
SMITH	CLERK		FORD	800
ALLEN	SALESMAN	BLAKE	1600
WARD	SALESMAN	BLAKE	1250
JONES	MANAGER	KING	2975
MARTIN	SALESMAN	BLAKE	1250
BLAKE	MANAGER	KING	2850
CLARK	MANAGER	KING	2450
SCOTT	ANALYST		JONES	3000
TURNER	SALESMAN	BLAKE	1500
ADAMS	CLERK		SCOTT	1100
JAMES	CLERK		BLAKE	950
FORD	ANALYST		JONES	3000
MILLER	CLERK		CLARK	1300

11. 커미션이 없는 직원을 모두 출력하시오 (서브쿼리)
select ename from emp where empno in (select empno from emp where comm is null or comm=0);
ename
SMITH
BLAKE
CLARK
SCOTT
TURNER
ADAMS
JAMES
FORD
MILLER

12. deptno별 인원수를 출력하시오. 단 인원수가 4명 이상인 부서만 출력하시오.  인원수 deptno
select count(*),deptno from emp group by deptno having count(deptno)>=4; 
count(*)	deptno
5	20
6	30

13. deptno별 인원수를 출력하시오. 단 인원수가 4명 이상인 부서만 출력하시오.  인원수 deptno dname
조인
select count(*),e.deptno, d.dname from emp e
right outer join dept d on e.deptno=d.deptno 
group by e.deptno, d.dname having count(e.deptno)>=4;

서브쿼리
select count(*),e.deptno, (select dname from dept where e.deptno= deptno) dname from emp e
group by deptno having count(d.deptno)>=4;

count(*)	deptno	dname
5	20	RESEARCH
6	30	SALES

14. 관리자가 없는 직원의 이름과 직위를 구하시오
select ename, job from emp where mgr is null;
ename	job
KING	PRESIDENT

15. 관리자가 없는 직원의 이름과 직위, 근무지를 구하시오
조인
select e.ename, e.job, d.loc from emp e left outer join dept d
on e.deptno=d.deptno where e.mgr is null;

서브쿼리
select e.ename, e.job, (select loc from dept where e.deptno=deptno) loc from emp e 
where e.mgr is null;

조인+서브쿼리(조인의 횟수가 줄어들어 속도에 이점이 있다)
select e.ename, e.job, d.loc from (select * from emp where mgr is null) e 
inner join dept d
on e.deptno=d.deptno;

ename	job		loc
KING	PRESIDENT	NEW YORK

16. FORD와 같은 부서에서 근무하는 사람의 이름과 직위 근무지를 출력하시오.
조인+서브쿼리(where)
  select e.ename, e.job, d.loc from emp e left outer join dept d
  on e.deptno=d.deptno where e.deptno=(select deptno from emp where ename='ford');

조인+서브쿼리(인라인뷰)
select e.ename, e.job, d.loc from (select * from emp where deptno=
(select deptno from emp where ename='ford')) e inner join dept d
  on e.deptno=d.deptno;

ename	job		loc
SMITH	CLERK		DALLAS
JONES	MANAGER	DALLAS
SCOTT	ANALYST		DALLAS
ADAMS	CLERK		DALLAS
FORD	ANALYST		DALLAS

17. martin이 관리하고 있는 직원의 이름과 직위와 기본급을 출력하시오.
 select job,sal from emp where mgr=(select empno from emp where ename='martin');
 결과 없음

18. 부서별 최저 급여를 받는 사람의 이름과 급여를 출력하시오.
select ename, sal, deptno from emp where sal in (select min(sal) from emp group by deptno);

select ename, sal from emp where (sal,deptno) in (select min(sal),deptno from emp group by deptno);

ename	sal	deptno
SMITH	800	20
JAMES	950	30
MILLER	1300	10


개인적인 참고질문

3. 부서가 있는 직원 중 연봉이 2500이상인 직원의 deptno와 그 인원수를 출력하시오.
select deptno,count(*) from emp 
where deptno is not null group by deptno having sal>=2500;
-->에러 발생

6.부서가 있는 모든 부서의 (deptno)의 인원수를 출력하시오. 
단 부서의 평균이 전체평균보다 높은 부서만 출력하시오.
select deptno, count(*) from emp 
where deptno is not null 
group by deptno having avg(sal)>(select avg(sal) from emp);
-->정상처리 

둘의 차이가 무엇인가??

순서가 group by를 한 후 having으로 걸러낸다.
3번 같은 경우 이미 그룹이 만들어 졌으므로 sal>=2500이 안됨.

6번의 경우 그룹이 만들어진 후 그룹에 대한 집계 함수를 사용 한것이므로 가능하다.*/