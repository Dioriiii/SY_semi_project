<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

    
<%
	String ctxPath = request.getContextPath();
%>




<title>마이페이지</title>


<%-- Required meta tags --%>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
 

<%-- Font Awesome 6 Icons --%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/db/mypage/mypageMain.css" />

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
<script type="text/javascript" src="<%= ctxPath%>/js/db/mypage/mypageMain.js"></script>
<link rel="icon" href="<%= ctxPath%>/images/jy/fav_tamburins.png">




</head>
<jsp:include page="../../jy/header_revised.jsp" />

<body>
	<div id="member">
		<jsp:include page="./mypageLeft_bar.jsp" />
		
		<div id="mypage_right">
			<table id="shopping_info">
				<tr>
					<th colspan="3" class="table_title">쇼핑 정보</th>
				</tr>
				<tr>
					<th class="table_field_1">상품 정보</th>
					<th class="table_field_2">진행 상황</th>
					<th class="table_field_3"></th>
				</tr>
				<%-- DB 여러개의 값이 들어가야 됨 (반복문) 아래는 예시 -- 쇼핑 정보 상세 ppt-72 --%>
				<c:if test="${not empty requestScope.uvoList}">
					<c:forEach var="uvo" items="${requestScope.uvoList}">
						<tr>
							<td class="product">
								<div class="div_img"><img class="product_image" src="<%= ctxPath%>/images/db/mypage/${uvo.imvo.img_file}" /></div>
								<div class="div_info">
									<span>${uvo.itvo.it_name}</span><br>
									<span>${uvo.dvo.o_qty}개<c:if test="${uvo.total_o_qty ne 0}">&nbsp;<span>외 ${uvo.total_o_qty}건</span></c:if></span><br>
									<span><fmt:formatNumber value="${uvo.total_o_price}" pattern="#,###" />원</span>
								</div> 
							</td>
							<td class="none__progress">
								<c:if test="${uvo.dvo.o_status eq 0}">배송준비중</c:if>
								<c:if test="${uvo.dvo.o_status eq 1}">배송중</c:if>
								<c:if test="${uvo.dvo.o_status eq 2}">배송완료</c:if>
							</td>
							<td class="detail_view">
								<button type="button" class="detail_view_btn" onclick="location.href='mypageOrderDetail.tam?order_seq_no=${uvo.ovo.order_seq_no}'">상세보기</button>
							</td>
						</tr>					
					</c:forEach>
				</c:if>

			<%-- DB 여러개의 값이 들어가야 됨 (반복문) --%>
			</table>
			<div class="div_btn">
				<button id="shopping_view_info_btn" type="button" onclick="location.href='mypageOrderDeliver.tam'">더보기</button>
			</div>
		</div>
	</div>	
	<br>
</body>

<jsp:include page="../../jh/footer.jsp" />

</html>