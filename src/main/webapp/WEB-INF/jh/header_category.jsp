<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 

<%
    String ctxPath = request.getContextPath();
	//    /tempSemi
%>
<!DOCTYPE html>
<%-- 헤더 시작 --%>
<html lang="ko">
<head>
<%-- Required meta tags --%>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<%-- Bootstrap CSS --%>
<link rel="stylesheet" href="<%= ctxPath %>/bootstrap-4.6.2-dist/css/bootstrap.min.css" type="text/css">

<%-- Font Awesome 5 Icons --%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<link rel="stylesheet"  href="<%= ctxPath%>/css/font.css" type="text/css">

<%-- header,footer 전용 CSS --%>
<link rel="stylesheet" href="<%= ctxPath %>/css/jy/header_category_store.css" type="text/css">

<%-- Optional JavaScript --%>
<script src="<%= ctxPath %>/js/jquery-3.7.1.min.js" type="text/javascript"></script>
<script src="<%= ctxPath %>/bootstrap-4.6.2-dist/js/bootstrap.bundle.min.js" type="text/javascript"></script>

<%-- header,footer 전용 js --%>
<script src="<%= ctxPath %>/js/jh/header/header.js" type="text/javascript"></script>

<%-- 직접 만든 JS --%>
<script type="text/javascript" src="<%= ctxPath%>/js/jh/index/index.js"></script>
 	
 <link rel="icon" href="<%= ctxPath%>/images/jy/fav_tamburins.png">
 	
