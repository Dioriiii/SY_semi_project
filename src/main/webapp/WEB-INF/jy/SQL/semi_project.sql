
------------------------------------------------------

drop table TBL_LOGIN_LOG purge;
drop table TBL_USER purge;
drop table TBL_CATEGORY purge;
drop table TBL_IMG purge;
drop table TBL_ITEM purge;
drop table TBL_BOARD purge;
drop table TBL_QNA purge;
drop table tbl_detail purge;

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
(order_seq_no  number(6)            not null -- 주문일련번호
,fk_userid     varchar2(60)         not null -- 회원아이디
,fk_it_seq_no  number(6)            not null -- 제품일련번호
,sh_name       varchar2(20)         not null -- 수령인
,sh_mobile     varchar2(11)         not null -- 수령인연락처
,sh_postcode   varchar2(5)          not null -- 우편번호
,sh_address    varchar2(100)        not null -- 배송수령지
,sh_msg        varchar2(100)        not null -- 배송메세지
,order_date    date default sysdate not null -- 주문일자
,constraint PK_tbl_order_order_seq_no primary key(order_seq_no)
,constraint FK_tbl_order_fk_userid foreign key(fk_userid) references tbl_user(userid)
,constraint FK_tbl_order_fk_it_seq_no foreign key(fk_it_seq_no) references tbl_item(it_seq_no)
);
-- Table TBL_ORDER이(가) 생성되었습니다.


-- 주문상세 테이블
create table tbl_detail
(o_detail_seq_no  number(12)           not null -- 주문상세일련번호
,fk_order_seq_no  number(6)            not null -- 주문일련번호
,o_qty            number(3)            not null -- 주문수량
,o_price          number(10)           not null -- 주문금액
,o_status         number(1)            not null -- 주문상태 (0 : 배송준비중 / 1 : 배송중 / 2 : 배송완료)
,deliverd_date    date                          -- 배송완료일자
,constraint PK_tbl_detail_o_detail_seq_no primary key(o_detail_seq_no)
,constraint FK_tbl_detail_fk_order_seq_no foreign key(fk_order_seq_no) references tbl_order(order_seq_no)
,constraint CK_tbl_detail_o_status check( o_status in(0,1,2) )
);
-- Table TBL_DETAIL이(가) 생성되었습니다.
drop table tbl_store purge;



-------------------------------------------------------------------------------


commit;

delete from tbl_user;

delete from TBL_LOGIN_LOG
where fk_userid='test66@empas.com';

select  *
from TBL_LOGIN_LOG;

select *
from tbl_item;

commit;

update tbl_user set last_pwd_changedte = '2022/10/01'
where userid='doona@nate.com';

commit;

delete from tbl_user
where userid='test33@empas.com';

select *
from tbl_qna;

select *
from user_sequences;


-------------------------------------------------------------------------------


drop table tbl_store;
drop table tbl_store_img;
create table tbl_store
(store_no          number(4)       not null  -- 매장번호
,fk_cty_code       Nvarchar2(2)    not null  -- 매장 국가 (kr, cn)
,store_name        Nvarchar2(20)   not null  -- 매장 이름
,store_address     Nvarchar2(100)  not null  -- 매장 주소
,store_contact     varchar2(20)              -- 매장 연락처
,store_hours       Nvarchar2(100)            -- 매장 운영시간
,store_ca          Nvarchar2(4)              -- 매장 카테고리(유통채널) (flag, dept, stck)
,lat               number                    -- 위도
,lng               number                    -- 경도  
,constraint PK_tbl_store_store_no primary key(store_no)
,constraint FK_tbl_store_fk_cty_code foreign key(fk_cty_code) references tbl_store_country(cty_code)
);
-- Table TBL_STORE이(가) 생성되었습니다.


create table tbl_store_img
(store_img_no     number(6)      not null  -- 매장 이미지 번호
,fk_store_no      number(4)      not null  -- 매장 번호
,store_img_file   Nvarchar2(30)  not null  -- 이미지 파일명
,is_main_img      number(1)                -- 메인 이미지(메인 이미지:1 / 아닐시:0)
,file_type        varchar2(1) default 'i'  -- 파일 타입 (이미지:i / 비디오: v)
,constraint PK_tbl_store_img_store_img_no primary key(store_img_no)
,constraint FK_tbl_store_img_fk_store_no foreign key(fk_store_no) references tbl_store(store_no)
,constraint CK_tbl_store_img_is_main_img check( is_main_img in('0','1') )
,constraint CK_tbl_store_img_file_type check( file_type in('i','v') )
);
-- Table TBL_STORE_IMG이(가) 생성되었습니다.

