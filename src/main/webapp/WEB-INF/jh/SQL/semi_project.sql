
show user;
-- USER이(가) "SEMI_ORAUSER2"입니다.

create table tbl_이재훈
(no     number
,name   varchar2(20)
);
-- Table TBL_이재훈이(가) 생성되었습니다.

insert into tbl_이재훈(no, name) values(111, '동빈쿤');
-- 1 행 이(가) 삽입되었습니다.

commit;
-- 커밋 완료.

select * from tabs;

select * from tbl_이재훈;
select * from tbl_정지연;
select * from tbl_최원석;
select * from tbl_최우현;
select * from tbl_박동빈;

drop table tbl_이재훈 purge;

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
,status             number(1) default 1 not null     -- 회원상태  0: 관리자 / 1: 사용가능(가입중, 활동중) / 2: 휴면중 
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

alter table tbl_category add ca_img_file varchar2(30);

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

alter table tbl_img add is_main_img number(1) default 0;
-- Table TBL_IMG이(가) 변경되었습니다.

alter table tbl_img
add constraint CK_tbl_img_is_main_img check (is_main_img in (0, 1));

update tbl_img set is_main_img = 1
where main_img_file is not null;
-- 10개 행 이(가) 업데이트되었습니다.

select *
from tbl_img

commit;

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

commit;

------------------------------------------------------------------------------------------------------

----------------------- 카테고리 테이블 추가 -----------------------
-- 퍼퓸(아이디, 이름, 사용방법, 주의사항, 사용기한)
insert into tbl_category(ca_id, ca_name, ca_how_to_use, ca_caution, ca_expired) 
values(
'pf', 
'perfume', 
'향수를 원하는 만큼 분사하여 사용하세요.<br>
맥박이 뛰는 곳에도 가볍게 터치해주면 향을 더 고르게 느낄 수 있습니다.<br>
-옷, 이불 등 섬유에 직접 뿌릴 경우 이염/오염에 주의해주세요.<br>
-원료 특성상 내용물의 색상 편차가 있을 수 있고 미량의 침전물이 보일 수 있으나, 품질에는 이상이 없으니 안심하고 사용해주세요.<br><br><br>
-제품 주요 사양: 모든 피부용', 
'1) 화장품 사용 시 또는 사용 후 직사광선에 의하여 사용부위가 붉은 반점, 부어오름 또는 가려움증 등의 이상 증상이나 부작용이 있는 경우에는 전문의 등과 상담할 것.<br>
2) 상처가 있는 부위 등에는 사용을 자제할 것.<br>
3) 보관 및 취급 시의 주의사항<br>
가. 어린이의 손이 닿지 않는 곳에 보관할 것.<br>
나. 직사광선을 피해서 보관할 것.<br><br><br>
-기능성 화장품의 경우 화장품법에 따른 식품의약품안전처 심사필 유무: 무<br>
-품질보증기준: 본 제품은 공정거래위원회고시 소비자분쟁해결 기준에 의거 교환 또는 보상 받을 수 있습니다.<br>
-소비자상담번호: 1644-1246 (Made in korea)<br>
-화장품책임판매업자: ㈜아이아이컴바인드<br>
-제조국: 대한민국', 
'사용기한 36개월(상품 발송일 기준으로 사용기한이 12개월 이상 남은 상품만을 판매합니다.)'
);
-- 1 행 이(가) 삽입되었습니다.


-- 퍼퓸핸드(아이디, 이름, 사용방법, 주의사항, 사용기한)
insert into tbl_category(ca_id, ca_name, ca_how_to_use, ca_caution, ca_expired) 
values(
'ph', 
'perfume_hand', 
'더 쉘 퍼퓸핸드의 쉘 케이스는 특수한 이중구조 용기와 에어리스 펌프 시스템으로 사용하는 동안 내용물이 변질되지 않게끔 외부 공기와의 접촉을 최대한 차단합니다.<br><br>
쉘 케이스의 뚜껑을 열어 버튼을 세로방향으로 손등에 부드럽게 눌러보세요. 깔끔한 애티튜드로 기능하는 새로운 에어리스 펌프 시스템이 내용물을 최대한 남기지 않고 사용할 수 있게 도와줍니다.', 
'에어리스 펌프 특성상 공타가 3~10회 정도 발생할 수 있으며 공펌핑을 n회 더하면 사용이 가능합니다. 
1.화장품 사용시 또는 사용후 직사광선에 의하여 사용부위가 붉은반점, 부어오름 또는 가려움증 등의 이상 증상이나 부작용이 있는 경우 전문의 등과 상담할 것 
2.상처가 있는 부위 등에는 사용을 자제할 것 
3.보관 및 취급시의 주의사항 1)어린이의 손이 닿지 않는 곳에 보관할 것 2)직사광선을 피해서 보관할 것 *본 제품은 공정거래위원회 고시 소비자분쟁해결기준에 의거 교환 또는 보상받을 수 있습니다.', 
'사용기한 36개월(상품 발송일 기준으로 사용기한이 12개월 이상 남은 상품만을 판매합니다.)'
);
-- 1 행 이(가) 삽입되었습니다.


-- 퍼퓸비누(아이디, 이름, 사용방법, 주의사항, 사용기한)
insert into tbl_category(ca_id, ca_name, ca_how_to_use, ca_caution, ca_expired) 
values('ps', 
'perfume_soap', 
'거품을 충분히 낸 뒤, 피부에 사용 후 물로 깨끗이 헹구어 냅니다.', 
'1) 화장품 사용 시 또는 사용 후 직사광선에 의하여 사용부위가 붉은 반점, 부어오름 또는 가려움증 등의 이상 증상이나 부작용이 있는 경우에는 전문의 등과 상담할 것.<br>
2) 상처가 있는 부위 등에는 사용을 자제할 것.<br>
3) 보관 및 취급 시의 주의사항<br>
가. 어린이의 손이 닿지 않는 곳에 보관할 것.<br>
나. 직사광선을 피해서 보관할 것.<br><br>
*제품 특성상 표면 갈라짐 및 색상이 변할 수 있으나 제품 품질에는 이상 없습니다.<br>
*건조가 잘 될 수 있는 비누 받침대와 함께 사용하시면 오래 사용 가능합니다.', 
'사용기한 24개월(상품 발송일 기준으로 사용기한이 6개월 이상 남은 상품만을 판매합니다.)'
);
-- 1 행 이(가) 삽입되었습니다.


