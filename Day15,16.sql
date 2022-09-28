/*
- 자료형(문자, 숫자, 날짜) 암기와 이해
- 함수: max, min, avg, count,다른함수는 찾아서 할 수 있도록.
- 테이블 조인(이너조인, 아우터 조인)
- 테이블 생성 명령어(create, drop, alter(modify, add))
- DCL 명령어: commit, rollback
- 인덱스: 특징, 인덱스 생성 방법(기본키는 자동 생성, 자주 검색하는 컬럼은 create 명령어로 생성 가능), 삭제 방법
어떻게 사용하는게 좋을지 생각.
- 뷰: 특징, 생성방법

- 많이 사용했던 명령어등
desc, DCL, DML, DDL

*오류를 범할 수 있는 것 체크
1. 오라클에서 mysql의 auto_increment를 대처하기 위한 것이 시퀀스이다.(x)
2. 오라클에서는 외래키 옵션 설정 시 on update가 지원되지 않는다. 이것은 트리거를 활용하면 된다.
   트리거는 오라클에서 on update가 지원되지 않아서 나온 기술이다(x)
   
미니프로젝트
회원테이블
create table member(
mid varchar2(10) primary key,
mname varchar2(8) not null,
mpw varchar2(10) not null, 
maddr varchar2(5) not null,
mdate timestamp default sysdate,
mgrade number(1) check (mgrade between 1 and 5));

회원 insert
insert into member values ('aaaa','이영자','1111','수원',default,2);
insert into member values ('bbbb','박성수','2222','화성',default,2);
insert into member values ('cccc','김은정','3333','천안',default,3);
insert into member values ('dddd','최진호','4444','청주',default,5);
insert into member values ('eeee','이진우','5555','대전',default,4);
insert into member values ('ffff','오민지','6666','대구',default,3);
insert into member values ('gggg','임광수','7777','부산',default,5);
insert into member values ('hhhh','신노미','8888','제주',default,5);

수정
update member set mgrade=3 where mid='aaaa';
update member set mgrade=4 where mid='bbbb';
update member set mgrade=4 where mid='dddd';
update member set mgrade=3 where mid='eeee';
update member set mgrade=2 where mid='ffff';
update member set mgrade=2 where mid='gggg';
/
게시판 테이블
create table board(
no number primary key,
btitle varchar2(10),
bcontent varchar2(200),
bid varchar2(10),
bdate timestamp default sysdate,
foreign key(bid) references member(mid)
on delete set null
);
/

게시판 insert
nsert into board values(bno.nextval,'여진식당','양념게장이 맛잇어요','aaaa',default);
insert into board values(bno.nextval,'삼거리농원','닭볶음탕이 맛잇습니다','bbbb',default);
insert into board values(bno.nextval,'긴자참치','서비스가 너무좋아요','cccc',default);
insert into board values(bno.nextval,'나산축산','고기품질이 너무좋아요','dddd',default);
insert into board values(bno.nextval,'연탄구이','맛이 너무좋고 서비스가 좋아요','eeee',default);
insert into board values(bno.nextval,'디렉션','도넛이 깔끔하고 맛있습니다','ffff',default);
insert into board values(bno.nextval,'수원CVG','카라멜팝콘 맛집입니다','gggg',default);

insert into board values(bno.nextval,'술국전문집','술먹을때 안주로 너무좋습니다','ffff',default,'대전 유성','042-746-1785');
insert into board values(bno.nextval,'빨간닭발집','매운거 자신있는분들 추천합니다.','gggg',default,'경기 안산','031-419-7548');
insert into board values(bno.nextval,'경상도횟집','회가 싱싱하고 다시또오고싶어요~','ffff',default,'경기 용인','031-784-4258');
insert into board values(bno.nextval,'수원갈비집','양에 비해 가격이 너무 비싸요','gggg',default,'경기 수원','031-297-9729');
insert into board values(bno.nextval,'한식밥','외국인에게 한식소개할때 너무좋아요','aaaa',default,'강원 평창','033-445-6857');
insert into board values(bno.nextval,'양갈비','잡냄새가 안나고 또 가고싶을정도로 너무좋습니다','cccc',default,'충북 제천','043-316-7547');
insert into board values(bno.nextval,'해장국집','전날 먹은 술이 말끔하게 해장되여','eeee',default,'경남 마산','055-367-7546');
/


추가 속성
alter table board add(baddr varchar2(20));
alter table board add(btel varchar2(13));

update board set baddr= '전남 여수' ,btel= '061-685-7999' where bno=1;
update board set baddr= '전남 담양' ,btel= '507-1367-8798' where bno=2;
update board set baddr= '경기 수원' ,btel= '031-291-9757' where bno=3;
update board set baddr= '경기 수원' ,btel= '031-296-6384' where bno=4;
update board set baddr= '경기 수원' ,btel= '507-1410-4624' where bno=6;
update board set baddr= '경기 수원' ,btel= '1544-1122' where bno=7;

게시판 bno 시퀀스 명령어
create sequence bno
increment by 1
start with 1
minvalue 1
maxvalue 100
nocycle
;
/

댓글 테이블
create table review(
rid varchar2(10),
rno number,
rtext varchar2(30) not null,
rdate timestamp default sysdate,
foreign key(rid) references member(mid)
on delete set null,
foreign key(rno) references board(bno)
on delete set null
);
/

참조테이블
create or replace trigger mem_re
after update of mid on member
for each row
begin
  update review
  set rid=:new.mid
  where rid=:old.mid;
end;
/
create or replace trigger bo_re
after update of bno on board
for each row
begin
  update review
  set rno=:new.bno
  where rno=:old.bno;
end;
/
create or replace trigger mem_bo
after update of mid on member
for each row
begin
  update board
  set bid=:new.mid
  where bid=:old.mid;
end;
/

member 테이블
mid	mname	mpw	maddr	mdate				mgrade
aaaa	이영자	1111	수원	22/08/18 09:38:53.000000000	3
bbbb	박성수	2222	화성	22/08/18 09:38:53.000000000	4
cccc	김은정	3333	천안	22/08/18 09:38:53.000000000	3
dddd	최진호	4444	청주	22/08/18 09:38:53.000000000	4
eeee	이진우	5555	대전	22/08/18 09:38:53.000000000	3
ffff	오민지	6666	대구	22/08/18 09:38:53.000000000	2
gggg	임광수	7777	부산	22/08/18 09:38:53.000000000	2
hhhh	신노미	8888	제주	22/08/18 10:13:46.000000000	5

board테이블
bno	btitle		bcontent				bid	bdate				baddr	btel
1	여진식당		양념게장이 맛잇어요		aaaa	22/08/18 09:39:23.000000000	전남 여수	061-685-7999
2	삼거리농원	닭볶음탕이 맛잇습니다		bbbb	22/08/18 09:39:23.000000000	전남 담양	507-1367-8798
3	긴자참치		서비스가 너무좋아요		cccc	22/08/18 09:39:23.000000000	경기 수원	031-291-9757
4	나산축산		고기품질이 너무좋아요		dddd	22/08/18 09:39:23.000000000	경기 수원	031-296-6384
6	디렉션		도넛이 깔끔하고 맛있습니다		ffff	22/08/18 09:39:23.000000000	경기 수원	507-1410-4624
7	수원CVG		카라멜팝콘 맛집입니다		gggg	22/08/18 09:39:23.000000000	경기 수원	1544-1122
5	연탄구이		맛이 너무좋고 서비스가 좋아요	eeee	22/08/18 10:19:37.000000000	전남 여수	064-738-0018
8	술국전문집	술먹을때 안주로 너무좋습니다	ffff	22/08/18 10:19:37.000000000	대전 유성	042-746-1785
9	빨간닭발집	매운거 자신있는분들 추천합니다.	gggg	22/08/18 10:19:37.000000000	경기 안산	031-419-7548
10	경상도횟집	회가 싱싱하고 다시또오고싶어요~	ffff	22/08/18 10:19:37.000000000	경기 용인	031-784-4258
11	수원갈비집	양에 비해 가격이 너무 비싸요	gggg	22/08/18 10:19:37.000000000	경기 수원	031-297-9729
12	한식밥		외국인에게 한식소개할때 너무좋아요	aaaa	22/08/18 10:19:37.000000000	강원 평창	033-445-6857
13	양갈비		잡냄새가 안나고 또 가고싶을정도로 
			너무좋습니다			cccc	22/08/18 10:19:37.000000000	충북 제천	043-316-7547
14	해장국집		전날 먹은 술이 말끔하게 해장되여	eeee	22/08/18 10:19:37.000000000	경남 마산	055-367-7546

review테이블
rid	rno	rtext			rdate
bbbb	1	찐맛집인정		22/08/18 10:36:06.000000000
ffff	1	게장 굿			22/08/18 10:36:08.000000000
eeee	1	먹다 이나가는줄		22/08/18 10:36:10.000000000
bbbb	2	닭이커요			22/08/18 10:36:24.000000000
cccc	3	참치가신선해요		22/08/18 10:36:24.000000000
bbbb	3	나는 별루였음		22/08/18 10:36:24.000000000
eeee	4	한우투쁠최고		22/08/18 10:36:24.000000000
ffff	5	돼지파의 성지		22/08/18 10:36:24.000000000
aaaa	5	연탄향이 좋아요		22/08/18 10:36:24.000000000
bbbb	6	달콤한 도넛 좋아요 	22/08/18 10:36:24.000000000
dddd	5	돼지먹고 돼지됨		22/08/18 10:36:24.000000000
aaaa	8	해장은 이집		22/08/18 10:36:24.000000000
dddd	8	국물이 끝내줘요		22/08/18 10:36:24.000000000
cccc	9	매운닭발 최고		22/08/18 10:36:24.000000000
dddd	10	스끼다시 잘나와요		22/08/18 10:36:24.000000000
eeee	10	매운탕맛집		22/08/18 10:36:24.000000000
ffff	12	분위기 굿			22/08/18 10:36:24.000000000
gggg	13	누린내없어욧		22/08/18 10:36:24.000000000
aaaa	13	소고기보다 맛남		22/08/18 10:36:24.000000000
bbbb	14	해장이 싹			22/08/18 10:36:24.000000000
cccc	14	국물이 찐해요		22/08/18 10:36:24.000000000
eeee	14	술마시면필수		22/08/18 10:36:24.000000000

문제

1.게시판 글작성
insert into board values(bno.nextval,'최고','정말 맛있습니다.','aaaa',default,'서울특별시','02-476-3258');

2.게시판 글수정
update board set bcontent='new bcontent' where bno='30';

3.게시판 글삭제
delete from board where bno='5';

4.게시판 글 전체보기(7개씩만 화면에 출력)
select b.bno, b.btitle, b.bid, to_char(bdate,'rrrr.mm.dd') ,count(r.rno)
from (select * from board where bno between 1 and 7) b left outer join review r on b.bno=r.rno
group by r.rno, b.bdate,b.bno, b.btitle, b.bid order by b.bno asc;


오라클에서는 mysql의 limit기능이 없어 rownum을 활용한 특정 갯수의 튜플을 출력하기
5.회원 ffff가 쓴 글을 검색하기(2부터 3까지만 화면에 출력)
select b.bno, b.btitle, b.bid, to_char(bdate,'rrrr.mm.dd'),count(r.rno)
from (select * from (select rownum count, b.* from board b where bid='ffff' order by bno asc) where count between 2 and 3) b 
left outer join review r on b.bno=r.rno
group by r.rno, b.bdate,b.bno, b.btitle, b.bid order by b.bno asc;

6.글내용에 "좋아요" 있는 글 검색하기(2개씩만 화면에 출력)
select b.bno, b.btitle, b.bid, to_char(bdate,'rrrr.mm.dd'),count(r.rno)
from (select * from (sel6.ect rownum count, b.* from board b where bcontent like '%좋아요%' order by bno asc) where count between 1 and 2) b 
left outer join review r on b.bno=r.rno
group by r.rno, b.bdate,b.bno, b.btitle, b.bid order by b.bno asc;

7.경기도에 있는 식당 글 검색하기(10개씩만 화면에 출력)
select b.bno, b.btitle, b.bid, to_char(bdate,'rrrr.mm.dd'),count(r.rno)
from (select * from (select rownum count, b.* from board b where baddr like '%경기%' order by bno asc) where count between 1 and 10) b 
left outer join review r on b.bno=r.rno
group by r.rno, b.bdate,b.bno, b.btitle, b.bid order by b.bno asc;

8.나산축산이 장사가 잘되서 서울로 확장 이전을 했다. 주소와 전화번호를 수정하세요.
update board set baddr='서울특별시',btel='02-222-3455' where btitle='나산축산';

9.게시글을 리뷰가 많은 수로 정렬(글번호, 글제목, 회원아이디, 글게시일 출력, 리뷰수)
select b.bno, b.btitle, b.bcontent, b.bid, to_char(bdate,'rrrr.mm.dd'), cnt from board b 
inner join (select rno, count(rno) cnt from review group by rno order by count(rno) desc, rno asc) r
on b.bno=r.rno;

10. ffff가 작성한 글 수
select count(*) 글수  from board where bid='ffff';

11. 회원가입
insert into member values('iiii','우영우','1212','여수', default, default);

12. 회원수정(최진호 회원의 비밀번호가 '9999'로 변경되었다.)
update member set mpw='9999' where mname='최진호';

13. dddd 회원이 작성한 댓글 수
select count(*) 댓글수 from review where rid='dddd';

14.bbbb 회원이 남긴 댓글 중에 '좋아요'라는 단어가 있는 리뷰와 그 게시 시간을 출력
select rtext, to_char(rdate,'rrrr.mm.dd') 날짜 from review where rid='bbbb' and rtext like '%좋아요%'; 

15. aaaa가 남긴 댓글의 원글을 출력하시오.
select bno 글번호, btitle 제목, bid 아이디, to_char(bdate,'rrrr.mm.dd') 날짜 from board where bno in (select rno from review where rid='aaaa');

*/