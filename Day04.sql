-- member 테이블 생성
create table member(
    id varchar(4) primary key,
    name varchar(10),
    addr varchar(10),
    tel varchar(10)
    );

-- car 테이블 생성
create table car(
    no int primary key auto_increment,
    carNum varchar(4) not null,
    carInfo varchar(10),
    carUser varchar(4),
    foreign key(carUser)
    references member(id)
    );

-- member 테이블 튜플 삽입
insert into member values('0000','홍길동','정자동','3445-2223');
insert into member values('0001','고길동','화서동','3322-1445');
insert into member values('0002','둘리','고등동','2335-1004');

-- car 테이블 튜플 삽입
insert into car values(default,'1233','소나타','0000');
insert into car values(default,'4553','k3','0000');
insert into car values(default,'5536','k3','0002');

-- 오류 발생시키는 문제 만들어보기

-- 자식테이블의 insert 오류
-- 1. car 테이블에 차량번호는 5222 차종은 k5 caruser는 0004 인 튜플을 삽입(insert)하시오.
insert into car values(default,'5222','k5','0004');
-- 에러발생: 참조하는 부모 테이블(member)의 id에 0004 없음.

-- 자식테이블의 update 오류
-- 2. car 테이블에 caruser 0002를 0005로 수정(update)하시오.
update car set carUser='0005' where carUser='0002';
-- 에러발생: 참조하는 부모 테이블(member)에 수정하고자 하는 0005라는 id가 없음.

-- 부모테이블의 update 오류
-- 3. member 테이블에 id가 0000인 회원의 id를 0005으로 수정(update)하시오.
update member set id='0005' where id='0000';
-- 에러발생: 참조당하는 자녀 테이블(car)에 id가 0000인 데이터 남아있음.

-- 부모테이블의 delete 오류
-- 4. member 테이블에 id가 0000인 데이터를 삭제(delete)하시오.
delete from member where id='0000';
-- 에러발생: 참조당하는 자녀 테이블(car)에 id가 0000인 데이터 남아있음.
