-- 실습
create database hm0804;                

use hm0804;                               

create table member(                   
no int primary key auto_increment,
name varchar(4),
addr varchar(10),
grade varchar(1),
point int default 10,
wdate timestamp default now()
);

insert into member values(default,'kim','suwon',1,400,default); 
insert into member values(default,'suji','city suwon',2,200,default);
insert into member values(default,'lee','seoul',3,20,default);
insert into member values(default,'choi','seoul',2,120,default);
insert into member values(default,'jee','yongin',1,20,default);
insert into member values(default,'lee','yongin',2,300,default);

select * from member;              

-- 현재 사용중인 데이터베이스에서 만들어진 테이블을 모두 보는 명령어
show tables;                               

-- 테이블 구조확인 명령어: desc 테이블명;
desc member;                              

-- 테이블 생성시 명령어 확인: show create table 테이블명;
show create table member;       

-- 1. 모든사람의 이름과 주소와 학년을 출력
select name, addr, grade from member;

-- 2. 1학년의 이름과 주소와 포인트와 등록일을 출력
select name, addr, point, wdate from member where grade=1;

-- 3. 포인트가 높은 순서부터 출력, 단 화면에는 name, addr, grade, point로 출력
select name, addr, grade, point from member order by point desc;

-- 4. 1학년과 3학년의 주소와 포인트와 학년을 출력, 
-- 이때 포인트가 낮은 학생부터 출력
select addr, point, grade from member 
where grade=1 or grade=3 order by point asc;

-- 5. 수원에 거주하는 사람의 이름과 주소를 출력
select name, addr from member where addr like '%suwon%';

-- 6. 포인트가 100이상 200 이하인 사람의 이름과 주소를 출력
select name, addr from member where point between 100 and 200;

-- 7. 포인트가 100이상 200 미만인 사람의 이름과 주소를 출력
select name, addr from member where point>=100 and point<200;

-- 8. 모든 학생의 포인트에 100을 합하여 모든 데이터 출력(단, 저장된 데이터를 변경하면 안됨)
select no, name, addr, grade, point+100, wdate from member;

-- 9. 포인트를 -100 했을 경우 0보다 큰 사람의 이름과 주소와 포인트를 출력
select name, addr, point-100 from member where point-100 > 0;

-- 10. [심화] 포인트가 높은 사람부터 검색, 출력은 포인트가 세번째로 높은 사람의 모든 정보를 출력.
select * from member order by point desc limit 2,1;

-- 11. [추가] 포인트가 높은 사람부터 출력, 단 포인트가 같을 경우는 번호가 낮은 사람부터 출력
select * from member order by point desc, no asc;     

-- 과제

create table user(
no int primary key auto_increment,
name varchar(10),
addr varchar(10),
point double,
grade varchar(1),
jumin varchar(8));

insert into user values (default,'kimsu','suwon',99.12,1,'820405-1');
insert into user values (default,'leesu','suwon city',89.00,2,'970805-2');
insert into user values (default,'choihee','seoul',88.21,1,'910204-2');
insert into user values (default,'leesil','suwon',77.62,4,'850405-1');
insert into user values (default,'james','seoul',60.22,1,'871105-1');
insert into user values (default,'parksuji','suwon',90.12,3,'880405-2');
insert into user values (default,'kimrae','yougin',89.96,3,'820105-1');
insert into user values (default,'sangJin','youngin',99.31,3,'990420-2');
insert into user values (default,'Leechan','incheon',79.12,2,'970605-2');
insert into user values (default,'kimmi','incheon',79.92,1,'810505-1');
insert into user values (default,'ryusu','seoul',85.32,4,'861205-2');
insert into user values (default,'Gosu',null,82.13,4,'810715-1');

-- 목표문제
-- 1. 모든 사람들의 이름과 점수와 생년월일을 검색하시오. 
 select name '이름', point '점수', left(jumin,6) '생년월일' from user;


-- 2. 80점 이상의 사람의 이름과 주소, 점수를 검색하시오.
select name, addr, point from user where point>=80;

-- 3. 이름이 kim으로 시작되는 사람의 이름과 주소와 점수를 검색하시오.
select name, addr, point from user where name like 'kim%';

-- 4. 현재 점수에서 +10으로 보정한 점수를 출력하시오.
--    단. 100점을 넘을 수 있습니다. 원본 데이터에 반영되지 않습니다.
select point+10 from user;

-- 5. 1학년의 점수를 +1점씩 올려서 출력하세요. (단, 원본 데이터에 반영되지 않습니다.)
select no, name, addr, point+1, grade, jumin from user where grade = 1;

