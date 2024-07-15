<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
       
<%
	// 컨텍스트 패스명(context path name)을 알아오고자 한다.
	String ctxPath = request.getContextPath();
	// ctxPath ==> /tempsemi
%> 



<title>온라인 서비스 | TAMBURINS 비공식 온라인 스토어</title>

<link rel="stylesheet"  href="<%= ctxPath%>/css/ws/onlinmeSerivce.css" type="text/css">
<link rel="stylesheet"  href="<%= ctxPath%>/font/font.css" type="text/css">
<jsp:include page="../jy/header_revised.jsp" />
<%-- 카테고리 시작 --%>
	<div id="category_container">
		<ul>
			<li id="total_view" name="total_view">
				<a href="#">
					<span class="category_img"><img src="<%= ctxPath %>/images/ws/header_footer/온라인 서비스.png" style="width:100px; height:100px;" class="cate_img" ></span>
					<span class="category_name header_footer_font">온라인 서비스</span>
				</a>
			</li>
		</ul>
	</div>
	<%-- 카테고리 끝 --%>
	
	<%-- sticky bar 시작 --%>
	
	<div class="sticky_son" style="padding-left:230px; font-weight:bold">온라인 서비스</div>

	<%-- sticky bar 끝 --%>
	
	
	<div class="service_background_img"><img src="<%= ctxPath %>/images/ws/header_footer/service_background.jpg"/></div>
	
	
	
	
	
	
	<div class="main-banner_cont text-center">
        <div class="main-banner_subject">특별한 온라인 서비스</div>
        <div class="main-banner_desc">탬버린즈는 고객님의 특별한 쇼핑 경험을 위해 언제나 노력합니다. <br>고객님을 위해 준비된 다양한 온라인 혜택 및 서비스를 경험해 보세요.</div>
    </div>
    
<div id="service-info_container">    
	<div class="row row_up">
		<div class="service-info__item col-md-4 bd-rg">
	        <h3 class="service-info_title text-center">무료배송</h3>
	        <div class="service-info_content">3만원 이상 제품 구매 시 무료배송 서비스가 제공되며, 재고를 보유하고 있는 상품의 경우 주문일로부터 영업일 기준 1-2일 내 출고 진행됩니다. 배송은 지역 택배사 사정에 따라 약간의 지연이 생길 수 있습니다. 배송이 시작되면 구매자에게는 이메일, 수령인에게는 카카오 알림톡으로 배송 정보를 전송해 드립니다.</div>
	    </div>
	    
		<div class="service-info__item col-md-4 bd-rg">
	        <h3 class="service-info_title text-center">온라인 익스클루시브</h3>
	        <div class="service-info_content">탬버린즈 회원만을 위해 준비된 온라인 익스클루시브 혜택을 경험해보세요.</div>
	    </div>
	    
		<div class="service-info__item col-md-4">
	        <h3 class="service-info_title text-center">무료 샘플</h3>
	        <div class="service-info_content">탬버린즈의 다양한 제품을 경험해 보실 수 있도록 모든 제품 구매 시 무료 샘플이 제공됩니다.</div>
	    </div>
	</div>
	<div class="row row_down">   
		<div class="service-info__item col-md-4 bd-rg">
	        <h3 class="service-info_title text-center">리워드</h3>
	        <div class="service-info_content">모든 상품 구매 시 2%의 적립금을 드립니다. 적립금은 구매금액 제한 없이 공식 온라인 스토어와 직영 오프라인 스토어에서 현금처럼 사용하실 수 있습니다.</div>
	    </div>
	    
		<div class="service-info__item col-md-4 bd-rg">
	        <h3 class="service-info_title text-center">회원 혜택</h3>
	        <div class="service-info_content">신규 회원가입 단계에서 탬버린즈 카카오톡 플러스 친구 추가 시 발급되는 코드를 입력하시면 즉시 사용 가능한 3,000P가 제공됩니다. 1년 이내 구매 이력이 있는 고객님께는 생일 축하 5,000P가 제공됩니다.</div>
	    </div>
	    <div class="service-info__item col-md-4">
	        <h3 class="service-info_title text-center"></h3>
	        <div class="service-info_content"></div>
	    </div>
	</div>
</div>
	
	<hr>
	
<div class="more-prd">
    <h3 class="more-prd_title text-center">다양한 제품 더 알아보기</h3>
    <div class="more-prd_list">
		<div class="more-prd_item">
            <div class="more-prd__thumbnail"><img src="https://www.tamburins.com/img/promotion/210119/3Online_service/more01.jpg" alt="" style="width::340px; height:450px;"></a></div>
            <div class="more-prd_info">
                <h3 class="more-prd_subject">세트 추천</h3>
                <div class="more-prd_content">합리적인 제품들로 구성된 세트제품들을 만나보세요.</div>
            </div>
        </div>
        <div class="more-prd_item">
            <div class="more-prd__thumbnail"><img src="https://www.tamburins.com/img/promotion/210119/3Online_service/more02.jpg" alt="" style="width::340px; height:450px;"></a></div>
            <div class="more-prd_info">
                <h3 class="more-prd_subject">베스트 셀러</h3>
                <div class="more-prd_content">탬버린즈에서 가장 사랑받는 제품들을 만나 보세요.</div>
            </div>
        </div>
        <div class="more-prd_item">
            <div class="more-prd__thumbnail"><img src="https://www.tamburins.com/img/promotion/210119/3Online_service/more03.jpg" alt="" style="width::340px; height:450px;"></a></div>
            <div class="more-prd_info">
                <h3 class="more-prd_subject">더 쉘 퍼퓸 핸드</h3>
                <div class="more-prd_content">향수처럼 사용할 수 있는 크림 타입 퍼퓸을 경험해 보세요.</div>
            </div>
        </div>
        <div class="more-prd_item">
            <div class="more-prd__thumbnail"><img src="https://www.tamburins.com/img/promotion/210119/3Online_service/more04.jpg" alt="" style="width::340px; height:450px;"></a></div>
            <div class="more-prd_info">
                <h3 class="more-prd_subject">샘플 경험</h3>
                <div class="more-prd_content">샘플 경험을 통해 나에게 맞는 제품을 선택해 보세요.</div>
            </div>
        </div>
	</div>
</div>







<jsp:include page="../jh/footer.jsp" />