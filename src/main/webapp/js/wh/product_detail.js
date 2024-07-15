$(document).ready(function(){
	$("div#hide_product_price").hide();
	$("div#hide_all_price").hide();
	$("div#discription_full").hide();
	$("div#itemNoCopy").hide();
	$("div#userid").hide();
	$("div#cart_null").hide();
	$("div#it_seq_no").hide();
	
	
	/*
	
	const get_it_seq_no = $("input[name='page__it_seq_no']").val();

    // 화면이 로드 되면 현재 페이지 상품의 좋아요 수를 가지고 온다.
    getLike(get_it_seq_no); 
    
    */
	
	
	
	// 더보기 클릭 시 상세설명을 펼쳐주는 메소드
	$("span#fullview").click(function(){
		goFull();
	});
	
	$("div#cart").hide();


	$("div#container").click(function(e){
		if(!$(e.target).is("button#putCart")) {
			$("div#cart").hide()
		}
	});
	
	///////////////////////////////////////////////////////////////
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}); // end of $(document).ready(function()-----------------------------------

// 주문하기 버튼 클릭 시 장바구니에 담긴 내용을 쇼핑백 탭으로 보내주는 메소드
function goOrder(userid) {
	const frm = document.cartFrm;
	//console.log("userid => ",userid);
	//console.log("typeof userid => ",typeof(userid));
	// login한 상태로 주문하기 클릭한 경우
	
	
	
	if(userid != null){
		
		let s_cart = sessionStorage.getItem("cartData");
				// [{"kkk":jjj,"iii":kkk}]
				
	    let cart_arr = JSON.parse(s_cart);
		
		let arr_fk_it_seq_no = [];
		let arr_order_qty = [];

		
		for(let i = 0; i<cart_arr.length; i++) {
			
			arr_fk_it_seq_no.push(cart_arr[i].fk_it_seq_no)
			arr_order_qty.push(cart_arr[i].order_qty)
			
		}
		
		
		
			$.ajax({
			url:"cartInsertJSON.tam",
			type:"post",
			data:{"userid":userid,
				  "arr_fk_it_seq_no_join":arr_fk_it_seq_no.join(),
				  "arr_order_qty_join":arr_order_qty.join()
				  },	
			dataType:"json",
			success:function(json){
			
			console.log(json.isSuccess);
			
				if(json.isSuccess == 1) {
					frm.method = "post";
					frm.action = "cart_detail.tam";
					frm.submit();
				}
				else{
					alert("오류발생!!");
					
				}
				
			},
			error: function(request, status, error){
	          alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        }
		});			
			
	
		
		
	}
	
	// login하지 않은 상태로 주문하기 클릭한 경우
	else if(userid == null){
		
		frm.method = "get";
		frm.action = "login.tam";
		frm.submit();
		
		
		
	}
	
	
	
}


// 더보기 클릭 시 상세설명을 펼쳐주는 메소드
function goFull() {
	
	$("div#discription_simple").empty();
	$("div#discription_full").show();
	
}


