<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
    String ctx_Path = request.getContextPath();
%>

    
<hr>
 	
 	
 	<div class="row justify-content-md-center" id="footer_content">
		    <div class="col col-lg-2">
		      	<span class="content_title">선물 추천</span>
				<span class="content_txt header_footer_font"><a href="<%= ctx_Path%>/onlineService.tam">온라인 서비스</a></span>
		    </div>
		    <div class="col col-lg-2">
		      	<span class="content_title header_font">고객센터</span>
				<span class="content_txt header_footer_font"><a href="<%= ctx_Path%>/mypage/mypageOrderDeliver.tam">공지사항</a></span>
				<span class="content_txt header_footer_font">주문 배송 조회</span>
				<span class="content_txt header_footer_font">적립금 현황</span>
				<span class="content_txt header_footer_font">고객서비스</span>
				<span class="content_txt header_footer_font">자주 묻는 질문</span>
		    </div>
		    <div class="col col-lg-2">
		    	<span class="content_title header_font">소셜</span>
				<span class="social_link content_txt header_footer_font"><a href="https://www.instagram.com/tamburinsofficial/">Instagram</a></span>
				<span class="social_link content_txt header_footer_font"><a href="https://pf.kakao.com/_RkqIj" style="color: #b39a7c;">Kakaotalk</a></span>
				<span class="social_link content_txt header_footer_font"><a href="https://weibo.com/tamburinsofficial">Weibo</a></span>
				<span class="social_link content_txt header_footer_font"><a href="https://www.facebook.com/tamburinsofficial/">Facebook</a></span>
		    </div>
 	</div>
		    
	<br>
 	
 	<hr>
 	
 	<div id="footer_bottom">
		<div class="footer_info header_footer_font">주)아이아이컴바인드 | 사업자등록번호: 119-86-38589 | 대표자: 김한국 | 서울특별시 마포구 어울마당로5길 41 | 대표번호: 1644-1246 | 이메일: cs@tamburins.com
			<br>
			개인정보 보호 책임자: 정태호 | 호스팅 서비스 사업자: Aws | 통신판매업신고: 제 2014-서울마포-1050 호  <a href="#">개인정보처리방침</a> | <a href="#">이용약관</a>
		</div>
		<div class="footer_info header_footer_font">고객님의 안전한 현금자산 거래를 위하여 하나은행과 채무지급보증계약을 체결하여 보장해드리고 있습니다.</div>
		<div class="header_footer_font copyright">&copy; 탬버린즈 &nbsp; 대한민국</div>
	</div>

 	<%-- footer 끝 --%>
 	

  </body>
  
</html>