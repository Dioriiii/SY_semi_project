<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/db/mypage/mypageConsumerService_del.css" />

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

<%-- 직접 만든 JS --%> <%-- 아직 없음 --%>
<%-- 
<script type="text/javascript" src="<%= ctxPath%>/js/db/mypage/mypageConsumerService_del.css"></script>
--%>
<link rel="icon" href="<%= ctxPath%>/images/jy/fav_tamburins.png">



</head>
<jsp:include page="../../jy/header_revised.jsp" />

<body>
	<div id="member">
		<jsp:include page="./mypageLeft_bar.jsp" />
		
		
		<div id="mypage_right">
			<div class="head_div">
				<div class="page_title">
					<h3>고객서비스</h3>
					<ul class="ul__cate">
						<li><a class="cate" href="mypageConsumerService.tam">결제</a></li>
						<li><a class="cate __ac" href="mypageConsumerService_del.tam">배송</a></li>
						<li><a class="cate" href="mypageConsumerService_return.tam">교환/반품</a></li>
					</ul>
				</div>
			</div>
			
			
			<table id="product_info">
				<tr class="bold_line">
					<th colspan="3" class="table_title">탬버린즈 결제 시스템 안내</th>
				</tr>
				<tr>
					<td>
						<ul>
							<li class="list__title">주문 조회</li>
							<ul>
								<li class="list__content_2">주문하신 제품의 진행 상황은 [마이페이지 > 주문조회] 에서 확인하실 수 있습니다.</li>
								<li class="list__content_2">비회원으로 주문하신 경우에는 [로그인 > 비회원 주문조회] 페이지에서 확인이 가능합니다.</li>
								<li class="list__content_2">결제가 완료되지 않은 주문 내역은 3일 후에 자동으로 취소됩니다.</li>
							</ul>
							
							
							<li class="list__title">배송</li>
							<li class="list__content">
								주문일로부터 영업일 기준 1-2일 내 출고 진행됩니다.
								<br> 
                            	배송은 지역 택배사 사정에 따라 약간의 지연이 생길 수 있습니다.
                            	<br>
                            	배송이 시작되면 구매자에게는 이메일, 수령인에게는 카카오 알림톡으로 배송 정보를 전송해
                            	<br>
                            	드립니다.
                            </li>
                            <li class="add__notice">
                            	CJ대한통운 (https://www.cjlogistics.com)
                            </li>
                            
                            <li class="list__title">무료 배송</li>
                            <li class="list__content">
                            	배송 비용은 2,500원이며, 3만원 이상 구매하실 경우 배송 비용은 무료입니다.
                            </li>

						</ul>
						
					</td>
				</tr>
								
			</table>
		</div>
	</div>		
	<br>
</body>

<jsp:include page="../../jh/footer.jsp" />

</html>