//장바구니에 담기 버튼 클릭 시 tbl_cart에 제품번호 insert 해주기
function insertInfoCart(it_seq_no) {
	
	const item_imgfile = $("input#imagefile").val();
	const item_name = $("div#product_name").text();
	const item_price = $("div#hide_product_price").text();
	const item_category = $("span.item_category").text();
	
	let cart_item = {
					  fk_it_seq_no : Number(it_seq_no),
					  order_qty : 1,
					  it_name : item_name.trim(),
					  it_price : Number(item_price.trim()),
					  img_file : item_imgfile,
					  item_category : item_category
					}
		
		
			if( sessionStorage.getItem("cartData") != null ) {
				
				const s_cart = sessionStorage.getItem("cartData");
				// [{"kkk":jjj,"iii":kkk}]
				
				const cart = JSON.parse(s_cart);
				// console.log(cart);
				
				let isOKduplication = false;
				
				
				// 기존 sessionStorage에 저장되어있는 제품 정보를 한 번더 장바구니에 담기를 클릭하면 세션스토리지에 똑같은 객체가 쌓이므로 기존의 저장되어있는 객체를 지우고 새로운 객체를 수량만 1 더한채로 넣기위함.
				// 세션스토리지에 저장되어있는 제품 정보 객체
				let numberUpdate = cart.find( function(item, index, array){
							//item 은 필수
							if(item.fk_it_seq_no == it_seq_no) {
								isOKduplication = true;
								item.order_qty = item.order_qty + 1;
								return item;
							}				
						});
						
				
				// console.log("isOKduplication => ", isOKduplication);
					if(isOKduplication) {
							
										
										// 세션스토리지에 저장되어있는 제품 정보 객체의 index
										let idx = cart.findIndex(item => item.fk_it_seq_no == it_seq_no);
										// console.log(idx);
										
										// console.log(cart[idx].fk_it_seq_no);
										
										// 내가 현재 위치하고 있는 상세페이지의 제품 번호가 세션스토리지에 저장된 데이터에 이미 존재할 경우
										
											
										// cart[idx] = numberUpdate;
										cart.splice(idx, 1, numberUpdate);
										
										// [{},{}]
										sessionStorage.setItem("cartData", JSON.stringify(cart));
					
						
					}
				    
				    else {
							cart.push(cart_item);
							// [{},{}]
							sessionStorage.setItem("cartData", JSON.stringify(cart));
						
					}
			}
			else {
				// 기존 세션스토리지에 아무 정보가 안담겨있으면
				const cart = [];
				
				cart.push(cart_item);
				
				// 받아와서 만들 배열 넣어주기

				sessionStorage.setItem("cartData",JSON.stringify(cart));			
				
			}
		
		
			let storedCartData = sessionStorage.getItem("cartData");
			// console.log("storedCartData => ",storedCartData );
			let cartDataList = JSON.parse(storedCartData);
			// console.log("cartDataList => ",cartDataList );
			
			
			let totalSum = 0; 
			
			html = ``;
			v_html = ``;
			$.each(cartDataList, function(index,item){
				html += `
								<div id="cart_item1">
				
									<input type="checkbox" class="chkboxinum" name="inum" id="inum${index}" /><label for="item"></label>
									<div id="cart_product_mini_photo">
										<img src="/tempSemi/images/wh/${item.img_file}"
											class="img-fluid mt-4" alt="Responsive image" />
									</div>
									
									<input type="hidden" class="itemno" name="itemno"
									value="${item.fk_it_seq_no}" />
									
									<input type="hidden" class="indexno" name="indexno"
									value="${index}" />
									
										
									<div id="cart_item_info">
										<div id="cart_product_name">
											<span id="cart_item_name" class="cart_item_name">${item.it_name}</span> 
											
											
											
											<select class="quantity" name="quantity" onchange="updateInfoCart(this)">
												<option value="1" ${item.order_qty === 1 ? 'selected' : ''}>1</option>
												<option value="2" ${item.order_qty === 2 ? 'selected' : ''}>2</option>
												<option value="3" ${item.order_qty === 3 ? 'selected' : ''}>3</option>
												<option value="4" ${item.order_qty === 4 ? 'selected' : ''}>4</option>
												<option value="5" ${item.order_qty === 5 ? 'selected' : ''}>5</option>
												<option value="6" ${item.order_qty === 6 ? 'selected' : ''}>6</option>
												<option value="7" ${item.order_qty === 7 ? 'selected' : ''}>7</option>
												<option value="8" ${item.order_qty === 8 ? 'selected' : ''}>8</option>
												<option value="9" ${item.order_qty === 9 ? 'selected' : ''}>9</option>
												<option value="10" ${item.order_qty === 10 ? 'selected' : ''}>10</option>
												<option value="11" ${item.order_qty === 11 ? 'selected' : ''}>11</option>
												<option value="12" ${item.order_qty === 12 ? 'selected' : ''}>12</option>
												<option value="13" ${item.order_qty === 13 ? 'selected' : ''}>13</option>
												<option value="14" ${item.order_qty === 14 ? 'selected' : ''}>14</option>
												<option value="15" ${item.order_qty === 15 ? 'selected' : ''}>15</option>
											</select>
										
							  </div>
				
										<div id="cart_product_price">
											<span id='cart_in_price'><label id="price">${(item.it_price*item.order_qty).toLocaleString('en')}</label>
												원</span>
											<div>
												<span id="delete" class="delete" onclick="deleteInfoCart()">삭제</span>
											</div>
										</div>
									</div>
								</div>
							`;
							
					
							
					const itemTotal = item.it_price * item.order_qty;
    				totalSum += itemTotal;		
							
					
					v_html = `
							    
							<div id="all_price">
								<span id='all_price'>총 금액</span>
							</div>
							<div id="product_price_sum">
								<span><label id="price_sum">${totalSum.toLocaleString('en')}</label> 원</span>
							</div>
							
							
							
							
							`;
					
							
			});// end of $.each(json, function(index,item)-------------------------------------
			
			
			$("div#item").html(html);
			$("div#cart_price_info").html(v_html);
			
			$("div#cart").show();
			
			
						
			
			
			
				
	
	
	
}