-- 튜브핸드(아이디, 이름, 사용방법, 주의사항, 사용기한)
insert into tbl_category(ca_id, ca_name, ca_how_to_use, ca_caution, ca_expired) 
values(
'th', 
'tube_hand', 
'손을 씻고 물기가 완전히 마르기 전, 손에 적당량을 덜어 발라줍니다. 움직임이 많고 피부가 얇은 부위인 손목에도 핸드크림을 발라 마사지해 주는 것이 좋습니다.', 
'1.화장품 사용시 또는 사용후 직사광선에 의하여 사용부위가 붉은반점, 부어오름, 가려움증 등의 이상 증상이나 부작용이 있는 경우 전문의와 상담할 것 2.상처가 있는 부위 등에는 사용을 자제할 것.<br>
보관 및 취급시의 주의사항 1)어린이의 손에 닿지 않는 곳에 보관할 것 2)직사광선을 피해서 보관할 것 *본 제품은 공정거래위원회 고시 소비자 분쟁 해결 기준에 의거교환 또는 보상 받을 수 있습니다.', 
'사용기한 36개월(상품 발송일 기준으로 사용기한이 12개월 이상 남은 상품만을 판매합니다.)'
);
-- 1 행 이(가) 삽입되었습니다.

select *
from tbl_category;

----------------------- 제품 테이블 추가 -----------------------
-- 제품 일련번호
create sequence seq_item
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_ITEM이(가) 생성되었습니다


-- 퍼퓸 
-- 퍼퓸 카모(제품일련번호(1), 카테고리 아이디, 상품명, 가격, 성분, 설명, 재고, 용량, 단종여부(0 : 단종 / 1 : 판매중))
insert into tbl_item(it_seq_no, fk_ca_id, it_name, it_price, it_ingredient, it_describe, it_stock, it_volume, it_status)
values(
seq_item.nextval, 
'pf', 
'퍼퓸 카모', 
139000, 
'진득한 카모마일 | 부드러운 나무결 | 머스크', 
'꿀처럼 진득하고 달콤한 카모마일과 씁쓸한 클라리세이지의 허브 향이 오묘한 조화를 이루어 중독성 있는 향을 선사합니다. 
자칫 차갑게 느껴질 수 있는 촉촉한 이끼의 느낌을 우아하고 부드러운 나무결의 블론드 우드와 따뜻한 머스크로 감싸주어 당신의 지친 마음에 특별하고 작은 위안을 선물합니다.<br>
<span>탬버린즈 퍼퓸</span><br>
탬버린즈가 찾아낸 규정되지 않은 아름다움. 시간이 흐르면서 일어나는 다채로운 향의 변화를 느껴보세요. 세상에 흩어진 모든 이야기에서 영감을 받은 감각적인 향이 단조로운 일상에 자유롭고 새로운 리듬을 부여합니다.<br><br>
<span>탬버린즈의 미학</span><br>
직선적으로 느껴지는 날카로운 첫인상과 대비되는 부드러운 곡선의 촉각적인 경험은 손끝으로 사물을 읽는 듯한 공감각적인 흥미로움을 선사합니다.',
1000, 
'50mL', 
1);
-- 1 행 이(가) 삽입되었습니다.

-- 퍼퓸 버가샌달(제품일련번호(17), 카테고리 아이디, 상품명, 가격, 성분, 설명, 재고, 용량, 단종여부(0 : 단종 / 1 : 판매중))
insert into tbl_item(it_seq_no, fk_ca_id, it_name, it_price, it_ingredient, it_describe, it_stock, it_volume, it_status)
values(
seq_item.nextval, 
'pf', 
'퍼퓸 버가샌달', 
139000, 
'지중해의 베르가못 | 쌉싸래한 청귤 | 샌달우드', 
'지중해의 푸릇한 기운을 받고 자란 베르가못의 청량한 향에 라임 카다멈의 신선하고 쌉싸래한 향이 더해져 따사로운 햇볕 아래 서서히 익어가는 청귤을 떠오르게 합니다. 
뒤이어 샌달우드가 그려내는 부드러운 곡선의 잔 향은 주위에 은은하게 머물며 햇살 가득한 여름날의 따뜻한 기억을 그려냅니다.<br>
<span>탬버린즈 퍼퓸</span><br>
탬버린즈가 찾아낸 규정되지 않은 아름다움. 시간이 흐르면서 일어나는 다채로운 향의 변화를 느껴보세요. 세상에 흩어진 모든 이야기에서 영감을 받은 감각적인 향이 단조로운 일상에 자유롭고 새로운 리듬을 부여합니다.<br><br>
<span>탬버린즈의 미학</span><br>
직선적으로 느껴지는 날카로운 첫인상과 대비되는 부드러운 곡선의 촉각적인 경험은 손끝으로 사물을 읽는 듯한 공감각적인 흥미로움을 선사합니다.',
1000, 
'50mL', 
1);

-- 퍼퓸 쏘,선셋(제품일련번호(18), 카테고리 아이디, 상품명, 가격, 성분, 설명, 재고, 용량, 단종여부(0 : 단종 / 1 : 판매중))
insert into tbl_item(it_seq_no, fk_ca_id, it_name, it_price, it_ingredient, it_describe, it_stock, it_volume, it_status)
values(
seq_item.nextval, 
'pf', 
'퍼퓸 쏘,선셋', 
139000, 
'따뜻한 공기 | 오렌지 껍질 | 머스크', 
'봄이 찾아와 겨울의 무거운 공기가 걷히고 따뜻한 노을이 하늘을 붉게 물들이는 듯한 머스크의 묵직한 향과 오렌지 껍질의 상큼한 향이 만나 경쾌한 무게감을 퍼트립니다. 
달콤한 바닐라와 통카빈은 부드러운 향취를 더 하여 살결 위에 포근하고 기분 좋은 여운으로 오랜 시간 머무릅니다.<br>
<span>탬버린즈 퍼퓸</span><br>
탬버린즈가 찾아낸 규정되지 않은 아름다움. 시간이 흐르면서 일어나는 다채로운 향의 변화를 느껴보세요. 세상에 흩어진 모든 이야기에서 영감을 받은 감각적인 향이 단조로운 일상에 자유롭고 새로운 리듬을 부여합니다.<br><br>
<span>탬버린즈의 미학</span><br>
직선적으로 느껴지는 날카로운 첫인상과 대비되는 부드러운 곡선의 촉각적인 경험은 손끝으로 사물을 읽는 듯한 공감각적인 흥미로움을 선사합니다.',
1000, 
'50mL', 
1);


