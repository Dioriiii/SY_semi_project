$(document).ready(function() {
	
	$("button#btn_pwdCheck").bind("click", function () {
		goPwdCheck();	
	});
	
	$("input#pwd").bind("keyup", function (e) {
		if(e.keyCode == 13) {
			goPwdCheck();
		}
	})
});


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

function goPwdCheck() {
	const input_pwd = $("input#pwd").val();
	if(input_pwd == ""){
		showBanner();
		$("span#err_msg").html(`비밀번호를 입력하여 주세요!`);
		return false;
	}
	else {
		$.ajax({
			url:"myPagePwdCheck.tam", // 이곳에 JSON 형식으로 보여주는 것!
			type:"POST", // 생략가능~ 기본값은 "get"
			data:{"pwd":input_pwd}, //  8    8    8     8     8
			dataType:"json",
			success:function(json){
				
				if(json.isMatch) {
					// 비밀번호가 맞을 때
					const frm = document.pwdFrm;
					frm.action = "myPageInfoEdit.tam";
					frm.method = "POST";
					frm.submit();	
				}
				
				else {
					// 비밀번호가 틀릴 경우
					showBanner();
					$("span#err_msg").html(`비밀번호가 일치하지 않습니다`);
					return;
				}
				
			}, // end of success
			error:function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
	}
	
	
}// end of function goPwdCheck() {})------------