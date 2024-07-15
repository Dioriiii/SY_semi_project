<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String ctxPath = request.getContextPath();
	//	   /tempSemi
%>



<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>회원가입 페이지</title>

<meta name="viewport" content="width=device-width,initial-scale=1">

<%-- Required meta tags --%>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <title>탬버린즈 header</title>
    
    <%-- Bootstrap CSS --%>
    <link rel="stylesheet" href="<%= ctxPath%>/bootstrap-4.6.2-dist/css/bootstrap.min.css" type="text/css">
    
    <%-- Font Awesome 5 Icons --%>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    
    <%-- header,footer 전용 CSS --%>
    <link rel="stylesheet" href="<%= ctxPath%>/css/jy/hearderTest.css" type="text/css">
    
    <%-- register 전용 CSS --%>
    <link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/font.css" />
	<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/jy/common.css" />
    <link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/jy/login/userRegister.css" />

	<%-- Optional JavaScript --%>
    <script src="<%= ctxPath%>/js/jquery-3.7.1.min.js" type="text/javascript"></script>
    <script src="<%= ctxPath%>/bootstrap-4.6.2-dist/js/bootstrap.bundle.min.js" type="text/javascript"></script>
    
    <%-- header,footer 전용 js --%>
 	<script src="<%= ctxPath%>/js/jy/headerTest/headerTest.js" type="text/javascript"></script>
 	<script type="text/javascript" src="<%= ctxPath%>/js/jy/login/userRegister.js"></script>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>


<script>


</script>
 </head>
 
