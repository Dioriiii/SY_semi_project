<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 

<%
    String ctxPath = request.getContextPath();
	//    /tempSemi
%>


<%-- Font Awesome 6 Icons --%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/wh/product_detail.css" />


<jsp:include page="../jy/header_revised.jsp" />
<script type="text/javascript" src="<%= ctxPath%>/js/wh/product_detail.js"></script>
<script type="text/javascript">







</script>
<title>제품 상세페이지</title>

	<div id="container">
		<div id="left" class="float-left">
			<div id="Product_photo">
				<c:forEach var="itemvo" items="${requestScope.infoList}">
						<img src="<%=ctxPath%>/images/wh/${itemvo.imgvo.img_file}"
							class="img-fluid mb-1 img-sm" alt="Responsive image"> 
						<input type="hidden" id="imagefile" value="${itemvo.imgvo.img_file}"/>
				</c:forEach> 
			</div>
		</div>
		
		

		<div id="right" class="float-right">
			<div id="product_detail">
				<div id="category">
					<c:forEach begin="1" end="1" var="itemvo" items="${requestScope.infoList}">
						 <span class="item_category">${itemvo.categvo.ca_name}</span>
					</c:forEach> 	
				</div>


				<div id="product_info">
					<div id="product_name">
						<c:forEach begin="1" end="1" var="itemvo" items="${requestScope.infoList}">
					   	 <span id="item_name">${itemvo.it_name}</span>
						</c:forEach>
					</div>
					
					
					<%--  Like 기능
					<div id="product_like">
						<i class="fa-regular fa-star before_like fa-xl" id="unliked" style="color: #333333; margin-bottom: 1%;"></i>
						<span id="like__cnt" style="display:block; text-align:center; font-size: 13px;">52</span>
						<i class="fa-solid fa-star after_like fa-xl" id="liked" style="color: #333333; display:none;"></i>
					</div> 
					--%>
				</div>
				<div id="product_price">
						<c:forEach begin="1" end="1" var="itemvo" items="${requestScope.infoList}">
							<fmt:formatNumber value="${itemvo.it_price}" pattern="#,###" /> 원
						</c:forEach>
				</div>
				<div id="hide_product_price">
						<c:forEach begin="1" end="1" var="itemvo" items="${requestScope.infoList}">
							${itemvo.it_price}
						</c:forEach>
				</div>

				<div id="smell" class="mt-4 mb-4">
					<c:forEach begin="1" end="1" var="itemvo" items="${requestScope.infoList}">
						 <span>${itemvo.it_theme}</span>
					</c:forEach>
				</div>

				<div id=discription_simple>
					<c:forEach begin="1" end="1" var="itemvo" items="${requestScope.infoList}">
						 <div>${itemvo.it_describe_simple}</div>
					</c:forEach>
					<span id="fullview">샤워리바디 더보기</span>
				</div>

				<div id=discription_full>
					<c:forEach begin="1" end="1" var="itemvo" items="${requestScope.infoList}">
						 <div>${itemvo.it_describe}</div>
					</c:forEach>
				</div>

				<div id="it_seq_no">
						${requestScope.it_seq_no}
				</div>
				<input name="page__it_seq_no" type="hidden" value="${requestScope.it_seq_no}"/>


				<button id="putCart" type="button" onclick="insertInfoCart('${requestScope.it_seq_no}')">장바구니에 담기</button>


				<div id="detail_info">
					<div id="first_info">
						<button type="button" class="btn mt-2 mb-2" data-toggle="collapse"
							data-target="#demo1">온라인 익스클루시브 혜택</button>
						<div id="demo1" class="collapse">
							<div>탬버린즈는 고객님들께 빠른 배송 및 반품과 최고의 경험을 제공하기 위해 언제나 세심한 주의를
								기울입니다. 고객님을 위한 익스클루시브 서비스를 경험해보세요.</div>
						</div>
					</div>

					<div id="second_info">
						<button type="button" class="btn mt-2 mb-2" data-toggle="collapse"
							data-target="#demo2">제품 세부 정보</button>
						<div id="demo2" class="collapse">
							<c:forEach begin="1" end="1" var="itemvo" items="${requestScope.infoList}">
								 <div id="ingredient"><span>전성분</span><br>${itemvo.it_ingredient}</div>
							</c:forEach>

							<c:forEach begin="1" end="1" var="itemvo" items="${requestScope.infoList}">
								 <div id="how_to_use" class="mt-3"><span>사용방법</span><br>${itemvo.categvo.ca_how_to_use}</div>
							</c:forEach>
							
							<c:forEach begin="1" end="1" var="itemvo" items="${requestScope.infoList}">
								 <div id="cautions" class="mt-3"><span>사용할 때의 주의사항</span><br>${itemvo.categvo.ca_caution}</div>
							</c:forEach>

							<c:forEach begin="1" end="1" var="itemvo" items="${requestScope.infoList}">
								 <div id="expiration_date" class="mt-3"><span>사용기한</span><br>${itemvo.categvo.ca_expired}</div>
							</c:forEach>

						</div>
					</div>

					<div id="third_info">
						<button type="button" class="btn mt-2 mb-2" data-toggle="collapse"
							data-target="#demo3">배송 & 반품 </button>
						<div id="demo3" class="collapse">
							<div>
								3만원 이상 구매하실 경우 배송 비용은 무료입니다.<br> <span class="mt-3">주문일로부터
									1-2 영업일 이내 출고됩니다.</span>
							</div>

							<div class="mt-3">배송은 지역 택배사 사정에 따라 약간의 지연이 생길 수 있습니다. 배송이
								시작되면 구매자에게는 이메일, 수령인에게는 카카오 알림톡으로 배송 정보를 전송해 드립니다.
								CJ대한통운(https://www.cjlogistics.com)</div>

							<div class="mt-3">
								*상품 혹은 증정품의 포장(랩핑)을 개봉 및 훼손한 경우 반품이 불가합니다.<br> *단순 변심 또는 주문
								실수로 인한 교환이 불가합니다. 신중한 구매 부탁드립니다.
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%-- === 구매할 상품의 수량 및 가격을 쇼핑백으로 보내기 위한 폼을 생성 === --%>
	<form name="cartFrm">
		<div id="cart">
			<div id="cart_top">
				<div id="cart_title">장바구니</div>
					
				
				 	
						<div id="item">
							
							
						</div>
				
				<%-- 제품명을 폼태그를 이용하여 쇼핑백 페이지로 넘기기 위해 만든 input 히든타입 --%>
			
			</div>
			
			<div id="bottom">
				<div id="cart_bottom">
					<div id="cart_price_info">
						
					</div>
					<input type="hidden" name="userid" value="${sessionScope.loginuser.userid}" />
					<button type="button" id="order" onclick="goOrder('${sessionScope.loginuser.userid}')">주문 하기</button>
				</div>
	
	
			</div>
	
		</div>
</form>



<jsp:include page="../jh/footer.jsp" />





