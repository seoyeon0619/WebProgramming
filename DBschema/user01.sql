-- 회원 테이블 만들기
drop table tb_member;
create table tb_member
(
    member_id number primary key,
    user_id varchar2(50) unique not null,
    password varchar2(50) not null,
    user_name varchar2(100) not null,
    email varchar2(40) unique not null,
    phone varchar2(40)
);
desc tb_member; --테이블 확인
select*from tb_member; 

create sequence sq_member;

-- 외래키 설정
alter table tb_guestbook
add constraint FK_member_guestbook
foreign key (writer)
references tb_member(user_id);

insert into tb_member(member_id, user_id, password, user_name, email, phone) 
values (SQ_MEMBER.nextval, 'test01', '1234', '테스트', 'test@com', '010-0000-0000');
insert into tb_member(member_id, user_id, password, user_name, email, phone) 
values (SQ_MEMBER.nextval, 'test02', '1234', '테스트2', 'test2@com', '010-0000-2222');

update tb_guestbook set writer='test01';
update tb_guestbook set writer='test02' where seq<10;
update tb_gallery set image='diary.jpg' where seq<36;
update tb_gallery set image='study.jpg' where seq<36;

commit;
rollback;

select * from tb_guestbook;
select * from tb_member;
select * from tb_gallery;
commit;

select A.seq, A.title, A.writer, B.user_name, A.wdate, A.contents A.hit from tb_guestbook A
left outer join tb_member B 
on A.writer = B.user_id
order by A.seq desc;

select rownum rnum, A.seq, A.title, A.user_name, A.writer, A.wdate, A.contents, A.hit
from
(select A.seq, A.title, A.writer, B.user_name, A.wdate, A.contents, A.hit from tb_guestbook A
left outer join tb_member B 
on A.writer = B.user_id
order by A.seq desc
)A
where rownum>=6 and rownum<=10; -- 6~10

select A.rnum, A.seq, A.writer, A.title, A.user_name, to_char(A.wdate, 'yyyy-mm-dd') wdate, A.contents, A.hit 
from
(
    select rownum rnum, A.seq, A.title, A.user_name, A.writer, A.wdate, A.contents, A.hit
    from
    (select A.seq, A.title, A.writer, B.user_name, A.wdate, A.contents, A.hit from tb_guestbook A
    left outer join tb_member B 
    on A.writer = B.user_id
    order by A.seq desc
    )A where rownum<=10
)A where rnum>=6;

-- window 함수-----------------------------------------------------------
select writer, count(*)
from tb_guestbook
group by writer;

-- 아이디, 이름, 전화번호, 이메일, 아이디별 게시글 개수
select user_id, user_name, phone, email,
(select count(*) from tb_guestbook B where A.user_id=B.writer) cnt
from tb_member A;
-- 조인하는 방법 사용
select A.user_id, A.user_name, A.email, A.phone, nvl(B.cnt,0) as cnt
from tb_member A
left outer join(
select writer, count(*) cnt
from tb_guestbook
group by writer
)B on A.user_id = B.writer;

-- 분석함수
select A.user_id, A.user_name, A.email, A.phone, count(*) over(partition by B.writer) as cnt
from tb_member A
left outer join tb_guestbook b on A.user_id=B.writer;

-- row_number는 분석함수
select seq, title, writer, contents, hit, wdate,
row_number() over(order by seq desc) as rnum
from tb_guestbook;

-- 페이징쿼리 분석함수
select * from
(
select seq, title, writer, contents, hit, wdate,
row_number() over(order by seq desc) as rnum
from tb_guestbook
) where rnum>=6;

-- ceil 페이징쿼리 (데이터가 별로 없는 경우)
select A.seq, A.title, A.writer, A.user_name, to_char(A.wdate, 'yyyy-mm-dd') wdate, A.hit
from
(
    select seq, title, writer, contents, hit, wdate, B.user_name,
    row_number() over(order by seq desc) as rnum,
    ceil(row_number() over(order by seq desc)/5)-1 pg
    from tb_guestbook A
    left outer join tb_member B
    on A.writer=B.user_id
)A where pg=0;

