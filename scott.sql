create sequence seq_board;

create table tbl_board(
    bno number(10,0),
    title varchar2(200) not null,
    content varchar2(2000) not null,
    writer varchar2(50) not null,
    regdate date default sysdate,
    updatedate date default sysdate
);

alter table tbl_board add constraint pk_board
primary key(bno);

insert into tbl_board (bno, title, content, writeR) values (seq_board.nextval, '테스트 제목', '테스트 내용', 'user00');

create table tbl_reply(
    rno number(10,0),
    bno number(10,0) not null,
    reply varchar2(1000) not null,
    replyer varchar2(50) not null,
    replyDate date default sysdate,
    updateDate date default sysdate
);

create sequence seq_reply;

alter table tbl_reply add constraint pk_reply primary key(rno);
alter table tbl_reply add constraint fk_replyboard foreign key(bno) references tbl_board(bno);

create index idx_reply on tbl_reply (bno desc, rno asc);

select /*+ INDEX(TBL_REPLY IDX_REPLY) */
rownum rn, bno, rno, reply, replyer, replyDate, updatedate
from tbl_reply
where bno = 1 and rno >0