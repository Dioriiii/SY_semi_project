let userid = null;

$(document).ready(function () {
	
	$("div#telCheck").hide();
	
	$("input#mobile").bind("keyup", (e) => {
		
		if( e.keyCode == 13) {
			checkMobile();
		}
	
	});
	
	// 인증번호 "인증하기" 버튼을 눌렀을 때 이벤트 처리
	$("button#checkCode").bind("click", () => {
	  /*
	  	인증번호 확인 후 맞으면 아이디 알려준 뒤 로그인 페이지로 이동시켜주기
	  */
	   const input_confirmCode = $("input:text[name='input_confirmCode']").val().trim(); 
	  
	  if( $("input#input_confirmCode").val().trim() != ""){
		  
		  $.ajax({
	    	url:"/tempSemi/login/verifyCertification.tam", // <- 상대경로. 혹은 절대경로 http://localhost:9090/MyMVC/member/emailDuplicateCheck.up 로도 가능
	//	    속성명:"벨류값"
	   		data:{"inputCode":input_confirmCode}, // data 속성은 http://localhost:9090/MyMVC/member/emailDuplicateCheck.up 로 전송해야할 데이터를 말한다.
	   		// "email" 는 $("input#email").val() 이 값을 받아와야한다. 그래서 EmailDuplicateCheckAction 클래스에서 key값을 email 로 하여
	   		// request.getParameter("email") 로 $("input#email").val() 이 값을 받아온다.
	   		type:"post", // method 아님!. type 을 생략하면 type:"get" 이다.
	   
	   		async:true, // async:true => 비동기 방식. async 을 생략하면 기본값이 비동기 방식인 async:true 이다.
                        // async:false => 동기 방식. 지도를 할때는 반드시 동기방식인 async:false 을 사용해야만 지도가 올바르게 나온다.
            
            dataType:"json",
            // !!!! ★★★★★ 대문자 T 인거 잊지말자 ★★★★★ !!!!      
	   
	   		success:function(json){
			   
			   // 성공했을때!!  readonly로 변경 재전송버튼 비활성화
			   if(json.isMatch_m) { 
			       // 인증코드가 맞을 경우				   
				   $("input#input_confirmCode").prop("readonly",true);
				   $("button#resendCode").prop("disable",true);
				   const result = confirm(userid + "님의 연락처 인증이 완료되었습니다.\n로그인 하러 가시겠습니까? \n확인을 누르면 로그인 페이지로 이동합니다.");
				   if(result) {
				       location.href="/tempSemi/login/login.tam";							   
				   }

			   }
			   else {
				   alert("인증번호가 일치하지 않습니다.");
			   }
		    },
		    error: function(request, status, error){
               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }		
		})  
		}  
		 
	  else {
		  showBanner();
		  $("div.err_banner").html("인증 번호를 입력해주세요.");
		  return;
	  }
	   
   });// end of $("button#checkCode").bind("click", () => {})-------------

	
	
}); // end of $(document).ready(function () {})---------------


// 연락처 입력시 호출되는 함수
function onInputHandler_tel() {
	
	let text_tel = $("input:text[id='mobile']");
	let tel_val = text_tel.val().replace(/\D/g, "");
	let tel_len = tel_val.length;
	let result = "";
	
	// 세번째 입력 숫자까지 그대로 출력
    if(tel_len < 4) result = tel_val;
    // 4번째에 "-" 추가 후 숫자입력
    else if(tel_len < 8){
	  	result += tel_val.substring(0,3);
	    result += "-";
	    result += tel_val.substring(3);
    // 9번째에 "-" 추가 후 숫자입력
    } else{
	  	result += tel_val.substring(0,3);
	    result += "-";
	    result += tel_val.substring(3,7);
	    result += "-";
	    result += tel_val.substring(7);
    }
	
	// 결과를 값으로 출력
	text_tel.val(result);
	
}

// 연락처 "인증하기" 버튼 클릭 시
function checkMobile() {
	const mobile = $("input#mobile").val();
	let regPhone = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
	
	if(regPhone.test(mobile)) {
		
		const result = confirm(mobile+" 전화번호로 인증번호를 발송하시겠습니까?\n확인을 누르시면 인증번호가 발송됩니다.");
		
		if(result) { // 확인을 눌렀을 때, DB 확인 후 참일 시 문자 발송 / 아닐 시 상단바 알림
			
			$.ajax ({ // DB 에 해당 연락처가 있는지 확인
				url:"findIdMobile.tam",
				data:{"mobile":mobile},
				type:"post",
				dataType:"json",
				success:function(json){
					
					if(json.userid != null) { // tbl_user 에 존재하는 연락처 일때
						userid = json.userid;
						 // 하기 3줄은 문자전송 action 제대로 실행 시, 지우고 success 안쪽의 주석을 푼다! 
						 $("input#mobile").prop("readonly",true);
						 $("div#telCheck").show();
				         $("div#btn_mobile").hide();	
				         				
						 $.ajax({
						 url:"/tempSemi/smsSend.tam",
						 type:"post",
						 data:{"mobile":mobile},
						 dataType:"json",
						 success:function(json){
						  
							 if(json.success_count == 1) {
								 alert("문자전송이 완료되었습니다.\n인증번호를 입력해주세요.")
							/*	 $("input#mobile").prop("readonly",true);
								 $("div#telCheck").show();
								 $("div#btn_mobile").hide();
							*/	
							 }
							 else if (json.error_count != 0) {
								 alert("문자전송이 실패되었습니다.\n잠시후 재시도해주세요.")
							 }
							  
						 },
						 error:function(request, status, error){
				             alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				         }
				         
		            }); // end of $.ajax ({})-----------
						
					}
					else { // 존재하지 않는 연락처 일때
						showBanner();
						$("div.err_banner").html("해당 연락처로 계정이 존재하지 않습니다. 연락처를 확인해주세요.");
					}
				 }
			 }); // end of $a.jax({// DB에서 연락처 유무 확인})------------	
			 			
		}// end of if(result) {}----------------
		
	}// end of if(regPhone.test(mobile)) {}----------
	
	else if (mobile == "") { // 연락처가 공백일 때
		showBanner();
		$("div.err_banner").html("연락처를 입력하여주세요.");
	}
	else { // 연락처가 올바르지 않을 때
		showBanner();
		$("div.err_banner").html("연락처 입력이 올바르지 않습니다.");
	}
}// end of function checkMobile()--------------


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
