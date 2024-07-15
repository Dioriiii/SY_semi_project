<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
	String ctxPath = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지 주문/배송</title>


<%-- Required meta tags --%>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
 

<%-- Font Awesome 6 Icons --%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/db/mypage/mypageOrderDetail.css" />

<%-- bootstrap CSS --%>
<link rel="stylesheet" href="<%= ctxPath%>/bootstrap-4.6.2-dist/css/bootstrap.min.css" type="text/css">

<%-- font CSS--%>
<link rel="stylesheet" href="<%= ctxPath%>/css/font.css" type="text/css">

<%-- Optional JavaScript --%> 
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.2-dist/js/bootstrap.bundle.min.js" ></script> 


<%-- jQuery CC 및 JS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.css" />
<script type="text/javascript" src="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.js"></script>


<%-- 직접 만든 JS --%>
<script type="text/javascript" src="<%= ctxPath%>/js/db/mypage/mypageOrderDetail.js"></script>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link rel="icon" href="<%= ctxPath%>/images/jy/fav_tamburins.png">

</head>
<jsp:include page="../../jy/header_revised.jsp" />

<body>
	<div id="member">
		<jsp:include page="./mypageLeft_bar.jsp" />
		
		
		<div id="mypage_right">
			<div class="head_div">
				<div class="page_title">
					<h3>주문 상세</h3>
				</div>
			</div>
			
			<table id="product_info">
				<tr class="bold_line">
					<th colspan="2" class="table_title">상품 정보</th>
					<th class="table_title">진행 상황</th>
				</tr>
				
				<%-- DB 구매내역이 있는 경우 (반복) --%>
					<%-- 한번 --%>
				<tr class="bold_line">
					<td colspan="3"><div class="order_date">주문일자&nbsp;:&nbsp;<span id="order_date">${requestScope.uservo.ovo.order_date}</span>주문번호&nbsp;:&nbsp;<span id="order__no">${requestScope.uservo.ovo.order_seq_no}</span></div></td>
				</tr>
					<%-- 여러번 시작 --%>
				<c:forEach var="uvo" items="${requestScope.uvoList}">
					<tr class="product_detail opac_line">
						<td>
							<img class="product_image" src="<%= ctxPath%>/images/db/mypage/${uvo.imvo.img_file}" />
						</td>
						<td>
							<ul class="ul_info">
								<li class="pro__name">${uvo.itvo.it_name}</li>
								<li><span class="it_volume">${uvo.itvo.it_volume}</span>&nbsp;/&nbsp;<span class="pur__quantity">${uvo.dvo.o_qty}</span>개</li>
								<li><span class="to__price"><fmt:formatNumber value="${uvo.dvo.o_price}" pattern="#,###" /></span>&nbsp;원</li>
							</ul>	
						</td>
						<td>
							<div class="order__status">
								<c:if test="${uvo.dvo.o_status eq 0}">배송준비중</c:if>
								<c:if test="${uvo.dvo.o_status eq 1}">배송중</c:if>
								<c:if test="${uvo.dvo.o_status eq 2}">배송완료</c:if>
							</div>
						</td>
					</tr>
				</c:forEach>
				<%-- 반복문 끝 --%>
				<%-- DB 구매내역이 있는 경우 (반복) --%>
			</table>
			
			<table id="payment__info" class="opac_line__bt">
				<tr class="payment__info__hd opac_line__bt" >
					<th>배송지 정보</th>
					<th>결제 정보</th>
					<th></th>
				</tr>
				<tr>
					<td class="user__info">
						<form name="update__del_info">
							<ul id="user__address__info">
								<li id="user__name__li"><span id="name">${requestScope.uservo.ovo.sh_name}</span></li>
								<li id="user__address1"><span id="postcode">${requestScope.uservo.ovo.sh_postcode}</span>&nbsp;<span id="adrress">${requestScope.uservo.ovo.sh_address}</span></li>
								<li id="user__address2"><span id="detail_address">${requestScope.uservo.ovo.sh_detailaddress}</span></li>
								<li id="user__mobile__li"><span id="user_mobile">${requestScope.uservo.ovo.sh_mobile}</span></li>
							</ul>
							<input type="hidden" id="extraAddress" name="sh_extraaddress" value="${requestScope.uservo.ovo.sh_extraaddress}"/>
						</form>
					</td>
					
					
					<td class="payment__info">
						<ul>
							<li class="opac_line__bt">
								<div class="__flex"><div>결제수단</div><div id="payment__method" class="__flex_right">신용카드</div></div>
							</li>
							<li class="opac_line__bt">
								<div class="__flex"><div>주문금액</div><div id="order__amount" class="__flex_right"><fmt:formatNumber value="${requestScope.uservo.total_o_price}" pattern="#,###" />원</div></div>
							</li>
							<li class="opac_line__bt">
								<div class="__flex"><div>배송비</div><div id="deli__fee" class="__flex_right">0원</div></div>
							</li>
							<li class="font__bold">
								<div class="__flex"><div>총 결제 금액</div><div id="tot_order__amount" class="__flex_right"><fmt:formatNumber value="${requestScope.uservo.total_o_price}" pattern="#,###" />원</div></div>
							</li>
						</ul>
					</td>
					<td class="ver__top">
						<div>
							<div id="up__reset" class="__flex">
								<div><button class="white__" id="up_date__address" type="button">수정하기</button></div>
								<div class="__flex_right"><button class="up__can" id="reset__" type="button" disabled>취소하기</button></div>
							</div>
							
							<div id="select__div">
							</div>
							
							<div id="go_order__list"><button class="white__" type="button" onclick="location.href='mypageOrderDeliver.tam'">주문목록 돌아기기</button></div>
						</div>
					</td>
				</tr>
			</table>
			
			<div class="__notification">
				<ul>
					<li class="list__title">온라인 취소/교환/반품 안내</li>
					<li class="list__head">취소</li>
					<li class="list__cont">
						ㆍ상품 준비 단계에서는 배송을 위한 출고 작업이 시작되므로, 주문 최소 및 주문 정보(상품,
						<br>
						수량, 배송지) 변경이 불가합니다.</li>
					<li class="list__head">교환 및 반품</li>
					<li class="list__cont">
						ㆍ반품(환불)은 수령일 이후 7일 이내 마이페이지를 통해서 접수가 가능합니다.
					</li>
					<li class="list__cont">
						ㆍ단순변심 또는 주문 실수로 인한 교환은 불가합니다. 원하시는 상품으로 재 구매를
						<br>
						해주세요.
					</li>
					<li class="List_add__cont">
						도움이 필요하신가요? 더 궁금하신 사항이 있다면 탬버린즈 고객센터[1644-1246] 또는
						<br>
						cs@tamburins.com 로 문의하여 주십시오.
					</li>
				</ul>
			</div>
		</div>
			
	</div>
</body>

<jsp:include page="../../jh/footer.jsp" />

</html>