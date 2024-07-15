<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 

<%
    String ctxPath = request.getContextPath();
	//    /tempSemi
%>


<%-- Font Awesome 6 Icons --%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/wh/order_payment.css" />
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<jsp:include page="../jy/header_revised.jsp" />

<script type="text/javascript">

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
   
   
   /* $(document).on('click', "button#payment" , function(){

		
		const ctxPath = $("input:hidden[name='ctxPath']").val();
		
		
		goPay(userid, ctxPath);
		
		
		
		
	}); */
	
   
   
   
   
});// end of $(document).ready(function() {-----------------------------------------------

// === 결제 시작 === //
function goPay(userid, ctxPath){
	
	const payment_price = $("input.payment_price").val();
	console.log("payment_price => ", payment_price );
	// console.log("userid=>",userid);
		
	const width = 1200;
	const height = 800;
	
	
	// 포트원(구 아임포트) 결제 팝업창 띄우기
	const url = `\${ctxPath}/paymentPurchaseEnd.tam?payment_price=${payment_price}&userid=${userid}`;
	
	const left = Math.ceil((window.screen.width - width)/2);
	const top = Math.ceil((window.screen.height - height)/2);

	
	window.open(url, "paymentPurchaseEnd", 
			`left=${left}; top=${top}, width=${width}, height=${height}`);
				
				
				
}// end of function goCoinPurchaseTypeChoice(userid, ctx_Path) ----------------------


// === 포트원(구 아임포트) 결제를 해주는 함수 === //
function goPaymentPurchaseEnd(ctx_Path, payment_price, userid){
// alert(`확인용 부모창의 함수 호출함.\n결제금액 : ${coinmoney}원, 사용자id : ${userid}`)
	
// 포트원(구 아임포트) 결제 팝업창 띄우기
	
// 너비 1000, 높이 600 인 팝업창을 화면 가운데 위치시키기
const width = 1200;
const height = 800;

const left = Math.ceil((window.screen.width - width)/2);
const top = Math.ceil((window.screen.height - height)/2);

window.open(url, "paymentPurchaseEnd", 
			`left=${left}; top=${top}, width=${width}, height=${height}`);

}// end of function goCoinPurchaseEnd(coinmoney)------------------

// ==== DB 상의 tbl_user에 해당 사용자의 결제내역을 추가(insert)시켜주는 함수 === //
function goPayment_DB_Update(userid) {
	
	const frm = document.Payment_DB_Update_Frm;
	frm.method = "post";
	frm.action = "paymentUpdateLoginUser.tam";
	frm.submit();
	
	
	
	
	
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


function searchAddress () {
	
	b_searchAdd_click = true;
		// "우편번호찾기"를 클릭했는지 안했는지 여부를 알아오기 위한 용도.
		
        // 주소를 쓰기 가능으로 만들기
        $("input#address").removeAttr("readonly");
        
		
		new daum.Postcode({
    	oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            let addr = ''; // 주소 변수
            let extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                document.getElementById("extraaddress").value = extraAddr;
            
            } else {
                document.getElementById("extraaddress").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('postcode').value = data.zonecode;
            document.getElementById("address").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("detailaddress").focus();
        }
	}).open();		
		
		
		// 주소를 읽기전용(readonly) 로 만들기
        $("input#address").attr("readonly", true);
        
        
	
}








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





</script>
<title>주문/결제</title>

