<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
	String ctxPath = request.getContextPath();
	//	   /tempSemi
%>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/jh/login/login.css" />
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/jy/common.css" />
<link rel="icon" href="<%= ctxPath%>/images/jy/fav_tamburins.png">

<div class="err_banner">
  		<span id="err_msg"></span>
</div>
<jsp:include page="../../jy/header_revised.jsp" />

<title>로그인 | Tamburins</title>

<script type="text/javascript">

$(document).ready(function(){
	
	$("input#userid").focus();
	
	$("button#btnSubmit").click(function(){
		goLogin(); // 로그인 시도한다.
	})
	
	$("input#userid").bind("keyup", function(e){
		// 암호입력란에 엔터를 했을 경우
		if(e.keyCode == 13){
			goLogin(); // 로그인 시도한다.
		}
	})
	
	$("input#pwd").bind("keyup", function(e){
		// 암호입력란에 엔터를 했을 경우
		if(e.keyCode == 13){
			goLogin(); // 로그인 시도한다.
		}
	})
	
}); // end of $(document).ready(function(){});


// === 로그인 처리 함수 === //
function goLogin(){
	// alert("확인용 로그인 처리 하러감!")
	const loginUserid = $("input#userid").val().trim();
	const loginPwd = $("input#pwd").val().trim();
	
	// 아이디가 공백인 경우
	if(loginUserid == ""){
		showBanner();
		$("div.err_banner").html("아이디를 입력하세요!!");
	//	alert("아이디를 입력하세요!!");
		$("input#userid").val("").focus();
		return; // goLogin() 함수 종료
	}
	
	// 비밀번호가 공백인 경우
	if(loginPwd == ""){
		
		showBanner();
		$("div.err_banner").html("비밀번호를 입력하세요!!");
	//	alert("비밀번호를 입력하세요!!");
		$("input#pwd").val("").focus();
		return; // goLogin() 함수 종료
	}
	
	
	const frm = document.loginFrm;
	frm.submit();
	
} // end of function goLogin()

/* 오류 상단 빨간 배너 */
function showBanner() {
	
	$("div.err_banner").addClass('show');
	$("div.err_banner").removeClass('hide');	
  		
  		setTimeout(() => {
			 
    		$("div.err_banner").removeClass('show');
    		$("div.err_banner").addClass('hide');
    		
  		}, 1500)
 
 	
/* 	
	$("div.err_banner").show();
    showBanner();
    이렇게 호출하여 사용하면 됨
*/
}// end of function showBanner()--------

</script>

</head>


<body>
	<div class="page__2-col--wide">
		<!-- left section : login -->
		<section class="login-section section--left">
			<div class="section__inner">
				<h1 class="common_title">로그인</h1>
			
				<form class="account__form" name="loginFrm" action="<%= ctxPath%>/login/loginCheck.tam" method="post">
					
					<div class="input_item">
						<div class="input_label">
							<label class="input_label" for="userid">아이디</label>
						</div>
						<div class="common_input">
							<input type="text" name="userid" id="userid" class="text" size="20" maxlength="50" autocomplete="off" >
						</div>
					</div>
					
					<div class="input_item">
						<div class="input_label">
							<label class="input_label" for="pwd">비밀번호</label>
						</div>
						<div class="common_input">
							<input type="password" name="pwd" id="pwd" class="text" size="20" maxlength="20">
						</div>
					</div>
				
					<div class="btn_wrap">
						<div class="common_btn" id="btn_login">
							<button class="common_btn" type="button" id="btnSubmit" >로그인</button>
						</div>           
						<div class="common_btn common_mt4" id="kakao_button" onclick="kakaoPopup('https://kauth.kakao.com/oauth/authorize?client_id=79e13928f1cf993b2db5c76dc2c43349&amp;redirect_uri=https://www.tamburins.com/plugin/social/kakao_login_member.php&amp;response_type=code&amp;state=https://www.tamburins.com/')">
							<button class="common_btn" type="button">카카오 로그인</button>
						</div>                             
					</div>
					
					<!-- 
						<button type="button" class="btn social__btn social__btn--kakao"
							onclick="window.open('https://www.tamburins.com/plugin/social/popup.php?provider=kakao&amp;url=https%3A%2F%2Fwww.tamburins.com%2F','social_sing_on', 'location=0,status=0,scrollbars=1,width=500,height=600')">
							카카오 계정으로 로그인
						</button>                                     
                                      
					-->
                       
					<div class="text-wrap">
						<p>
							<a class="link" href="<%= ctxPath%>/login/findId.tam">아이디</a>
							&nbsp;또는&nbsp;                    
							<a class="link" href="<%= ctxPath%>/login/findPwd.tam">비밀번호 찾기</a>
							&nbsp;|&nbsp;
							<a class="link" href="<%= ctxPath%>/login/userRegister.tam">회원가입</a>
						</p>
					</div>

				</form>
			</div>
		</section>
		<!-- // left section : login End -->
           
		<!-- right section : join -->
		<section class="login-section section--right">
			<div class="section__inner">
				<h1 class="common_title">회원가입</h1>
				<p class="right_top_txt">회원가입 시 즉시 사용 가능한 3,000원 혜택을 드립니다.</p>
				<div class="btn_wrap">
					<a href="<%= ctxPath%>/login/userRegister.tam" class="common_btn goRegister_btn">신규 회원가입</a>
				</div>
			</div>
		</section>
		<!-- // right section : join End -->
	</div>
</body>

<jsp:include page="../footer.jsp" />