create sequence seq_tbl_store_img
start with 1  
increment by 1 
nomaxvalue
nominvalue
nocycle           
nocache;
-- Sequence SEQ_TBL_STORE_IMG이(가) 생성되었습니다.

create sequence seq_tbl_store_no
start with 1  
increment by 1 
nomaxvalue
nominvalue
nocycle           
nocache;
-- Sequence SEQ_TBL_STORE_NO이(가) 생성되었습니다.

commit;
-- 커밋 완료.



insert into tbl_store(store_no, fk_cty_code, store_name, store_address, store_contact, store_hours, store_ca, lat, lng)
values(seq_tbl_store_no.nextval, 'kr', '플래그십스토어 삼청', '서울 종로구 율곡로3길 84', '+82 70 4139 7450', '월-일 11:00am-8:00pm', 'flg',37.5793697128721,126.98226074158);

insert into tbl_store(store_no, fk_cty_code, store_name, store_address, store_contact, store_hours, store_ca, lat, lng)
values(seq_tbl_store_no.nextval, 'kr', '하우스 도산', '서울 강남구 압구정로46길 50', '+82 70 4128 2124', '월-일 11:00am-9:00pm', 'flg',37.5253703709931,127.035679523304);

insert into tbl_store(store_no, fk_cty_code, store_name, store_address, store_contact, store_hours, store_ca, lat, lng)
values(seq_tbl_store_no.nextval, 'kr', '플래그십스토어 신사', '서울 강남구 압구정로10길 44', '+82 02 511 1246', '월-일 12:00pm-9:00pm', 'flg',37.520637672047,127.022049838124);

insert into tbl_store(store_no, fk_cty_code, store_name, store_address, store_contact, store_hours, store_ca)
values(seq_tbl_store_no.nextval, 'kr', '스타필드 하남점', '경기도 하남시 미사대로 750 스타필드 하남 1F', '+82 031 8072 8499', '월-일 10:00am-10:00pm', 'dpt');

insert into tbl_store(store_no, fk_cty_code, store_name, store_address, store_contact, store_hours, store_ca)
values(seq_tbl_store_no.nextval, 'kr', '신세계 면세점 명동점', '서울 중구 퇴계로 77 신세계백화점 본점 04583 10F', '+82 02 6370 4182', '월-목 10:30am-8:00pm / 금-일,공휴일 10:30am-8:30pm', 'dpt');

insert into tbl_store(store_no, fk_cty_code, store_name, store_address, store_contact, store_hours, store_ca)
values(seq_tbl_store_no.nextval, 'kr', '신세계백화점 강남점', '서울특별시 서초구 신반포로 176 (반포동) 1F', '+82 02-3479-1275', '월-목 10:30am-8:00pm / 금-일,공휴일 10:30am-8:30pm', 'dpt');

insert into tbl_store(store_no, fk_cty_code, store_name, store_address, store_contact, store_hours, store_ca)
values(seq_tbl_store_no.nextval, 'kr', '신세계백화점 센텀시티점', '부산 해운대구 센텀남대로 35 신세계백화점 센텀시티점 1F', '+82 051-745-1398', '월-목 10:30am-8:00pm / 금-일,공휴일 10:30am-8:30pm', 'dpt');

insert into tbl_store(store_no, fk_cty_code, store_name, store_address, store_contact, store_hours, store_ca)
values(seq_tbl_store_no.nextval, 'kr', '롯데백화점 본점', '서울 중구 남대문로 81 롯데백화점 본점 B1F', '+82 02-772-3905', '월-목 10:30am-8:00pm / 금-일,공휴일 10:30am-8:30pm', 'dpt');

insert into tbl_store(store_no, fk_cty_code, store_name, store_address, store_contact, store_hours, store_ca)
values(seq_tbl_store_no.nextval, 'kr', '현대백화점 판교점', '경기도 성남시 분당구 판교역로146번길 20 (1F)', '+031-5170-1153', '월-목 10:30am-8:00pm / 금-일,공휴일 10:30am-8:30pm', 'dpt');

insert into tbl_store(store_no, fk_cty_code, store_name, store_address, store_contact, store_hours, store_ca)
values(seq_tbl_store_no.nextval, 'kr', '더현대 서울점', '서울 영등포구 여의대로 108 1F', '+82 02-3277-8593', '월-목 10:30am-8:00pm / 금-일, 공휴일 10:30am-8:30pm', 'dpt');

insert into tbl_store(store_no, fk_cty_code, store_name, store_address, store_contact, store_hours, store_ca)
values(seq_tbl_store_no.nextval, 'kr', '롯데 면세점 명동점', '서울 중구 을지로 30 12F', '+82 70-4240-9664', '월-일 9:30am-8:00pm', 'dpt');