-- 퍼퓸 바이링거(제품일련번호(19), 카테고리 아이디, 상품명, 가격, 성분, 설명, 재고, 용량, 단종여부(0 : 단종 / 1 : 판매중))
insert into tbl_item(it_seq_no, fk_ca_id, it_name, it_price, it_ingredient, it_describe, it_stock, it_volume, it_status)
values(
seq_item.nextval, 
'pf', 
'퍼퓸 바이링거', 
139000, 
'마시멜로 | 오렌지 블라섬 | 타바코', 
'바이링거는 서로 다른 언어가 만나 새로운 의미로 확장되는 경험에서 영감을 얻었습니다. 
오렌지 블로섬의 깨 끗하고 정돈된 플로럴 향이 마시멜로와 만나 폭신한 솜사탕이 되고, 이와 대비되는 씁쓸하고 레더리한 토바코 노트가 어우러지며 서로 독립적으로 존재하던 상반된 두 가지 향이 서로를 휘감듯 자리하며 낯선 조화의 향을 경험하게 합니다.<br>
<span>탬버린즈 퍼퓸</span><br>
탬버린즈가 찾아낸 규정되지 않은 아름다움. 시간이 흐르면서 일어나는 다채로운 향의 변화를 느껴보세요. 세상에 흩어진 모든 이야기에서 영감을 받은 감각적인 향이 단조로운 일상에 자유롭고 새로운 리듬을 부여합니다.<br><br>
<span>탬버린즈의 미학</span><br>
직선적으로 느껴지는 날카로운 첫인상과 대비되는 부드러운 곡선의 촉각적인 경험은 손끝으로 사물을 읽는 듯한 공감각적인 흥미로움을 선사합니다.',
1000, 
'50mL', 
1);



-- 퍼퓸 핸드
-- 퍼퓸 쉘 엑스 카모(제품일련번호(2), 카테고리 아이디, 상품명, 가격, 성분, 설명, 재고, 용량, 단종여부(0 : 단종 / 1 : 판매중))
insert into tbl_item(it_seq_no, fk_ca_id, it_name, it_price, it_ingredient, it_describe, it_stock, it_volume, it_status)
values(
seq_item.nextval, 
'ph', 
'퍼퓸 쉘 엑스 카모', 
32000, 
'진득한 카모마일 | 부드러운 나무결 | 머스크', 
'꿀처럼 진득하고 달콤한 카모마일과 씁쓸한 클라리세이지의 허브 향이 오묘한 조화를 이루어 중독성 있는 향을 선사합니다. 
자칫 차갑게 느껴질 수 있는 촉촉한 이끼의 느낌을 우아하고 부드러운 나무결의 블론드 우드와 따뜻한 머스크로 감싸주어 당신의 지친 마음에 특별하고 작은 위안을 선물합니다.<br>
향수처럼 사용할 수 있는 크림 타입 퍼퓸.<br>
건조하고 손상되기 쉬운 손에 바르는 순간 빠르게 흡수됩니다. 끈적이지 않는 산뜻한 감촉과 함께 풍부한 영양을 공급하는 동시에 매력적인 향기를 전해줍니다. 
일상의 자극으로 지친 손을 편안한 수분감으로 진정시켜 주어 촉촉하게 빛나는 피부를 완성해 줍니다.<br>
모래에서 건져 낸 듯 한 퍼퓸 쉘 엑스의 디자인은 하나하나의 제품이 고유한 무늬를 띕니다. 향의 다채로운 느낌을 상상할 수 있도록 여러가지 컬러로 구성되어 있습니다.',
1000, 
'30mL', 
1);
-- 1 행 이(가) 삽입되었습니다.

-- 퍼퓸 쉘 엑스 버가샌달(제품일련번호(21), 카테고리 아이디, 상품명, 가격, 성분, 설명, 재고, 용량, 단종여부(0 : 단종 / 1 : 판매중))
insert into tbl_item(it_seq_no, fk_ca_id, it_name, it_price, it_ingredient, it_describe, it_stock, it_volume, it_status)
values(
seq_item.nextval, 
'ph', 
'퍼퓸 쉘 엑스 버가샌달', 
32000, 
'지중해의 베르가못 | 쌉싸래한 청귤 | 샌달우드', 
'지중해의 푸릇한 기운을 받고 자란 베르가못의 청량한 향에 라임 카다멈의 신선하고 쌉싸래한 향이 더해져 따사로운 햇볕 아래 서서히 익어가는 청귤을 떠오르게 합니다. 
뒤이어 샌달우드가 그려내는 부드러운 곡선의 잔 향은 주위에 은은하게 머물며 햇살 가득한 여름날의 따뜻한 기억을 그려냅니다.<br>
향수처럼 사용할 수 있는 크림 타입 퍼퓸.<br>
건조하고 손상되기 쉬운 손에 바르는 순간 빠르게 흡수됩니다. 끈적이지 않는 산뜻한 감촉과 함께 풍부한 영양을 공급하는 동시에 매력적인 향기를 전해줍니다. 
일상의 자극으로 지친 손을 편안한 수분감으로 진정시켜 주어 촉촉하게 빛나는 피부를 완성해 줍니다.<br>
모래에서 건져 낸 듯 한 퍼퓸 쉘 엑스의 디자인은 하나하나의 제품이 고유한 무늬를 띕니다. 향의 다채로운 느낌을 상상할 수 있도록 여러가지 컬러로 구성되어 있습니다.',
1000, 
'30mL', 
1);
-- 1 행 이(가) 삽입되었습니다.


-- 퍼퓸 쉘 엑스 라레(제품일련번호(22), 카테고리 아이디, 상품명, 가격, 성분, 설명, 재고, 용량, 단종여부(0 : 단종 / 1 : 판매중))
insert into tbl_item(it_seq_no, fk_ca_id, it_name, it_price, it_ingredient, it_describe, it_stock, it_volume, it_status)
values(
seq_item.nextval, 
'ph', 
'퍼퓸 쉘 엑스 라레', 
32000, 
'이슬을 머금은 풋사과 | 화이트 튤립 | 샌달우드', 
'튤립의 첫 이름을 의미하는 라레는 새벽의 이슬을 머금은 청초한 푸른 사과를 한 입 베어 문 듯 청량하면서도 절제된 달콤함을 시작으로, 잔잔한 그린 플로럴의 향취가 화이트 튤립의 싱그러운 푸른 잎사귀를 떠오르게 합니다. 
진득한 샌달우드에 스파이시한 무드의 레더와 미모사가 더해져 깊고 은은한 여운을 남깁니다.<br>
향수처럼 사용할 수 있는 크림 타입 퍼퓸.<br>
건조하고 손상되기 쉬운 손에 바르는 순간 빠르게 흡수됩니다. 
끈적이지 않는 산뜻한 감촉과 함께 풍부한 영양을 공급하는 동시에 매력적인 향기를 전해줍니다. 일상의 자극으로 지친 손을 편안한 수분감으로 진정시켜 주어 촉촉하게 빛나는 피부를 완성해 줍니다.<br>
모래에서 건져 낸 듯 한 퍼퓸 쉘 엑스의 디자인은 하나하나의 제품이 고유한 무늬를 띕니다. 향의 다채로운 느낌을 상상할 수 있도록 여러가지 컬러로 구성되어 있습니다.',
1000, 
'30mL', 
1);


