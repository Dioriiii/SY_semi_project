


------------------------------------------------------

drop table TBL_LOGIN_LOG purge;
drop table TBL_USER purge;
drop table TBL_CATEGORY purge;
drop table TBL_IMG purge;
drop table TBL_ITEM purge;
drop table TBL_BOARD purge;
drop table TBL_QNA purge;
drop table tbl_detail purge;
drop table tbl_order purge;

-- 회원 테이블
create table tbl_user
(userid             varchar2(60)   not null  -- 회원아이디
,pwd                varchar2(200)  not null  -- 비밀번호 (SHA-256 암호화 대상)
,name               varchar2(30)   not null  -- 회원명
,birthday           varchar2(10)             -- 생년월일   
,email              varchar2(200)  not null  -- 이메일 (AES-256 암호화/복호화 대상)
,mobile             varchar2(200)            -- 연락처 (AES-256 암호화/복호화 대상)
,gender             varchar2(1)              -- 성별   남자:1  / 여자:2 
,postcode           varchar2(5)              -- 우편번호
,address            varchar2(200)            -- 주소
,detailaddress      varchar2(200)            -- 상세주소
,extraaddress       varchar2(200)            -- 참고항목
,registerdate        date default sysdate     -- 가입일자
,last_pwd_changedate  date default sysdate    -- 마지막으로 암호를 변경한 날짜  
,status             number(1) default 1 not null     -- 회원상태  0: 관리자 / 2: 휴면중 / 1: 사용가능(가입중, 활동중)
,constraint PK_tbl_member_userid primary key(userid)
,constraint UQ_tbl_member_email  unique(email)
,constraint CK_tbl_member_gender check( gender in('1','2') )
,constraint CK_tbl_member_status check( status in(0,1,2) )
);
-- Table TBL_USER이(가) 생성되었습니다.


-- 로그인기록 테이블
create table tbl_login_log
(fk_userid      varchar2(60)         not null  -- 회원아이디
,login_date     date default sysdate not null  -- 로그인 되어진 접속날짜 및 시간
,login_ip       varchar2(20)         not null
,constraint FK_tbl_login_log_fk_userid foreign key(fk_userid) references tbl_user(userid)
);
-- Table TBL_LOGIN_LOG이(가) 생성되었습니다.


-- 카테고리 테이블
create table tbl_category
(ca_id            varchar2(60)        not null  -- 카테고리 아이디
,ca_name          varchar2(60)        not null  -- 카테고리 이름
,ca_how_to_use    Nvarchar2(1000)     not null  -- 사용방법
,ca_caution       Nvarchar2(1000)     not null  -- 주의사항
,ca_expired       Nvarchar2(100)      not null  -- 사용기한
,constraint PK_tbl_category_ca_id primary key(ca_id)
);
-- Table TBL_CATEGORY이(가) 생성되었습니다.


-- 제품 테이블
create table tbl_item
(it_seq_no       number(6)            not null  -- 제품일련번호
,fk_ca_id        varchar2(60)         not null  -- 카테고리 아이디
,it_name         Nvarchar2(100)       not null  -- 상품명
,it_price        number(10)           not null  -- 가격
,it_ingredient   Nvarchar2(1000)                -- 성분
,it_describe     Nvarchar2(1000)                -- 설명
,it_create_date  date default sysdate not null  -- 제품생성일
,it_update_date  date                           -- 제품수정일
,it_stock        number(10)                     -- 재고
,it_volume       varchar2(10)                   -- 용량
,it_status       number(1)                      -- 단종여부(0 : 단종 / 1 : 판매중)
,constraint PK_tbl_item_it_seq_no primary key(it_seq_no)
,constraint FK_tbl_item_fk_ca_id foreign key(fk_ca_id) references tbl_category(ca_id)
,constraint CK_tbl_item_it_status check( it_status in(0,1) )
);
-- Table TBL_ITEM이(가) 생성되었습니다.


