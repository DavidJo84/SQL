create table word1(
eng varchar2(20) primary key,
kor varchar2(30),
imp varchar2(2),
comm varchar2(20),
misscnt number default 0
);

select * from word1;

truncate table word1;

select * from word1 where eng like 'apple';

drop table word1;

create table member2(
id varchar2(10) primary key,
name varchar2(10),
pass varchar2(10),
addr varchar2(50),
point number default 0
);

desc member2;
select * from member2;
select * from member2 where id = 'aaaa';
drop table member;

select * from member2 where id like '%го%' or name like '%го%';
/
create table goods(
gid varchar2(10) primary key,
gname varchar2(10),
gprice number default 0,
gcnt number default 0,
selName varchar2(10),
gdate timestamp default sysdate
);
/
alter table goods MODIFY gname varchar(20);

create table gbasket(
no number primary key,
id varchar2(10),
gid varchar2(10),
buyDate timestamp default sysdate,
buyCnt number,
foreign key(id) REFERENCES member2(id)
on delete set null,
foreign key(gid) REFERENCES goods(gid)
on delete set null
);

create sequence no
increment by 1
start with 1
nocycle
;
/
create or replace trigger mem_bask
after update of id on member2
for each row
begin
  update gbasket
  set id=:new.id
  where id=:old.id;
end;
/

create or replace trigger goods_bask
after update of gid on goods
for each row
begin
  update gbasket
  set gid=:new.gid
  where gid=:old.gid;
end;
/
create or replace trigger updategcnt
after insert on gbasket
for each row
begin
  update goods 
  set gcnt=:old.gcnt - :new.buyCnt
  where gid=:new.gid;
end;
/

select * from goods;
select * from gbasket;
insert into gbasket values (no.nextval, 'aaaa' , 'a222', default, 2);
desc goods;
select * from goods where gcnt>(select avg(gcnt) from goods);
drop trigger updategcnt;
desc gbasket;

select * from member2 where id ='aaaa' and pass='1111';

create view goodsBasket as
select distinct g.gid, g.gname, g.selname, g.gprice, b.buydate, b.buycnt, m.id, m.addr
from goods g, member2 m, gbasket b
where g.gid = b.gid and m.id = b.id;

select * from goodsBasket;
select * from goodsBasket where id ='aaaa';