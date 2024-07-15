

$(document).ready(function(){
	
	let name;
	let postcode;
	let adrress;
	let detail_address;
	let user_mobile;
	
	let html = ``;
	
	let btn_status = 1;
	
	// up_date__address 버튼 클릭시
	$("button#up_date__address").bind("click", ()=>{
		
		if(btn_status == 1) {
		// "수정하기" 버튼 클릭
			// 버튼색 검은색으로
			$("button#up_date__address").addClass("active__btn").text("수정완료");
			
			// 결제 정보 회색 처리
			$("td.payment__info").addClass("out__");
			
			// "취소하기" => "수정취소"
			$("button#reset__").text("수정취소");
			
			$("button#reset__").prop("disabled",false).addClass("white__");
			
			// ** -- 주소 찾기 카카오로 대체 -- ** //
			name = $("span#name").text();
			postcode = $("span#postcode").text();
			adrress = $("span#adrress").text();
			detail_address = $("span#detail_address").text();
			user_mobile = $("span#user_mobile").text();
			
			html =	`<li id="user__name__li" class="bar__"><input type="text" id="name" name="sh_name" value="${name}"></input></li>
					 <li id="user__address1" class="bar__"><input type="text" id="postcode" name="sh_postcode" value="${postcode}" onclick="openDaumPOST()" readonly ></input>&nbsp;<input type="text" id="address" name="sh_address" value="${adrress}" onclick="openDaumPOST()" readonly ></input></li>
					 <li id="user__address2" class="bar__"><input type="text" id="detailAddress" name="sh_detailaddress" value="${detail_address}" ></input></li>
					 <li id="user__mobile__li"><input type="text" id="user_mobile" name="sh_mobile" value="${user_mobile}"></input></li>`
		
			$("ul#user__address__info").html(html);
			
			
			btn_status = 2;
		}
		else if (btn_status == 2) {
		// "수정완료" 버튼 클릭
			// 값을 넣어준다.
			const order_seq_no = $("span#order__no").text();
			const name = $("input#name").val();
			const postcode = $("input#postcode").val();
			const address = $("input#address").val();
			const detailAddress = $("input#detailAddress").val();
			const user_mobile = $("input#user_mobile").val();
			const extraAddress = $("input#extraAddress").val();
		/*
			console.log("order_seq_no => ", order_seq_no);
			console.log("name => ", name);
			console.log("postcode => ", postcode);
			console.log("address => ", address);
			console.log("detailAddress => ", detailAddress);
			console.log("user_mobile => ", user_mobile);
			console.log("extraAddress =>", extraAddress)
		*/	
			
			$.ajax({
				url:"mapageDeliverAddressUpdate.tam",
				type:"post",
				data:{"order_seq_no":order_seq_no,
					  "name":name,
					  "postcode":postcode,
					  "address":address,
					  "detailAddress":detailAddress,
					  "user_mobile":user_mobile,
					  "extraAddress":extraAddress},
				dataType:"json",
				success:function(json){
					
					if(json.UpdateCheck) {
						alert("배송지 변경이 완료되었습니다.");
						
					}
					else{
						alert("배송지 변경이 실패하였습니다.");
						
					}
					
				},
				error:function(request, status, error) {
					alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
				}
				
			}); // end of $.ajax({
			
			html = `<li id="user__name__li"><span id="name">${name}</span></li>
					<li id="user__address1"><span id="postcode">${postcode}</span>&nbsp;<span id="adrress">${address}</span></li>
					<li id="user__address2"><span id="detail_address">${detailAddress}</span></li>
					<li id="user__mobile__li"><span id="user_mobile">${user_mobile}</span></li>`;
			
			$("ul#user__address__info").html(html);
					
			// 검은색 테마 지우기
			$("button#up_date__address").removeClass("active__btn").text("수정하기");
			
			// 회색 지우기
			$("td.payment__info").removeClass("out__");
			
			// "취소하기"로 변경
			$("button#reset__").text("취소하기");
			
			btn_status = 1; // 처음 상태로 돌아간다.
		}
		else if(btn_status == 3) {
		// "뒤로가기" 클릭
			// 검은색 제거
			$("button#reset__").removeClass("active__btn").text("취소하기");
			
			// "뒤로가기" => "수정하기"
			$("button#up_date__address").text("수정하기");
			
			// 사유 select 태그 제거
			$("div#select__div").empty();
			
			btn_status = 1;
		}
	 
	});	// end of $("button#up_date__address").bind("click", ()=>{
	
	
	
	// reset__ 버튼 클릭시
	$("button#reset__").bind("click", () => {
		
		if (btn_status == 2) {
		// "수정취소" 클릭
			// 검은색 테마 지우기
			$("button#up_date__address").removeClass("active__btn").text("수정하기");
			
			// 회색 지우기
			$("td.payment__info").removeClass("out__");
			
			// "취소하기"로 변경
			$("button#reset__").text("취소하기");
			
			$("button#reset__").prop("disabled",true).removeClass("white__");
			
			// 수정 하기 전의 값들이 원래 태그의 위치로 들어와야한다.
			html = `<li id="user__name__li"><span id="name">${name}</span></li>
					<li id="user__address1"><span id="postcode">${postcode}</span>&nbsp;<span id="adrress">${adrress}</span></li>
					<li id="user__address2"><span id="detail_address">${detail_address}</span></li>
					<li id="user__mobile__li"><span id="user_mobile">${user_mobile}</span></li>`;
							
			$("ul#user__address__info").html(html);
			
			btn_status = 1;
		}
		
	
	}); // end of $("button#name__").bind("click", function(){
	
	
	
	
	// --- 주문상세페이지에서 진행상황이 "배송중", "배송완료"상태가 포함되어 있다면 주소지 변경 버튼이 없어진다. --- //
	const status_list = $("div.order__status");
//	console.log("status_list => ", status_list);
	// status_list =>  ce.fn.init(4)
	
	status_list.each(function(index, item){
		const status = item.innerText;
		
		if(status == "배송중" || status == "배송완료") {
			
			$("div#up__reset").empty();
			
			return false;	
		}
		
	}); // end of status_list.each(function(index, item){

	
	
	
	
}); // end of $(document).ready(function(){
	
	
	
function openDaumPOST() {
	
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
			if (data.userSelectedType === 'R') {
				// 법정동명이 있을 경우 추가한다. (법정리는 제외)
				// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
				if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
					extraAddr += data.bname;
				}
				// 건물명이 있고, 공동주택일 경우 추가한다.
				if (data.buildingName !== '' && data.apartment === 'Y') {
					extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
				}
				// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
				if (extraAddr !== '') {
					extraAddr = ' (' + extraAddr + ')';
				}
				// 조합된 참고항목을 해당 필드에 넣는다.
				document.getElementById("extraAddress").value = extraAddr;

			} else {
				document.getElementById("extraAddress").value = '';
			}

			// 우편번호와 주소 정보를 해당 필드에 넣는다.
			document.getElementById('postcode').value = data.zonecode;
			document.getElementById("address").value = addr;
			// 커서를 상세주소 필드로 이동한다.
			document.getElementById("detailAddress").focus();
		}
	}).open();

} // end of function openDaumPOST() ---------------