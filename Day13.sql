/*1. 오라클
-오라클은 관계형데이터베이스의 일종이다.
-오라클과 mysql(or maria)의 차이점
오라클은 로그(기록)를 남긴다.(속도는 약간 느리지만 보안에 강함)
mysql은 로그를 남기지 않는다.(속도는 조금 빠르지만 보안에 약함)

2. 오라클 홈페이지


mysql

auto_increment는 unipue한 속성에서 사용 가능하며 
테이블 당 한번만 사용가능하다.

limit
게시판에서 각 페이지당 보여지는 튜플의 갯수만큼 가져올때 많이 사용

고객테이블에서 고객번호가 3이 아닌 튜플을 
고객번호로 그룹핑하되 그룹별 고객번호의 갯수가 1보다 큰 튜플만 
해당 고객번호와 이름을 출력하라.

고객                                      자동차                                                자동차종류
고객번호 이름 주소 포인트          고객번호  자동차 번호  차종                 차종      설명
   1        a     a      10                  1         2222        f1                     f1        승용
   2       b      b      20                  2         3333       f2                     f2        SUV
  3       c       c       30                 1          4444       f3                     f3        RV

---- 목표
 1. 자동차를 소유하지 않은 고객의 이름을 출력하시오..
   조인 : 테이블을 합쳐서 해결 할 수 있나?  
select m.m_name from member m left outer join car c
on m.m_no=c.m_no where c.c_no is null;

  서브쿼리 :  1차 가공을 해서 그 결과물로 2차로 활용?
select m_name from member where m_no not in (select distinct m_no from car);

 2. 등록된 자동차의 차종과 설명을 출력
   조인 : 테이블을 합쳐서 해결 할 수 있나?
select k.c_kind, k.k_name from car c inner join kind k
on c.c_kind=k.c_kind;

   서브쿼리 : 1차 가공해서 그 결과물을 활용?
select k.c_kind, k.k_name from kind k where k.c_kind in 
(select c.c_kind from car c where c.c_kind=k.c_kind);

---  업그레이드

3. 고객별 자동차 등록대수를 출력하시오. (단, 자동차가 없는 고객은 출력하지 마시오.)
   고객번호 이름 주소 포인트 등록대수  (조인, 서브쿼리 상관없음)
 인라인뷰

select m.m_no, m.m_name, m.m_addr, m.m_point, count(*) 등록대수
from member m inner join car c on m.m_no=c.m_no
group by m.m_no;

m_no	m_name	m_addr	m_point	등록대수
1	a	a	10	2
2	b	b	20	1

select m.m_no, m.m_name, m.m_addr, m.m_point, c.cm 
from member m, (select m_no,count(m_no) cm from car group by m_no) c
where m.m_no=c.m_no;

4. 위 3번에서 자동차가 없는 고객도 출력하시오.   (조인, 서브쿼리 상관없음)
select m.m_no, m.m_name, m.m_addr, m.m_point, count(c.m_no) 등록대수
from member m left outer join car c on m.m_no=c.m_no
group by m.m_no;

select m.m_no, m.m_name, m.m_addr, m.m_point, if(m.m_no=c.m_no,c.cm,0) 
from member m, (select m_no,count(m_no) cm from car group by m_no) c
;

m_no	m_name	m_addr	m_point	등록대수
1	a	a	10	2
2	b	b	20	1
3	c	c	30	0

--- 복습문제

5. 고객중 자동차를 2대 이상 소유한 사람의 고객이름을 출력하시오.
  조인 
select m.m_name from member m inner join car c on m.m_no=c.m_no
group by c.m_no having count(c.m_no)>=2;
  서브쿼리 
select m_name from member where m_no in 
(select m_no from car group by m_no having count(m_no)>=2); 

6. 등록된 자동차중 SUV 차종의 자동차 번호를 출력하시오.
  조인
select c.c_no from car c left outer join kind k on c.c_kind=k.c_kind
where k.k_name='SUV'; 
  서브쿼리
select c_no from car where c_kind=(select c_kind from kind where k_name='suv'); 

7. 포인트가 10이상인 고객의 자동차번호와 고객번호 이름을 출력하시오.(제한없음)
select c.c_no, m.m_no, m.m_name from member m left outer join car c
on m.m_no=c.m_no where m.m_point >=10;

8. 포인트가 10이상의 각 고객들이 소유한 자동차의 수를 출력하시오. (고객명 등록대수) (제한없음)
select m.m_name 고객명, count(c.m_no) 등록대수 from member m left outer join car c
on m.m_no=c.m_no where m.m_point >=10 group by c.m_no;

고객명	등록대수
a	2
b	1
c	0


9. 고객이름, 자동차 번호, 차종, 설명을 출력하시오. (자동차가 없는 고객도 포함)
select m.m_name, c.c_no, c.c_kind, k.k_name from member m
left outer join car c on m.m_no=c.m_no
left outer join kind k on c.c_kind=k.c_kind;

m_name	c_no	c_kind	k_name
a	4444	f3	RV
a	2222	f1	승용
b	3333	f2	SUV
c	NULL	NULL	NULL

10. 고객이름, 자동차 번호, 차종, 설명을 출력하시오. (자동차가 있는 고객만 포함)
select m.m_name, c.c_no, c.c_kind, k.k_name from member m
inner join car c on m.m_no=c.m_no
inner join kind k on c.c_kind=k.c_kind;

m_name	c_no	c_kind	k_name
a	2222	f1	승용
b	3333	f2	SUV
a	4444	f3	RV

1. 다운로드(오라클,  sqldeveloper 2개)를 받으면서 문제를 정리합니다. 
   오프라인 윈도우키 + R   \\192.168.0.53
2. 5-6교시는 손코딩
3. 7-8 교시는 컴퓨터 실습 .. */