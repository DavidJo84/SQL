/*상품정보 테이블
create table product(
p_no varchar(6) primary key,
p_name varchar(20) not null,
p_count int not null,
p_price int not null
);

상품정보 튜플
insert into product values('1111','새우깡',42, 800);
insert into product values('2334','초코파이18입',15, 8700);
insert into product values('1132','빼빼로 오리지널',23, 700);
insert into product values('0012','신라면',55, 800);
insert into product values('4332','갈아만든배',100, 600);
insert into product values('3311','촉촉한초코칩',54, 1500);
insert into product values('6442','고래밥',33, 650);
insert into product values('3452','아몬드브리즈',23, 500);
insert into product values('2222','감동란2입',21, 900);

+------+------------------------+---------+---------+
| p_no | p_name                 | p_count | p_price |
+------+------------------------+---------+---------+
| 0012 | 신라면                 |      55 |     800 |
| 1111 | 새우깡                 |      42 |     800 |
| 1132 | 빼빼로 오리지널        |      23 |     700 |
| 2222 | 감동란2입              |      21 |     900 |
| 2334 | 초코파이18입           |      15 |    8700 |
| 3311 | 촉촉한초코칩           |      54 |    1500 |
| 3452 | 아몬드브리즈           |      23 |     500 |
| 4332 | 갈아만든배             |     100 |     600 |
| 6442 | 고래밥                 |      33 |     650 |
+------+------------------------+---------+---------+

제조업체정보 테이블
create table supCom(
sc_name varchar(20) primary key,
sc_tel varchar(15) not null,
sc_addr varchar(20) not null,
sc_manager varchar(10) not null
);

제조업체 정보
insert into supCom values('오리온','02-111-1444','서울시', '김길동');
insert into supCom values('농심','02-223-5644','서울시', '박농심');
insert into supCom values('해태','031-544-1004','수원시', '김해태');
insert into supCom values('롯데','031-256-2000','파주시', '최롯데');
+-----------+--------------+-----------+------------+
| sc_name   | sc_tel       | sc_addr   | sc_manager |
+-----------+--------------+-----------+------------+
| 농심      | 02-223-5644  | 서울시    | 박농심     |
| 롯데      | 031-256-2000 | 파주시    | 최롯데     |
| 오리온    | 02-111-1444  | 서울시    | 김길동     |
| 해태      | 031-544-1004 | 수원시    | 김해태     |
+-----------+--------------+-----------+------------+

공급정보 테이블
create table supply(
sc_name varchar(20) ,
p_no varchar(6) ,
su_date timestamp not null default now(),
su_count int not null,
su_no varchar(26) primary key,
foreign key(sc_name) references supCom(sc_name)
on delete set null on update cascade,
foreign key(p_no) references product(p_no)
on delete set null on update cascade
);

공급정보 튜플
insert into supply values('오리온','2334',default, 21, '오리온2334');
insert into supply values('오리온','3311',default, 60, '오리온3311');
insert into supply values('오리온','6442',default, 50, '오리온6442');
insert into supply values('농심','1111',default, 60, '농심1111');
insert into supply values('농심','0012',default, 90, '농심0012');
insert into supply values('해태','4332',default, 120, '해태4332');
insert into supply values('해태','3452',default, 40, '해태3452');
insert into supply values('롯데','1132',default, 25, '롯데1132');
insert into supply values('롯데','2222',default, 25, '롯데2222');
+-----------+------+---------------------+----------+---------------+
| sc_name   | p_no | su_date             | su_count | su_no         |
+-----------+------+---------------------+----------+---------------+
| 농심      | 0012 | 2022-08-09 12:40:31 |       90 | 농심0012      |
| 농심      | 1111 | 2022-08-09 12:40:31 |       60 | 농심1111      |
| 롯데      | 1132 | 2022-08-09 12:40:31 |       25 | 롯데1132      |
| 롯데      | 2222 | 2022-08-09 12:40:32 |       25 | 롯데2222      |
| 오리온    | 2334 | 2022-08-09 12:40:31 |       21 | 오리온2334    |
| 오리온    | 3311 | 2022-08-09 12:40:31 |       60 | 오리온3311    |
| 오리온    | 6442 | 2022-08-09 12:40:31 |       50 | 오리온6442    |
| 해태      | 3452 | 2022-08-09 12:40:31 |       40 | 해태3452      |
| 해태      | 4332 | 2022-08-09 12:40:31 |      120 | 해태4332      |
+-----------+------+---------------------+----------+---------------+

회원정보 테이블
create table member(
m_id varchar(20) primary key,
m_pwd varchar(20) not null,
m_name varchar(10) not null,
m_age int,
m_job varchar(20),
m_grade varchar(1) not null default 'D',
m_point int not null default 0
);

회원정보 튜플
insert into member values('aaaa','1111','홍길동',14,'없음','D',5),
('BaBa','2171','이길동',34,'회사원','b',40),
('SaSa','1191','고길동',24,'학생','C',32),
('LaLa','7171','조길동',64,'농부','A',50),
('CaCa','4121','김길동',44,'소방관','C',30),
('kaka','1218','박길동',30,'경찰','B',40 );
+------+-------+-----------+-------+-----------+---------+---------+
| m_id | m_pwd | m_name    | m_age | m_job     | m_grade | m_point |
+------+-------+-----------+-------+-----------+---------+---------+
| aaaa | 1111  | 홍길동    |    14 | 없음      | D       |       5 |
| BaBa | 2171  | 이길동    |    34 | 회사원    | b       |      40 |
| CaCa | 4121  | 김길동    |    44 | 소방관    | C       |      30 |
| kaka | 1218  | 박길동    |    30 | 경찰      | B       |      40 |
| LaLa | 7171  | 조길동    |    64 | 농부      | A       |      50 |
| SaSa | 1191  | 고길동    |    24 | 학생      | C       |      32 |
+------+-------+-----------+-------+-----------+---------+---------+

게시글 테이블
create table post(
po_no int primary key auto_increment,
po_title varchar(20) not null,
po_text varchar(20),
po_date timestamp not null default now(),
m_id varchar(20) ,
foreign key(m_id) references member(m_id)
on delete set null
on update cascade
);

게시글 튜플
insert into post values(default,'처음방문','과자',default,'aaaa');
insert into post values(default,'원하는물품','와인매장은 없나요',default,'BaBa');
insert into post values(default,'배송문의','언제쯤 받을수있을까요',default,'SaSa');
insert into post values(default,'반품','원하는물건이아님',default,'LaLa');
insert into post values(default,'교환문의','제품에 교환',default,'CaCa');
insert into post values(default,'서비스','너무 만족합니다',default,'kaka');
+-------+-----------------+---------------------------------+---------------------+------+
| po_no | po_title        | po_text                         | po_date             | m_id |
+-------+-----------------+---------------------------------+---------------------+------+
|     1 | 처음방문        | 과자                            | 2022-08-09 13:02:51 | aaaa |
|     2 | 원하는물품      | 와인매장은 없나요               | 2022-08-09 13:02:51 | BaBa |
|     3 | 배송문의        | 언제쯤 받을수있을까요           | 2022-08-09 13:02:51 | SaSa |
|     4 | 반품            | 원하는물건이아님                | 2022-08-09 13:02:51 | LaLa |
|     5 | 교환문의        | 제품에 교환                     | 2022-08-09 13:02:51 | CaCa |
|     6 | 서비스          | 너무 만족합니다                 | 2022-08-09 13:02:52 | kaka |
+-------+-----------------+---------------------------------+---------------------+------+

주문정보 테이블
create table ord(
or_no varchar(20) primary key,
or_count int not null default 0,
or_addr varchar(20) not null,
or_date timestamp not null default now(),
m_id varchar(20),
p_no varchar(6),
foreign key(m_id) references member(m_id)
on delete set null
on update cascade,
foreign key(p_no) references product(p_no)
on delete set null
on update cascade
);

주문정보 튜플
insert into ord values('aaaa1111','2','수원',default,'aaaa','1111'),
('BaBa2334','3','수원',default,'BaBa','2334'),
('BaBa0012','4','용인',default,'BaBa','0012'),
('CaCa4332','2','판교',default,'CaCa','4332'),
('LaLa6442','6','안산',default,'LaLa','6442'),
('KaKa2334','5','수원',default,'kaka','2334'),
('CaCa2222','10','수원',default,'aaaa','2222'),
('aaaa2334','1','수원',default,'aaaa','2334');

+----------+----------+---------+---------------------+------+------+
| or_no    | or_count | or_addr | or_date             | m_id | p_no |
+----------+----------+---------+---------------------+------+------+
| aaaa1111 |        2 | 수원    | 2022-08-09 12:54:52 | aaaa | 1111 |
| aaaa2334 |        1 | 수원    | 2022-08-09 12:54:52 | aaaa | 2334 |
| BaBa0012 |        4 | 용인    | 2022-08-09 12:54:52 | BaBa | 0012 |
| BaBa2334 |        3 | 수원    | 2022-08-09 12:54:52 | BaBa | 2334 |
| CaCa2222 |       10 | 수원    | 2022-08-09 12:54:52 | aaaa | 2222 |
| CaCa4332 |        2 | 판교    | 2022-08-09 12:54:52 | CaCa | 4332 |
| KaKa2334 |        5 | 수원    | 2022-08-09 12:54:52 | kaka | 2334 |
| LaLa6442 |        6 | 안산    | 2022-08-09 12:54:52 | LaLa | 6442 |
+----------+----------+---------+---------------------+------+------+


문제
1. 포인트가 30 초과인 회원들의 이름과 아이디와 등급과 포인트를 검색하시오. 
 select m_name, m_id,m_grade,m_point from member where m_point>30;
+-----------+------+---------+---------+
| m_name    | m_id | m_grade | m_point |
+-----------+------+---------+---------+
| 이길동    | BaBa | b       |      40 |
| 박길동    | kaka | B       |      40 |
| 조길동    | LaLa | A       |      50 |
| 고길동    | SaSa | C       |      32 |
+-----------+------+---------+---------+

2. 현재 포인트에서 +10으로 보정한 포인트,회원이름을 출력하시오.
select m_name, m_point+10 from member;
+-----------+------------+
| m_name    | m_point+10 |
+-----------+------------+
| 홍길동    |         15 |
| 이길동    |         50 |
| 김길동    |         40 |
| 박길동    |         50 |
| 조길동    |         60 |
| 고길동    |         42 |
+-----------+------------+

3. 회원중 '이길동'이 '이둘리'로 개명하였다. 이를 적용하여 회원명, 회원아이디를 출력하시오.
select replace(m_name,'이길동','이둘리'), m_id from member;
+-----------------------------------------+------+
| replace(m_name,'이길동','이둘리')       | m_id |
+-----------------------------------------+------+
| 홍길동                                  | aaaa |
| 이둘리                                  | BaBa |
| 김길동                                  | CaCa |
| 박길동                                  | kaka |
| 조길동                                  | LaLa |
| 고길동                                  | SaSa |
+-----------------------------------------+------+

4. 상품 중 가장 단가가 비싼 3개의 단가와 상품명을 출력하시오.
select p_price,p_name from product order by p_price desc limit 0,3;
+---------+--------------------+
| p_price | p_name             |
+---------+--------------------+
|    8700 | 초코파이18입       |
|    1500 | 촉촉한초코칩       |
|     900 | 감동란2입          |
+---------+--------------------+

5. 제조업체 정보에서 제조업체명,담당자명을 출력하시오. 단, 담당자의 개인정보보안을 위해 박*심으로 출력하시오.
select sc_name, concat(left(sc_manager,1),'*',right(sc_manager,1)) sc_manager from supCom;
+-----------+------------+
| sc_name   | sc_manager |
+-----------+------------+
| 농심      | 박*심      |
| 롯데      | 최*데      |
| 오리온    | 김*동      |
| 해태      | 김*태      |
+-----------+------------+

6. 상품정보에서 상품명 초코파이18입의 총 재고금액(재고량*단가)과 상품명을 출력하시오.
select p_name,p_count*p_price '총재고금액' from product where p_name='초코파이18입';
+-------------------+-----------------+
| p_name            | 총재고금액      |
+-------------------+-----------------+
| 초코파이18입      |          130500 |
+-------------------+-----------------+

7. 공급정보에서 제조업체별 가장 많은 공급양, 가장 적은 공급양, 평균 공급양(반올림하여 1의자리까지나타낸다.), 제조업체를 출력하시오.
select max(su_count), min(su_count), round(avg(su_count),0),sc_name from supply group by sc_name;
+---------------+---------------+------------------------+-----------+
| max(su_count) | min(su_count) | round(avg(su_count),0) | sc_name   |
+---------------+---------------+------------------------+-----------+
|            90 |            60 |                     75 | 농심      |
|            25 |            25 |                     25 | 롯데      |
|            60 |            21 |                     44 | 오리온    |
|           120 |            40 |                     80 | 해태      |
+---------------+---------------+------------------------+-----------+

8. 회원정보에서 등급별 회원에 평균나이,등급을 출력하시오.
 select avg(m_age),m_grade from member group by m_grade;
+------------+---------+
| avg(m_age) | m_grade |
+------------+---------+
|    14.0000 | D       |
|    32.0000 | b       |
|    34.0000 | C       |
|    64.0000 | A       |
+------------+---------+

9. 회원정보에서 회원등급별 총 회원수를 회원등급, 총 회원수로 출력하시오.
select m_grade, count(*) from member group by m_grade;
+---------+----------+
| m_grade | count(*) |
+---------+----------+
| D       |        1 |
| b       |        2 |
| C       |        2 |
| A       |        1 |
+---------+----------+

10. 상품정보에서 단가가 높은 상품 2개를 10% 할인하여 기존 단가와 할인된 단가를 출력하시오.
select p_price, p_price*0.9 from product order by p_price desc limit 0,2;
+---------+-------------+
| p_price | p_price*0.9 |
+---------+-------------+
|    8700 |      7830.0 |
|    1500 |      1350.0 |
+---------+-------------+

11. 회원정보에서 회원명, 회원아이디, 등급을 출력하시오 단, 등급은 모두 대문자로 출력하시오.
select m_name, m_id, upper(m_grade) from member;
+-----------+------+----------------+
| m_name    | m_id | upper(m_grade) |
+-----------+------+----------------+
| 홍길동    | aaaa | D              |
| 이길동    | BaBa | B              |
| 김길동    | CaCa | C              |
| 박길동    | kaka | B              |
| 조길동    | LaLa | A              |
| 고길동    | SaSa | C              |
+-----------+------+----------------+

12. 주문정보에서 회원별 총주문양을 회원아이디, 총주문량으로 출력하시오.
select m_id, sum(or_count) from ord group by m_id;
+------+---------------+
| m_id | sum(or_count) |
+------+---------------+
| aaaa |            13 |
| BaBa |             7 |
| CaCa |             2 |
| kaka |             5 |
| LaLa |             6 |
+------+---------------+

13. 게시글정보에서 모든 정보를 출력하시오 단, 게시글에 시간을 그대로 출력하지 말고 xx 년 xx 월 xx 일 xx 시 xx 분 xx 초 형식으로 출력한다. 
select po_no, po_title, po_text, date_format(po_date,'%y년%m월%d일%h시%i분%s초') po_date, m_id from post;
+-------+-----------------+---------------------------------+--------------------------------+------+
| po_no | po_title        | po_text                         | po_date                        | m_id |
+-------+-----------------+---------------------------------+--------------------------------+------+
|     1 | 처음방문        | 과자                            | 22년08월09일01시02분51초       | aaaa |
|     2 | 원하는물품      | 와인매장은 없나요               | 22년08월09일01시02분51초       | BaBa |
|     3 | 배송문의        | 언제쯤 받을수있을까요           | 22년08월09일01시02분51초       | SaSa |
|     4 | 반품            | 원하는물건이아님                | 22년08월09일01시02분51초       | LaLa |
|     5 | 교환문의        | 제품에 교환                     | 22년08월09일01시02분51초       | CaCa |
|     6 | 서비스          | 너무 만족합니다                 | 22년08월09일01시02분52초       | kaka |
+-------+-----------------+---------------------------------+--------------------------------+------+

14. 회원정보에서 30대인 회원에 아이디,이름,나이,직업을 출력하시오.
select m_id, m_name, m_age, m_job from member where m_age between 30 and 39;
+------+-----------+-------+-----------+
| m_id | m_name    | m_age | m_job     |
+------+-----------+-------+-----------+
| BaBa | 이길동    |    34 | 회사원    |
| kaka | 박길동    |    30 | 경찰      |
+------+-----------+-------+-----------+

15. 상품정보에서 상품가격이 높은 순으로 3번째부터 6번째까지 상품명,가격을 출력하시오.
select p_name, p_price from product order by p_price desc limit 2,4;
+------------------------+---------+
| p_name                 | p_price |
+------------------------+---------+
| 감동란2입              |     900 |
| 신라면                 |     800 |
| 새우깡                 |     800 |
| 빼빼로 오리지널        |     700 |
+------------------------+---------+


4조 문제

회원테이블
create table member(
id varchar(10) primary key,
pswd varchar(10) not null,
name varchar(10) not null,
age int ,
job varchar(10),
grade int default 1,
point int default 0
);

아이템테이블
create table item(   
no int  primary key auto_increment,
name varchar(10) not null,
restcount int default 0,  
price int
);

공급업체테이블
create table company(    
name varchar(20) primary key,
tel varchar(10),
addr varchar(20),
director varchar(100)
);

게시글테이블
create table board(
no int primary key auto_increment,
name varchar(20) not null,
contents varchar(100) not null,
wdate timestamp  default now(),
id varchar(10),
foreign key (id) references member (id) on update cascade on delete set null
);

주분테이블
create table iorder(   
orderno int primary key auto_increment,
count int default 1,
addr varchar(50) not null,
odate timestamp default now(),
id varchar(10),
no int,
foreign key (id)
references member(id) on update cascade on delete set null,
foreign key (no)
references item(no) on update cascade on delete set null
);

공급테이블
create table supply(
supplyno int primary key auto_increment,
sdate timestamp default now(),
supplycount int default 10,
no int,
cname varchar(20),
foreign key(no)
references  item(no) on update cascade on delete set null,
foreign key(cname)
references company(name) on update cascade on delete set null 
);


회원튜플
insert into member values('gkdud','0713','김하영',26,'baker',3,30);
insert into member values('eo01','1934','강덕구',59,'chemist',1,default);
insert into member values('cke99','a943','고은지',32,'nurse',5,78);
insert into member values('bl33','b232','최은철',47,'detective',1,default);
insert into member values('go55','od05','공유',36,'actor',7,500);

item 튜플
insert into item values(392,'toothbrush',30,800);
insert into item values(493,'laptop',5,2000000);
insert into item values(52,'soap',20,1200);
insert into item values(921,'towel',18,7000);
insert into item values(5,'tumbler',1,30000);

회사튜플
insert into company values('최고짱','2222-3333','suwon','관리잘함');
insert into company values('스다벅스','2356-6666','yongin','영업잘함');
insert into company values('샘송','5467-1111','seoul','운전잘함');
insert into company values('앱블','3565-8777','seoul','엑셀잘함');
insert into company values('지구','4451-7865','deagu','사회생활잘함');

주문튜플
insert into iorder values(23,default,'suwon',now(),'go55',493);
insert into iorder values(default,default,'suwon',now(),'go55',392);
insert into iorder values(default,default,'anyang',now(),'gkdud',52);
insert into iorder values(default,default,'jeju',now(),'eo01',921);
insert into iorder values(default,default,'kangwon',now(),'bl33',5);

공급튜플
insert into supply values(default,now(),default,52,'지구');
insert into supply values(default,now(),default,392,'최고짱');
insert into supply values(default,now(),default,493,'앱블');
insert into supply values(default,now(),default,5,'스다벅스');
insert into supply values(default,now(),default,921,'샘송');

게시글튜플
insert into board values(default,'칫솔가격','개싸다',default,'gkdud');
insert into board values(default,'노트북이거','원래 이렇게 비쌌음?',default,'eo01');
insert into board values(default,'비누 먹어본사람?','그걸왜먹어?',default,'cke99');
insert into board values(default,'타올 이거','사는사람있음?',default,'bl33');
insert into board values(default,'텀블러요고는','스다벅스에서 많이 사더라',default,'go55');

select * from member;
+-------+------+-----------+------+-----------+-------+-------+
| id    | pswd | name      | age  | job       | grade | point |
+-------+------+-----------+------+-----------+-------+-------+
| bl33  | b232 | 최은철    |   47 | detective |     1 |     0 |
| cke99 | a943 | 고은지    |   32 | nurse     |     5 |    78 |
| eo01  | 1934 | 강덕구    |   59 | chemist   |     1 |     0 |
| gkdud | 0713 | 김하영    |   26 | baker     |     3 |    30 |
| go55  | od05 | 공유      |   36 | actor     |     7 |   500 |
+-------+------+-----------+------+-----------+-------+-------+

select * from item;
+-----+------------+-----------+---------+
| no  | name       | restcount | price   |
+-----+------------+-----------+---------+
|   5 | tumbler    |         1 |   30000 |
|  52 | soap       |        20 |    1200 |
| 392 | toothbrush |        30 |     800 |
| 493 | laptop     |         5 | 2000000 |
| 921 | towel      |        18 |    7000 |
+-----+------------+-----------+---------+

select * from company;
+--------------+-----------+--------+--------------------+
| name         | tel       | addr   | director           |
+--------------+-----------+--------+--------------------+
| 샘송         | 5467-1111 | seoul  | 운전잘함           |
| 스다벅스     | 2356-6666 | yongin | 영업잘함           |
| 앱블         | 3565-8777 | seoul  | 엑셀잘함           |
| 지구         | 4451-7865 | deagu  | 사회생활잘함       |
| 최고짱       | 2222-3333 | suwon  | 관리잘함           |
+--------------+-----------+--------+--------------------+

select * from board;
+----+-------------------------+-------------------------------------+---------------------+-------+
| no | name                    | contents                            | wdate               | id    |
+----+-------------------------+-------------------------------------+---------------------+-------+
|  1 | 칫솔가격                | 개싸다                              | 2022-08-09 16:29:36 | gkdud |
|  2 | 노트북이거              | 원래 이렇게 비쌌음?                 | 2022-08-09 16:29:36 | eo01  |
|  3 | 비누 먹어본사람?        | 그걸왜먹어?                         | 2022-08-09 16:29:36 | cke99 |
|  4 | 타올 이거               | 사는사람있음?                       | 2022-08-09 16:29:36 | bl33  |
|  5 | 텀블러요고는            | 스다벅스에서 많이 사더라            | 2022-08-09 16:29:36 | go55  |
+----+-------------------------+-------------------------------------+---------------------+-------+

select * from iorder;
+---------+-------+---------+---------------------+-------+------+
| orderno | count | addr    | odate               | id    | no   |
+---------+-------+---------+---------------------+-------+------+
|      23 |     1 | suwon   | 2022-08-09 16:29:23 | go55  |  493 |
|      24 |     1 | suwon   | 2022-08-09 16:29:23 | go55  |  392 |
|      25 |     1 | anyang  | 2022-08-09 16:29:23 | gkdud |   52 |
|      26 |     1 | jeju    | 2022-08-09 16:29:23 | eo01  |  921 |
|      27 |     1 | kangwon | 2022-08-09 16:29:23 | bl33  |    5 |
+---------+-------+---------+---------------------+-------+------+

select * from supply;
+----------+---------------------+-------------+------+--------------+
| supplyno | sdate               | supplycount | no   | cname        |
+----------+---------------------+-------------+------+--------------+
|        1 | 2022-08-09 16:29:29 |          10 |   52 | 지구         |
|        2 | 2022-08-09 16:29:29 |          10 |  392 | 최고짱       |
|        3 | 2022-08-09 16:29:29 |          10 |  493 | 앱블         |
|        4 | 2022-08-09 16:29:29 |          10 |    5 | 스다벅스     |
|        5 | 2022-08-09 16:29:29 |          10 |  921 | 샘송         |
+----------+---------------------+-------------+------+--------------+

문제
1. 30살 이상의 고객의 이름과 아이디를 출력하시오
select name, id from member where age >=30;
+-----------+-------+
| name      | id    |
+-----------+-------+
| 최은철    | bl33  |
| 고은지    | cke99 |
| 강덕구    | eo01  |
| 공유      | go55  |
+-----------+-------+

2. 등급이 5 이상인 고객의 직업과 나이를 출력하시오
 select job, age from member where grade >=5;
+-------+------+
| job   | age  |
+-------+------+
| nurse |   32 |
| actor |   36 |
+-------+------+

3. 회원의 아이디와 이름을 출력하시오.
select id, name from member;
+-------+-----------+
| id    | name      |
+-------+-----------+
| bl33  | 최은철    |
| cke99 | 고은지    |
| eo01  | 강덕구    |
| gkdud | 김하영    |
| go55  | 공유      |
+-------+-----------+

4. 게시글의 제목과 내용을 출력하시오.
select name, contents from board;
+-------------------------+-------------------------------------+
| name                    | contents                            |
+-------------------------+-------------------------------------+
| 칫솔가격                | 개싸다                              |
| 노트북이거              | 원래 이렇게 비쌌음?                 |
| 비누 먹어본사람?        | 그걸왜먹어?                         |
| 타올 이거               | 사는사람있음?                       |
| 텀블러요고는            | 스다벅스에서 많이 사더라            |
+-------------------------+-------------------------------------+

5. 전체회원을 출력하시오, (이름을 기준으로 오름차순)
 select name from member order by name asc;
+-----------+
| name      |
+-----------+
| 강덕구    |
| 고은지    |
| 공유      |
| 김하영    |
| 최은철    |
+-----------+

6. 아이디가 5글자 이상인 회원만 출력하시오(아이디와 이름만 출력)
select id, name from member where length(id)>=5;
+-------+-----------+
| id    | name      |
+-------+-----------+
| cke99 | 고은지    |
| gkdud | 김하영    |
+-------+-----------+

7. 가장저렴한 아이템의 이름과 가격을 출력하시오
select name, price from item order by price asc limit 0,1;
+------------+-------+
| name       | price |
+------------+-------+
| toothbrush |   800 |
+------------+-------+

8. 1000원이상 10000원 미만의 아이템의 이름과 수량을 출력하시오.
select name, restcount from item where price >=1000 and price <10000;
+-------+-----------+
| name  | restcount |
+-------+-----------+
| soap  |        20 |
| towel |        18 |
+-------+-----------+

9. 가격이 높은 순으로 2~4번째 아이템을 출력하세요(아이템명과 가격만 출력)
select name, price from item order by price desc limit 1,3;
+---------+-------+
| name    | price |
+---------+-------+
| tumbler | 30000 |
| towel   |  7000 |
| soap    |  1200 |
+---------+-------+

10. 샘송이 회사이름을 샘숭으로 바꿨습니다. 이를 처리하세요.
update company set name='샘숭' where name='샘송';

11. 전체 towel을 다 팔았을때 총액을 출력하시오.
select restcount*price 총액 from item where name='towel';
+--------+
| 총액   |
+--------+
| 126000 |
+--------+

12. 아이템의 평균 가격을 출력하세요.
select avg(price) from item;
+-------------+
| avg(price)  |
+-------------+
| 407800.0000 |
+-------------+

13. 이름에 'l'(알파벳 L)이 들어가 아이템을 출력하시오.(이름과 가격만 출력)
select name, price from item where name like '%l%';
+---------+---------+
| name    | price   |
+---------+---------+
| tumbler |   30000 |
| laptop  | 2000000 |
| towel   |    7000 |
+---------+---------+

14. 회사에 주소 's'로 시작하는 회사의 회사명과 전화번호를 출력하시오.
select name, tel from company where addr like 's%';
+-----------+-----------+
| name      | tel       |
+-----------+-----------+
| 샘숭      | 5467-1111 |
| 앱블      | 3565-8777 |
| 최고짱    | 2222-3333 |
+-----------+-----------+

15. 'toothbrush'가격이 1200원으로 올랐습니다. 이를 처리하세요.
 update item set price=1200 where name='toothbrush';

16. 택배파업으로 'suwon'지역은 택배가 불가합니다. 택배 불가한 주문건을 출력하세요.(주문번호,주문지역,아이디 출력)
select orderno, addr, id from iorder where addr='suwon';
+---------+-------+------+
| orderno | addr  | id   |
+---------+-------+------+
|      23 | suwon | go55 |
|      24 | suwon | go55 |
+---------+-------+------+
*/