</head>
  
  <body id="container" style="overflow-x: hidden">
	  
	
	<%-- 네비게이션바 시작 --%>  
	  
	<nav class="navbar navbar-expand-lg bg-white navbar-white sticky-top ">
		<a class="logo-svg" href="<%=ctxPath%>/main.tam" style="font-size:0px;">
		  <svg class="logo-svg" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="150" height="18.562" viewBox="0 0 150 18.562">
	        <defs>
	            <clipPath id="clip-path">
	                <rect id="사각형_3452" data-name="사각형 3452" width="150" height="18.561" fill="none"></rect>
	            </clipPath>
	        </defs>
	        <g id="TAMBURINS_LOGO_BK" data-name="TAMBURINS LOGO BK" clip-path="url(#clip-path)">
	            <path id="패스_1137" data-name="패스 1137" d="M16.344.387H0V4.305H.1a8.717,8.717,0,0,1,4.64-1.444H6.368V14a17.906,17.906,0,0,1-.155,2.217,10.7,10.7,0,0,1-.9,1.8v.155h5.723V18.02a10.7,10.7,0,0,1-.9-1.8A17.906,17.906,0,0,1,9.977,14V2.862H11.6a8.718,8.718,0,0,1,4.64,1.444h.1ZM14.858,18.02v.155H19.55v-.232a9.077,9.077,0,0,1-.516-1.341,9.513,9.513,0,0,1,.645-2.475l.206-.567H26.9l.206.619a9.571,9.571,0,0,1,.619,2.423,5.953,5.953,0,0,1-.541,1.418v.155h5.826V18.02L32.259,16.6a26.462,26.462,0,0,1-1.134-2.475L25.659.387h-3.48L16.791,14.127A25.774,25.774,0,0,1,15.683,16.6c-.232.438-.567,1.005-.825,1.418m5.775-6.471.8-2.14,2.037-5.182h.026l2.062,5.259.67,2.062ZM49.944.387,45.123,13.663h-.129L40.122.387H33.96V.541a10.684,10.684,0,0,1,.9,1.8,17.942,17.942,0,0,1,.155,2.217V14a17.942,17.942,0,0,1-.155,2.217,10.684,10.684,0,0,1-.9,1.8v.155h4.692V18.02a10.684,10.684,0,0,1-.9-1.8A17.94,17.94,0,0,1,37.6,14V4.228h.155l5.156,13.947H46.18l5-13.792h.129V14a17.906,17.906,0,0,1-.155,2.217,10.7,10.7,0,0,1-.9,1.8v.155h5.671V18.02a10.711,10.711,0,0,1-.9-1.8A17.942,17.942,0,0,1,54.868,14V4.563a17.942,17.942,0,0,1,.155-2.217,10.711,10.711,0,0,1,.9-1.8V.387Zm23.22,12.555c0-2.99-1.83-4.331-4.46-4.8V8.095c2.114-.851,3.248-2.037,3.248-3.79,0-2.449-2.114-3.738-6.29-3.893-.7-.026-1.573-.026-2.037-.026H58.263V.541a10.7,10.7,0,0,1,.9,1.8,17.906,17.906,0,0,1,.155,2.217V14a17.906,17.906,0,0,1-.155,2.217,10.7,10.7,0,0,1-.9,1.8v.155h8.3c3.893,0,6.6-1.5,6.6-5.233m-10.235,2.99V9.977h3.222c2.011,0,3.222.877,3.222,2.99,0,2.346-1.444,3.119-3.4,3.119Zm0-7.914V2.423h2.191c2.037,0,3.068.645,3.068,2.6a3.694,3.694,0,0,1-1.263,2.99Zm16.031,2.63V4.563a17.94,17.94,0,0,1,.155-2.217,10.685,10.685,0,0,1,.9-1.8V.387H74.294V.541a10.711,10.711,0,0,1,.9,1.8,17.943,17.943,0,0,1,.155,2.217V10.57c0,5.182,2.836,7.992,7.657,7.992,4.872,0,7.579-2.913,7.579-8.017V4.615a18.1,18.1,0,0,1,.155-2.269,10.685,10.685,0,0,1,.9-1.8V.387H86.668V.541a10.7,10.7,0,0,1,.9,1.8,18.07,18.07,0,0,1,.155,2.269v6.032c0,3.274-1.366,5.233-4.305,5.233-3.068,0-4.46-2.217-4.46-5.233m26.407,7.528h4.073v-.232l-5.568-8.121.18-.077c1.83-.748,4.357-2.713,3.867-5.053S105.5.387,102.093.387h-8.61V.541a10.7,10.7,0,0,1,.9,1.8,17.908,17.908,0,0,1,.155,2.217V14a17.908,17.908,0,0,1-.155,2.217,10.7,10.7,0,0,1-.9,1.8v.155h5.723V18.02a10.7,10.7,0,0,1-.9-1.8A17.9,17.9,0,0,1,98.149,14V10.7H99.7a5.837,5.837,0,0,0,.7-.026Zm-7.218-9.59V2.449h2.63c2.114,0,3.377.722,3.377,3.016a4.118,4.118,0,0,1-1.392,3.222c-.335.026-.876.026-1.212.026-.284,0-1.8-.052-3.4-.129M115.422,14V4.563a17.943,17.943,0,0,1,.155-2.217,10.7,10.7,0,0,1,.9-1.8V.387h-5.723V.541a10.685,10.685,0,0,1,.9,1.8,17.943,17.943,0,0,1,.155,2.217V14a17.943,17.943,0,0,1-.155,2.217,10.684,10.684,0,0,1-.9,1.8v.155h5.723V18.02a10.7,10.7,0,0,1-.9-1.8A17.943,17.943,0,0,1,115.422,14M131.284.387V.541a10.7,10.7,0,0,1,.9,1.8,17.94,17.94,0,0,1,.155,2.217v8.946h-.052L124.607.387h-5.775V.541a10.684,10.684,0,0,1,.9,1.8,17.94,17.94,0,0,1,.155,2.217V14a17.94,17.94,0,0,1-.155,2.217,10.684,10.684,0,0,1-.9,1.8v.155h4.744V18.02a10.7,10.7,0,0,1-.9-1.8A17.906,17.906,0,0,1,122.519,14V3.944h.052l8.456,14.23h3.944V4.563a17.9,17.9,0,0,1,.155-2.217,10.7,10.7,0,0,1,.9-1.8V.387Zm12.451,18.175c4.486,0,6.264-2.707,6.264-5.491,0-3.016-1.908-4.46-4.64-5.336l-.8-.258c-1.727-.567-3.274-1.083-3.274-2.758,0-1.753,1.676-2.4,3.042-2.4A6.1,6.1,0,0,1,149.1,4.666l.206-.077v-3.2A8.308,8.308,0,0,0,144.483,0c-3.506,0-6.651,1.882-6.651,5.362,0,2.269,1.34,4.047,4.408,5.13l.876.309c2.191.773,3.48,1.263,3.48,2.913,0,1.573-1.16,2.475-2.861,2.475a7.666,7.666,0,0,1-5.749-3.016l-.206.077v3.48c.954.954,2.939,1.83,5.955,1.83" fill="#040000"></path>
	        </g>
   	 	 </svg>
   	    </a>
	  
	<%-- 사이드바 시작 --%>
		<div id="side_bar_container">
		<span>
			<a class="nav-link header_footer_font" href="#">
				<svg xmlns="http://www.w3.org/2000/svg" height="1.5em" viewBox="0 0 448 512"><!--! Font Awesome Free 6.4.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2023 Fonticons, Inc. --><style>svg{fill:#000000}</style><path d="M160 112c0-35.3 28.7-64 64-64s64 28.7 64 64v48H160V112zm-48 48H48c-26.5 0-48 21.5-48 48V416c0 53 43 96 96 96H352c53 0 96-43 96-96V208c0-26.5-21.5-48-48-48H336V112C336 50.1 285.9 0 224 0S112 50.1 112 112v48zm24 48a24 24 0 1 1 0 48 24 24 0 1 1 0-48zm152 24a24 24 0 1 1 48 0 24 24 0 1 1 -48 0z"/></svg>
				<label>0</label>
			</a>
		</span>
		<div class="side_bar">	
			<div id="mySidepanel" class="sidepanel">
			  <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
			  <a href="<%=ctxPath%>/index.tam">전체보기</a>
			  <a href="<%=ctxPath%>/store/findStore.tam">매장 보기</a>
			  
			  <c:if test="${sessionScope.loginuser != null and sessionScope.loginuser.userid == 'admin@naver.com'}">
			      <a href="<%=ctxPath%>/adminOrder.tam">마이페이지</a>
			  </c:if>
			  <c:if test="${sessionScope.loginuser != null and sessionScope.loginuser.userid != 'admin@naver.com'}">
			      <a href="<%=ctxPath%>/mypage/mypage.tam">마이페이지</a>
			  </c:if>
			  <c:if test="${sessionScope.loginuser == null}">
			      <a href="<%=ctxPath%>/mypage/mypage.tam">마이페이지</a>
			  </c:if>
			  
			  <c:if test="${empty sessionScope.loginuser}">
			  	<a href="<%=ctxPath%>/login/login.tam">로그인</a>
			  </c:if>
			  <c:if test="${not empty sessionScope.loginuser}">
			  	<a href="<%=ctxPath%>/login/logout.tam">로그아웃</a>
			  </c:if>
			  <a href="#">장바구니</a>
			</div>

			<button class="openbtn" onclick="openNav()">&#9868;</button>
		</div>
	</div>		
	<%-- 사이드바 끝 --%>

			
		<div id="mySidepane0" class="sidepanel collapse navbar-collapse" style="white-space:nowrap;">
			  <ul class="navbar-nav">
			    <li class="nav-item active">
			      <a class="nav-link header_footer_font" href="<%=ctxPath%>/index.tam">제품 보기</a>
			    </li>
			    <li class="nav-item active">
			      <a class="nav-link header_footer_font" href="<%=ctxPath%>/store/findStore.tam">매장 보기</a>
			    </li>
			  </ul>
		</div>	  
			<div id="align-right" class="sidepanel">
			  <ul class="navbar-nav">
				 <li class="nav-item active">
					  <c:if test="${sessionScope.loginuser != null and sessionScope.loginuser.userid == 'admin@naver.com'}">
					      <a class="nav-link header_footer_font" href="<%=ctxPath%>/adminOrder.tam">마이페이지</a>
					  </c:if>
					  <c:if test="${sessionScope.loginuser != null and sessionScope.loginuser.userid != 'admin@naver.com'}">
					      <a class="nav-link header_footer_font" href="<%=ctxPath%>/mypage/mypage.tam">마이페이지</a>
					  </c:if>
					  <c:if test="${sessionScope.loginuser == null}">
					      <a class="nav-link header_footer_font" href="<%=ctxPath%>/mypage/mypage.tam">마이페이지</a>
					  </c:if>
			     </li>
			     
			     <li class="nav-item active">
				     <c:if test="${empty sessionScope.loginuser}">
				  		<a class="nav-link header_footer_font" href="<%=ctxPath%>/login/login.tam">로그인</a>
					 </c:if>
					 <c:if test="${not empty sessionScope.loginuser}">
					  	<a class="nav-link header_footer_font" href="<%=ctxPath%>/login/logout.tam">로그아웃</a>
					 </c:if>
			     </li>
			  </ul>
			  <span>
				  <a class="nav-link header_footer_font" href="#">
					  <svg xmlns="http://www.w3.org/2000/svg" height="1.5em" viewBox="0 0 448 512"><!--! Font Awesome Free 6.4.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2023 Fonticons, Inc. --><style>svg{fill:#000000}</style><path d="M160 112c0-35.3 28.7-64 64-64s64 28.7 64 64v48H160V112zm-48 48H48c-26.5 0-48 21.5-48 48V416c0 53 43 96 96 96H352c53 0 96-43 96-96V208c0-26.5-21.5-48-48-48H336V112C336 50.1 285.9 0 224 0S112 50.1 112 112v48zm24 48a24 24 0 1 1 0 48 24 24 0 1 1 0-48zm152 24a24 24 0 1 1 48 0 24 24 0 1 1 -48 0z"/></svg>
					  <label>0</label>
				  </a>
			  </span>
			</div> 
	</nav>
	<%-- 네비게이션바 끝 --%>
	
<%-- 헤더 끝 --%>	

<%-- 카테고리 시작 --%>
	<div id="category_container">
		<ul>
			<li id="total_view" name="total_view">
				<a href="<%=ctxPath%>/index.tam">
					<c:if test="${empty requestScope.ca_id}">
						<span class="category_img_select">
							<img src="<%= ctxPath %>/images/jh/category/entire.png" style="width:100px; height:100px;" class="cate_img" >
						</span>
					</c:if>
					<c:if test="${not empty requestScope.ca_id}">
						<span class="category_img">
							<img src="<%= ctxPath %>/images/jh/category/entire.png" style="width:100px; height:100px;" class="cate_img" >
						</span>
					</c:if>
					<span class="category_name header_footer_font">전체보기</span>
				</a>
			</li>
			
			<c:forEach var="caImgList" items="${requestScope.cateImgList}" varStatus="status" >
				
				
				<c:if test="${empty requestScope.ca_id}">
					<li id="${caImgList.ca_id}" name="${caImgList.ca_id}">
						<a href="<%=ctxPath%>/category.tam?ca_id=${caImgList.ca_id}">
							<span class="category_img"><img src="<%= ctxPath %>/images/jh/category/${caImgList.ca_img_file}" style="width:100px; height:100px;" class="cate_img" ></span>
							<span class="category_name header_footer_font">${caImgList.ca_name}</span>
						</a>
					</li>
				</c:if>
				<c:if test="${not empty requestScope.ca_id}">
					<c:if test="${caImgList.ca_id eq requestScope.ca_id}">
						<li id="${caImgList.ca_id}" name="${caImgList.ca_id}">
							<a href="<%=ctxPath%>/category.tam?ca_id=${caImgList.ca_id}">
								<span class="category_img_select"><img src="<%= ctxPath %>/images/jh/category/${caImgList.ca_img_file}" style="width:100px; height:100px;" class="cate_img" ></span>
								<span class="category_name header_footer_font">${caImgList.ca_name}</span>
							</a>
						</li>
					</c:if>
					<c:if test="${caImgList.ca_id ne requestScope.ca_id}">
						<li id="${caImgList.ca_id}" name="${caImgList.ca_id}">
							<a href="<%=ctxPath%>/category.tam?ca_id=${caImgList.ca_id}">
								<span class="category_img"><img src="<%= ctxPath %>/images/jh/category/${caImgList.ca_img_file}" style="width:100px; height:100px;" class="cate_img" ></span>
								<span class="category_name header_footer_font">${caImgList.ca_name}</span>
							</a>
						</li>
					</c:if>
				</c:if>
				<%-- 카테고리 끝 --%>
				
			</c:forEach>
			
		</ul>
	</div>
	
	<c:if test="${not empty requestScope.cateMainMap}">
		<%-- 카테고리 메인 시작 --%>
		<div class="text-center" style="margin-top: 20px;">
		
			<%-- 카테고리 메인 이미지 --%>
			<c:if test="${requestScope.cateMainMap.CA_ID eq 'pf'}">
				<div>
					<video class="video" muted autoplay playsinline loop style="background-size: cover; width: 100%;" >
						<source class="img-fluid" type="video/mp4;codec='avc.1.42e01e, mp4a.40.2'" src="<%= ctxPath %>/images/jh/category/${requestScope.cateMainMap.CA_MAIN_IMG}">
					</video>
				</div>
			</c:if>
			<c:if test="${requestScope.cateMainMap.CA_ID ne 'pf'}">
				<div>
					<img style="background-size: cover; width: 100%;" class="img-fluid cateMainImg" src="<%= ctxPath %>/images/jh/category/${requestScope.cateMainMap.CA_MAIN_IMG}">
				</div>
			</c:if>
			
			<div style="margin: 40px auto 60px auto; width: 80%">
				<%-- 카테고리 메인 제목 --%>
				<div style="font-size: 18pt; line-height: 50px; font-weight: 500; margin: 0; padding: 0;">
					<div style="margin: 0; padding: 0;">${requestScope.cateMainMap.CA_MAIN_TITLE}</div>
				</div>
				
				<%-- 카테고리 메인 설명 --%>
				<div style="margin: 30px auto 0px auto; width: 60%; font-size: 11pt; line-height: 180%; word-break: keep-all;">
					<div style="font-weight: 400; letter-spacing: -0.2px;">
						${requestScope.cateMainMap.CA_MAIN_TEXT}
					</div>
				</div>
			</div>
		
		</div>
		<%-- 카테고리 메인 끝 --%>		
	</c:if>
	
	<%-- sticky bar 시작 --%>
	<c:if test="${not empty requestScope.cateMainMap}">
		<div class="sticky_son" style="text-align: left;">
			<Strong>${requestScope.cateMainMap.CA_NAME}</Strong>
			<span style="margin-left: 10px; letter-spacing: -0.2px; font-weight: 100;">
				(${requestScope.cateMainMap.CNT})
			</span>
		</div>
	</c:if>
	
	<c:if test="${empty requestScope.cateMainMap}">
		<div class="sticky_son" style="text-align: left; letter-spacing: -0.2px; font-weight: 500; ">
			<Strong>전체보기</Strong>
			<span style="margin-left: 10px; letter-spacing: -0.2px; font-weight: 100;">
				(${requestScope.allItemCount})
			</span>
		</div>
	</c:if>
	<%-- sticky bar 끝 --%>
	
	