-- FEY9(제품일련번호(23), 카테고리 아이디, 상품명, 가격, 성분, 설명, 재고, 용량, 단종여부(0 : 단종 / 1 : 판매중))
insert into tbl_item(it_seq_no, fk_ca_id, it_name, it_price, it_ingredient, it_describe, it_stock, it_volume, it_status)
values(
seq_item.nextval, 
'ph', 
'FEY9', 
32000, 
'무화과나무 | 엠브레트 씨앗 | 달콤 씁쓸한', 
'열매 안에서 꽃을 피우는 무화과는 절제된 향취를 가집니다. 
잎과 과육의 달콤 씁쓸함이 더해져 향은 더욱 풍부해지고, 엠브레트 씨앗과 엠버의 부드러운 조화는 깊이감 있는 여운을 남기며 향의 매력에 빠져들게 만듭니다.<br><br>
향수처럼 사용할 수 있는 크림 타입 퍼퓸.<br>
더 쉘 퍼퓸핸드는 건조하고 손상되기 쉬운 손에 바르는 순간 빠르게 흡수됩니다. 끈적이지 않는 산뜻한 감촉과 함께 풍부한 영양을 공급하는 동시에 매력적인 향기를 전해줍니다.<br><br>
일상의 자극으로 지친 손을 편안한 수분감으로 진정시키는 더 쉘 퍼퓸핸드와 함께 촉촉하게 빛나는 피부를 완성해보세요.',
1000, 
'40mL', 
1);


-- 퍼퓸 비누
-- 퍼퓸 비누 카모 트레이 세트(제품일련번호(3), 카테고리 아이디, 상품명, 가격, 성분, 설명, 재고, 용량, 단종여부(0 : 단종 / 1 : 판매중))
insert into tbl_item(it_seq_no, fk_ca_id, it_name, it_price, it_ingredient, it_describe, it_stock, it_volume, it_status)
values(
seq_item.nextval, 
'ps', 
'퍼퓸 비누 카모 트레이 세트', 
43500, 
'진득한 카모마일 | 부드러운 나무결 | 머스크', 
'퍼퓸 비누와 전용 트레이로 구성 된 세트 제품입니다.<br>
꿀처럼 진득하고 달콤한 카모마일과 씁쓸한 클라리세이지의 허브 향이 오묘한 조화를 이루어 중독성 있는 향을 선사합니다.<br><br>
자연을 닮은 탬버린즈 퍼퓸 비누는 화학적인 성분을 최대한 배제하고 작물의 수확에서 오는 건강함을 온전히 전하고자 식물유래 성분을 사용하여 피부 pH와 유사한 약산성 성분의 비누로 만들어졌습니다.<br><br>
작물을 수확할 때의 기쁨을 형상화한 퍼퓸 비누.<br>
건강한 사람의 피부는 pH 4.5~6.5를 유지합니다.<br>
코코넛 유래 계면활성제는 밀도감 있는 풍부한 거품을 만들어 주며, 식물성 오일 컴플렉스는 피부를 보호하고 수분 증발을 차단해 줍니다. 또한 옥수수전분을 통한 소프트한 스크럽 효과가 피부 결을 정돈해 줍니다.<br><br>
*코코넛유래 계면활성제를 사용하는 약산성비누 특성상 물과 만나면 제품표면에 하얗게 백탁현상이 생길 수 있습니다. 비누가 다시<br>
건조되면 본래 컬러로 되돌아오니 안심하시고 사용 부탁드립니다.<br><br>
[퍼퓸 비누 트레이]<br>
사이즈: 140 x 100 x 5mm<br>
재질: 세라믹',
1000, 
'115g', 
1);
-- 1 행 이(가) 삽입되었습니다.

-- 퍼퓸 비누 버가샌달 트레이 세트(제품일련번호(24), 카테고리 아이디, 상품명, 가격, 성분, 설명, 재고, 용량, 단종여부(0 : 단종 / 1 : 판매중))
insert into tbl_item(it_seq_no, fk_ca_id, it_name, it_price, it_ingredient, it_describe, it_stock, it_volume, it_status)
values(
seq_item.nextval, 
'ps', 
'퍼퓸 비누 버가샌달 트레이 세트', 
43500, 
'지중해의 베르가못 | 쌉싸래한 청귤 | 샌달우드', 
'퍼퓸 비누와 전용 트레이로 구성 된 세트 제품입니다.<br>
지중해의 푸릇한 기운을 받고 자란 베르가못의 청량한 향에 라임 카다멈의 신선하고 쌉싸래한 향이 더해져 따사로운 햇볕 아래 서서히 익어가는 청귤을 떠오르게 합니다.<br><br>
자연을 닮은 탬버린즈 퍼퓸 비누는 화학적인 성분을 최대한 배제하고 작물의 수확에서 오는 건강함을 온전히 전하고자 식물유래 성분을 사용하여 피부 pH와 유사한 약산성 성분의 비누로 만들어졌습니다.<br><br>
작물을 수확할 때의 기쁨을 형상화한 퍼퓸 비누.<br>
건강한 사람의 피부는 pH 4.5~6.5를 유지합니다.<br>
코코넛 유래 계면활성제는 밀도감 있는 풍부한 거품을 만들어 주며, 식물성 오일 컴플렉스는 피부를 보호하고 수분 증발을 차단해 줍니다. 또한 옥수수전분을 통한 소프트한 스크럽 효과가 피부 결을 정돈해 줍니다.<br><br>
*코코넛유래 계면활성제를 사용하는 약산성비누 특성상 물과 만나면 제품표면에 하얗게 백탁현상이 생길 수 있습니다. 비누가 다시<br>
건조되면 본래 컬러로 되돌아오니 안심하시고 사용 부탁드립니다.<br><br>
[퍼퓸 비누 트레이]<br>
사이즈: 140 x 100 x 5mm<br>
재질: 세라믹',
1000, 
'140g', 
1);
-- 1 행 이(가) 삽입되었습니다.