-- 6. B등급을 획득한 사람의 이름, 주소, 점수를 출력하세요 (B등급 80점 이상 90점 미만입니다)
 select name, addr, point from user where point >=80 and point<90;

-- 7. select * from user; 쿼리 결과 중 NULL은 실제 입력하지 않은 값입니다.
--    주소를 입력하지 않은 학생의 이름과, 주소, 학년, 점수, 주민번호를 출력하세요
select name, addr, grade, point, jumin from user where addr is null;

-- 8. 4학년의 점수를 10%로 올린 점수를 계산하세요.
--    (단, 원본데이터는 반영되지 않는다)
select point * 1.1 from user where grade=4;

-- 9. 점수가 낮은 학생부터 출력하세요.  번호, 이름, 주소, 포인트
select no, name, addr, point from user order by point asc;

-- 10. 학년을 오름차순으로 정렬하시오, 단 학년이 동일 할 경우 포인트가 높은 사람이 먼저 출력됩니다.
--      출력은 번호, 이름, 학년, 포인트 
select no, name, grade, point from user order by grade asc, point desc;

-- 11. 1학년중에서 점수가 2번째와 3번째로 높은 학생의 이름, 주소, 점수, 주민번호를 출력하세요.
select name, addr, point, jumin from user where grade=1 order by point desc limit 1,2;

-- 12.  현재의 점수에서 -10을 보정한 결과 80점 이상인 사람의 이름과 점수, 보정한 결과 점수를 출력하세요.
 select name, point, point-10 from user where point-10>=80;

-- * 본인을 한번 칭찬하세요 목표달성..
-- * 출력 형태는 임의대로 결정하되 결과값이 정확하면 됩니다 

-- 추가문제 <mysql  함수>
-- 13. 학생은 총 몇명입니까?]
select count(no) from user;

-- 14. 1학년은 총 몇명입니까?
select count(no) from user where grade=1;

-- 15. 모든 학생의 이름과 학년을 출력하시오. 단 이름은 모두 소문자로만 출력하시오.
select lower(name), grade from user;

-- 16. 2학년 학생의 이름과 학년과 주소를 출력하시오. 보안을 위해서 주소는 앞글자 2글자만 출력하시오.
select name, grade, left(addr,2) from user where grade=2;

-- 17. 모든 학생의 점수의 일의 자리를 절삭하시오. - 반올림 없음 (단, 원본 데이터에 반영되지 않습니다.)
select truncate(point,-1) from user; 

-- 18. 모든 학생의 점수를 소수 첫째자리 반올림하여 출력하시오. (단, 원본 데이터에 반영되지 않습니다.)
select round(point) from user; 

-- 19. 2학년은 모두 몇명입니까?
select count(no) from user where grade=2;

-- 20. 1학년중 80점 이상은 몇명입니까?
select count(no) from user where grade=1 and point >=80;

-- 21. 3학년의 평균은 몇점입니까?
select avg(point) from user where grade=3;

-- 22. 전체 학생 중 최고점은 몇점입니까?
select max(point) from user;

-- 23. 2학년 중 가장 낮은 점수를 획득한 점수는 몇점입니까?
select min(point) from user where grade=2;

-- 24. 보안을 위해서 주소를 모두 출력하지 않고 앞의 세 글자만 출력하고 뒤에 *를 하나 붙힌다.
--    (단, 원본 데이터에 반영되지 않습니다.)
--    예)suwon  >> su*
select concat(left(addr,2),'*') from user;

-- 25. 이름의 맨 앞에 *를 맨 뒤에도*를 붙혀서 출력한다. (단, 원본 데이터에 반영되지 않습니다.)
select concat('*', name,'*') from user;

-- 26. 생년월일을 그대로 출력하지 말고
 --    xx 년 xx 월 xx 일 형식으로 출력한다. (단, 원본 데이터에 반영되지 않습니다. 성별은 무시한다)
select concat(left(jumin,2),'년',substring(jumin,3,2),'월', substring(jumin,5,2),'일') '생년월일' from user;

-- 27. 이름, 포인트, 학년, 생년월일, 성별을 출력한다. 성별은 생년월일로 판단하며 마지막 숫자가1이면 남
--     2이면 여라고 표시한다. 

-- 방법1. case when then 사용
select name '이름', point '점수', grade '학년', left(jumin,6) '생년월일', 
(case 
when right(jumin,1)=1 then '남' 
when right(jumin,1)=2 then '여' 
end) '성별'
from user;

-- 방법2. replace() 사용
select name '이름', point '점수', grade '학년', left(jumin,6) '생년월일',
 replace(replace(right(jumin,1), '1', '남'), '2', '여') '성별' from user;

  