select ceil(2.8), ceil(2.1), ceil(2.0) from dual;

----------------------------------------------------------------------------------------------------
-- 페이징 쿼리 만들기
-- rownum 필드
select count(*) from myemp;
desc myemp;

select empno, ename, deptno 
from myemp
where rownum<5;

select empno, ename, deptno 
from myemp
where rownum<=5
order by empno desc;

select *from 
(select empno, ename, deptno 
from myemp
order by empno desc)
where rownum<=5;

select A.rnum, A.empno, A.ename, A.deptno
from (
    select rownum rnum, A.empno, A.ename, A.deptno 
    from ( -- join과 검색쿼리 넣어야 함
        select A.empno, A.ename, A.deptno, B.dname
        from myemp A
        left outer join dept B on A.deptno=B.deptno
        where A.deptno in (10, 20) -- 부서번호 검색
        order by A.empno desc
        ) A where rownum<=10
) A where rnum>=6;
   
-- 그룹함수
select deptno, count(*) 
from myemp 
group by deptno;

-- 에러 발생
select ename, deptno, count(*)
from myemp
group by deptno;

-- 분석함수 사용
select ename, deptno, count(*) over(partition by deptno)
from myemp;
-- 서브쿼리로
select A.ename, A.deptno, B.cnt
from myemp A
left outer join 
    (select deptno, count(*) cnt
    from myemp 
    group by deptno
)B on A.deptno=B.deptno;

-- rownumber over
select A.* from
(
select row_number() over(order by empno desc) rnum,
        ceil(row_number() over(order by empno desc)/10)-1 pg,
    empno,ename, deptno
from myemp) A where pg=1;    

-- 프로시저 만들기
create or replace procedure makeData
is
begin
    delete from tb_guestbook;
    for i in 1..327 loop
        insert into tb_guestbook(seq, title, writer, contents, wdate, hit)
        values (sq_guest.nextval, '제목'||i, 'test02', '내용'||i, sysdate, 10);
    end loop;
    commit;
end;
/

exec makeData; -- 프로시저 실행
select count(*) from tb_guestbook;

select A.seq, A.title, A.writer, A.contents, A.wdate, A.hit, B.user_name " from tb_guestbook A "
left outer join tb_member B on A.writer=B.user_id "
						+ " where seq="+seq;
                        
select A.seq, A.title, A.writer, A.contents,  A.wdate, A.hit, B.user_name  
from tb_guestbook A  
left outer join tb_member B on A.writer=B.user_id  
where seq=734;





create table tb_gallery
(
    seq number primary key,
    title varchar2(400) not null,
    writer varchar2(40),
    contents varchar2(4000), 
    image varchar2(400),
    wdate date,
    hit number
);

create sequence sq_gallery;

-- 테이블수정
alter table tb_gallery add hit number;

select*from tb_gallery;



select A.seq, A.title, A.writer, A.contents,  A.wdate, A.hit, B.user_name, A.image 
from tb_gallery A  
left outer join tb_member B on A.writer=B.user_id  
where seq=1;


select seq, image from tb_gallery order by seq desc limit 5 ;

select seq, image from 
(select *
from tb_gallery
order by seq desc) 
where rownum<=5;

select * from tb_gallery;
select * from tb_guestbook;

select seq, title, contents from 
(select * 
from tb_guestbook 
order by seq desc)
where rownum<=5;

select A.seq, A.title, A.writer,
(select user_name from tb_member B where A.writer=B.user_id) user_name
from
{
    select *
    from tb_guestbook A
    order by seq desc
) A where rownum<=9;

-- 프로젝트
create table tb_diary
(
    seq number primary key,
    title varchar2(400) not null,
    contents varchar2(4000), 
    image varchar2(400),
    wdate date,
    hit number
);

create table tb_travle
(
    seq number primary key,
    title varchar2(400) not null,
    contents varchar2(4000), 
    image varchar2(400),
    wdate date,
    hit number
);

create table tb_study
(
    seq number primary key,
    title varchar2(400) not null,
    contents varchar2(4000), 
    image varchar2(400),
    wdate date,
    hit number
);

create sequence sq_shop;

drop table tb_shop;