-- 제품사진 테이블
create table tbl_img
(img_seq_no      number(6)     not null -- 사진 일련번호
,fk_it_seq_no    number(6)     not null -- 제품아이디
,img_file        varchar2(30)  not null -- 파일이름
,constraint FK_tbl_img_fk_it_seq_no foreign key(fk_it_seq_no) references tbl_item(it_seq_no)
,constraint UQ_tbl_img_img_file  unique(img_file)
);
-- Table TBL_IMG이(가) 생성되었습니다.


-- 공지사항 테이블
create table tbl_board
(seq_no         number(3)             not null -- 글번호
,title          Nvarchar2(50)         not null -- 글제목
,content        Nvarchar2(1000)                -- 글내용
,register_date  date default sysdate  not null -- 글등록일
,update_date    date                           -- 글수정일
,constraint PK_tbl_board_seq_no primary key(seq_no)
);
--Table TBL_BOARD이(가) 생성되었습니다.


-- 자주묻는 질문 테이블
create table tbl_qna
(q_seq_no          number(3)             not null -- 질문번호
,q_category        Nvarchar2(10)         not null -- 질문카테고리
,q_title           Nvarchar2(50)                  -- 질문제목
,q_content         Nvarchar2(500)                 -- 답변내용
,q_register_date   date default sysdate  not null -- 답변등록일
,q_update_date     date                           -- 답변수정일
,constraint PK_tbl_qna_q_seq_no primary key(q_seq_no)
);
-- Table TBL_QNA이(가) 생성되었습니다.


-- 리뷰 테이블
create table tbl_review
(re_seq_no     number(3)            not null -- 리뷰번호
,fk_userid     varchar2(60)         not null -- 회원아이디
,fk_it_seq_no  number(6)            not null -- 제품아이디
,re_content    Nvarchar2(200)                -- 리뷰내용
,re_date       date default sysdate not null -- 작성일자
,constraint PK_tbl_review_re_seq_no primary key(re_seq_no)
,constraint FK_tbl_review_fk_userid foreign key(fk_userid) references tbl_user(userid)
,constraint FK_tbl_review_fk_it_seq_no foreign key(fk_it_seq_no) references tbl_item(it_seq_no)
);
-- Table TBL_REVIEW이(가) 생성되었습니다.


-- 장바구니 테이블
create table tbl_cart
(ct_seq_no     number(3)     not null -- 장바구니일련번호
,fk_userid     varchar2(60)  not null -- 회원아이디
,fk_it_seq_no  number(6)     not null -- 제품아이디
,order_qty     number(3)     not null -- 주문수량
,constraint PK_tbl_cart_ct_seq_no primary key(ct_seq_no)
,constraint FK_tbl_cart_fk_userid foreign key(fk_userid) references tbl_user(userid)
,constraint FK_tbl_cart_fk_it_seq_no foreign key(fk_it_seq_no) references tbl_item(it_seq_no)
);
-- Table TBL_CART이(가) 생성되었습니다.


-- 좋아요 테이블
create table tbl_heart
(fk_userid     varchar2(60)  not null -- 회원아이디
,fk_it_seq_no  number(6)     not null -- 제품아이디
,heart         varchar2(1)            -- 좋아요
,constraint FK_tbl_heart_fk_userid foreign key(fk_userid) references tbl_user(userid)
,constraint FK_tbl_heart_fk_it_seq_no foreign key(fk_it_seq_no) references tbl_item(it_seq_no)
);
-- Table TBL_HEART이(가) 생성되었습니다.


-- 주문내역 테이블
create table tbl_order
(order_seq_no       varchar2(12)         not null   -- 주문일련번호
,fk_userid          varchar2(60)         not null   -- 회원아이디
,sh_name            varchar2(20)         not null   -- 수령인
,sh_mobile          varchar2(11)         not null   -- 수령인연락처
,sh_postcode        varchar2(5)          not null   -- 우편번호
,sh_address         varchar2(100)        not null   -- 배송수령지
,sh_detailaddress   varchar2(200)                   -- 상세주소
,sh_extraaddress    varchar2(200)                   -- 참고항목
,sh_msg             varchar2(100)        not null   -- 배송메세지
,order_date     date default sysdate     not null   -- 주문일자
,constraint PK_tbl_order_order_seq_no primary key(order_seq_no)
,constraint FK_tbl_order_fk_userid foreign key(fk_userid) references tbl_user(userid)
);



