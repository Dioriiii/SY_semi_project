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
<title>비밀번호 찾기</title>

<meta name="viewport" content="width=device-width,initial-scale=1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/jy/login/userRegister.css" />

<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/jy/common.css" />
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/font.css" />
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/js/jy/login/pwdUpdate_3m.js"></script>
<script>



</script>


</head>
<body>

<main>

<jsp:include page="../header_revised.jsp" />

<div id="container">
    <div class="page__inner">
        <div class="page__1-col">
            <section class="pwd-section">
               <div class="section_inner">
                    <h1 class="title">비밀번호 변경</h1>
                    <p class="sub-title">개인정보 보호를 위해 비밀번호를 변경해주세요.</p>
                    <form name="pwdChgFrm">
	                    <div class="input-item">
							<div class="div_label label_email"><label class="input_label" for="old_pwd">기존 비밀번호</label></div>
							<div class="input_wrap">
								<div class="common_input"><input class="text" type="password" name="old_pwd" id="old_pwd" maxlength="50" size="50" required/></div>
							</div>
							<div class="pwd_err_msg" id="err_old_pwd"><span>비밀번호를 입력해 주세요.</span></div>
						</div><div class="input-item email">
							<div class="div_label label_email"><label class="input_label" for="new_pwd">새 비밀번호</label></div>
							<div class="input_wrap">
								<div class="common_input"><input class="text" type="password" name="new_pwd" id="new_pwd" maxlength="50" size="50" required/></div>
							</div>
							<div class="pwd_err_msg" id="err_new_pwd"><span>필수 입력란입니다.</span></div>
						</div>
						<div class="input-item email">
							<div class="div_label label_email"><label class="input_label" for="check_pwd">비밀번호 확인</label></div>
							<div class="input_wrap">
								<div class="common_input"><input class="text" type="password" name="check_pwd" id="check_pwd" maxlength="50" size="50" required/></div>
							</div>
							<div class="pwd_err_msg" id="err_check_pwd"><span>필수 입력란입니다.</span></div>
						</div>
	                        
	                        
		                <div class="btn_wrap">
		                	<a class="common_btn bk_btn" type="button" id="chgPwd_btn">비밀번호 변경하기</a>     
			                <a id="chgNext_btn" class="common_btn common_mt4 wh_btn">90일 후 변경</a>
		                </div>
	                    <div class="pwd_notice">
							<ul>
		                        <li class="member-notice__item">· 3개월 이상 비밀번호를 변경하지 않고 동일한 비밀번호를 사용 중인 경우, 로그인 시 비밀번호 변경 안내를 해드리고 있습니다.</li>
		                        <li class="member-notice__item">· 영문 대소문자는 구분이 되며, 최소 1개의 대문자, 특수문자, 숫자가 포함된 비밀번호를 사용하셔야 됩니다.</li>
		                        <li class="member-notice__item">· 사용 가능한 특수문자 ! @ # $ % ^ & * ( ) - + / < >.</li>
		                        <li class="member-notice__item">· 비밀번호는 주기적으로 바꾸어 사용하시는 것이 안전합니다.</li>
	                        </ul>
						</div>    
                    </form>
                </div>
            </section>
        </div>
    </div>
</div>

</main>
</body>
</html>