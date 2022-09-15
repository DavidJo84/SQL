-- hm0729 데이터베이스 생성
create database hm0729;

-- hm0729 데이터베이스 사용
use hm0729;

-- member 테이블 생성
create table member(
	no int,
    id varchar(4),
    name varchar(8),
	point int default 10);

-- 자료 삽입
insert into member  value(1, 'aaa','kim',30);

-- no와 id만 조회
select no, id from member;

-- 컬럼명 no를 번호로 바꾸어 id와 함께 조회
select no as '번호', id from member;

-- 두번째 자료 삽입(포인트는 기본값으로)
insert into member value(2,'bbb','Lee',default);

-- 세번째 자료를 no, id, name에만 선택적으로 삽입
insert into member (no,id,name) values(3,'ccc','Park');

-- 자료중 id명이 aaa인 자료 조회
 select * from member where id='aaa';

-- 자료중 no가 2 미만인 자료 조회
select * from member where no <2;

-- 자료중 point가 10이상인 자료를 no, point만 조회하되 컬럼명 no를 번호로 바꾸어 출력
select no as '번호', point from member where point>=10;

-- id가 ccc인 사람의 포인트를 300으로 수정
update member set point=300 where id='ccc';

-- id가 aaa인 사람의 정보를 삭제
 delete from member where id='aaa';

-- id가 ccc인 사람의 point를 500으로 no를 900으로 수정
update member set point=500, no=900 where id='ccc';

-- id가 aaa, no가 3인 자료 삽입(name은 null값이 저장됨, point는 기본값이 10저장)
insert into member (no,id) values(3,'aaa');

-- name이 null값인 자료 삭제
delete from member where name is null;

-- member2 테이블 생성
create table member2(
    id varchar(4) primary key,
    name varchar(8),
    Jumin varchar(13) not null
	);
    
--     실습

-- 게시판 데이터 베이스 만들기
-- 게시판은 글은 글번호로 구분한다.
-- 게시판은 작성자를 저장한다.
-- 게시판은 제목과 내용을 저장한다.
-- 게시판은 조회수가 있으며 최초 값은 0번이다.
-- 게시판은 비밀번호를 저장하며 수정과 삭제에 사용된다.
-- 게시판은 작성일이 있으며 시스템의 날짜를 자동으로 저장한다.
-- 날짜는 년월일시분초를 저장한다.

-- 조건 1.글번호는 중복이 불가능하다.
-- 작성자는 여러개의 글을 등록할 수 있다.
-- 제목은 한글 기준 최대 글자 5이다. (한글은 2byte, 영문과 숫자는 1 byte의 공간이 필요.)
-- 내용은 한글 기준 최대 10글자 이다.
-- 조회수는 숫자로 기록된다.
-- 비빌번호는 4자 까지 허용한다.

-- 문제

-- 1. 위 조건을 만족하는 게시판을 만드시오
create table member3(
    no int primary key,
	name varchar(10),
    title varchar(10),
    text varchar(20),
    cnt int default 0,
    pwd varchar(4) not null default '0000',
    date timestamp default now()
    );

-- 2. 다음 내용을 입력하시오
-- 이때 날짜는 모두 시스템날짜가 자동으로 저장된다.

-- 글번호 작성자 제목 내용 조회수 비밀번호 작성일
-- 1 kim 10 11111 안녕 반갑습니다
-- 2 lee 1 11111 날씨 매우 맑음
-- 3 parkkim 5 11111 일정 오후만남
-- 4 lee 10 11111 공지 저녁만남
-- 5 choi 4 11111 메뉴 삼겹살
-- 6 jinlee 20 11111 여행 동해바다가
-- 7 kimjin 25 11111 일정 오전시험

-- 3. 모든 글을 출력하시오.
select * from member3;

-- 4. 작성자와 제목과 내용을 출력하시오.
select name,title,text from member3;

-- 5. 6번글의 작성자 제목 내용을 출력하시오.
select name,title,text from member3 where no=6;

-- 6. 제목이 여행, 내용이 동해바다가 글의 비밀번호를 3333으로 변경하시오.
update member3 set pwd='3333' where title='여행' and text='동해바다가';

-- 7. 작성자 lee가 작성한 글을 모두 검색하시오.
select * from member3 where name='lee';

-- 8. 조회수가 10회 이상한 글의 제목과 내용과 조회수를 검색하시오.
select title, text, cnt from member3 where cnt>=10;

-- 9. 5 번 글 작성자가 비번을 분실했다 비번을 0000으로 초기화 하세요.
update member3 set pwd=default where no=5;

-- 10. 3 번을 삭제하시오.
delete from member3 where no=3;

-- 11. 모든 게시글의 조회수를 2씩 증가하시오.
update member3 set cnt=cnt+2;

-- 심화
-- 12. 내용에 만남이라는 글자가 있는 글을 모두 검색하시오.
select * from member3 where text like '%만남%';

-- 13. 조회수가 10이상 25미만인 게시글을 모두 검색하시오.
select * from member3 where cnt >=10 and cnt<25;

-- 14. 모든 글의 평균조회수를 출력하시오
-- 출력형태 >> 평균조회수
--                  결과값
select avg(cnt) '평균조회수' from member3;

-- 15. 조회수가 높은 순서대로 정렬하여 출력하시오.
select * from member3 order by cnt desc;

-- 16. 조회수가 낮은 순서대로 정렬하여 출력하시오 단 조회수는 1보다 커야 한다.
select * from member3 where cnt>1 order by cnt asc;