-- 퍼퓸 비누 라레 트레이 세트(제품일련번호(25), 카테고리 아이디, 상품명, 가격, 성분, 설명, 재고, 용량, 단종여부(0 : 단종 / 1 : 판매중))
insert into tbl_item(it_seq_no, fk_ca_id, it_name, it_price, it_ingredient, it_describe, it_stock, it_volume, it_status)
values(
seq_item.nextval, 
'ps', 
'퍼퓸 비누 라레 트레이 세트', 
43500, 
'이슬을 머금은 풋사과 | 화이트 튤립 | 샌달우드', 
'퍼퓸 비누와 전용 트레이로 구성 된 세트 제품입니다.<br>
튤립의 첫 이름을 의미하는 라레는 새벽의 이슬을 머금은 청초한 푸른 사과를 한 입 베어 문 듯 청량하면서도 절제된 달콤함을 시작으로, 잔잔한 그린 플로럴의 향취가 화이트 튤립의 싱그러운 푸른 잎사귀를 떠오르게 합니다.<br><br>
자연을 닮은 탬버린즈 퍼퓸 비누는 화학적인 성분을 최대한 배제하고 작물의 수확에서 오는 건강함을 온전히 전하고자 식물유래 성분을 사용하여 피부 pH와 유사한 약산성 성분의 비누로 만들어졌습니다.<br><br>
작물을 수확할 때의 기쁨을 형상화한 퍼퓸 비누.<br>
건강한 사람의 피부는 pH 4.5~6.5를 유지합니다.<br>
코코넛 유래 계면활성제는 밀도감 있는 풍부한 거품을 만들어 주며, 식물성 오일 컴플렉스는 피부를 보호하고 수분 증발을 차단해 줍니다. 또한 옥수수전분을 통한 소프트한 스크럽 효과가 피부 결을 정돈해 줍니다.<br><br>
*코코넛유래 계면활성제를 사용하는 약산성비누 특성상 물과 만나면 제품표면에 하얗게 백탁현상이 생길 수 있습니다. 비누가 다시<br>
건조되면 본래 컬러로 되돌아오니 안심하시고 사용 부탁드립니다.<br><br>
[퍼퓸 비누 트레이]<br>
사이즈: 140 x 100 x 5mm<br>
재질: 세라믹',
1000, 
'130g', 
1);
-- 1 행 이(가) 삽입되었습니다.

select *
from tbl_item


-- 퍼퓸 비누 화이트다즐링 트레이 세트(제품일련번호(26), 카테고리 아이디, 상품명, 가격, 성분, 설명, 재고, 용량, 단종여부(0 : 단종 / 1 : 판매중))
insert into tbl_item(it_seq_no, fk_ca_id, it_name, it_price, it_ingredient, it_describe, it_stock, it_volume, it_status)
values(
seq_item.nextval, 
'ps', 
'퍼퓸 비누 화이트다즐링 트레이 세트', 
43500, 
'화이트 샴페인 | 다즐링 티 | 크리미한 머스크', 
'퍼퓸 비누와 전용 트레이로 구성 된 세트 제품입니다.<br>
화이트 샴페인의 섬세한 거품과 달달한 과일향에 씁쓸한 다즐링 차 향이 풍성하고 조화롭게 어우러져 찻잔 속에서 추는 우아한 향의 춤의 향연을 선사합니다.<br><br>
자연을 닮은 탬버린즈 퍼퓸 비누는 화학적인 성분을 최대한 배제하고 작물의 수확에서 오는 건강함을 온전히 전하고자 식물유래 성분을 사용하여 피부 pH와 유사한 약산성 성분의 비누로 만들어졌습니다.<br><br>
작물을 수확할 때의 기쁨을 형상화한 퍼퓸 비누.<br>
건강한 사람의 피부는 pH 4.5~6.5를 유지합니다.<br>
코코넛 유래 계면활성제는 밀도감 있는 풍부한 거품을 만들어 주며, 식물성 오일 컴플렉스는 피부를 보호하고 수분 증발을 차단해 줍니다. 또한 옥수수전분을 통한 소프트한 스크럽 효과가 피부 결을 정돈해 줍니다.<br><br>
*코코넛유래 계면활성제를 사용하는 약산성비누 특성상 물과 만나면 제품표면에 하얗게 백탁현상이 생길 수 있습니다. 비누가 다시<br>
건조되면 본래 컬러로 되돌아오니 안심하시고 사용 부탁드립니다.<br><br>
[퍼퓸 비누 트레이]<br>
사이즈: 140 x 100 x 5mm<br>
재질: 세라믹',
1000, 
'115g', 
1);
-- 1 행 이(가) 삽입되었습니다.


-- 튜브 핸드
-- 000(제품일련번호(4), 카테고리 아이디, 상품명, 가격, 성분, 설명, 재고, 용량, 단종여부(0 : 단종 / 1 : 판매중))
insert into tbl_item(it_seq_no, fk_ca_id, it_name, it_price, it_ingredient, it_describe, it_stock, it_volume, it_status)
values(
seq_item.nextval, 
'th', 
'000', 
32000, 
'샌달우드 | 패츌리 | 흙 내음', 
'바르는 순간 코 끝을 스치는 베르가못의 시원함, 수분을 머금은 흙을 연상시키는 패츌리와 무겁게 내려앉은 샌달우드는 갓 꺾은 야생화를 품에 가득 안았을 때 느껴지는 대지의 활기를 떠올리게 합니다.<br><br>
피부 친화력이 뛰어난 누드에이치앤드크림.<br>
식물성 오일 성분으로 피부 장벽을 강화시키며 빠르게 스며듭니다. 끈적이지 않는 깔끔한 텍스처는 언제든지 손을 사용하기에 자유로운 상태를 유지해 주며, 벨벳같이 부드러운 피부로 가꾸어 줍니다.',
1000, 
'65mL', 
1);
-- 1 행 이(가) 삽입되었습니다.

-- 7(제품일련번호(27), 카테고리 아이디, 상품명, 가격, 성분, 설명, 재고, 용량, 단종여부(0 : 단종 / 1 : 판매중))
insert into tbl_item(it_seq_no, fk_ca_id, it_name, it_price, it_ingredient, it_describe, it_stock, it_volume, it_status)
values(
seq_item.nextval, 
'th', 
'7', 
32000, 
'로즈우드 | 코코넛 향 | 우아함', 
'잔잔한 꽃 향이 섞인 로즈우드와 라반딘의 정제되지 않은 야생화 본연의 향기에 코코넛의 달콤한 잔향이 어우러져 우아하고 매력적인 여운을 남깁니다.<br><br>
피부 친화력이 뛰어난 누드에이치앤드크림.<br>
식물성 오일 성분으로 피부 장벽을 강화시키며 빠르게 스며듭니다. 끈적이지 않는 깔끔한 텍스처는 언제든지 손을 사용하기에 자유로운 상태를 유지해 주며, 벨벳같이 부드러운 피부로 가꾸어 줍니다.',
1000, 
'65mL', 
1);
-- 1 행 이(가) 삽입되었습니다.

