create database wornggame;
use wornggame;
show tables;

create table user(
id varchar(10) primary key,
password varchar(10) not null,
name varchar(10) not null,
point int default 0
);

create table word(
word varchar(20) primary key,
mean varchar(20) not null,
memo varchar(20),
impt varchar(2) not null
);

create table worngword(
id varchar(10),
word varchar(20) not null,
answer varchar(20) not null,
foreign key(id) references user(id)
on update cascade
on delete set null,
foreign key(word) references word(word)
on update cascade
on delete cascade
);

drop table worngword;

desc user;
desc word;
desc worngword;
