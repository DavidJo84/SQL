/*DB정리
1. DBMS 무엇인가?
관계형 데이터를 저장하고 관리하기 위한 시스템
공동으로 접근, 여기에 있는 데이터는 실시간 변화, 자료에 의한 참조
사용한 프로그램 : mysql, oracle

2. 관계형 데이터 베이스(RDBMS)란 무엇인가?
개체: 기본키가 존재하며, 독립적으로 표현할 수 있는 대상
예)학생(개체), 수강신청(학생이 있어야 하므로 개체가 될 수 없다)
관계: 개체와 개체가 어떤 연관성이 있느냐? 
연관성을 판단하는 팁은? 개체의 기본키로 판단하면 쉽게 접근 가능.
예) 1:1, 1:N, N:M

면접 질문 예)
사용해본 데이터베이스 프로그램이 무엇이 있나요?
ERD가 무엇입니까?

3. 관계형 데이터 베이스에서 먼저 이해해야할 용어

가. 릴레이션(테이블)
행과 열로 구성된 전체의 자료
DDL 명령어-create, alter, drop

나. 속성명과 속성
릴레이션을 구성하는 컬럼들(릴레이션의 열)

속성의 종류
a.문자 b.수치 c.날짜

속성의 제약조건
not null: 컬럼의 값이 null이 될 수 없다
primary key: 컬럼의 값이 null이 될 수 없다, 자료가 중복될 수 없다.(튜플을 유일하게 식별)
자동으로 index를 생성(검색 속도에 이점)
foreign key: 외래키로 지정된 속성은 부모릴레이션의 속성을 참조
부모 릴레이션에 존재하는 데이터만 컬럼의 값이 될 수 있다.
외래키는 두개 이상의 테이블에 연과성이 있고 이는 조인에 많이 활용된다
외래키는 유니크 하지 않아도 되지만 참조하는 속성은 반드시 유니크해야 한다.
check: 컬럼이 가지는 값에 세부내용을 지정
unique: 자료가 중복될 수 없다.(튜플을 유일하게 식별)

다. 튜플
릴레이션에 저장할 실제 데이터(릴레이션의 행)
DML명령어-insert, select, update, delete

면접 질문 예)
기본키와 외래키가 무엇인가?

DCL명령어 

a.계정생성
create user 아이디명 identified by 비밀번호;
로그인: connect 아이디명/비밀번호;(권한부여가 안되어 있으면 로그인 안됨)
현재 계정 정보확인: select user from dual;

b.권한부여
grant dba(권한의 종류) to 아이디명;

예제) kkk/1234 계정을 만들고 접속한 아이디를 화면에 출력
 create user kkk identified by 1234;
 grant dba to kkk;
 connect kkk/1234;
 select user from dual;

c.계정삭제
drop user 아이디 cascade;

d.commit
실제 데이터로 저장

e.rollback
마지막 커밋까지 복구

예제) 다음환경을 셋팅하시오
1. 계정 생성 human /1234
2. 테이블 생성
테이블 명: member
속성: no number 기본키, name varchar2(10), addr varchar2(10 char), 
gender varchar2(1) 'm,f만 입력가능', indate timastamp 기본값 현재 시스템 날짜

테이블명: car
속성: carno number 기본키, carnumber varchar2(4)
carinfo varchar2(20), userno number 외래키, 참조 member 테이블

데이터 입력
member
1, 홍길동, 수원, m
2, 일지매, 서울,f
3, 삼식이, 수원,m

car
1, 1234,suv,1
2, 1111,rv,2
3, 1234,suv,1

3. 두테이블에 입력된 자료를 확인
select * from member;
select * from car;

4. human 계정이 접근 가능한 테이블 목록을 확인
SELECT *
  2    FROM all_tab_comments
  3   WHERE table_type = 'TABLE'(반드시 대문자)
  4     AND owner = 'HUMAN';(반드시 대문자)

5. 소유한 테이블의 구조를 desc 명령어로 확인
desc member;
desc car;

6. 방금 만든 테이블의 제약조건을 확인하는 명령어
계정 human의 모든 테이블
select * from all_constraints where owner= 'HUMAN';

현재 유저로 확인할때
select * from user_constraints;

계정 human의 member 테이블
select * from all_constraints where owner= 'HUMAN' and table_name='MEMBER';

계정 human의 car 테이블
select * from all_constraints where owner= 'HUMAN' and table_name='CAR';

7.고객이 소유한 자동차 출력(이름,주소,성별,차번호,차종)

뷰 생성
create view member_car_view as
select a.name,a.addr,a.gender,b.carnumber, b.carinfo 
from member a
inner join car b on a.no=b.userno;

뷰 조회
select * from member_car_view;


라. View뷰-가상테이블

물리적인 테이블로 조인등을 통해 논리적인 테이블로 만드는것
물리적인 테이블은 아니지만 유사하다
복잡한 쿼리 단순화
테이블에 컬럼을 숨겨서 보안성을 향상시킬 수 있다.
장바구니 같은 경우는 조인된 결과를 미리 뷰로 만들어 놓으므로 
개발이 심플해진다.

단순뷰- 단일 테이블, 함수나 수식이 포함되지 않고 단순 칼럼으로만 구성
단순 뷰는 뷰를 통해서 insert, update, delete 가능

복합뷰- 다중테이블, 함수, 수식, group by 가능, select 연산만 가능

문제
member table로 뷰를 만드세요.(모든 컬럼 포함)
뷰 이름: member_v

create view member_v as
select * from member; (단순뷰)

마. index
장점 : 조건절에서 사용하면 검색의 성능을 높여줌
단점: insert, update, delete문에서 성능의 저하
불필요한 인덱스 생성은 자제해야함.

인덱스를 사용하는 조건
1. 테이블의 크기(튜플의 수)가 수십만 수천만건 이상이어야 효율적이다. 
2. 조건에서 사용하는 것이 좋다.
3. 테이블의 5% 미만 정도의 행을 검색하는 경우 활용

인덱스 생성법
1.기본키는 자동으로 인덱스 생성
2.자주 조건으로 사용하는 컬럼을 수동으로 만들 수 있다.
생성: create index 인덱스명 on 테이블명(컬럼명);
조회: select * from user_indexes where table_name='테이블명';
삭제: drop index 인덱스명;

실습
게시판 생성
create table board(
no number(3) primary key,
name varchar2(10),
title varchar2(30),
text varchar2(40),
ct varchar2(5),
bdate timestamp default sysdate);

카테고리에 인덱스 생성
create index board_ct_idx on board(ct);

카테고리별 게시물의 갯수를 뷰로 만들어 사용
create view bbs_cat_view as
select count(*) count, ct from board 
group by ct;(복합뷰)



SELECT EXTRACT(HOUR FROM CAST(DATETIME AS TIMESTAMP)) hour, count(*) from animal_outs
where EXTRACT(HOUR FROM CAST(DATETIME AS TIMESTAMP))
between 9 and 19 
group by EXTRACT(HOUR FROM CAST(DATETIME AS TIMESTAMP))
order by hour asc;

TO_CHAR(DATETIME, 'HH24')


SELECT HOUR, COUNT(B.DATETIME) AS COUNT
FROM
(
SELECT LEVEL-1 AS HOUR
FROM DUAL
CONNECT BY LEVEL <= 24
)A 
LEFT JOIN ANIMAL_OUTS B
ON A.HOUR = TO_CHAR(B.DATETIME, 'HH24')
GROUP BY HOUR
ORDER BY HOUR


SELECT a.hour, sum(if(b.animal_id is null,0,1)) count 
from animal_outs as b
right outer join(SELECT LEVEL-1 as hour
   FROM DUAL CONNECT BY LEVEL <= 24) as a
on to_char(b.datetime,'HH24')=a.hour
group by a.hour order by a.hour asc;



SELECT hour, count(b.datetime) count 
from animal_outs as b
right join(SELECT LEVEL-1 as hour
   FROM DUAL CONNECT BY LEVEL <= 24) as a
on to_char(b.datetime,'HH24')=a.hour
group by hour order by hour asc;*/