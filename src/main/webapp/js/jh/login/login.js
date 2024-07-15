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
		alert("아이디를 입력하세요!!");
		$("input#userid").val("").focus();
		return; // goLogin() 함수 종료
	}
	
	// 비밀번호가 공백인 경우
	if(loginPwd == ""){
		alert("비밀번호를 입력하세요!!");
		$("input#pwd").val("").focus();
		return; // goLogin() 함수 종료
	}
	
	
	const frm = document.loginFrm;
	frm.submit();
	
} // end of function goLogin()