insert into tbl_store(store_no, fk_cty_code, store_name, store_address, store_contact, store_hours, store_ca)
values(seq_tbl_store_no.nextval, 'kr', '시코르 홍대점', '서울특별시 마포구 양화로 147 아일렉스 1F', '+82 02-3143-6721', '월-일 10:30am-10:00pm', 'stk');

insert into tbl_store(store_no, fk_cty_code, store_name, store_address, store_contact, store_hours, store_ca)
values(seq_tbl_store_no.nextval, 'kr', '시코르 강남점', '서울 서초구 강남대로 441 서산빌딩', '+82 02-3495-7600', '월-일 10:30am-10:00pm', 'stk');

insert into tbl_store(store_no, fk_cty_code, store_name, store_address, store_contact, store_hours, store_ca)
values(seq_tbl_store_no.nextval, 'kr', '10 꼬르소꼬모 에비뉴엘점', '서울 중구 남대문로 73 5층 10 꼬르소꼬모', '+82 02 2118 6095', '월-일 10:30am-8:00pm', 'stk');

insert into tbl_store(store_no, fk_cty_code, store_name, store_address, store_contact, store_hours, store_ca)
values(seq_tbl_store_no.nextval, 'kr', '10 꼬르소꼬모 청담점', '서울 강남구 압구정로 416', '+82 02 3018 1010', '월-일 11:00am-8:00pm', 'stk');

insert into tbl_store(store_no, fk_cty_code, store_name, store_address, store_contact, store_hours, store_ca)
values(seq_tbl_store_no.nextval, 'cn', '하우스 상해', '4F, No.798-812, Middle Huaihai Road, Huangpu District, Shanghai, China', '+86 21-64220858', '월-일 10:00am-10:00pm', 'flg');


commit;
-- 커밋 완료.

select  *
from tbl_store;

insert into tbl_store_img(store_img_no, fk_store_no, store_img_file, is_main_img) values(seq_tbl_store_img.nextval, 1, 'kr_samcheong_1.jpg', 1);
insert into tbl_store_img(store_img_no, fk_store_no, store_img_file, is_main_img) values(seq_tbl_store_img.nextval, 1, 'kr_samcheong_2.jpg', 0);
insert into tbl_store_img(store_img_no, fk_store_no, store_img_file, is_main_img) values(seq_tbl_store_img.nextval, 1, 'kr_samcheong_3.jpg', 0);
insert into tbl_store_img(store_img_no, fk_store_no, store_img_file, is_main_img) values(seq_tbl_store_img.nextval, 1, 'kr_samcheong_4.jpg', 0);
insert into tbl_store_img(store_img_no, fk_store_no, store_img_file, is_main_img, file_type) values(seq_tbl_store_img.nextval, 2, 'kr_dosan_1.mp4', 1, 'v');
insert into tbl_store_img(store_img_no, fk_store_no, store_img_file, is_main_img) values(seq_tbl_store_img.nextval, 2, 'kr_dosan_2.jpg', 0);
insert into tbl_store_img(store_img_no, fk_store_no, store_img_file, is_main_img) values(seq_tbl_store_img.nextval, 2, 'kr_dosan_3.jpg', 0);
insert into tbl_store_img(store_img_no, fk_store_no, store_img_file, is_main_img) values(seq_tbl_store_img.nextval, 2, 'kr_dosan_4.jpg', 0);
insert into tbl_store_img(store_img_no, fk_store_no, store_img_file, is_main_img) values(seq_tbl_store_img.nextval, 2, 'kr_dosan_5.jpg', 0);
insert into tbl_store_img(store_img_no, fk_store_no, store_img_file, is_main_img) values(seq_tbl_store_img.nextval, 3, 'kr_sinsa_1.jpg', 1);
insert into tbl_store_img(store_img_no, fk_store_no, store_img_file, is_main_img) values(seq_tbl_store_img.nextval, 3, 'kr_sinsa_2.jpg', 0);
insert into tbl_store_img(store_img_no, fk_store_no, store_img_file, is_main_img) values(seq_tbl_store_img.nextval, 3, 'kr_sinsa_3.jpg', 0);
insert into tbl_store_img(store_img_no, fk_store_no, store_img_file, is_main_img) values(seq_tbl_store_img.nextval, 3, 'kr_sinsa_4.jpg', 0);
insert into tbl_store_img(store_img_no, fk_store_no, store_img_file, is_main_img) values(seq_tbl_store_img.nextval, 3, 'kr_sinsa_5.jpg', 0);
insert into tbl_store_img(store_img_no, fk_store_no, store_img_file, is_main_img) values(seq_tbl_store_img.nextval, 3, 'kr_sinsa_6.jpg', 0);
insert into tbl_store_img(store_img_no, fk_store_no, store_img_file, is_main_img) values(seq_tbl_store_img.nextval, 3, 'kr_sinsa_7.jpg', 0);
insert into tbl_store_img(store_img_no, fk_store_no, store_img_file, is_main_img, file_type) values(seq_tbl_store_img.nextval, 16, 'cn_Shanghai_1.mp4', 1, 'v');
insert into tbl_store_img(store_img_no, fk_store_no, store_img_file, is_main_img) values(seq_tbl_store_img.nextval, 16, 'cn_Shanghai_2.jpg', 0);
insert into tbl_store_img(store_img_no, fk_store_no, store_img_file, is_main_img) values(seq_tbl_store_img.nextval, 16, 'cn_Shanghai_3.jpg', 0);
insert into tbl_store_img(store_img_no, fk_store_no, store_img_file, is_main_img) values(seq_tbl_store_img.nextval, 16, 'cn_Shanghai_4.jpg', 0);
insert into tbl_store_img(store_img_no, fk_store_no, store_img_file, is_main_img) values(seq_tbl_store_img.nextval, 16, 'cn_Shanghai_5.jpg', 0);
insert into tbl_store_img(store_img_no, fk_store_no, store_img_file, is_main_img) values(seq_tbl_store_img.nextval, 16, 'cn_Shanghai_6.jpg', 0);
insert into tbl_store_img(store_img_no, fk_store_no, store_img_file, is_main_img) values(seq_tbl_store_img.nextval, 16, 'cn_Shanghai_7.jpg', 0);
insert into tbl_store_img(store_img_no, fk_store_no, store_img_file, is_main_img) values(seq_tbl_store_img.nextval, 16, 'cn_Shanghai_8.jpg', 0);

