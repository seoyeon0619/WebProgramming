create table tb_guestbook
(
    seq number primary key,
    title   varchar2(400),
    writer  varchar2(100),
    contents clob,
    wdate   date,
    hit     int 
);

create sequence sq_guest;

insert into tb_guestbook(seq, title, writer, contents, wdate, hit) values(sq_guest.nextval, '제목1', '작성자1', '내용1', sysdate, 0);
insert into tb_guestbook(seq, title, writer, contents, wdate, hit) values(sq_guest.nextval, '제목2', '작성자2', '내용2', sysdate, 0);
insert into tb_guestbook(seq, title, writer, contents, wdate, hit) values(sq_guest.nextval, '제목3', '작성자3', '내용3', sysdate, 0);
commit;

select * from tb_guestbook;



create sequence sq_score;
create table tb_score
(
    seq number primary key,
    name varchar2(40),
    kor number,
    eng number,
    mat number,
    wdate date
);

delete from tb_score;
insert into tb_score (seq, name, kor, eng, mat, wdate) values(sq_guest.nextval, '일길동', 76, 95, 90, sysdate);
insert into tb_score (seq, name, kor, eng, mat, wdate) values(sq_guest.nextval, '이길동', 55, 27, 84, sysdate);
insert into tb_score (seq, name, kor, eng, mat, wdate) values(sq_guest.nextval, '삼길동', 44, 90, 64, sysdate);
insert into tb_score (seq, name, kor, eng, mat, wdate) values(sq_guest.nextval, '사길동', 88, 77, 55, sysdate);
commit;

select*from tb_score;

