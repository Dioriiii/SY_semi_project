$(document).ready(function () {
	
	// 에러 메시지 전부 숨김
	$("div.pwd_err_msg").hide();
	
	$("a#chgPwd_btn").bind("click", function() {
		goEditPwd();
	});
	
	$("a#chgNext_btn").bind("click", function() {
		goSkip();
	});
	
	// 각 input 에서 keydown 시, 빨간박스와 오류메시지 지워주기	//
	$("input#old_pwd").bind("keydown", () => {
		$("div#err_old_pwd").hide();
		$("input#old_pwd").parent().css("border","");		
	});
/*	
	$("input#new_pwd").bind("keydown", () => {
		$("div#err_new_pwd").hide();
		$("input#new_pwd").parent().css("border","");
	});
*/	
	
	
	// 새 비밀번호에서 keydown 시 이벤트 처리 - 유효성 검사 후 빨간박스 및  오류메시지 표시
	$("input#new_pwd").bind("keyup", () => {
	    const regExp_pwd = new RegExp(/^.*(?=^.{8,20}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g);
		if( !regExp_pwd.test($("input#new_pwd").val()) ) {
			$("div#err_new_pwd").hide();
			$("input#new_pwd").parent().css("border","solid 1px #d12b2b");
		}
		else {
			$("div#err_new_pwd").hide();
			$("input#new_pwd").parent().css("border","");					
		}
	})
	
	// 비밀번호 확인에서 keydown 시 이벤트 처리 - 새 비밀번호와 다를 경우 빨간 box 
	$("input#check_pwd").bind("keyup", (e) => {
				
		if ( $(e.target).val() != $("input#new_pwd").val()){
			$("div#err_check_pwd").show();
			$("div#err_check_pwd").html("새 비밀번호와 일치하지 않습니다.");	
			$("input#check_pwd").parent().css("border","solid 1px #d12b2b");			
		}
		else {
			$("div#err_check_pwd").hide();
			$("input#check_pwd").parent().css("border","");			
		}
	});
	
	
});// end of $(document).ready(function () {})----------/

function goEditPwd() {

// 1-1. 기존 비밀번호 - 공백 일때 메시지 띄워주기 "비밀번호를 입력해 주세요."
// 1-2. 기존번호와 일치하지 않을 때 메시지 띄워주기 "비밀번호가 일치하지 않습니다"
// 1-3. 맞으면 전부 통과 시 true
// 2-1. 새 비밀번호 - 공백 일때 메시지 띄워주기 "필수 입력란입니다."
// 2-2. else - if 정규식에 위배 될때 "올바르지 않은 비밀번호 입니다."
// 2-3.        else if 위배되지 않고 기존 비밀번호와 같을 때 "기존 비밀번호와 동일합니다."
// 2-4.		   else 통과
// 3-1. 비밀번호 확인 - 공백 일때 메시지 띄워주기 "필수 입력란입니다."
// 3-2. else - if 새 비밀번호와 같지 않을 때 "새 비밀번호와 일치하지 않습니다."
// 3-3. 	   else 통과

	let b_old_pwd = true;
	let b_old_pwd_right = false;  // 기존 비밀번호가 맞았을 때 (새 비밀번호가 ajax 없이 기존비밀번호와 대조 가능하도록 만듦)
	let b_new_pwd = true;
	
	const old_pwd = $("input#old_pwd").val();
	const new_pwd = $("input#new_pwd").val();
	const check_pwd = $("input#check_pwd").val();
	
	if( old_pwd == "" ){
		$("div#err_old_pwd").show();
		$("div#err_old_pwd").html("비밀번호를 입력해 주세요.");	
		$("input#old_pwd").parent().css("border","solid 1px #d12b2b");
		b_old_pwd = false;
	}
	else {
		
		$.ajax({
			url:"/tempSemi/mypage/myPagePwdCheck.tam", // 이곳에 JSON 형식으로 보여주는 것!
			type:"POST", // 생략가능~ 기본값은 "get"
			data:{"pwd":old_pwd}, //  8    8    8     8     8
			dataType:"json",
			async : false,
			success:function(json){
				if(!json.isMatch) {
					// 비밀번호가 일치하지 않을 때
					$("div#err_old_pwd").show();
					$("div#err_old_pwd").html("기존 비밀번호와 일치하지 않습니다.");
					$("input#old_pwd").parent().css("border","solid 1px #d12b2b");
					b_old_pwd = false;
				}
				else {
					b_old_pwd_right = true;
				}
				
			}, // end of success
			error:function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
		
	}
	
	if( new_pwd == "" ){
		$("div#err_new_pwd").show();
		$("div#err_new_pwd").html("필수 입력란입니다.");	
		$("input#new_pwd").parent().css("border","solid 1px #d12b2b");
		b_new_pwd = false;
	}
	else {
		// 숫자/문자/특수문자 포함 형태의 8~20 자리 이내의 암호 정규표현식 객체 생성
	    const regExp_pwd = new RegExp(/^.*(?=^.{8,20}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g);
		if( !regExp_pwd.test(new_pwd) ) {
			$("div#err_new_pwd").show();
			$("div#err_new_pwd").html("올바르지 않은 비밀번호입니다.");	
			$("input#new_pwd").parent().css("border","solid 1px #d12b2b");
			b_new_pwd = false;
		}
		else if (b_old_pwd_right && old_pwd == new_pwd) {
			$("div#err_new_pwd").show();
			$("div#err_new_pwd").html("기존 비밀번호와 다른 번호로 입력하여주세요.");
			$("input#new_pwd").parent().css("border","solid 1px #d12b2b");
			b_new_pwd = false;
		}
		else {
			
			// 아래는 ajax 를 사용하여 기존의 비밀번호와 비교할 때이다.
			/* 
			$.ajax({
				url:"/tempSemi/mypage/myPagePwdCheck.tam", // 이곳에 JSON 형식으로 보여주는 것!
				type:"POST", // 생략가능~ 기본값은 "get"
				data:{"pwd":new_pwd}, //  8    8    8     8     8
				async : false,
				dataType:"json",
				success:function(json){
					alert("2 json.isMatch => "+json.isMatch);
					if(json.isMatch) {
						// 비밀번호가 기존 번호와 일치할 때
						$("div#err_new_pwd").show();
						$("div#err_new_pwd").html("기존 비밀번호와 다른 번호로 입력하여주세요.");
						$("input#new_pwd").parent().css("border","solid 1px #d12b2b");
						b_new_pwd = false;
					}
					
					
				}, // end of success
				error:function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
			});
			*/
		}
	}
	
	if( check_pwd == "" ){
		$("div#err_check_pwd").show();
		$("div#err_check_pwd").html("필수 입력란입니다.");	
		$("input#check_pwd").parent().css("border","solid 1px #d12b2b");
		b_new_pwd = false;
	}
	else if(check_pwd != new_pwd) {
		$("div#err_check_pwd").show();
		$("div#err_check_pwd").html("새 비밀번호와 일치하지 않습니다.");	
		$("input#check_pwd").parent().css("border","solid 1px #d12b2b");
		b_new_pwd = false;
	}
	
	if(b_old_pwd&&b_new_pwd) {
		
		const frm = document.pwdChgFrm;
		console.log(document.pwdChgFrm);
		frm.action = "pwdUpdateEnd_3m.tam";
		frm.method = "POST";
		frm.submit();
	}
	
}// end of function goEditPwd() {})----------------------

function goSkip () {
	const frm = document.pwdChgFrm;
	frm.action = "pwdUpdateEnd_3m.tam";
	frm.method = "GET";
	frm.submit();
}