create table tb_shop
(
    seq number primary key,
    pro_name varchar2(400) not null,
    pro_price number not null,
    pro_size varchar2(100) not null,
    pro_image varchar2(400)
);

select A.seq, A.rnum, A.pro_name, A.pro_price, A.pro_size, A.pro_image, A.pg
from 
(
    select seq, pro_name, pro_price, pro_size, A.image, 
    row_number() over(order by seq desc) as rnum,
    ceil(row_number() over(order by seq desc)/12)-1 pg
    from tb_shop A
)A where pg=
    
select seq, pro_name, pro_price, pro_size, pro_image
from tb_shop 
where seq=1;

------------------------------------------------------------------------
select seq, title, writer, contents, to_char(wdate, 'yyyy-mm-dd') wdate, user_name, hit
	from (
	select seq
		, title
		, writer
		, contents
		, wdate
		, hit
		, user_name
		, row_number() over(order by seq desc) num
		, ceil(row_number() over(order by seq desc)/10)-1 pg
	from tb_guestbook A
	left outer join tb_member B on A.writer=B.user_id
	) A where A.pg=0;

select seq
		, title
		, writer
		, contents
		, wdate
		, hit
		, user_name
	from tb_guestbook A
	left outer join tb_member B on A.writer=B.user_id
	where writer='test02';

select seq, name, kor, eng, mat
from tb_score;

select * from tb_member;

select member_id, user_id, password, user_name, phone, email, num
		from (
			select member_id
				, user_id
				, password
				, user_name
				, phone
				, email
				, row_number() over(order by member_id desc) num
				, ceil(row_number() over(order by member_id desc)/10)-1 pg
			from tb_member A
		) A where A.pg=0;
        
alter table tb_gallery add image1 varchar2(200);
commit;
select * from tb_gallery;


update tb_gallery set image1=image;
commit;

--------------------------------------------
create table tb_home
(
    seq number primary key,
    title varchar2(400) not null,
    image varchar2(400)
);

create sequence sq_home;
commit;
------------------------------------------------
create table test1(seq number primary key, test varchar2(10));
create table test2(seq number primary key, test varchar2(10));
create table test3(seq number primary key, test varchar2(10));

select table_name from tabs;
select * from test1;
select * from test2;
select * from test3;
--------------------------------------------------
-- 회원전용게시판
create table board
(
	seq  number,         -- 게시물 식별값 
	userid varchar2(40), -- 사용자아이디
	title varchar2(600), -- 제목
	contents clob,  -- 내용(varchar2는 4000이최고, clob - 2g)
	filename1  varchar2(300), -- 첨부파일 
	filename2  varchar2(300), -- 첨부파일 
	filename3  varchar2(300), -- 첨부파일 
	regdate  date,  -- 등록일
	moddate  date,  -- 수정일
	delyn    char(1), -- 삭제여부, Y-삭제, 기본-N
	group_id number,  -- 그룹아이디 
	depth    number,  -- 글의 깊이 
	g_level    number,   -- 그룹내에서의 내 순서 
	hit number	
);
-- 기본키 설정
alter table board add constraint PK_BOARD primary key (seq);

-- 부모글 insert 
(select nvl(max(seq), 0)+1 from board)

insert into board(seq, userid, title, contents,regdate, group_id, depth, g_level, hit)
values( 1,'test1', '제목1', '내용1', sysdate, 1, 0, 1, 0);
insert into board(seq, userid, title, contents,regdate, group_id, depth, g_level, hit)
values( 2,'test2', '제목2', '내용2', sysdate, 2, 0, 1, 0);
insert into board(seq, userid, title, contents,regdate, group_id, depth, g_level, hit)
values( 3,'test3', '제목3', '내용3', sysdate, 3, 0, 1, 0);
insert into board(seq, userid, title, contents,regdate, group_id, depth, g_level, hit)
values( 4,'test4', '제목4', '내용4', sysdate, 4, 0, 1, 0);
insert into board(seq, userid, title, contents,regdate, group_id, depth, g_level, hit)
values( 5,'test5', '제목5', '내용5', sysdate, 5, 0, 1, 1);