select *
from tbl_order

-- 주문상세 테이블
create table tbl_detail
(o_detail_seq_no  varchar2(16)         not null -- 주문상세일련번호
,fk_order_seq_no  varchar2(12)         not null -- 주문일련번호
,fk_it_seq_no     number(6)            not null -- 제품번호
,o_qty            number(3)            not null -- 주문수량
,o_price          number(10)           not null -- 주문금액
,o_status         number(1)            not null -- 주문상태 (0 : 배송준비중 / 1 : 배송중 / 2 : 배송완료)
,deliverd_date    date                          -- 배송완료일자
,constraint PK_tbl_detail_o_detail_seq_no primary key(o_detail_seq_no)
,constraint FK_tbl_detail_fk_order_seq_no foreign key(fk_order_seq_no) references tbl_order(order_seq_no)
,constraint FK_tbl_detail_fk_it_seq_no foreign key(fk_it_seq_no) references tbl_item(it_seq_no)
,constraint CK_tbl_detail_o_status check( o_status in(0,1,2) )
);

select *
from tbl_detail;

select *
from tbl_order;

commit;


-- 자주 묻는 질문 카테고리 테이블
create table tbl_qna_category
(qna_cate_no    number(2)         not null
,qna_cate_name  Nvarchar2(10)     not null
,constraint tbl_qna_category_qna_cate_no primary key(qna_cate_no)
);
-- Table TBL_QNA_CATEGORY이(가) 생성되었습니다.

create table tbl_qna
(q_seq_no          number(3)             not null -- 질문번호
,fk_qna_cate_no    number(2)             not null -- 질문카테고리번호
,q_title           Nvarchar2(50)                  -- 질문제목
,q_content         Nvarchar2(500)                 -- 답변내용
,q_register_date   date default sysdate  not null -- 답변등록일
,q_update_date     date                           -- 답변수정일
,constraint PK_tbl_qna_q_seq_no primary key(q_seq_no)
,constraint FK_tbl_qna_fk_qna_cate_no foreign key(fk_qna_cate_no) references tbl_qna_category(qna_cate_no)
);
-- Table TBL_QNA이(가) 생성되었습니다.


-- 자주 묻는 질문 카테고리 
select qna_cate_no, qna_cate_name
from tbl_qna_category;

-- 자주묻는 질문 카테고리 번호 조인 select
select q_title, q_content
from tbl_qna Q join tbl_qna_category C
on Q.fk_qna_cate_no = C.qna_cate_no
where fk_qna_cate_no = 1
order by q_seq_no asc;


-- 카테고리 별 총 페이지 수
select ceil(count(*)/8)
from tbl_qna
where fk_qna_cate_no = 1

SELECT q_title, q_content
FROM
(
    select row_number() over(order by q_seq_no asc) as RNO, q_seq_no, fk_qna_cate_no , q_title, q_content
    from tbl_qna
    where fk_qna_cate_no = 1
    order by q_seq_no asc
)
WHERE RNO BETWEEN 1 AND 8


-- test1@naver.com
-- admin@naver.com
-- doona@nate.com
-- test2@hanmail.net


-- // ** 가져온 주문일련번호 안의 주문상세일련번호 중 가장 비싼 상품이름, 수량, 진행상황, 이미지파일 가져오기 ** //
SELECT IT.it_name ,D2.o_qty, D2.o_status, IM.img_file
FROM 
(
    select fk_it_seq_no, o_qty, o_status
    from 
    (
        select row_number() over(order by o_price desc) as rno, fk_it_seq_no, o_qty, o_status
        from tbl_detail
        -- where fk_order_seq_no = order_seq_no
    ) D
    where rno = 1
) D2 JOIN tbl_item IT
ON D2.fk_it_seq_no = IT.it_seq_no
JOIN tbl_img IM
ON D2.fk_it_seq_no = IM.fk_it_seq_no
where IM.is_main_img = 1;

-- // ** 주문일련번호의 총 구매제품수, 총 구매가격 가져오기 ** //
select sum(o_qty) as TOTAL_O_QTY, sum(o_price) as TOTAL_O_PRICE
from tbl_detail
where fk_it_seq_no = 10