<body id="container" style="overflow-x: hidden">
	<div class="err_banner">
	  		<span id="err_msg"></span>
	</div>
	  
	  
	<jsp:include page="../header_revised.jsp" />

	<div id="divRegisterFrm">
		<form name="registerFrm" autocomplete="off">
			<div class="page_1_kakao">
				<section class="signup-section-kakao">
					<div class="section_inner join-kakao">
						<div class="">
							<h1 class="title">빠른회원가입</h1>
							<p class="sub-title">카카오 계정으로 간편하게 회원가입을 해보세요.</p>
						</div>
						<div class="btn_wrap_kakao"><a class="common_btn" id="kakao_button">카카오 계정으로 1초 가입하기</a></div>
					</div>
				</section>
			</div>
			
			<div class="page_1">
				<section class="signup-section">
					<div class="section_inner signup">
						<h1 class="common_title">일반 회원가입</h1>
						<div class="input-item email">
							<div class="div_label input_label"><label class="input_label" for="userid_f">아이디</label></div>
							
							<div class="input_email_container">
								<div class="common_input input_email"><input type="text" class="text" name="userid_f" id="userid_f" maxlength=15 required autocomplete="off" /></div>
								<div class="text_wrap"><span style="cursor:default;">@</span></div>
		                       	<div class="input_email_wrap">
			                       	<div class="common_input input_email"><input type="text" class="text required" id="userid_email" name="userid_b" readonly ></div>                  
											<div class="common_input div_select_email" id="div_email-select" style="cursor:default;">
											<select class="tam-select_input input_email" id="email-select">
												<option value="" selected="" disabled="">선택</option>
						                        <option value="naver.com">naver.com</option>
						                        <option value="hanmail.net">hanmail.net</option>
						                        <option value="nate.com">nate.com</option>
						                        <option value="gmail.com">gmail.com</option>
						                        <option value="hotmail.com">hotmail.com</option>
						                        <option value="hanmir.com">hanmir.com</option>
						                        <option value="dreamwiz.com">dreamwiz.com</option>
						                        <option value="lycos.co.kr">lycos.co.kr</option>
						                        <option value="empas.com">empas.com</option>
						                        <option value="direct">직접 입력</option>			
											</select>
											</div>
								</div>
								<input type="hidden" class="text" name="userid" id="userid_full" maxlength=15 required autocomplete="off" />
							</div>								
						</div>
						<div class="input-item" id="sendEmail_btn_wrap">
							<div class="input_email_wrap">
								<div class="common_btn" id="sendEmail_btn"><button type="button" class="common_btn" id="sendEmail_btn" onclick="goSendEmail()">인증하기</button></div>
							</div>
						</div>
 						<div class="input-item email_check" id="checkCode_email_wrap">
							<div class="div_label label_emailCheck"><label class="input_label" for="input_confirmCode_email">인증번호 입력</label></div>
							<div class="input_email_wrap">
								<div class="common_input tel" id="div_input_confirmCode_email"><input class="text" type="text" id="input_confirmCode_email" name="input_confirmCode_email" class="input" pattern="[0-9]*" maxlength="7" /></div>
								<div class="common_input btn_item_sm"><button type="button" class="btn_item" id="resendCode_email">재전송</button></div>
								<div class="common_input btn_item_sm"><button type="button" class="btn_item" id="checkCode_email">인증하기</button></div>
							</div>
						</div>
						<div class="input-item pwd">
							<div class="div_label label_pwd"><label class="input_label" for="pwd">비밀번호</label></div>
							<div class="common_input input_pwd"><input class="text required" type="password" id="pwd" name="pwd" maxlength=20 required/></div>
						</div>
						<div class="input-item pwdCheck">
							<div class="div_label label_pwdCheck"><label class="input_label" for="pwdCheck">비밀번호 확인</label></div>
							<div class="common_input input_pwdCheck "><input class="text required" type="password" id="pwdCheck" maxlength=20 required/></div>
						</div>						
						
						<div class="error_pwd_notice">
							<ul>
		                        <li class="member-notice__item">· 영문 대소문자는 구분이 되며, 최소 1개의 대문자, 특수문자, 숫자가 포함 된 비밀번호를 사용 하셔야 됩니다.</li>
		                        <li class="member-notice__item">· 사용 가능한 특수문자: ! @ # $ % ^ &amp; * ( ) - + / &lt; &gt; , .</li>
	                        </ul>
						</div>
						<div class="input-item select-gender">
							<div class="div_label label_gender"><label class="input_label" for="gender">성별</label></div>
							<div class="common_input select_gender">
								<select name="gender" class="required" id="gender">
									<option selected disabled>성별을 선택해주세요.</option>
									<option value="2">여자</option>
									<option value="1">남자</option>
								</select>
							</div>
						</div>
						<div class="input-item name">
							<div class="div_label label_name"><label class="input_label" for="name">이름</label></div>
							<div class="common_input input_name"><input class="text required" type="text" id="name" name="name" maxlength="15" required/></div>
						</div>
						<div class="input-item telCheck">
							<div class="div_label label_telCheck"><label class="input_label" for="input_confirmCode">인증번호 입력</label></div>
							<div class="input_tel_wrap">
								<div class="common_input tel" id="div_input_confirmCode"><input class="text" type="text" id="input_confirmCode" name="input_confirmCode" class="input" pattern="[0-9]*" maxlength="8" /></div>
								<div class="common_input btn_item_sm"><button type="button" class="btn_item" id="resendCode"onclick="resendMsgTel()">재전송</button></div>
								<div class="common_input btn_item_sm"><button type="button" class="btn_item" id="checkCode">인증하기</button></div>
							</div>
						</div>
						<div class="input-item tel">
							<div class="div_label label_tel"><label class="input_label" for="mobile">연락처</label></div>
							<div class="input_tel_wrap">
								<div class="common_input input_tel" id="div_input_tel"><input class="text required" type="text" id="mobile" name="mobile" class="input" placeholder="예: 01012341234" pattern="[0-9]*" maxlength="13" oninput="onInputHandler_tel()" required/></div>
								<div class="common_input btn_item" id="div_send_code"><button type="button" class="btn_item" id="btn_send_code" onclick="sendMsgTel()">인증하기</button></div>
							</div>
						</div>
						<div class="input-item birth">
							<div class="div_label label_birth"><label class="input_label" for="birthday">생년월일(양력)</label></div>
							<div class="common_input"><input type="text" class="text required" id="birthday" name="birthday" class="input" placeholder="예: 2020.01.31" pattern="[0-9]*" maxlength="10" oninput="onInputHandler_birth()"required/></div>
						</div>
						
						<div class="input-item address">
							<div class="div_label label_post"><label class="input_label" for="postcode">주소</label></div>
							<div class="input_tel_wrap">
								<div class="common_input input_post" style="display:none;"><input type="text" class="text" name="postcode" id="postcode" size="6" maxlength="5"/></div>
								<div class="common_input input_add"><input class="text" type="text" id="address" name="address" maxlength="15" placeholder="기본주소" onclick="searchAddress()" readonly /></div>
								<div class="common_input btn_item"><button type="button" class="btn_item" id="search_add" onclick="searchAddress()">검  색</button></div>
							</div>
							<div class="common_input input_add" id="detail_add"><input class="text" type="text" id="detailaddress" name="detailaddress" size="40" maxlength="200" placeholder="상세주소를 입력해주세요" /></div>
							<div class="common_input" id="extra_add" style="display:none;"><input class="text" type="text" id="extraaddress" name="extraaddress" size="40" maxlength="200"/></div>
						</div>
						<div class="agree_list">
							<div class="checkbox-item">
								<label class="agree agreeAll" for="agreeAll">
								<input type="checkbox" id="agreeAll" class="checkbox-item" onclick="func_allCheck(this.checked)"/>
								<span class="checkbox-shape"></span>
								모두 동의합니다.</label>
							</div>
							<div class="checkbox-item">
								<label class="agree" for="agreeAge">
								<input type="checkbox" name="agree" id="agreeAge" class="checkbox-item" onclick="func_agreeCheck()"/>
								<span class="checkbox-shape"></span>
								(필수) 본인은 만 14세 미만이 아닙니다.</label>
							</div>
							<div class="checkbox-item">
								<label class="agree" for="agreeLegal">
								<input type="checkbox" name="agree" id="agreeLegal" class="checkbox-item" onclick="func_agreeCheck()"/>
								<span class="checkbox-shape"></span>
								(필수) <a class="agree" href="<%= ctxPath%>/termsAndConditions.tam" target="_blank">이용약관</a>에 동의합니다.</label>
							</div>
							<div class="checkbox-item">
								<label class="agree" for="agreeInfo">
								<input type="checkbox" name="agree" id="agreeInfo" class="checkbox-item" onclick="func_agreeCheck()"/>
								<span class="checkbox-shape"></span>
								(필수) <a class="agree" href="<%= ctxPath%>/privacyPolicy.tam" target="_blank">개인정보처리방침</a>에 동의합니다.</label>
							</div>						
						</div>
						<div class="btn_wrap"><a class="common_btn" id="goRegister_btn" href="javascript:goRegister()">신규 회원가입</a></div>
					</div>
				</section>
			</div>		
		</form>	
		
	<%-- 인증하기 form --%>
	<form name="verifyCertificationFrm">
		<input type="hidden" name="userCertificationCode" />
	</form>	
	</div>	

<jsp:include page="../../jh/footer.jsp"/>
