

$(document).ready(function(){
	const ctxPath = $("input.ctxPath").val();
	
	// 리뷰 작성하기 버튼을 클릭했다.
	$(document).on("click", "button.product_review_btn", function(e){
		
		const index = $("tr.product_detail").index($(e.target).parent().parent());
	//	alert('$("tr.product_detail").eq(index) => '+ $("tr.product_detail").eq(index));
		// 8
		const targetTag = $("tr.product_detail").eq(index);
		
		const product__name = targetTag.find("li.product__name").text();  // 상품명
		const product__volume = targetTag.find("span.product__volume").text(); // 용량
		const img_file = targetTag.find("input.modal_img_file").val(); // 이미지		
		const o_detail_seq_no = targetTag.find("input.modal_o_detail_seq_no").val(); // 주문상세일련번호
		
		$("div.review_product_name").text(product__name); // 제품명
		$("div.review_product_volume").text(product__volume); // 제품 용량
		$("img.review_product_image").attr("src", img_file); // 이미지
		$("input#o_detail_seq_no").val(o_detail_seq_no); // $.ajax 보낼 주문상세일련번호
		
		let html = `<button type="button" class="tam_btn review__btn" >작성하기</button>`
		         + `<button type="button" class="tam_btn my_close" data-dismiss="modal" >취소하기</button>`;
        
		$("div.modal-footer").html(html);
		
		let exist;
		
		$.ajax({
			url:ctxPath+"/myshop/reviewExistCheck.tam",
			type:"post",
			data:{
				"o_detail_seq_no":o_detail_seq_no
			},
			async:false,
			dataType:"json",
			success:function(json){
				// json {"existCheck":true} 또는 {"existCheck":false}
			//	console.log(JSON.stringify(json));
				
				if(json.existCheck) {
				// 작성한 리뷰가 존재
					exist = true;
				}
				else{
				// 리뷰가 없음	
					exist = false;
				}
			},
			error:function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
			
		});// end of $.ajax -------------------
		
		
		if(exist) {
		// 리뷰가 이미 존재한다.
			// plan.1
		//	alert("해당 주문의 리뷰는 이미 작성되었습니다.");
		
			// plan.2
			if(confirm("해당 주문은 리뷰를 이미 작성하였습니다. \n작성한 리뷰를 확인하시겠습니까?")) {
			// 내가 작성한 리뷰 확인
				
				$.ajax({
					url: ctxPath + "/myshop/selectMyReview.tam",
					type: "post",
					data: {
						"o_detail_seq_no": o_detail_seq_no
					},
					async: false,
					dataType: "json",
					success: function(json) {
						// json {"existCheck":true} 또는 {"existCheck":false}
						//	console.log(JSON.stringify(json));
						$("textarea.review_contents").text(json.re_content);
					},
					error: function(request, status, error) {
						alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
					}
			
				});// end of $.ajax -------------------
				
				let html = `<button type="button" class="tam_btn delete__btn" >삭제하기</button>`
						 + `<button type="button" class="tam_btn update__btn" >수정하기</button>`
						 + `<button type="button" class="tam_btn my_close" data-dismiss="modal">취소하기</button>`
						 
				$("div.modal-footer").html(html);

				$("input.modal_btn").trigger("click");
				
			}
			else{
			// 아무것도 안하겠다.
			}
		
		}
		else {
		// 리뷰가 없다.
		
			if(confirm("작성된 리뷰가 없습니다 리뷰를 작성하시겠습니까?\n작성된 리뷰는 삭제 또는 수정이 가능합니다.")){
			// 리뷰를 작성하겠다.
			
				let html = `<button type="button" class="tam_btn review__btn " >작성하기</button>`
						 + `<button type="button" class="tam_btn my_close" data-dismiss="modal">취소하기</button>`
						 
				$("div.modal-footer").html(html);
				
				$("input.modal_btn").trigger("click");
			//	console.log(`product__name => ${product__name}\nproduct__volume => ${product__volume}\nmodal_o_detail_seq_no => ${modal_o_detail_seq_no}\nmodal_img_file => ${modal_img_file}`);
			
			/*
				product__name => 000
				product__volume => 65mL
				modal_o_detail_seq_no => 9601229601221237
				modal_img_file => /tempSemi/images/db/mypage/th_000.jpg
			*/
				// -- 모달 div
				
				
			}

		}
	
	}); // end of $(document).on("click", "button.product_review_btn", function(e) ----- 리뷰 작성 하기 버튼
	
	
	
	// 모달창의 리뷰 "작성하기" 클릭시 발생 이벤트
	$(document).on("click", "button.review__btn", function(){
		// 리뷰 내용
		const re_content = $("textarea.review_contents").val();
		
		const o_detail_seq_no = $("input#o_detail_seq_no").val();
		
		if(re_content.length > 200) {
			alert("200글자 이하의 리뷰만 작성할 수 있습니다.");
			return;
		}
		else {
					// 리뷰작성하는
			$.ajax({
				url:ctxPath+"/myshop/writeReivew.tam",
				type:"post",
				data:{"re_content":re_content,
					  "o_detail_seq_no":o_detail_seq_no
				},
				async:false,
				dataType:"json",
				success:function(json){
					if(json.result == 1) {
						alert("고객님의 소중한 의견 감사합니다.");
					}
					else {
						alert("시스템 오류가 발생했습니다.");
					}
					
				},
				error:function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
				
			})// end of $.ajax -------------------
			$("button.my_close").trigger("click");
			history.go(0);
		}
		
	});// end of $(document).on("click", "button.review__btn", function() ------------

	
	
	// "삭제하기" 버튼을 클릭시 이벤트 
	$(document).on("click","button.delete__btn",function(){
		
		if( confirm("작성하신 리뷰를 삭제하시겠습니까?") ) {
			const o_detail_seq_no = $("input#o_detail_seq_no").val();
		//	console.log("o_detail_seq_no => ", o_detail_seq_no);
		
			$.ajax({
				url:ctxPath+"/myshop/reivewDel.tam",
				type:"post",
				data:{"o_detail_seq_no":o_detail_seq_no},
				async:false,
				dataType:"json",
				success:function(json){
					
					if(json.result == 1) {
						alert("작성한 리뷰가 삭제되었습니다.")
					}
					else {
						alert("시스템 오류가 발생했습니다.");
					}
					
					history.go(0);
					
				},
				error:function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
				
			})// end of $.ajax -------------------
			
		} // end of if( confirm("작성하신 리뷰를 삭제하시겠습니까?") ) --------------
		
	}); // end of $(document).on("click","btn.delete__btn",function() -------------
	
	
	
	// "수정하기" 버튼을 클릭시 이벤트
	$(document).on("click","button.update__btn",function(){
		
		const o_detail_seq_no = $("input#o_detail_seq_no").val();
		const re_content = $("textarea.review_contents").val();
	//	console.log("o_detail_seq_no => ", o_detail_seq_no);
	//	console.log("re_content => ", re_content);
	
		if(re_content.length > 200) {
			alert("200글자 이하의 리뷰만 작성할 수 있습니다.");
			return;
		}
		else {
		// 글자수 200 이하
			$.ajax({
				url:ctxPath+"/myshop/reivewUpdate.tam",
				type:"post",
				data:{"re_content":re_content,
					  "o_detail_seq_no":o_detail_seq_no
				},
				async:false,
				dataType:"json",
				success:function(json){
					
					if(json.result == 1) {
						alert("고객님의 리뷰가 수정되었습니다.");
					}
					else {
						alert("시스템 오류가 발생했습니다.");
					}
					
					history.go(0);
				},
				error:function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
			}); // end of $.ajax ------------------
		}
	}); // end of $(document).on("click","btn.delete__btn",function() -------------	
	
	
	
}); // end of $(document).ready(function() -------------



