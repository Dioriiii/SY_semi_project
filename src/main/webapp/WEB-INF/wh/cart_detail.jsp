<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 


<% 
	String ctxPath = request.getContextPath(); 
%>

<jsp:include page="../jy/header_revised.jsp" />



<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/wh/cart_detail.css" />
<%-- jQuery CC 및 JS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.css" />
<script type="text/javascript" src="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/js/wh/cart_detail.js"></script>




<script type="text/javascript">



</script>



<title>쇼핑백</title>




<body>
	<form name="bagFrm">
	<div id="container">
		
		<div id="left" class="float-left" >
			<div id="cart_bag">
				<div id="item_info">
					<div id="cart_title">쇼핑백&nbsp;<label></label></div>
					
					<input name="userid" class="userid" type="hidden" value="${requestScope.userid}"/>
					
					<div id="shop_bag">
						<%-- <c:set var = "total" value = "0" />--%>
						<c:if test="${not empty requestScope.shopBagList}">
						<c:set var = "total" value = "0" />
						<c:forEach items="${requestScope.shopBagList}" var="cartvo">
						<div id="cart_item">
							<div id="cart_product_mini_photo">
								<img src="<%=ctxPath%>/images/wh/${cartvo.imgvo.img_file}" class="img-fluid mb-1 img-sm" alt="Responsive image"> 
							</div>
	
							<input name="itemno" class="itemno" type="hidden" value="${cartvo.fk_it_seq_no}"/>
							<div id="cart_item_info">
								<div id="cart_product_name">
									<span style="font-weight:bold;">${cartvo.ivo.it_name}</span> 
									<span>${cartvo.categvo.ca_name}</span>
									<select name="quantity" class="quantity" onchange="updateInfoBag(this,'${requestScope.userid}')" >
									  <c:forEach begin="1" end="15" var="i">
									    <option value="${i}" ${cartvo.order_qty == i ? 'selected' : ''}>${i}</option>
									  </c:forEach>
									</select>
								</div>
	
								<div id="cart_product_price">
									<span class="item_price"><fmt:formatNumber value="${cartvo.ivo.it_price*cartvo.order_qty}" pattern="#,###" /> 원</span>
									<div>
										<span id="delete" class="delete" onclick="deleteInfoCart(this)" >삭제</span>
									</div>
								</div>
							</div>
						</div>
						<%-- <c:set var= "total" value="${total + cartvo.ivo.it_price*cartvo.order_qty"/>--%>
						<c:set var= "total" value="${total + cartvo.ivo.it_price*cartvo.order_qty}"/>
						</c:forEach> 
					</c:if>
					</div>
					
					<div id="cart_Noitem">
						<span>장바구니에 담긴 상품이 없습니다.</span>
					</div>
				</div>
			</div>
		</div>
		

		<div id="right" class="float-right">
			<div id="payment_detail" style="width:100%">
				<div id="payment_title">결제내역</div>
				
				<div id="payment">
					<div id="payment_price" >
						<div>
							<span>주문금액</span>
						</div>
						
						<div>
							<span id="price_sum"><fmt:formatNumber value="${total}" pattern="#,###" /> 원</span>
						</div>
					</div>
					
					<div id="delivery_charge">
						<div >
							<span>배송비</span>
						</div>
						
						<div>
							<span><span id="free_charge">3만원 이상 구매 시 무료배송</span>&nbsp;&nbsp;&nbsp;0 원</span>
						</div>
					</div>
					
					
					<div id="payment_all_price">
						<div>
							<span>총 금액</span>
						</div>
						
						<div>
							<span id="price_total"><fmt:formatNumber value="${total}" pattern="#,###" /> 원</span>
						</div>
					</div>
				</div>
				
				<button type="button" id="goPayment" onclick="goPayment('${requestScope.userid}')">
					주문 계속하기
				</button>
				
				<button id="goShopping" type="button" onclick="goMain()">
					쇼핑 계속하기
				</button>
				
				<span id="no_bag"> · 환경부 고시에 따라, 기본 쇼핑백이 제공되지 않습니다. </span>
				
			</div>
		</div>
		
	</div>
	</form>
	
<jsp:include page="../jh/footer.jsp" />