// 장바구니의 select 의 옵션을 변경 할 때마다 tbl_cart의 제품 수량 update 해주기
function updateInfoCart(obj) {
	
	const index = $("select.quantity").index(obj);
	//console.log(" index=> ",index)
	const itemno = $("input.itemno").eq(index).val();	// 제품번호
	//console.log("itemno => ",itemno)
	const quantity = $("select.quantity").eq(index).val(); // select 에서 선택한 수량
	//console.log("quantity => ",quantity)
	// const it_seq_no = $("div#it_seq_no").text();
	
	
				   
				let s_cart = sessionStorage.getItem("cartData");
				// [{"kkk":jjj,"iii":kkk}]
				// console.log("s_cart => ",s_cart)
				let p_cart = JSON.parse(s_cart);
				
				// console.log("p_cart => ",p_cart);
				
				// 기존 sessionStorage에 저장되어있는 제품 정보를 한 번더 장바구니에 담기를 클릭하면 세션스토리지에 똑같은 객체가 쌓이므로 기존의 저장되어있는 객체를 지우고 새로운 객체를 수량만 1 더한채로 넣기위함.
				// 세션스토리지에 저장되어있는 제품 정보 객체
				let qtyUpdate = p_cart.find( function(item, index, array){
							//item 은 필수
							if(item.fk_it_seq_no == itemno) {
								item.order_qty = Number(quantity);
								return item;
							}				
						});
				
				// console.log(" qtyUpdate=> ",qtyUpdate)
					
							
				// console.log(number);
				// console.log(number.fk_it_seq_no);
				// 세션스토리지에 저장되어있는 제품 정보 객체의 index
				let idx = p_cart.findIndex(item => item.fk_it_seq_no == itemno);
				//console.log(" idx=> ",idx)
				
					
				p_cart.splice(idx, 1, qtyUpdate);
				//console.log(" p_cart.splice(idx, 1, qtyUpdate)=> ",p_cart.splice(idx, 1, qtyUpdate))
				
				// [{},{}]
				
				sessionStorage.setItem("cartData",JSON.stringify(p_cart));

				
				let storedCartData = sessionStorage.getItem("cartData");
				
			
				let cartDataList = JSON.parse(storedCartData);
				// console.log(" spliced_cartDataList=> ",cartDataList)
				let totalSum = 0; 
				html = ``;
				v_html = ``;
					
				
			
			
				$.each(cartDataList, function(index,item){
				html += `
							
								
								<div id="cart_item1">
				
									<input type="checkbox" class="chkboxinum" name="inum" id="inum${index}" /><label for="item"></label>
									<div id="cart_product_mini_photo">
										<img src="/tempSemi/images/wh/${item.img_file}"
											class="img-fluid mt-4" alt="Responsive image" />
									</div>
									
									<input type="hidden" class="itemno" name="itemno"
									value="${item.fk_it_seq_no}" />
									
									<input type="hidden" class="indexno" name="indexno"
									value="${index}" />
									
										
									<div id="cart_item_info">
										<div id="cart_product_name">
											<span id="cart_item_name" class="cart_item_name">${item.it_name}</span> 
											<select class="quantity" name="quantity" onchange="updateInfoCart(this)">
												<option value="1" ${item.order_qty === 1 ? 'selected' : ''}>1</option>
												<option value="2" ${item.order_qty === 2 ? 'selected' : ''}>2</option>
												<option value="3" ${item.order_qty === 3 ? 'selected' : ''}>3</option>
												<option value="4" ${item.order_qty === 4 ? 'selected' : ''}>4</option>
												<option value="5" ${item.order_qty === 5 ? 'selected' : ''}>5</option>
												<option value="6" ${item.order_qty === 6 ? 'selected' : ''}>6</option>
												<option value="7" ${item.order_qty === 7 ? 'selected' : ''}>7</option>
												<option value="8" ${item.order_qty === 8 ? 'selected' : ''}>8</option>
												<option value="9" ${item.order_qty === 9 ? 'selected' : ''}>9</option>
												<option value="10" ${item.order_qty === 10 ? 'selected' : ''}>10</option>
												<option value="11" ${item.order_qty === 11 ? 'selected' : ''}>11</option>
												<option value="12" ${item.order_qty === 12 ? 'selected' : ''}>12</option>
												<option value="13" ${item.order_qty === 13 ? 'selected' : ''}>13</option>
												<option value="14" ${item.order_qty === 14 ? 'selected' : ''}>14</option>
												<option value="15" ${item.order_qty === 15 ? 'selected' : ''}>15</option>
											</select>
										</div>
				
										<div id="cart_product_price">
											<span id='cart_in_price'><label id="price">${(item.it_price*item.order_qty).toLocaleString('en')}</label>
												원</span>
											<div>
												<span id="delete" class="delete" onclick="deleteInfoCart()">삭제</span>
											</div>
										</div>
									</div>
								</div>
							`;
							
							
							const itemTotal = item.it_price * item.order_qty;
    						totalSum += itemTotal;		
							
					
					v_html = `
							    
							<div id="all_price">
								<span id='all_price'>총 금액</span>
							</div>
							<div id="product_price_sum">
								<span><label id="price_sum">${totalSum.toLocaleString('en')}</label> 원</span>
							</div>
							
							`;
							
			});// end of $.each(json, function(index,item)-------------------------------------
			
			
			$("div#item").html(html);
			$("div#cart_price_info").html(v_html);
				
				
				
				
				
				
				
						
				   
				   
			   }
		
		
			
	
	

