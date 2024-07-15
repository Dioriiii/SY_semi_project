$(document).ready(function() {

	// 이메일 선택시 뒷부분 자동입력
	$("select#email-select").bind("change", (e) => {
		
		const div_email = $("input#mb_email_suffix");
		
		if($(e.target).val() == "direct") {
			div_email.val("");
			div_email.prop('readonly',false);
			div_email.focus();
		}
		else {
			div_email.val($(e.target).val());			
		}
	})
	
	
	

	
   
   // 이메일 change 됐을 때 이벤트
   $("select#email-select").bind("change", () => {
   		if ( $("input#mb_email_suffix").val().trim() != "" ) {
			$("input#mb_email_suffix").parent().css("border","");
		}
   });
   // 이메일 직접입력 시, border 원상복구
   $("input#mb_email_suffix").bind("keyup", () => {
   		$("input#mb_email_suffix").parent().css("border","");
   });
   
   // 이름 키다운 됐을 때 이벤트
    $("input#mb_name").bind("keydown", (e) => {
	   if ( $(e.target).val().trim() != "" ) {
		   $(e.target).parent().css("border","");
	   }
   });
   
   
   $(document).on('click', "button#payment" , function(){

		
		const ctxPath = $("input:hidden[name='ctxPath']").val();
		
		
		goPay(userid, ctxPath);
		
		
		
		
	});
	
   
   
   
   
});// end of $(document).ready(function() {-----------------------------------------------

// === 결제 시작 === //
function goPay(userid, ctxPath){
	
	const userid = $("input:hidden[name='userid']").val();
	const payment_price = $("input:hidden[name='payment_price']").val();
	console.log("payment_price => ", payment_price )
	console.log("userid=>",userid);
		
	const width = 1000;
	const height = 600;	
	
	
	
	// 포트원(구 아임포트) 결제 팝업창 띄우기
	const url = `${ctxPath}/paymentPurchaseEnd.tam?payment_price=${payment_price}&userid=${userid}`;
	
	const left = Math.ceil((window.screen.width - width)/2);
	const top = Math.ceil((window.screen.height - height)/2);

	window.open(url, "paymentPurchaseEnd", 
			`left=${left}; top=${top}, width=${width}, height=${height}`);
				
				
				
}// end of function goCoinPurchaseTypeChoice(userid, ctx_Path) ----------------------


// === 포트원(구 아임포트) 결제를 해주는 함수 === //
function goPaymentPurchaseEnd(ctx_Path, coinmoney, userid){
// alert(`확인용 부모창의 함수 호출함.\n결제금액 : ${coinmoney}원, 사용자id : ${userid}`)
	
// 포트원(구 아임포트) 결제 팝업창 띄우기
	
// 너비 1000, 높이 600 인 팝업창을 화면 가운데 위치시키기
const width = 1000;
const height = 600;

const left = Math.ceil((window.screen.width - width)/2);
const top = Math.ceil((window.screen.height - height)/2);

window.open(url, "paymentPurchaseEnd", 
			`left=${left}; top=${top}, width=${width}, height=${height}`);

}// end of function goCoinPurchaseEnd(coinmoney)------------------

// ==== DB 상의 tbl_user에 해당 사용자의 결제내역을 추가(insert)시켜주는 함수 === //
function goPayment_DB_Update(userid) {
	
	console.log(`~~ 확인용 userid :  ${userid}`);
	
	
	
	
	
	
	
}



// === 결제 끝 === //








