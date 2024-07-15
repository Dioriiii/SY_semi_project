<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 	 <%-- JSTL을 사용할때 필요 --%>   

<%
	String ctxPath = request.getContextPath();
	// ctxPath ==> /tempsemi
%> 

<%-- Required meta tags --%>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
 

<%-- Font Awesome 6 Icons --%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/ws/mypage/mypageOrderDeliver.css" />
<link rel="stylesheet" href="<%= ctxPath%>/css/font.css" type="text/css">

<%-- Optional JavaScript --%> 
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.2-dist/js/bootstrap.bundle.min.js" ></script> 


<%-- jQuery CC 및 JS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.css" />
<script type="text/javascript" src="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.js"></script>

<%-- 직접 만든 JS --%>
<script type="text/javascript" src="<%= ctxPath%>/js/ws/mypage/mypageOrderDeliver.js"></script>

<title> 공지사항 </title>

<body>

<jsp:include page="../../jy/header_revised.jsp" />

	<div id="member">
		<jsp:include page="../../db/mypage/mypageLeft_bar.jsp" />
		
		
		<%-- 공지사항 목록 시작 --%>
		<div id="mypage_right">
			<div class="head_div">
				<div class="page_title">
					<h3 style="font-size:14pt;">공지사항</h3>
				</div>
			</div>
			
	<%-- 여기부터 hide and show--%>
	<div id="board_content_container">		
				<table id="board_table">
					<tr class="bold_line">
						<th class="table_title">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;번호</th>
						<th class="table_title">내용</th>
						<th class="table_title">등록일&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
					</tr>
				</table>
			<div class="board_list">
			
			
			
			<%-- 반복 시작 --%>
			
				
					<c:if test="${not empty requestScope.noticeList}">
						<c:forEach var="nvo" items="${requestScope.noticeList}">
							<div class="board boardNo${nvo.seq_no}" >
								<span class="board_number">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${nvo.seq_no}</span>
								<span class="board_title">${nvo.title}</span>
								<span class="board_registerDay">${nvo.register_date}</span>
								<input name="board_seq_no" type="hidden" value="${nvo.seq_no}"/>
							</div>
						</c:forEach>
					</c:if>
					
					<c:if test="${empty requestScope.noticeList}">
						<span style="color:red;">데이터가 존재하지 않습니다.</span>  
					</c:if>
					
				
				
			<%-- 반복 끝 --%>	
				
			</div>
	</div>
	<%-- 여기까지만 hide and show--%>
		
	<%-- 공지사항 내용 시작 --%>	
		<table id="hidden_bar" style="display:none; width:100%;" onclick="goList();">
			<tr class="bold_line">
				<th id="hidden_title" style="background-color:white; font-size:10pt; font-weight:600;"></th>
				<th id="hidden_resisterday" style="background-color:white; font-size:10pt; font-weight:600;"></th>
			</tr>
		</table>
		
		<c:if test="${not empty requestScope.noticeList}">
			<c:forEach var="nvo" items="${requestScope.noticeList }">
				<div class="board_content boardNo${nvo.seq_no}" style="display:none;">
						<div class="notice_content">
							${nvo.content}
						</div>	
							<div>
								<button type="button" class="goList" onclick="goList();">목록으로
									돌아가기</button>
							</div>
							<br><br><br>
							<br><br><br>
							<input name="content_seq_no" type="hidden" value="${nvo.seq_no}"/>
				</div>
			</c:forEach>
		</c:if>
		
		<c:if test="${empty requestScope.noticeList}">
			<span style="color:red;">데이터가 존재하지 않습니다.</span>  
		</c:if>
		
		</div>
		
		<%-- 공지사항 내용 끝 --%>
		
		<%-- 공지사항 목록 끝 --%>
	</div>		
	<br>
</body>

<%-- <jsp:forward page="이동할페이지"/> --%>

<jsp:include page="../../jh/footer.jsp" />

	
	
	
	
	
	
	
	
	