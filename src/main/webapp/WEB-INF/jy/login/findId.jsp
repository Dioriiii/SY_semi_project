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
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/jy/common.css" />
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/font.css" />
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/js/jy/login/findId.js"></script>

</head>
<body>

	<div class="err_banner">
	  		<span id="err_msg"></span>
	</div>

	<jsp:include page="../header_revised.jsp" /> 


	<div id="container">
	    <div class="page__inner">
	        <div class="page__1-col">
	            <section class="Id-section">
	               <div class="section_inner">
	                    <h1 class="title" id="findId_title">아이디 찾기</h1>
	                    <form class="account__form" id="findIdFrm" name="findIdFrm" onsubmit="return" method="post" autocomplete="off">
	
	                  		<div class="input-item" id="telCheck">
								<div class="div_label label_telCheck"><label class="input_label" for="input_confirmCode">인증번호 입력</label></div>
								<div class="input_tel_wrap">
									<div class="common_input tel" id="div_input_confirmCode"><input class="text input" type="text" id="input_confirmCode" name="input_confirmCode"pattern="[0-9]*" maxlength="8" /></div>
									<div class="common_input btn_item_sm"><button type="button" class="btn_item" id="resendCode"onclick="resendMsgTel()">재전송</button></div>
									<div class="common_input btn_item_sm"><button type="button" class="btn_item" id="checkCode">인증하기</button></div>
								</div>
							</div>
							<div class="input-item tel">
								<div class="div_label label_tel"><label class="input_label" for="mobile">연락처</label></div>
								<div class="input_tel_wrap">
									<div class="common_input input_tel" id="div_input_tel"><input class="text input required" type="text" id="mobile" name="mobile" placeholder="예: 01012341234" pattern="[0-9]*" maxlength="13" oninput="onInputHandler_tel()" required /></div>
									<div class="common_input btn_item" id="div_send_code"><button type="button" class="btn_item" id="btn_mobile" onclick="checkMobile()">인증하기</button></div>
								</div>
							</div>
	                        
		                <div class="btn_wrap_idFind">
			                <a class="common_btn bk_btn btn_login" id="goLogin_a" href="/tempSemi/login/userLogin.tam">로그인</a>	                
			                <a class="common_btn wh_btn common_mt4" id="goRegister_a" href="/tempSemi/login/userRegister.tam">신규 회원가입</a>
		                </div>
	                        
	                    </form>
	                </div>
	            </section>
	        </div>
	    </div>
	</div>


</body>
</html>