// 연락처 숫자만 입력 가능 + 하이픈 추가 함수
function onInputHandler_tel() {
	
	let text_tel = $("input:text[id='mb_tel']");
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

// 날짜 숫자만 입력 가능 + 하이픈 추가 함수
function onInputHandler_birth() {
	let text_birth = $("input:text[id='mb_birth']");
	let birth_val = text_birth.val().replace(/\D/g, "");
	let birth_len = birth_val.length;
	let result = "";

	// 4번째 입력 숫자까지 그대로 출력
    if(birth_len < 5) result = birth_val;
    // 5번째에 "." 추가 후 숫자입력
    else if( birth_val.substring(4,5) !="." && birth_len < 8){
	  	result += birth_val.substring(0,4);
	    result += ".";
	    result += birth_val.substring(4);
    // 9번째에 "-" 추가 후 숫자입력
    } else{
	  	result += birth_val.substring(0,4);
	    result += ".";
	    result += birth_val.substring(4,6);
	    result += ".";
	    result += birth_val.substring(6);
    }
	
	// 결과를 값으로 출력
	text_birth.val(result);	
}


// === 체크박스 전체선택/전체해제 === //
function func_allCheck(bool){
	
	const checkbox_list = document.querySelectorAll("input[name='agree']");
	
	for(let checkbox of checkbox_list) {
		checkbox.checked = bool;
	}// end of for()---------------------

	
}// end of function func_allCheck(bool) {}--------------------




// == 체크박스 전체선택 / 전체해제 에서 
//    하위 체크박스에 체크가 1개라도 체크가 해제되면 체크박스 전체선택/전체해제 체크박스도 체크가 해제되고
//    하위 체크박스에 체크가 모두 체크가 되어지면 체크박스 전체선택/전체해제 체크박스도 체크가 되어지도록 하는 것 == // 
function func_agreeCheck() {	
	
	  $("input:checkbox[name='agree']").click( (e) => {
      //  name이 agree인 체크박스에 대해서 클릭하면 발생하는 이벤트이다.
      
      const bool = $(e.target).prop("checked");
      // 클릭한 체크박스의 체크유무를 알아온다.
      
      
      if(bool) {
      // 클릭한 체크박스가 체크가 되어진 상태이라면
      
         // === [name='agree'] 인 모든 체크박스를 검사해서 모두 체크가 되어진 상태인지 알아온다.
         let b_all_checked = true;
         $("input:checkbox[name='agree']").each( (i, elt) => {
         // $(elt)이 $("div#firstDiv input:checkbox[name='agree']") 중 반복되어지는
         // 하나의 요소이다.
            const b_checked = $(elt).prop("checked");
            // 반복을 돌면서 클릭할때마다 모든 체크박스가 체크가 되었는지 안되었는지 알아온다.
            if(!b_checked){
            // 체크가 되어있지 않은 체크박스를 발견했다. 그렇다면 그 다음에 오는 체크박스를 
            // 확인할 필요가 없다.
               b_all_checked = false;
               return false; // Jquery문의 반복문 탈출 break를 말한다.
            }
            
         }); // end of each()-------------------
         
         if(b_all_checked) {
          // name이 person인 모든 체크박스를 하나하나씩 체크유무 검사를 마쳤을 때
          // 모든 체크박스가 체크가 되어진 상태이라면
             $("input:checkbox[id='agreeAll']").prop("checked", true);
            // "전체선택 / 전체해제 체크박스" 에 체크를한다.
         }
         
	     }
	     else {
	     	// 클릭한 체크박스가 체크가 해제가 되어진 상태라면
	        $("input:checkbox[id='agreeAll']").prop("checked", false);
	        // "전체선택 / 전체해제 체크박스" 에 체크를 해제한다.
	     }
      
   }); // end of $("div#firstDiv input:checkbox[name='person']").click( -----------
	
	
}// end of function func_usaCheck() {}----------------------------


// "가입하기" 버튼 눌렀을 때 호출되는 함수
function goRegister() {
	
// *** 필수입력사항에 모두 입력이 되었는지 검사하기 시작 *** //
   let b_requiredInfo = false;
	
   $("input.text").each(function(index, elmt){
      const data = $(elmt).val().trim();
      
      if(data == ""){
		  $(elmt).parent().css("border","1px solid red"); 
		  if(index==0) {
			 $("div.input_email").css("border","1px solid red");
		  }
		   	         
      }
      
   });
   if (b_requiredInfo == false) {
	   alert("필수 입력 사항을 확인해주세요")
   }
	
} // end of function goRegister() {}-----------------


// 연락처 "인증하기" 버튼 눌렀을 때 호출되는 함수
function sendMsgTel() {
	const mb_tel = $("input#mb_tel").val();
	let regPhone = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
	if(regPhone.test(mb_tel)) {
		confirm(mb_tel+" 전화번호로 인증번호를 발송하시겠습니까?");
	}
	else {
		alert("올바르지 않은 연락처 입니다.")
	}
}







