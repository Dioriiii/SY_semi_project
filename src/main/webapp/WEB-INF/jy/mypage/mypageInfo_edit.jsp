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
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/jy/mypage/mypageInfo_edit.css" />

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
<script type="text/javascript" src="<%= ctxPath%>/js/jy/mypage/mypageInfo_edit.js"></script>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/jy/common.css" />

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script>
$(document).ready(function () {
	// 성별 초기값
	$("select#gender").val('${sessionScope.loginuser.gender}').prop("selected",true);
	
});


</script>

</head>
<body id="container" style="overflow-x: hidden">
	  
	<div class="err_banner">
	  		<span id="err_msg"></span>
	</div>
	 
	<jsp:include page="../header_revised.jsp" />

	<div id="member">
		<jsp:include page="../../db/mypage/mypageLeft_bar.jsp" />
		
		<div id="mypage_right" class="mypage_info_right">
         	<div class="head_div">
	            <div class="page_title">
	               <h3>회원정보</h3>
	            </div>
            </div>
			<div class="sub_title_div">
				<span class="sub_title_sp">회원정보 수정</span>
			</div>
			<div class="page_1">
				<section class="signup-section">
					<form name="EditFrm" id="EditFrm">
						<div class="section_inner signup">
							<div class="input-item id_email">
								<div class="div_label label_id"><label class="input_label" for="userid">아이디</label></div>
								<div class="common_input input_id"><input class="text required" type="text" id="userid" name="userid" maxlength="50" readonly value="${sessionScope.loginuser.userid}"/></div>
							</div>
							<div class="input-item email">
								<div class="div_label label_name"><label class="input_label" for="email">이메일</label></div>
								<div class="common_input input_email"><input class="text required" type="text" id="email" name="email" maxlength="50" required value="${sessionScope.loginuser.userid}"/></div>
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
								<div class="div_label label_gender"><label class="input_label" for="gender" >성별</label></div>
								<div class="common_input select_gender">
									<select name="gender" class="required" id="gender">
										<option selected disabled>성별을 선택해주세요.</option>
										<option value="2" selected="">여자</option>
										<option value="1" selected="">남자</option>
									</select>
								</div>
							</div>
							<div class="input-item name">
								<div class="div_label label_name"><label class="input_label" for="name">이름</label></div>
								<div class="common_input input_name"><input class="text required" type="text" id="name" name="name" value="${sessionScope.loginuser.name}" maxlength="15" readonly required/></div>
							</div>
							<div class="input-item telCheck">
								<div class="div_label label_telCheck"><label class="input_label" for="input_confirmCode">인증번호 입력</label></div>
								<div class="input_tel_wrap">
									<div class="common_input tel" id="div_input_confirmCode"><input class="text input" type="text" id="input_confirmCode" name="input_confirmCode"pattern="[0-9]*" maxlength="8" autocomplete="false" /></div>
									<div class="common_input btn_item_sm"><button type="button" class="btn_item" id="resendCode"onclick="resendMsgTel()">재전송</button></div>
									<div class="common_input btn_item_sm"><button type="button" class="btn_item" id="checkCode">인증하기</button></div>
								</div>
							</div>
							<div class="input-item tel">
								<div class="div_label label_tel"><label class="input_label" for="mobile">연락처</label></div>
								<div class="input_tel_wrap">
									<div class="common_input input_tel" id="div_input_tel"><input class="text input required" type="text" id="mobile" name="mobile" placeholder="예: 01012341234" pattern="[0-9]*" maxlength="13" oninput="onInputHandler_tel()" value="${sessionScope.loginuser.mobile}" required readonly/></div>
									<div class="common_input btn_item" id="div_send_code"><button type="button" class="btn_item" id="btn_chg_mobile">변경하기</button></div>
								</div>
							</div>
							<div class="input-item birth">
								<div class="div_label label_birth"><label class="input_label" for="birthday">생년월일(양력)</label></div>
								<div class="common_input">
									<input type="text" class="text input required" id="birthday" name="birthday" placeholder="예: 2020.01.31" pattern="[0-9]*" maxlength="10" oninput="onInputHandler_birth()" value="${sessionScope.loginuser.birthday}" required/>
								</div>
							</div>
							
							<div class="input-item address">
								<div class="div_label label_post"><label class="input_label" for="postcode">주소</label></div>
								<div class="input_tel_wrap">
									<div class="common_input input_post" style="display:none;"><input type="text" class="text" name="postcode" id="postcode" size="6" maxlength="5"/></div>
									<div class="common_input input_add"><input class="text" type="text" 
									
									id="address" name="address" maxlength="15" placeholder="기본주소" onclick="searchAddress()" value="${sessionScope.loginuser.address}"readonly /></div>
									<div class="common_input btn_item"><button type="button" class="btn_item" id="search_add" onclick="searchAddress()">검  색</button></div>
								</div>
								<div class="common_input input_add" id="detail_add"><input class="text" type="text" id="detailaddress" name="detailaddress" size="40" maxlength="200" placeholder="상세주소를 입력해주세요" value="${sessionScope.loginuser.detailaddress}"/></div>
								<div class="common_input" id="extra_add" style="display:none;"><input class="text" type="text" id="extraaddress" name="extraaddress" size="40" maxlength="200"/></div>
							</div>
							<div class="agree_list">
								<div class="checkbox-item">
									<label class="agree agreeAll" for="agreeAll">
									<input type="checkbox" id="agreeAll" class="checkbox-item" onclick="func_allCheck(this.checked)" checked="checked"/>
									<span class="checkbox-shape"></span>
									모두 동의합니다.</label>
								</div>
								<div class="checkbox-item">
									<label class="agree" for="agreeAge">
									<input type="checkbox" name="agree" id="agreeAge" class="checkbox-item" onclick="func_agreeCheck()"checked="checked"/>
									<span class="checkbox-shape"></span>
									(필수) 본인은 만 14세 미만이 아닙니다.</label>
								</div>
								<div class="checkbox-item">
									<label class="agree" for="agreeLegal">
									<input type="checkbox" name="agree" id="agreeLegal" class="checkbox-item" onclick="func_agreeCheck()"checked="checked"/>
									<span class="checkbox-shape"></span>
									(필수) <a class="agree" href="<%= ctxPath%>/agreement/agree_1.html" target="_blank">이용약관</a>에 동의합니다.</label>
								</div>
								<div class="checkbox-item">
									<label class="agree" for="agreeInfo">
									<input type="checkbox" name="agree" id="agreeInfo" class="checkbox-item" onclick="func_agreeCheck()"checked="checked"/>
									<span class="checkbox-shape"></span>
									(필수) <a class="agree" href="<%= ctxPath%>/agreement/agree_2.html" target="_blank">개인정보처리방침</a>에 동의합니다.</label>
								</div>						
							</div>					
							<div class="common_btn" id="div_btn_edit"><a class="common_btn" id="goEdit_btn" onclick="goEdit()">수정하기</a></div>
						</div>
					</form>
				</section>
			</div>
		</div>
	</div>	
	<br>
</body>

	<jsp:include page="../../jh/footer.jsp"/>

</html>