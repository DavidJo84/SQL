-- member테이블 생성
create table member(
id varchar(4) primary key,
name varchar(10),
addr varchar(20)
);

-- car 테이블 생성
create table car(
no int primary key auto_increment,
carNum varchar(4) not null,
carInfo varchar(10),
id varchar(4),
foreign key(id)
references member(id)
on delete cascade
on update cascade
);

-- member 레이블 삽입
insert into member values('a000','kim','suwon'),
('a001','Park','seoul'),('a002','Choi','busan'),('a003','Lee','incheon');

-- car 레이블 삽입
insert into car values(default,'1111','sonata','a000'),
(default,'2222','K3','a001'),(default,'3333','K5','a000'),(default,'4444','K3','a003');

-- member 테이블에 id가 a003인 회원의 id를 a004로 변경해보기
update member set id='0004' where id='0003';

-- 자식릴레이션인 car테이블의 id a003이 a004로 변경되었는지 확인
select * from car;

-- member 테이블에 id가 a004인 회원의 정보를 삭제하기
 delete from member where id='a004';

-- 자녀릴레이션인 car테이블에 id가 a004인 레이블이 삭제되었는지 확인
select * from car;

-- 문제
-- 장바구니 구현
-- 고객은 id,이름,전화번호
-- 물건은 물건id, 종류, 가격
-- 고객은 여러개의 물건을 구매할 수 있다
-- 하나의 물건을 여러명이 구매할 수 있다
-- 구매시에 수량을 등록

-- 고객 테이블 생성
create table customer(
custId varchar(4) primary key,
name varchar(10) not null,
tel varchar(10) not null
);

-- 물건 테이블 생성
create table product(
prodId varchar(10) primary key,
kind varchar(10) not null,
price int not null default 0
);

-- 장바구니 테이블 생성
create table cart(
custId varchar(4),
prodId varchar(10),
cnt int not null default 0,
cartNum varchar(14) primary key,
foreign key(custId) references customer(custId)
on delete cascade on update cascade,
foreign key(prodId) references product(prodId)
on delete cascade on update cascade
);

-- 고객 정보 입력
insert into customer values('a000','kim','9570-9334'),
('a001','lee','2203-4457'),('a002','park','9330-0023'),
('a003','choi','2341-9003');

-- 물건 정보 입력
insert into product values('aa0000','aa',5000),
('bb0000','bb',3500),('aa0001','aa',580),
('aa0002','aa',9000),('cc0000','cc',15000),
('bb0001','bb',4500),('aa0003','aa',2300);

-- 장바구니 정보 입력
insert into cart values('a000','aa0000',2,'a000aa0000'),('a000','aa0003',1,'a000aa0003'),
('a002','bb0000',5,'a002bb0000'),('a001','aa0003',1,'a001aa0003'),('a002','bb0001',1,'a002bb0001'),
('a003','cc0000',2,'a003cc0000'),('a002','aa0000',2,'a002aa0000'),('a000','cc0000',5,'a000cc0000');

-- 한사람이 여러 도서를 빌릴 수 있음. 하나의 책을 여러명이 빌릴 수 있다.
-- 독서후기는 한사람이 여러개의 후기를 남길 수 있다.

-- 도서목록 테이블 생성
create table bookInfo
(
b_no int primary key auto_increment,
b_name varchar(20) not null,
b_date date not null,
b_write varchar(20) not null,
b_pud varchar(20) not null
);
-- 도서목록 데이터 삽입
insert into bookinfo values(1, '드래곤볼', '1984-07-18', '토리야마 아키라', '주간소년점프'),
(2, '원피스', '1997-7-20', '오다에이치로', '주간소년점프'),
(3, '나루토', '2000-3-3', '키시모토마사시', '주간소년점프'),
(4, '원펀맨', '2009-7-3', 'ONE', '점프코믹스'),
(5, '귀멸의칼날', '2020-12-4', '고토게 코요하루', '주간소년점프');