-- 712(제품일련번호(28), 카테고리 아이디, 상품명, 가격, 성분, 설명, 재고, 용량, 단종여부(0 : 단종 / 1 : 판매중))
insert into tbl_item(it_seq_no, fk_ca_id, it_name, it_price, it_ingredient, it_describe, it_stock, it_volume, it_status)
values(
seq_item.nextval, 
'th', 
'712', 
32000, 
'패츌리 | 쌉싸래한 풀 줄기 | 스모키함', 
'첫 향에서 느껴지는 부드럽고 매혹적인 오스만투스의 투명함과 짙게 남는 타바코의 퇴폐적인 향은 감각의 양면성이 가진 매력을 표현합니다. 순수와 퇴폐의 상반된 혼합은 새롭고 강렬한 아름다움을 선사합니다.<br><br>
피부 친화력이 뛰어난 누드에이치앤드크림.<br>
식물성 오일 성분으로 피부 장벽을 강화시키며 빠르게 스며듭니다. 끈적이지 않는 깔끔한 텍스처는 언제든지 손을 사용하기에 자유로운 상태를 유지해 주며, 벨벳같이 부드러운 피부로 가꾸어 줍니다.',
1000, 
'65mL', 
1);
-- 1 행 이(가) 삽입되었습니다.

-- 421(제품일련번호(29), 카테고리 아이디, 상품명, 가격, 성분, 설명, 재고, 용량, 단종여부(0 : 단종 / 1 : 판매중))
insert into tbl_item(it_seq_no, fk_ca_id, it_name, it_price, it_ingredient, it_describe, it_stock, it_volume, it_status)
values(
seq_item.nextval, 
'th', 
'421', 
32000, 
'바닐라 우디 | 너티함', 
'깊이 있는 나무 수지의 풍성함을 메인으로 중독적이면서 달콤한 바닐라와 내추럴한 시더우드가 편안함을 안겨주며 나뭇결 사이에 녹아 스며든 바닐라를 연상시키는 향입니다.<br><br>
피부 친화력이 뛰어난 누드에이치앤드크림.<br>
식물성 오일 성분으로 피부 장벽을 강화시키며 빠르게 스며듭니다. 끈적이지 않는 깔끔한 텍스처는 언제든지 손을 사용하기에 자유로운 상태를 유지해 주며, 벨벳같이 부드러운 피부로 가꾸어 줍니다.',
1000, 
'65mL', 
1);
-- 1 행 이(가) 삽입되었습니다.

select *
from tbl_item;

----------------------- 제품사진 테이블 추가 -----------------------
-- 제품사진 일련번호
create sequence seq_img
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_IMG이(가) 생성되었습니다.


-- 퍼퓸 
-- 퍼퓸 카모(사진 일련번호, 제품아이디, 파일이름)
insert into tbl_img(img_seq_no, fk_it_seq_no, img_file)
values(seq_img.nextval, 1, 'pf_chamo.jpg');
-- 1 행 이(가) 삽입되었습니다.
update tbl_img set main_img_file = 'pf_chamo.jpg'
where fk_it_seq_no = 1;
-- 1 행 이(가) 업데이트되었습니다.
commit;

-- 퍼퓸 버가샌달(사진 일련번호, 제품아이디, 파일이름)
insert into tbl_img(img_seq_no, fk_it_seq_no, img_file)
values(seq_img.nextval, 17, 'pf_berga.jpg');
-- 1 행 이(가) 삽입되었습니다.
update tbl_img set main_img_file = 'pf_berga.jpg'
where fk_it_seq_no = 17;
-- 1 행 이(가) 업데이트되었습니다.
commit;

-- 퍼퓸 쏘,선셋(사진 일련번호, 제품아이디, 파일이름)
insert into tbl_img(img_seq_no, fk_it_seq_no, img_file)
values(seq_img.nextval, 18, 'pf_thaw.jpg');
-- 1 행 이(가) 삽입되었습니다.
update tbl_img set main_img_file = 'pf_thaw.jpg'
where fk_it_seq_no = 18;
-- 1 행 이(가) 업데이트되었습니다.
commit;

-- 퍼퓸 바이링거(사진 일련번호, 제품아이디, 파일이름)
insert into tbl_img(img_seq_no, fk_it_seq_no, img_file)
values(seq_img.nextval, 19, 'pf_bilingual.jpg');
-- 1 행 이(가) 삽입되었습니다.
update tbl_img set main_img_file = 'pf_bilingual.jpg'
where fk_it_seq_no = 19;
-- 1 행 이(가) 업데이트되었습니다.





-- 퍼퓸 핸드
-- 퍼퓸 쉘 엑스 카모(사진 일련번호, 제품아이디, 파일이름)
insert into tbl_img(img_seq_no, fk_it_seq_no, img_file)
values(seq_img.nextval, 2, 'ph_chamo.jpg');
-- 1 행 이(가) 삽입되었습니다.
update tbl_img set main_img_file = 'ph_chamo.jpg'
where fk_it_seq_no = 2;
-- 1 행 이(가) 업데이트되었습니다.

-- 퍼퓸 쉘 엑스 버가샌달(21)(사진 일련번호, 제품아이디, 파일이름)
insert into tbl_img(img_seq_no, fk_it_seq_no, img_file, main_img_file)
values(seq_img.nextval, 21, 'ph_berga.jpg', 'ph_berga.jpg');

-- 퍼퓸 쉘 엑스 라레(22)(사진 일련번호, 제품아이디, 파일이름)
insert into tbl_img(img_seq_no, fk_it_seq_no, img_file, main_img_file)
values(seq_img.nextval, 22, 'ph_lale.jpg', 'ph_lale.jpg');

-- FEY9(23)(사진 일련번호, 제품아이디, 파일이름)
insert into tbl_img(img_seq_no, fk_it_seq_no, img_file, main_img_file)
values(seq_img.nextval, 23, 'ph_fey9.jpg', 'ph_fey9.jpg');


-- 퍼퓸 비누
-- 퍼퓸 비누 카모 트레이 세트(사진 일련번호, 제품아이디, 파일이름)
insert into tbl_img(img_seq_no, fk_it_seq_no, img_file)
values(seq_img.nextval, 3, 'ps_chamo_tray.jpg');
-- 1 행 이(가) 삽입되었습니다.
update tbl_img set main_img_file = 'ps_chamo_tray.jpg'
where fk_it_seq_no = 3;
-- 1 행 이(가) 업데이트되었습니다.


-- 튜브 핸드
-- 000(사진 일련번호, 제품아이디, 파일이름)
insert into tbl_img(img_seq_no, fk_it_seq_no, img_file)
values(seq_img.nextval, 4, 'th_000.jpg');
-- 1 행 이(가) 삽입되었습니다.
update tbl_img set main_img_file = 'th_000.jpg'
where fk_it_seq_no = 4;
-- 1 행 이(가) 업데이트되었습니다.


select *
from tbl_img
where main_img_file is not null
order by img_file;

-- pf_perfume_chamo_01


commit;
-- 커밋 완료.

select * 
from user_sequences;