commit;
delete from board;


-- 자식글 넣기
-- 부모글 1번, group_id=부모글 (1)
-- depth : 부모글의 depth+1
-- g_level : 부모글 level+1
insert into board(seq, userid, title, contents,regdate, group_id, depth, g_level, hit)
values( 6,'test2', '답글1', '자식글1', sysdate, 1, 1, 2, 0);



-- 5번 부모글(group_id=5)에 자식글 넣기
insert into board(seq, userid, title, contents,regdate, group_id, depth, g_level, hit)
values( 7,'test2', '답글1', '자식글1', sysdate, 5, 1, 2, 0);

select * from board;
select * from board order by group_id desc, g_level asc;
update board set g_level=3 where seq=7;

delete from board where seq=9;

-- 5번 부모글에 자식글2 넣기
update board set g_level=g_level+1 where group_id=5 and g_level>1;
insert into board(seq, userid, title, contents,regdate, group_id, depth, g_level, hit)
values( 8,'test2', '답글1', '자식글1', sysdate, 5, 1, 2, 0);

-- 8번 글에 자식글이 올라갈 때
-- group_id : 원글의 아이디
-- level : 부모글+1
update board set g_level=g_level+1 where group_id=5 and g_level>2;

insert into board(seq, userid, title, contents,regdate, group_id, depth, g_level, hit)
values( 9,'test2', '답글1', '자식글1', sysdate, 5, 2, 3, 0);

desc board;

select 
    A.seq
    , A.title
    , A.userid
    , nvl(filename1, '') filename1
    , nvl(filename2, '') filename2
    , nvl(filename3, '') filename3
    , to_char(regdate, 'yyyy-mm-dd') regdate
    , to_char(moddate, 'yyyy-mm-dd') moddate
    , rnum as num
    , nvl(hit, 0) hit
from
(
select
    A.seq
    , A.title
    , A.userid
    , A.contents
    , A.filename1
    , A.filename2
    , A.filename3
    , A.regdate
    , A.moddate
    , A.hit
    , row_number() over(order by group_id desc, g_level asc) rnum 
    -- row_number() over(order by) : group by, order by처럼 그룹 내에서 정렬한다는 의미
    , ceil(row_number () over (order by group_id desc, g_level asc)/10-1) pg
from board A 
order by group_id desc, g_level asc
)A where pg=0;

commit;

select 
	    A.seq
	    ,A.title
	    ,A.userid
	    ,A.contents
	    ,A.filename1
	    ,A.filename2
	    ,A.filename3
	    ,A.regdate
	    ,A.moddate 
	    ,A.hit
	    ,A.group_id
	    ,A.depth
	    ,A.g_level
	    ,row_number() over(order by group_id desc, g_level asc) rnum
	    ,ceil(row_number() over(order by group_id desc, g_level asc)/10)-1 pg
	from board A;


update board set hit=hit+1 where seq=13;

select * from board order by group_id desc, g_level asc;
commit;

select A.seq ,A.title ,A.userid ,A.contents ,nvl(A.filename1, '') filename1 ,nvl(A.filename2, '') filename2
,nvl(A.filename3, '') filename3 ,A.regdate ,A.moddate ,A.hit ,A.group_id ,A.depth ,A.g_level from board A where seq=18; 

delete from board where seq=17;
commit;
----------------------------------------------------------------------------
select * from board order by group_id desc, g_level asc;

-- 필드추가
alter table board add delyn2 char(1);

update board set delyn2='N';
commit;

drop table tb_comment;

create table tb_comment (
    board_seq number,
    seq number primary key,
    userid varchar2(40),
    comments varchar2(1000),
    regdate date,
    delyn char(1) default 'N'
);
select * from tb_comment;
alter table tb_comment add constraint FK_BOARD_COMMENT foreign key(board_seq) references board(seq);
commit;
insert into tb_guestbook   (    seq    , title    , writer    , contents    , wdate    , hit   )   values   (    1234    ,'1234'    ,'test02'    , '1234'     , sysdate    ,'1234'    );
------------------------------------------------------------------
commit;
select * from tb_member;
select * from tb_guestbook order by seq desc;
