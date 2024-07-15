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
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/db/mypage/mypageConsumerService.css" />

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
<script type="text/javascript" src="<%= ctxPath%>/js/db/mypage/mypageConsumerService.js"></script>
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
						<li><a class="cate __ac" href="mypageConsumerService.tam">결제</a></li>
						<li><a class="cate" href="mypageConsumerService_del.tam">배송</a></li>
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
							<li class="list__title">결제 방법</li>
							<li class="list__content">탬버린즈에서 이용하실 수 있는 결제 방법은 아래와 같습니다.</li>
							<li class="list__content">신용카드 | 무통장 | 입금 | 실시간 | 계좌이체 | 네이버페이 | 카카오페이</li>
							
							<li class="list__title">세금계산서 및 신용카드 매출전표 발행</li>
							<li class="list__content">
								세금계산서 교부의무의 면제 등 부가가치세법 규정에 의거하여 신용카드로 결제하신 고객님께서는
								<br> 
                            	신용카드 매출 전표만 출력이 가능합니다. 사업자가 재화 또는 용역을 공급하고
                            	<br>
                            	부가가치세법시행령 제32조의 제1항의 규정에 의한 신용카드매출전표 등을 교부한 경우,
                            	<br>
                            	부가가치세법시행령 제57조 제2항의 규정에 의하여 세금계산서를 교부하지 아니한다.
                            </li>
                            <li class="list__title">현금영수증 발행</li>
                            <li class="list__content">
                            	현금성 결제수단으로 주문하신 내역에 한하여 현금영수증이 국세청으로 자동 신고 됩니다. 발급 
                            	<br>
                            	여부에 대한 확인이 필요하신 경우, 납부 7일 후 국세청 홈페이지 또는 국세청 상담 센터를통해 
                            	<br>
                            	확인하실 수 있습니다.
                            </li>
                            <li class="add__notice">
                            	※ 국세청 현금영수증 홈페이지 (www.taxsave.go.kr), 국세청 현금영수증 상담센터 (1544-2020)
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