create table tbl_store_country
(cty_code     Nvarchar2(2)    not null  -- 국가 코드 (kr, cn)
,cty_name     Nvarchar2(20)   not null  -- 국가 이름
,cty_img      Nvarchar2(30)             -- 국가 메인 이미지
,constraint PK_tbl_store_country_cty_code primary key(cty_code)
);

insert into tbl_store_country(cty_code, cty_name, cty_img) values('kr', '대한민국', 'kr_icon.png');
insert into tbl_store_country(cty_code, cty_name, cty_img) values('cn', '중국', 'cn_icon.png');

select  *
from tbl_store_img;

commit;
-- 커밋 완료.

select S.store_no, I.store_img_file, I.is_main_img, store_img_file, file_type
from
(
    select store_no, store_country, store_name, store_address, store_contact, store_hours, store_ca
    from tbl_store
) S
join tbl_store_img I
on S.store_no = I.fk_store_no


select store_no, store_country, store_name, store_address, store_contact, store_hours, store_ca
from tbl_store
where store_country = 'kr' and store_ca = 'flg'

commit;

select cty_code, cty_name, cty_img
from tbl_store_country

select *
from tbl_user

alter table tbl_store
add store_url varchar2(100);


update tbl_store set store_url = 'https://naver.me/xEqtxCp8'
where store_name = '플래그십스토어 삼청';

update tbl_store set store_url = 'https://naver.me/5eGTFSJq'
where store_name = '하우스 도산';

update tbl_store set store_url = 'https://naver.me/xJNatEJo'
where store_name = '플래그십스토어 신사';

commit;


select count(*) as cnt
from tbl_store
where fk_cty_code = 'kr' and store_ca='flg'
group by department_id -- department_id 컬럼의 값이 같은것 끼리 그룹을 짓는다.
order by department_id;
-- 대부분 그룹함수에 count 는 같이 들어간다.


select  *
from user_tables;

select *
from tbl_store;

select store_name, store_address,lat,lng
from tbl_store
where store_no=1




------ ================== ****** DB 백업하기 ****** ================== ------

-- 오라클 계정 생성을 위해서는 SYS 또는 SYSTEM 으로 연결하여 작업을 해야 합니다. [SYS 시작] --
show user;
-- USER이(가) "SYS"입니다.

-- 오라클 계정 생성시 계정명 앞에 c## 붙이지 않고 생성하도록 하겠습니다.
alter session set "_ORACLE_SCRIPT"=true;
-- Session이(가) 변경되었습니다.

-- 오라클 계정명은 MYMVC_USER 이고 암호는 gclass 인 사용자 계정을 생성합니다.
create user semi_orauser2 identified by gclass default tablespace users;
-- User SEMI_ORAUSER2이(가) 생성되었습니다.

-- 위에서 생성되어진 MYMVC_USER 이라는 오라클 일반사용자 계정에게 오라클 서버에 접속이 되어지고,
-- 테이블 생성 등등을 할 수 있도록 여러가지 권한을 부여해주겠습니다.
grant connect, resource, create view, unlimited tablespace to SEMI_ORAUSER2;
-- Grant을(를) 성공했습니다.