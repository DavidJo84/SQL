-- 문제 아이디 4자리, 이름 10자, 수량, 등급 문자 1개, 초기값 A로 설정하여 테이블 만들기
create table goods(
     id varchar(4) unique,
 name varchar(10) not null,
     cnt int,
     grade varchar(1) default 'A'
     );
     
--     문제
-- 게시판 테이블
-- 글번호 숫자 글번호 중복금지
-- 작성자 10글자 반드시 입력
-- 제목 20글자
-- 조회수 숫자 기본값 0

create table table_1(
    num int unique,
	name varchar(10) not null,
    title varchar(20),
    cnt int default 0
    );
    
--  1.작성자가 20글자 가능하도록 수정
-- 컬럼의 데이터타입 및 속성 변경
alter table table_1 modify name varchar(20) not null;

-- 컬럼 명, 데이터 타입, 속성 모두 한번에 변경(예)
ALTER TABLE table_a CHANGE apple banana VARCHAR(2) NOT NULL;


-- 2.게시날짜 속성추가(년월일시분초형식으로)
alter table table_1 add date timestamp;

-- 3.insert문 검색후 튜플1개 저장
insert into table_1 values(1,'조하영','오늘은 이틀째 수업',23,now());

-- 제대로 입력되었는지 확인 
select * from table_1;