-- 카테고리아이디, 제품일련번호, 제품이름, 성분, 가격, 용량, 사진번호, 사진파일
select ca_id, ca_name, it_seq_no, it_name, it_ingredient, it_price, it_volume, img_seq_no, img_file
from
(
    SELECT rank() OVER(partition by ca_id ORDER BY ca_id, it_create_date) AS rank, ca_id, ca_name, it_seq_no, it_name, it_ingredient, it_price, it_volume, img_seq_no, img_file
        FROM
        (
        select *
        from tbl_img A
        join tbl_item B
        on A.fk_it_seq_no = B.it_seq_no
        where is_main_img = 1
        ) V
    JOIN tbl_category X
    ON V.fk_ca_id = X.ca_id
    order by ca_name desc, it_create_date
)
where rank <= 4;



-- 카테고리아이디, 제품일련번호, 제품이름, 성분, 가격, 용량, 사진번호, 사진파일
select ca_id, ca_name, it_seq_no, it_name, it_ingredient, it_price, it_volume, img_seq_no, img_file
    from
    (
    SELECT rank() OVER(partition by ca_id ORDER BY ca_id, it_create_date) AS rank, ca_id, ca_name, it_seq_no, it_name, it_ingredient, it_price, it_volume, img_seq_no, img_file
        FROM
        (
        select *
        from tbl_img A
        join tbl_item B
        on A.fk_it_seq_no = B.it_seq_no
        where is_main_img = 1
        ) V
    JOIN tbl_category X
    ON V.fk_ca_id = X.ca_id
    where ca_id = 'ph'
    order by ca_name desc, it_create_date
    );


select ca_id, ca_name
from tbl_category;

update tbl_category set ca_name = '퍼퓸'
where ca_id = 'pf';
commit;
update tbl_category set ca_name = '퍼퓸 핸드'
where ca_id = 'ph';
commit;
update tbl_category set ca_name = '퍼퓸 비누'
where ca_id = 'ps';
commit;
update tbl_category set ca_name = '튜브 핸드'
where ca_id = 'th';
commit;

select ca_name, ca_id, count(*) 
from tbl_category V
join tbl_item C
on V.ca_id = C.fk_ca_id
group by ca_name, ca_id
order by ca_name desc;

select *
from tbl_item
where fk_ca_id = 'bw';

select *
from tbl_img;


insert into tbl_img(img_seq_no, fk_it_seq_no, img_file)
values(seq_img.nextval, 14, 'bw_nimbus.jpg');
update tbl_img set is_main_img = 1
where img_file = 'bw_biga.jpg';

insert into tbl_img(img_seq_no, fk_it_seq_no, img_file)
values(seq_img.nextval, 20, 'bw_biga.jpg');
update tbl_img set is_main_img = 1
where img_file = 'bw_nimbus.jpg';

update tbl_img set is_main_img = 0
where main_img_file is null;

commit;

