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

insert into tb_guestbook(seq, title, writer, contents, wdate, hit) values(sq_guest.nextval, '����1', '�ۼ���1', '����1', sysdate, 0);
insert into tb_guestbook(seq, title, writer, contents, wdate, hit) values(sq_guest.nextval, '����2', '�ۼ���2', '����2', sysdate, 0);
insert into tb_guestbook(seq, title, writer, contents, wdate, hit) values(sq_guest.nextval, '����3', '�ۼ���3', '����3', sysdate, 0);
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
insert into tb_score (seq, name, kor, eng, mat, wdate) values(sq_guest.nextval, '�ϱ浿', 76, 95, 90, sysdate);
insert into tb_score (seq, name, kor, eng, mat, wdate) values(sq_guest.nextval, '�̱浿', 55, 27, 84, sysdate);
insert into tb_score (seq, name, kor, eng, mat, wdate) values(sq_guest.nextval, '��浿', 44, 90, 64, sysdate);
insert into tb_score (seq, name, kor, eng, mat, wdate) values(sq_guest.nextval, '��浿', 88, 77, 55, sysdate);
commit;

select*from tb_score;

