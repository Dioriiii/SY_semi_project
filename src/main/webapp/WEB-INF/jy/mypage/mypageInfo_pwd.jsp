<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String ctxPath = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>


<%-- Required meta tags --%>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
 

<%-- Font Awesome 6 Icons --%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/jy/mypage/mypageInfo_pwd.css" />
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/jy/common.css" />

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
<script type="text/javascript" src="<%= ctxPath%>/js/jy/mypage/mypageInfo_pwd.js"></script>


<script type="text/javascript">


</script>

</head>

<div class="err_banner">
	 <span id="err_msg"></span>
</div>
	
<jsp:include page="../header_revised.jsp" />

<body>
	<div id="member">
		<jsp:include page="../../db/mypage/mypageLeft_bar.jsp" />
		
		<div id="mypage_right" class="mypage_info_right">
         <div class="head_div">
            <div class="page_title">
               <h3>비밀번호 확인</h3>
            </div>
         </div>
			<div class="sub_title_div">
				<span class="sub_title_sp">회원정보 수정</span>
			</div>
			<div class="inner_contents_wrap">
				<form name="pwdFrm" class="inner_contents">
					 <div class="input_item">
		                 <div class="input_label">
		                     <label class="input_label" for="pwd">비밀번호</label>
		                 </div>
		                 <div class="common_input" id="div_pw">
		                     <input type="password" name="pwd" id="pwd" class="text" required="" size="20" maxlength="20">
		                     <input type="text" name="pwd_hidden" id="pwd_hidden" value="" style="display:none;">
		                 </div>
	                 </div>
	                 <div class="btn_wrap">
	                	 <div class="common_btn" id="div_btn_pwdCheck"><button class="common_btn" type="button" id="btn_pwdCheck" onclick="goPwdCheck()">비밀번호 확인</button></div>
	                 </div>
				</form>		
			</div>	
		</div>
	</div>	
	<br>
</body>

<jsp:include page="../../jh/footer.jsp"/>

</html>