// 장바구니의 삭제버튼 클릭 시 tbl_cart에 insert 되어있는 회원아이디, 제품번호 delete 해주기
function deleteInfoCart() {
	
	const iname = $(event.target).parent().parent().parent().find("span.cart_item_name").text();
	const indexno = $(event.target).parent().parent().parent().parent().find("input.indexno").val();
	
	   			let storedCartData = sessionStorage.getItem("cartData");
				let cartDataList = JSON.parse(storedCartData);
	   			
	   			cartDataList.splice(indexno, 1);
	   			
	   			// console.log(cartDataList);
				
				sessionStorage.setItem("cartData",JSON.stringify(cartDataList) );
	   			
	   			
			    storedCartData = sessionStorage.getItem("cartData");
			
			
			
				cartDataList = JSON.parse(storedCartData);
				
				
				let totalSum = 0; 
				html = ``;
				v_html = ``;
				if(cartDataList.length != 0) {
					
				
			
			
				$.each(cartDataList, function(index,item){
				html += `
							
								
								<div id="cart_item1">
				
									<input type="checkbox" class="chkboxinum" name="inum" id="inum${index}" /><label for="item"></label>
									<div id="cart_product_mini_photo">
										<img src="/tempSemi/images/wh/${item.img_file}"
											class="img-fluid mt-4" alt="Responsive image" />
									</div>
									
									<input type="hidden" class="itemno" name="itemno"
									value="${item.fk_it_seq_no}" />
									
									<input type="hidden" class="indexno" name="indexno"
									value="${index}" />
									
										
									<div id="cart_item_info">
										<div id="cart_product_name">
											<span id="cart_item_name" class="cart_item_name">${item.it_name}</span> 
												<select class="quantity" name="quantity" onchange="updateInfoCart(this)">
													<option value="1" ${item.order_qty === 1 ? 'selected' : ''}>1</option>
													<option value="2" ${item.order_qty === 2 ? 'selected' : ''}>2</option>
													<option value="3" ${item.order_qty === 3 ? 'selected' : ''}>3</option>
													<option value="4" ${item.order_qty === 4 ? 'selected' : ''}>4</option>
													<option value="5" ${item.order_qty === 5 ? 'selected' : ''}>5</option>
													<option value="6" ${item.order_qty === 6 ? 'selected' : ''}>6</option>
													<option value="7" ${item.order_qty === 7 ? 'selected' : ''}>7</option>
													<option value="8" ${item.order_qty === 8 ? 'selected' : ''}>8</option>
													<option value="9" ${item.order_qty === 9 ? 'selected' : ''}>9</option>
													<option value="10" ${item.order_qty === 10 ? 'selected' : ''}>10</option>
													<option value="11" ${item.order_qty === 11 ? 'selected' : ''}>11</option>
													<option value="12" ${item.order_qty === 12 ? 'selected' : ''}>12</option>
													<option value="13" ${item.order_qty === 13 ? 'selected' : ''}>13</option>
													<option value="14" ${item.order_qty === 14 ? 'selected' : ''}>14</option>
													<option value="15" ${item.order_qty === 15 ? 'selected' : ''}>15</option>
												</select>
										</div>
				
										<div id="cart_product_price">
											<span id='cart_in_price'><label id="price">${(item.it_price*item.order_qty).toLocaleString('en')}</label>
												원</span>
											<div>
												<span id="delete" class="delete" onclick="deleteInfoCart()">삭제</span>
											</div>
										</div>
									</div>
								</div>
							`;
							
							
							const itemTotal = item.it_price * item.order_qty;
    						totalSum += itemTotal;	
							
							v_html = `
							    
							<div id="all_price">
								<span id='all_price'>총 금액</span>
							</div>
							<div id="product_price_sum">
								<span><label id="price_sum">${totalSum.toLocaleString('en')}</label> 원</span>
							</div>
							
							`;
							
							
							
							
			});// end of $.each(json, function(index,item)-------------------------------------
			
			
			$("div#item").html(html);
			$("div#cart_price_info").html(v_html);	
			}
			else {
				
				html = `<div id="cart_null">장바구니에 담긴 상품이 없습니다</div>`;
				
				$("div#item").html(html);
				$("div#cart_price_info").html("");
				
				
			}	
				
					
	 
   
   	
    
    
    
	
}

/*

like 기능 !!


// 좋아요 추가 시작
function getLike(it_seq_no) {
   
   $.ajax({
      url:"myshop/likeCnt.tam",
      type:"post",
      async:false,
      data:{"it_seq_no":it_seq_no},
      dataType:"json",
      success:function(json){
         
         // like__cnt = 사용자들의 좋아요 수
         $("span#like__cnt").text(json.likeCnt);
         
      },
      error:function(request, status, error) {
         alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
      }
      
   }); // end of $.ajax({ 
}
/// 좋아요 추가 끝 -----------------------
	
	

*/


