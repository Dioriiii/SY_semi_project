<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 

<%
    String ctxPath = request.getContextPath();
    //     /tempSemi
%>

<%-- Font Awesome 6 Icons --%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

<%-- 직접 만든 CSS --%>
<link rel="stylesheet" href="<%= ctxPath%>/css/jy/main/main.css" type="text/css">


<title>TAMBURINS 비공식 온라인 스토어</title>

<jsp:include page="header_main.jsp" />

<div id="main_container">
	<div id="imgs_container">
		<div id="gradation"></div>
		<div id="left_img">
			
		</div>
		
		<div id="right_img">
			
		</div>
		<div id="txt_container">
			<div id="main_txt"><img src="https://web-resource.tamburins.com/assets/video/main/toilet_fragrance/toiletfragrance_logo2.svg" alt="TOILET FRAGRANCE"></div>
		    <div id="goIndex_div"><a id="goIndex_btn" href="<%=ctxPath%>/category.tam?ca_id=tf">신제품 보기</a></div>
		</div>
	</div>
	<jsp:include page="footer_main.jsp" />	
</div>