<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String ctxPath = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지 자주 묻는 질문</title>


<%-- Required meta tags --%>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
 

<%-- Font Awesome 6 Icons --%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/db/mypage/mypageCustomerCare.css" />

 
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
<script type="text/javascript" src="<%= ctxPath%>/js/db/mypage/mypageCustomerCare.js"></script>

<link rel="icon" href="<%= ctxPath%>/images/jy/fav_tamburins.png">



</head>
<jsp:include page="../../jy/header_revised.jsp" />

<body>
	<div id="member">
		<jsp:include page="./mypageLeft_bar.jsp" />



		<div id="mypage_right">
			<div class="head_div">
				<div class="page_title">
					<h3>자주 묻는 질문</h3>
				</div>
			</div>
			
			<table id="product_info">
				<tr class="bold_line">
					<th colspan="3" class="table_title">
						<ul>
							<%-- 카테고리 반복 --%>
							<c:forEach var="category" items="${requestScope.categoryList}">
								<li><a class="FAQ__click_categoy" href="<%= ctxPath%>/mypage/mypageCustomerCare.tam?q_ca=${category.qna_cate_no}">${category.qna_cate_name}</a></li>
							</c:forEach>
						</ul>
					</th>
				</tr>
			</table>
			
			<%-- DB에서 자주 묻는 질문 가져오기(질문과 답변) --%>
			
			<ul class="FAQ__list">
				<c:forEach var="cuvo" items="${requestScope.cuvoList}">
					<li class="FAQ__one">
						<div class="FAQ__question"><div class="__question">${cuvo.q_title}</div><div class="__question_angle_down"><svg xmlns="http://www.w3.org/2000/svg" height="1em" viewBox="0 0 448 512"><!--! Font Awesome Free 6.4.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2023 Fonticons, Inc. --><style>svg{fill:#000000}</style><path d="M201.4 342.6c12.5 12.5 32.8 12.5 45.3 0l160-160c12.5-12.5 12.5-32.8 0-45.3s-32.8-12.5-45.3 0L224 274.7 86.6 137.4c-12.5-12.5-32.8-12.5-45.3 0s-12.5 32.8 0 45.3l160 160z"/></svg></div></div>
						<div class="FAQ__answer">${cuvo.q_content}</div>
					</li>
				</c:forEach>
			</ul>
			
			<%-- DB에서 자주 묻는 질문 가져오기(질문과 답변) --%>
			<c:if test="${not empty requestScope.pageBar}">
				<div class="paging__div">
					<ul class="paging__ul">
						${requestScope.pageBar}
					</ul>
				</div>
			</c:if>
		</div>
	</div>
	
</body>

<jsp:include page="../../jh/footer.jsp" />

</html>