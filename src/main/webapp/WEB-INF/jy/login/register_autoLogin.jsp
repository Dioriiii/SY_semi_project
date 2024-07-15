<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String ctxPath = request.getContextPath();
	//	   /tempSemi
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>

<meta name="viewport" content="width=device-width,initial-scale=1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/jy/login/userRegister.css" />
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/font.css" />
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/jy/common.css" />
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>

<script type="text/javascript">

function goIndex() {
	const frm = document.loginFrm;
	frm.action="<%= ctxPath%>/login/loginCheck.tam";
	frm.method="post";
	frm.submit();
}
</script>

</head>
<body>

<main>

<jsp:include page="../header_revised.jsp" />

<div id="container">
    <div class="page__inner">
        <div class="page__1-col">
            <section class="welcome-section">
               <div class="section_inner ">
                    <div class="welcome_msg">
						<span>회원가입이 완료되었습니다.</span><br>
						<span>환영합니다.</span>
					</div>
                        
	                <div class="btn_wrap">
		                <a class="common_btn" id="goIndex_btn" href="javascript:goIndex()">쇼핑하러 가기</a>	                
	                </div>                        
                </div>
            </section>
        </div>
    </div>
</div>

	<form name="loginFrm">
		<input type="hidden" name="userid" value="${requestScope.userid}" />
		<input type="hidden" name="pwd" value="${requestScope.pwd}" />
	</form>
	
</main>
</body>
</html>