<body>
	<%-- === 결제를 하기 위한 폼을 생성 === --%>

	<c:if test="${not empty sessionScope.loginuser}">
		<form name="Payment_DB_Update_Frm">

			<div id="container" class="container">
				<div id="left" class="float-left">
					<div id="order_payment">

						<div id="payment_info_title">주문/결제</div>

								<div id="payment_process">

								<div id="buyer_info">
								<button type="button" class="btn mt-2 mb-2" data-toggle="collapse" data-target="#demo1">주문자 정보</button>
												<div id="demo1" class="collapse show">
									
													<div class="page_1">
														<section class="signup-section1">
															<div class="section_inner signup">
																<div class="input-item email">
																	
																	<div class="div_label input_label">
																		<label class="input_label" for="mb_id">이메일</label>
																	</div>
																	
																	<div class="input_email_container">
																		
																		<div class="input input_email" style="display: inline;">
																			<input type="text" class="text" id="mb_id" name="email1"
																				value="" maxlength=15 required
																				autocomplete="off" style="width: 30%;" />
																		</div>
																		
																		<div class="text_wrap" style="display: inline;">
																			<span style="cursor: default;">@</span>
																		</div>
																		
																		<div class="input_email_wrap" style="display: inline;">
																			
																			<div class="input input_email" style="display: inline;">
																				<input type="text" class="text" id="mb_email_suffix" name="email2" name="mb_email_suffix" value="" readonly style="width: 30%;">
																			</div>
																			
																			<div class="input div_select_email"
																				id="div_email-select"
																				style="cursor: default; display: inline;">
																				<select class="tam-select_input input_email"
																					id="email-select" style="width: 31%; height: 35px;">
																					<option value="" selected="" disabled="">옵션
																						선택</option>
																					<option value="naver.com" >naver.com</option>
																					<option value="hanmail.net">hanmail.net</option>
																					<option value="nate.com">nate.com</option>
																					<option value="gmail.com">gmail.com</option>
																					<option value="hotmail.com">hotmail.com</option>
																					<option value="hanmir.com">hanmir.com</option>
																					<option value="dreamwiz.com">dreamwiz.com</option>
																					<option value="lycos.co.kr">lycos.co.kr</option>
																					<option value="empas.com">empas.com</option>
																					<option value="direct" selected>직접 입력</option>
																				</select>
																			</div>
																		
																		
																		</div>
																	
																	</div>
																
																
																</div>
															</div>
			
			
															<div class="input-item name" style="margin-top: 5%;">
																<div class="div_label label_name">
																	<label class="input_label" for="mb_name">이름</label>
																</div>
																<div class="input input_name">
																	<input class="text" type="text" id="mb_name" value=""
																		name="name" maxlength="15" required style="width: 100%;" />
																</div>
															</div>
			
			
			
															<div class="input-item tel" style="margin: 5% 0;">
																<div class="div_label label_tel">
																	<label class="input_label" for="mb_tel">연락처</label>
																</div>
																<div class="input_tel_wrap" style="width: 100%;">
																	<div class="input tel" style="display: inline;">
																		<input style="width: 72%;" class="text" type="text"
																			id="mb_tel" name="mobile" class="input" value="" pattern="[0-9]*"
																			maxlength="13" oninput="onInputHandler_tel()" required />
																	</div>
																	<div class="input button_checkTel"
																		style="display: inline; width: 30%;">
																		<button type="button" class="button_checkTel"
																			id="send_msg_Tel" onclick="sendMsgTel()">인증하기</button>
																	</div>
																</div>
															</div>
			
			
			
															<%-- <div class="agree_list" style="margin-bottom: 5%;">
																<div class="checkbox-item">
																	<div>
																		<input type="checkbox" id="agreeAll"
																			class="checkbox-item"
																			onclick="func_allCheck(this.checked)" /><label
																			class="agree agreeAll" for="agreeAll"></label> 모두 동의합니다.
																	</div>
																</div>
			
																<div class="checkbox-item">
																	<div style="font-size: 9px;">
																		<input type="checkbox" name="agree" id="agreeAge"
																			class="checkbox-item" onclick="func_agreeCheck()" /><label
																			class="agree" for="agreeAge" style="font-size: 9px;"></label>
			
																		(필수) 개인정보처리방침 <a style="font-size: 9px;">자세히 보기</a>
																	</div>
			
																</div>
			
																<div class="checkbox-item">
																	<div style="font-size: 9px;">
																		<input type="checkbox" name="agree" id="agreeAge"
																			class="checkbox-item" onclick="func_agreeCheck()" /><label
																			class="agree" for="agreeAge" style="font-size: 9px;"></label>
			
																		(필수) 이용약관 동의 <a style="font-size: 9px;">자세히 보기</a>
																	</div>
			
																</div>
															</div> --%>
			
															<button id="nextLevel" name="nextLevel" type="button"
																onclick="">저장하고 다음 단계로</button>
			
														</section>
													</div>

												</div>
											
											</div>
							
										</div>


											<div id="shipping_info">
												<button type="button" class="btn mt-2 mb-2"
													data-toggle="collapse" data-target="#demo2"
													style="text-align: left;">배송 정보</button>
												<div id="demo2" class="collapse">
				
				
													<div class="page_2">
														<section class="signup-section2">
				
				
				
				
															<div class="input name" style="margin: 8% 0;">
																<div class="div_label label_name">
																	<label class="input_label" for="name">수령인</label><a
																		style="font-size: 11px; float: right; margin-top: 1%; line-height: 13px; border-bottom: solid 1px gray;">주문자
																		정보와 동일</a>
																</div>
																<div class="input input_name">
																	<input class="text" type="text" id="name" name="sh_name" maxlength="15"
																		required style="width: 100%;">
																</div>
															</div>
				
															<div class="input tel" style="margin: 13% 0;">
																<div class="div_label label_tel">
																	<label class="input_label" for="tel">연락처</label>
																</div>
																<div class="input_tel_wrap">
																	<div class="input tel">
																		<input class="text" type="text" id="tel" name="sh_mobile" class="input"
																			value="" pattern="[0-9]*" maxlength="13"
																			oninput="onInputHandler_tel()" required
																			style="width: 100%; text-align: left;" />
																	</div>
																</div>
															</div>
				
															<div class="input address" style="margin: 13% 0;">
																<div class="div_label label_address">
																	<label class="input_label" for="address">배송주소</label><a
																		style="font-size: 10px; float: right; margin-top: 1%; line-height: 13px; border-bottom: solid 1px gray;">최근배송지</a>
																</div>
																<div class="input_address_wrap" style="width: 100%;">
																	<div class="input Address" style="display: inline;">
																		<input type="hidden" class="text" name="postcode" id="postcode" size="6" maxlength="5"/>
																		<input style="width: 65%;" class="text" type="text"
																			id="address" name="address" 
																			placeholder="예) 서교동 아지오빌딩, 와우산로" onclick="searchAddress()" required />
																	</div>
																	<div class="input AddressSearch"
																		style="display: inline; width: 40%;">
																		<button type="button" class="button_addressSearch"
																			id="addressSearch" onclick="searchAddress()">검색</button>
																	</div>
																	<div class="input detailAddress" style="margin-top: 1%;">
																		<input type="text" id="detailAddress" name="detailAddress"
																			placeholder="나머지 주소 입력" style="width: 100%;" />
																	</div>
																</div>
															</div>
				
															<div class="input message"
																style="margin-top: 26%; margin-bottom: 18%;">
																<div class="div_label label_message">
																	<label class="input_label" for="message">기사님께 전하는
																		메시지</label>
																</div>
																<div class="input input_message">
																	<input class="text" type="text" id="message" name="tomsg" maxlength="20"
																		required style="width: 100%;">
																</div>
															</div>
				
															<button id="nextLevel" name="nextLevel" type="button"
																onclick="">저장하고 다음 단계로</button>
														</section>
													</div>
				
												</div>
				
											</div>




											<div id="payment_method_info">
												<button type="button" class="btn mt-2 mb-2"
													data-toggle="collapse" data-target="#demo3"
													style="text-align: left;">결제 수단</button>
												<div id="demo3" class="collapse">
				
													<div id="payment_info" style="width: 56%; margin: 0 auto; text-align: center;">
				
														<button id="creditcard" name="creditcard" type="button">
															신용카드</button>
																		<%-- 
																			<div class="agree_list" style="margin-top: 15%; text-align: left; padding-left: 3%;">
																				<div class="checkbox-item mb-2">
																					<div style="font-size: 13px;">
																						<input type="checkbox" id="agreeAll" class="checkbox-item"
																							onclick="func_allCheck(this.checked)" /><label
																							class="agree agreeAll" for="agreeAll"></label> 모두 동의합니다.
																					</div>
																				</div>
									
																				<div class="checkbox-item">
																					<div style="font-size: 11px;">
																						<input type="checkbox" name="agree" id="agreeAge"
																							class="checkbox-item" onclick="func_agreeCheck()" /><label
																							class="agree" for="agreeAge"></label> (필수) 본인은 만 14세 미만이
																						아닙니다.
																					</div>
																				</div>
									
																				<div class="checkbox-item" style="font-size: 11px;">
																					<div style="font-size: 11px;">
																						<input type="checkbox" name="agree" id="agreeAge"
																							class="checkbox-item" onclick="func_agreeCheck()" /><label
																							class="agree" for="agreeAge"></label> (필수) <a
																							style="font-size: 11px; border-bottom: solid 1px #343434;">이용약관</a>에
																						동의합니다.
																					</div>
																				</div>
									
																				<div class="checkbox-item" style="font-size: 11px;">
																					<div style="font-size: 11px;">
																						<input type="checkbox" name="agree" id="agreeAge"
																							class="checkbox-item" onclick="func_agreeCheck()" /><label
																							class="agree" for="agreeAge"></label> (필수) <a
																							style="font-size: 11px; border-bottom: solid 1px #343434;">개인정보처리방침</a>에
																						동의합니다.
																					</div>
																				</div>
									
																				<div class="checkbox-item" style="font-size: 11px;">
																					<div style="font-size: 11px;">
																						<input type="checkbox" name="agree" id="agreeAge"
																							class="checkbox-item" onclick="func_agreeCheck()" /><label
																							class="agree" for="agreeAge"></label> (필수) 위 주문의 상품, 가격,
																						할인, 배송 정보에 동의합니다.
																					</div>
																				</div>
									
																			</div>
																			--%>
				
															 <button id="payment" name="payment" type="button" onclick="javascript:goPay('${(sessionScope.loginuser).userid}', '<%= ctxPath%>')">결제하기</button>
															<%--<button id="payment" name="payment" type="button">결제하기</button>--%>
														</div>
								
													</div>
												</div>
											</div>
										</div>
											
											
											
											<%-- PG(Payment Gateway 결제대행)에 코인금액을 카드(카카오페이등)로 결제후 DB상에 사용자의 코인액을 update 를 해주는 폼이다. --%>
											<input type="hidden" name="userid" value='${(sessionScope.loginuser).userid}'/> 
											<input type="hidden" name="ctxPath" value='<%= ctxPath%>'/>






		


										<div id="right" style="border: solid 0px blue; width: 31%; display: flex; margin-top: 7%;" class="float-right">
								
											<div id="payment_detail" style="width: 100%">
								
												<div id="payment_info_title" style="width: 100%; font-size: 17px; font-weight: 600;">결제내역</div>
												<c:set var="total" value="0" />
												<c:forEach items="${requestScope.orderList}" var="item">
													<div id="order_item">
														<input name="itemno" class="itemno" type="hidden"
															value="${item.fk_it_seq_no}" />
														<div id="cart_product_mini_photo" style="width: 22%; float: left">
															<img src="<%=ctxPath%>/images/wh/${item.imgvo.img_file}"
																class="img-fluid mt-4" style="border-radius: 3px;">
														</div>
								
														<div id="order_item_info">
															<div id="cart_product_name">
																<span style="font-weight: 600;">${item.ivo.it_name}</span> <span
																	class="item_volume order_qty">${item.ivo.it_volume} /
																	${item.order_qty} 개 </span>
															</div>
														</div>
								
														<div id="order_product_price" style="text-align: left;">
															<span class="item_price"><fmt:formatNumber
																	value="${item.ivo.it_price*item.order_qty}" pattern="#,###" />
																원</span>
														</div>
													</div>
													<c:set var="total"
														value="${total + item.ivo.it_price*item.order_qty}" />
												</c:forEach>
								
								
												<div id="price_sum">
													<div id="payment_price">
														<span style="font-size: 11px; font-weight: 500;">주문 금액</span>
													</div>
								
													<div id="product_price">
														<span style="font-size: 11px; font-weight: 600;"><fmt:formatNumber
																value="${total}" pattern="#,###" /> 원</span>
													</div>
												</div>
								
												<div id="price_ship">
													<div id="delivery_charge">
														<span style="font-size: 11px; font-weight: 500;">배송비</span>
													</div>
								
													<div id="delivery_price">
														<span style="font-size: 11px; font-weight: 600;"> + 0 원 </span>
													</div>
												</div>
								
								
												<div id="price_total">
													<div id="payment_all_price">
														<span style="font-size: 13px; font-weight: 600;">총 금액</span>
													</div>
								
													<div id="product_sum_price">
														<span style="font-size: 13px; font-weight: 600;"><fmt:formatNumber
																value="${total}" pattern="#,###" /> 원</span>
													</div>
												</div>
												<input type="hidden" class='payment_price' name="payment_price" value="${total}"/>
								
											</div>
								
										</div>

	</div>
	

</form>
</c:if>

<jsp:include page="../jh/footer.jsp" />

</body>
</html>