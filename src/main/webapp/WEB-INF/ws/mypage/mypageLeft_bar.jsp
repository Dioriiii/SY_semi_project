<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String ctxPath = request.getContextPath();
%>

<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/ws/mypage/mypageLeft_bar.css" />

<div id="mypage_left">
	<h3 id="mypage_link"><a href="<%= ctxPath%>/mypage/mypage.tam">마이페이지</a></h3>
	<p id="p_user_info"><span id="user_name">박동빈</span><span id="point"></span></p>
	<ul class="list_md">
		<li class="list_head">쇼핑 정보</li>
		<li><a href="<%= ctxPath%>/mypage/mypageOrderDeliver.tam">주문 / 배송</a></li>
	</ul>
	
	<ul class="list_md">
		<li class="list_head">계정 정보</li>
		<li><a href="">회원정보 수정</a></li>
	</ul>
	
	<ul>
		<li class="list_head">고객센터</li>
		<li><a href="<%= ctxPath%>/mypage/mypageNotice.tam">공지사항</a></li>
		<li><a href="<%= ctxPath%>/mypage/mypageConsumerService.tam">고객서비스</a></li>
		<li><a href="<%= ctxPath%>/mypage/mypageCustomerCare.tam">자주 묻는 질문</a></li>
	</ul>
</div>