-- 고객정보 테이블 생성
create table memberInfo(
m_id varchar(10) primary key,
m_name varchar(10) not null,
m_pwd varchar(10) not null,
m_tel varchar(13) not null,
m_age int default 0,
m_sex char(1),
m_point int default 0
);

-- 고객정보 데이터 삽입
insert into memberInfo values
('aaaa', '홍길동','aaaa','010-0012-1200', 56, 'm', 1004),
('asdf', '길성준','dddd','010-5900-0480', 56, 'm', default),
('owl', '이상수','cccc','010-5004-0708', 56, 'm', 15),
('glew', '박지효','qwww','010-0700-6550', 56, 'f', 112),
('peft', '박은지','wwdw','010-4750-9750', 56, 'f', 185);

-- 도서대여대장 및 리뷰 테이블 생성
create table bookRent(
m_id varchar(10),
b_no int,
r_rent timestamp not null,
r_return timestamp,
r_no varchar(14) primary key,
r_review varchar(40),
foreign key(m_id) references memberInfo(m_id)
on delete set null on update cascade,
foreign key(b_no) references bookInfo(b_no)
on delete cascade on update cascade
);

-- 도서대여대장 및 리뷰 테이블 데이터 삽입
insert into bookRent(m_id, b_no, r_rent, r_no, r_review) values
('aaaa', 1, now(), 'aaaa1', '이 책은 저의 마음을 위로해주었습니다.'),
('aaaa', 4, now(), 'aaaa4', '내용이 너무 지루했습니다. 불면증이 있으신 분 추천.'),
('asdf', 1, now(), 'asdf1', '보는 내내 시간 가는줄 몰랐습니다. 추천합니다.'),
('glew', 4, now(), 'glew4', '우리 아이가 재밌다고하네요. 아이들에게 추천해요.'),
('glew', 2, now(), 'glew2', '눈물 펑펑 쏟았어요. 울고 싶은 분 꼭 읽으세요.'),
('glew', 5, now(), 'glew5', '잠시나마 동심의 세계로 돌아간것 같습니다.'),
('peft', 3, now(), 'peft3', '내용이 너무 잔인하네요. 아이들은 금지!'),
('peft', 2, now(), 'peft2', '이 작가의 책을 좋아해서 읽었습니다. good!');

-- 리뷰가 없는 데이터 삽입
insert into bookRent(m_id, b_no, r_rent, r_no) values
('peft',1,now(),'peft1');

-- 반납날짜 데이터 삽입
update bookrent set r_return=now() where r_no='aaaa1';
update bookrent set r_return=now() where r_no='aaaa4';
update bookrent set r_return=now() where r_no='asdf1';
update bookrent set r_return=now() where r_no='glew2';
update bookrent set r_return=now() where r_no='glew4';
update bookrent set r_return=now() where r_no='glew5';
update bookrent set r_return=now() where r_no='peft1';
update bookrent set r_return=now() where r_no='peft2';
update bookrent set r_return=now() where r_no='peft3';


-- 6번. 도서목록에서 원피스를 지웠을때 도서대여대장에서도 지워지는지 테스트
delete from bookInfo where b_name='원피스';


-- 7. 도서에 대한 정보가 갱신되면 그에따라 도서대여대장에서도 갱신되어야 하는지 확인
-- b_no=3인 도서를 b_no=2로 변경
update bookinfo set b_no =2  where b_no = 3;


-- 8.고객이 탈퇴하였을 경우는 그 고객이 대여한 도서도 같이 삭제되지 않고 흔적이 남아서 추후에 인기 도서목록을
-- 분석할때 사용되어야 함.
-- 고객정보에서 홍길동을 삭제해봄.
delete from memberinfo where m_name='홍길동';


-- 9. 고객의 정보가 수정되면 고객대여대장에서도 수정되어야 한다.
-- 길성준의 m_id를(asdf) cccc로 변경
update memberinfo set m_id='cccc' where m_id='asdf';
