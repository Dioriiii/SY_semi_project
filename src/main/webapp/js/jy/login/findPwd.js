let cnt_sendEmail = 0; // 이메일 발송 횟수 cnt

$(document).ready(function () {

	$("div#emailCheck").hide();
	
	$("input#email").bind("keyup", function (e) {
		
		if(e.keyCode == 13) {
			if(cnt_sendEmail>0){
				const result = confirm("임시 비밀번호를 재발송 하시겠습니까?");
				if(result){
					sendEmail();
				}
			}
			else {
				sendEmail();
			}
			
		}
	});
	$("button#sendEmail_btn").bind("click", function () {
		
		if(cnt_sendEmail>0){
			const result = confirm("임시 비밀번호를 재발송 하시겠습니까?");
			if(result){
				sendEmail();
			}
		}
		else {
			sendEmail();
		}
	});	
	
/*	
	// 인증번호 "인증하기" 버튼을 눌렀을 때 이벤트 처리
	$("button#checkCode").bind("click", () => {
	  
	 // 	인증번호 확인 후 맞으면 아이디 알려준 뒤 로그인 페이지로 이동시켜주기
	  
	   const input_confirmCode = $("input:text[name='input_confirmCode']").val(); 
	  
	  if( $("input#input_confirmCode").val() != ""){
		  
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
			   if(json.isMatch) { 
			       // 인증코드가 맞을 경우				   
				   $("input#input_confirmCode").prop("readonly",true);
				   const frm = document.findPwdFrm;
				   frm.action = "pwdUpdate_lost.tam";
				   frm.method = "post";   
				   frm.submit();
			   }
			   else {
				   alert("인증번호가 일치하지 않습니다.");
			   }
		    },
		    error: function(request, status, error){
               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }		
		});
		}  
		
		 
	  else {
		  alert("인증코드를 입력해주세요!");
		  return;
	  }
	   
   });// end of $("button#checkCode").bind("click", () => {})-------------
*/	
	
}); // end of $(document).ready(function () {})---------------

function sendEmail() {
	
	//const regExp_email = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i; 
    // 또는
    const regExp_email = new RegExp(/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i);
    // 숫자/문자/특수문자 포함 형태의 8~15 자리 이내의 암호 정규표현식 객체 생성
    
    const email = $("input#email").val();
    
    const bool = regExp_email.test(email);
    
    if(bool){ // 이메일이 정규 표현식에 맞을 경우
           
       $.ajax ({
		   url:"findPwdEmail.tam",
		   type:"POST",
		   data:{"email":email},
		   dataType:"json",
		   success:function(json)  {
			   
			   if(json.userid != null && json.sendMailSuccess) {
				   alert(email+" 로 임시 비밀번호가 발송되었습니다.\n 임시 비밀번호로 로그인 후 비밀번호를 변경해주세요. ")
				   const frm = document.findPwdFrm;
				   frm.action = "login.tam";
				   frm.method = "post";
				   frm.submit();
			   }
			   else if (json.userid == null) {
				   showBanner();
				   $("div.err_banner").html("해당 이메일로 가입된 회원이 없습니다.");
			   }
			   else if (!json.sendMailSuccess) {
				   alert("서버상의 오류로 이메일 발송이 실패하였습니다. 잠시후에 다시 시도해주세요.")
			   }
			   
		   },
		   error:function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	       }
		   
		   
	   }); // end of ajax({})------------
       
       
       
    }// end of if(bool){}------------- 
    
    else if (email == "") { // 이메일이 공백일 때
		showBanner();
		$("div.err_banner").html("이메일을 입력하여주세요.");
	}
	else { // 이메일 형식이 올바르지 않을 때(정규 표현식에 어긋났을 경우)
		showBanner();
		$("div.err_banner").html("이메일 형식이 올바르지 않습니다.");
	}
		
	
}// end of function sendEmail()--------------




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