-- // ** 주문일련번호=> 제품일련번호 -> 제품명, 구매수량, 구매가격, 진행상황, 제품메인이미지파일 ** //
SELECT it_name, o_qty, o_price, o_status, img_file
FROM
(
    SELECT D.fk_it_seq_no ,D.o_qty, D.o_price, D.o_status, I.img_file
    FROM
    (
        select fk_it_seq_no, o_qty, o_price, o_status
        from tbl_detail
        where fk_order_seq_no = '11'
    ) D JOIN
    (
        select fk_it_seq_no, img_file
        from tbl_img
        where is_main_img = 1
    ) I ON D.fk_it_seq_no = I.fk_it_seq_no
) V JOIN tbl_item IT
ON V.fk_it_seq_no = IT.it_seq_no

-- userid = test2@hanmail.net  주문일련번호 891011 
-- // ** tbl_order 주문일련번호 -> 수령인, 수령인 연락처, 우편번호, 배송수령지(상세주소 도) , 주문일자, 주문번호, 총 금액 ** //
SELECT sh_name, sh_mobile, sh_postcode, sh_address, sh_detailaddress, sh_extraaddress, to_char(order_date, 'yyyy-mm-dd') as order_date, total_o_price, order_seq_no
FROM
(
    select order_seq_no, sh_name, sh_mobile, sh_postcode, sh_address, sh_detailaddress, sh_extraaddress, order_date
    from tbl_order
    where fk_userid = 'test2@hanmail.net' and order_seq_no = 891011 
) O JOIN
(
    select fk_order_seq_no, sum(o_price) AS TOTAL_O_PRICE
    from tbl_detail
    where fk_order_seq_no = 891011 
    group by fk_order_seq_no
) D 
ON O.order_seq_no = D.fk_order_seq_no

-- userid = test2@hanmail.net  주문일련번호 891011 
--  // userid로 주문일련번호 가져오기 list형태로
select *
from tbl_order
where fk_userid = 'test2@hanmail.net'
order by order_date desc



-- 주문 일련번호 리스트의 값들로 다시 주문상세일련번호 리스트 만들기

-- userid = test2@hanmail.net  주문일련번호 891011 
-- // 주문일련번호를  O.주문일자  D.제품일련번호, IT.제품명, IT.용량, D.주문수량, D.주문금액, D.주문상태, IM.이미지 //
SELECT O.order_seq_no, to_char(O.order_date, 'yyyy-mm-dd') as order_, D.fk_it_seq_no, IT.it_name, IT.it_volume, D.o_qty, D.o_price, D.o_status, IM.img_file
FROM 
(
    select order_seq_no, order_date
    from tbl_order
    where order_seq_no = 891011
) O JOIN
(
    select fk_order_seq_no, fk_it_seq_no, o_qty, o_price, o_status
    from tbl_detail
    where fk_order_seq_no = '891011'
) D ON O.order_seq_no = D.fk_order_seq_no JOIN
(
    select it_seq_no, it_name, it_volume
    from tbl_item
) IT ON D.fk_it_seq_no = IT.it_seq_no JOIN
(
    select fk_it_seq_no, img_file
    from tbl_img
    where is_main_img = 1
) IM ON IT.it_seq_no = IM.fk_it_seq_no
order by D.o_price desc


-- // ** 로그인 유저의 최근 주문일련번호 4개 가져오기 ** //
SELECT order_seq_no
FROM
(
    select row_number() over(order by order_date desc) AS RNO , order_seq_no
    from tbl_order
    where fk_userid = 'test2@hanmail.net'
)
WHERE RNO <= 4
order by RNO desc


select *
from tbl_order
where fk_userid = 'test2@hanmail.net'

select *
from tbl_detail
where fk_order_seq_no in(202311019108,202310315678)


-- tbl_order 업데이트
update tbl_order set SH_NAME='프프프프' ,SH_MOBILE='0104444444', SH_POSTCODE='44444', SH_ADDRESS='인청광광광광', SH_DETAILADDRESS='광광 333', SH_EXTRAADDRESS='222-3333'
where order_seq_no = '202311019108'