-- 퍼퓸 비누 버가샌달 트레이 세트(제품일련번호(24)
insert into tbl_img(img_seq_no, fk_it_seq_no, img_file, is_main_img)
values(seq_img.nextval, 24, 'ps_berga_tray.jpg', 1);
-- 퍼퓸 비누 라레 트레이 세트(제품일련번호(25)
insert into tbl_img(img_seq_no, fk_it_seq_no, img_file, is_main_img)
values(seq_img.nextval, 25, 'ps_lale_tray.jpg', 1);
-- 퍼퓸 비누 화이트다즐링 트레이 세트(제품일련번호(26)
insert into tbl_img(img_seq_no, fk_it_seq_no, img_file, is_main_img)
values(seq_img.nextval, 26, 'ps_white_tray.jpg', 1);

-- 7(제품일련번호(27)
insert into tbl_img(img_seq_no, fk_it_seq_no, img_file, is_main_img)
values(seq_img.nextval, 27, 'th_7.jpg', 1);
-- 712(제품일련번호(28)
insert into tbl_img(img_seq_no, fk_it_seq_no, img_file, is_main_img)
values(seq_img.nextval, 28, 'th_712.jpg', 1);
-- 421(제품일련번호(29)
insert into tbl_img(img_seq_no, fk_it_seq_no, img_file, is_main_img)
values(seq_img.nextval, 29, 'th_421.jpg', 1);


-- 샤워리바디
-- 바디워시 FOG(제품일련번호(30), 카테고리 아이디, 상품명, 가격, 성분, 설명, 재고, 용량, 단종여부(0 : 단종 / 1 : 판매중))
insert into tbl_item(it_seq_no, fk_ca_id, it_name, it_price, it_ingredient, it_describe, it_stock, it_volume, it_status)
values(
seq_item.nextval, 
'bw', 
'바디워시 FOG', 
52000, 
'물안개 낀 숲 | 젖은 나무 | 캐시미어 우드', 
'소나무에 맺힌 이슬처럼 시원하고 상쾌한 주니퍼의 향취가 물안개 낀 이른 아침을 떠오르게 합니다. 비에 젖은 나무가 내뿜는 부드러운 캐시미어 우드의 향취가 자연에서 느낄 수 있는 차분한 편안함을 더해줍니다.<br><br>
샤워리바디 워시.<br>
4가지 비의 이야기를 담고 있는 샤워리 바디 워시는 물에 닿는 순간 풍성한 거품으로 변해 피부를 부드럽게 씻어내어 자연의 향으로 감싸줍니다.<br><br>
일상의 자극으로 지친 몸과 마음을 편안한 수분감으로 진정시키는 병풀 성분이 함유되어 촉촉하게 빛나는 피부를 유지하는 데에 도움을 줍니다.',
1000, 
'470mL', 
1);
-- 1 행 이(가) 삽입되었습니다.

-- 바디워시 STORM(제품일련번호(31), 카테고리 아이디, 상품명, 가격, 성분, 설명, 재고, 용량, 단종여부(0 : 단종 / 1 : 판매중))
insert into tbl_item(it_seq_no, fk_ca_id, it_name, it_price, it_ingredient, it_describe, it_stock, it_volume, it_status)
values(
seq_item.nextval, 
'bw', 
'바디워시 STORM', 
52000, 
'풀내음 | 짙은 오렌지 | 베티버 뿌리의 쌉쌀함', 
'갈바넘의 날카로운 그린함과 베티버의 스모키한 우디함을 담고 있는 이 향은 강한 폭풍이 휩쓸고 간 뒤 선명해진 공기를 연상 시킵니다. 
잘 익은 오렌지 향이 긴장감을 완화시키고 부드러운 베티버 뿌리의 쌉쌀한 잔향이 섬세한 감각의 호흡을 느끼게 합니다.<br><br>
샤워리바디 워시.<br>
4가지 비의 이야기를 담고 있는 샤워리 바디 워시는 물에 닿는 순간 풍성한 거품으로 변해 피부를 부드럽게 씻어내어 자연의 향으로 감싸줍니다.<br><br>
일상의 자극으로 지친 몸과 마음을 편안한 수분감으로 진정시키는 병풀 성분이 함유되어 촉촉하게 빛나는 피부를 유지하는 데에 도움을 줍니다.',
1000, 
'470mL', 
1);
-- 1 행 이(가) 삽입되었습니다.

select *
from tbl_item;

-- 바디워시 FOG(제품일련번호(30)
insert into tbl_img(img_seq_no, fk_it_seq_no, img_file, is_main_img)
values(seq_img.nextval, 30, 'bw_fog.jpg', 1);
-- 바디워시 STORM(제품일련번호(31)
insert into tbl_img(img_seq_no, fk_it_seq_no, img_file, is_main_img)
values(seq_img.nextval, 31, 'bw_storm.jpg', 1);


commit;


select *
from tbl_item
where it_name = 'BIGALICO';

select *
from tbl_item
where IT_DESCRIBE_SIMPLE is null and fk_ca_id = 'bw';

update tbl_item 
set it_name = '바디워시 BIGALICO'
where it_name = 'BIGALICO';

update tbl_item 
set IT_DESCRIBE_SIMPLE = '갈바넘의 날카로운 그린함과 베티버의 스모키한 우디함을 담고 있는 이 향은 강한 폭풍이 휩쓸고 간 뒤 선명해진 공기를 연상 시킵니다. 잘 익은 오렌지 향이 긴장감을 완화시키고 부드러운 베티버 뿌리의 쌉쌀한 잔향이 섬세한 감각의 호흡을 느끼게 합니다.<br><br>샤워리바디 워시.'
where it_name = '바디워시 STORM';

select *
from tbl_item
where it_describe_simple is null

select*

ALTER TABLE tbl_item RENAME COLUMN it_ingredient TO it_theme
-- Table TBL_IMG이(가) 변경되었습니다.


alter table tbl_item add it_ingredient Nvarchar2(1000);
-- Table TBL_IMG이(가) 변경되었습니다.

-- VEIN(제품일련번호(32), 카테고리 아이디, 상품명, 가격, 주제, 전성분, 간략설명, 설명, 재고, 용량, 단종여부(0 : 단종 / 1 : 판매중))
insert into tbl_item(it_seq_no, fk_ca_id, it_name, it_price, it_theme, it_ingredient, it_describe_simple, it_describe, it_stock, it_volume, it_status)
values(
seq_item.nextval, 
'ph', 
'VEIN', 
32000, 
'월계수 잎 | 은방울꽃 | 정돈된 가죽', 
'가볍게 감싸는 월계수 잎과 은방울꽃의 깨끗함 뒤로, 정돈된 가죽 향이 약간의 긴장감을 선명하게 유지해 줍니다. 
가죽의 무게감은 잔향의 머스크와 만나 눈부신 대조를 이루며 한층 부드러워진 맥박의 잔잔한 템포를 느끼게 합니다.<br><br>
향수처럼 사용할 수 있는 크림 타입 퍼퓸.',
'정제수, 글리세린, 카프릴릭/카프릭트라이글리세라이드, 부틸렌글라이콜, 세테 아릴알코올, C12-15알킬벤조에이트, 아이소도데케인, 향료, 1,2-헥산다이올, 글리세릴스테아레이트, 베헤닐알코올, 시어버터, 피이지-100스테아레이트, 다이메티콘, 에틸헥실글리세린, 알루미늄전분옥테닐석시네이트, 잔탄검, 암모늄아크릴로일 다이메틸타우레이트/브이피코폴리머, 세틸알코올, 하이드롤 라이즈드호호바에스터, 아데노신, 판테놀, 토코페릴아세테이트, 호호바에스터, 소듐하이알루로네이트, 병풀추출물, 시트로넬올, 유제놀, 제라니올, 헥실신남알, 아이소유제놀, 리모넨, 리날룰.', 
'가볍게 감싸는 월계수 잎과 은방울꽃의 깨끗함 뒤로, 정돈된 가죽 향이 약간의 긴장감을 선명하게 유지해 줍니다. <br>
가죽의 무게감은 잔향의 머스크와 만나 눈부신 대조를 이루며 한층 부드러워진 맥박의 잔잔한 템포를 느끼게 합니다.<br><br>
향수처럼 사용할 수 있는 크림 타입 퍼퓸.<br>
더 쉘 퍼퓸핸드는 건조하고 손상되기 쉬운 손에 바르는 순간 빠르게 흡수됩니다. 끈적이지 않는 산뜻한 감촉과 함께 풍부한 영양을 공급하는 동시에 매력적인 향기를 전해줍니다.<br><br>
일상의 자극으로 지친 손을 편안한 수분감으로 진정시키는 더 쉘 퍼퓸핸드와 함께 촉촉하게 빛나는 피부를 완성해보세요.',
1000, 
'40mL', 
1);

insert into tbl_img(img_seq_no, fk_it_seq_no, img_file, is_main_img)
values(seq_img.nextval, 32, 'ph_vein.jpg', 1);

commit;

select *
from tbl_user
where status = 0;



SELECT userid, name, birthday, email, mobile, gender, postcode, address, detailaddress, extraaddress, registerdate, pwdchangegap
     , nvl( lastlogingap, trunc(months_between(sysdate, to_date(registerdate, 'yyyy-mm-dd'))) ) AS lastlogingap, status
FROM
( 
    select userid, name, birthday, email, mobile, gender, postcode, address, detailaddress, extraaddress, to_char(registerdate, 'yyyy-mm-dd') AS registerdate, trunc(months_between(sysdate, last_pwd_changedate)) AS pwdchangegap, status
	from tbl_user
	where status = 1 -- and userid = ? and pwd = ?
) M
CROSS JOIN
(
    select trunc(months_between(sysdate, max(login_date))) AS lastlogingap
    from tbl_login_log
    -- where fk_userid = ?
) H;

select *
from tbl_user;

update tbl_user set registerdate = '21/10/22', status = 1, last_pwd_changedate = '21/10/23'
where name = '두나'


select fk_userid, login_date
from tbl_login_log;

update tbl_login_log set login_date = '21/10/24'
where fk_userid = 'doona@nate.com'

commit;

select ca_id, ca_name, ca_img_file
from tbl_category;

update tbl_category 
set ca_img_file = 'bw.png'
where ca_id = 'bw';

update tbl_category 
set ca_img_file = 'pf.png'
where ca_id = 'pf';

update tbl_category 
set ca_img_file = 'ph.png'
where ca_id = 'ph';

update tbl_category 
set ca_img_file = 'ps.png'
where ca_id = 'ps';

update tbl_category 
set ca_img_file = 'th.png'
where ca_id = 'th';

commit;














