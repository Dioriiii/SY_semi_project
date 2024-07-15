$(document).ready(function(){
	

	$("div#cart_Noitem").hide();

	
	$("button#goPayment").bind("click", function(){
		
		
		const userid = $("input.userid").val();
		
		goPayment(userid);
		
		
		
		
	});
	
	
	
	
	
}); // end of $(document).ready(function()-----------------------------------


// 주문계속하기 클릭 시 결제창으로 이동시키는 메소드
function goPayment(userid) {
	
	const frm = document.bagFrm;
	// alert(userid);
	// login한 상태로 주문하기 클릭한 경우
	
		
		const s_cart = sessionStorage.getItem("cartData");
				// [{"kkk":jjj,"iii":kkk}]
				
	    const cart_arr = JSON.parse(s_cart);
		
		const arr_fk_it_seq_no = [];
		const arr_order_qty = [];

		
		for(let i = 0; i<cart_arr.length; i++) {
			
			arr_fk_it_seq_no.push(cart_arr[i].fk_it_seq_no)
			arr_order_qty.push(cart_arr[i].order_qty)
			
		}
		
		
		
		$.ajax({
		url:"bagInsertJSON.tam",
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
				frm.action = "order_payment.tam";
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
		
}// end of function goPayment(userid)  ---------------------------------------------------------------*/

// 쇼핑계속하기 클릭 시 메인페이지로 이동시키는 메소드
function goMain() {
	
	const frm = document.bagFrm;
	
	frm.method = "get";
	frm.action = "index.tam";
	frm.submit();
}





function updateInfoBag(obj,userid) {
	console.log("userid : ",userid);
	
	const index = $("select.quantity").index(obj);
	// console.log("index =>",index);
	const itemno = $("input.itemno").eq(index).val();	// 제품번호
	// console.log("itemno =>",itemno)
	const quantity = $("select.quantity").eq(index).val(); // select 에서 선택한 수량
	// console.log("quantity =>",quantity)
	//const it_seq_no = $("div#it_seq_no").text();
				   
	let s_cart = sessionStorage.getItem("cartData");
			
	let p_cart = JSON.parse(s_cart);

	
	let qtyUpdate = p_cart.find( function(item, index, array){
							//item 은 필수
							if(item.fk_it_seq_no == itemno) {
								item.order_qty = Number(quantity);
								return item;
							}				
						});
	
	// console.log("qtyUpdate =>",qtyUpdate)
	
				
					
	p_cart.splice(index, 1, qtyUpdate);
	// console.log(" p_cart.splice(index, 1, qtyUpdate)=> ",p_cart.splice(index, 1, qtyUpdate))
	
	// [{},{}]
	
	sessionStorage.setItem("cartData",JSON.stringify(p_cart));
	
	
	let storedCartData = sessionStorage.getItem("cartData");
	// console.log(" storedCartData=> ",storedCartData);
	
	let cartDataList = JSON.parse(storedCartData);
	// console.log(" cartDataList=> ",cartDataList);
	
	
	
	let totalSum = 0; 
	let html = ``;
	let v_html = ``;

	$.each(cartDataList, function(index,item){
	html += `
			<div id="cart_item">
				<div id="cart_product_mini_photo">
					<img src="/tempSemi/images/wh/${item.img_file}" class="img-fluid mb-1 img-sm" alt="Responsive image"> 
				</div>

				<input type="hidden" class="itemno" name="itemno" value="${item.fk_it_seq_no}" />
				
				<input type="hidden" class="indexno" name="indexno" value="${index}" />


				<div id="cart_item_info">
					<div id="cart_product_name">
						<span style="font-weight:bold;">${item.it_name}</span> 
						<span>${item.item_category}</span>
						<select class="quantity" name="quantity" onchange="updateInfoBag(this)">
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
						<span class="item_price">${(item.it_price*item.order_qty).toLocaleString('en')} 원</span>
						<div>
							<span id="delete" class="delete" onclick="deleteInfoBag(this)" >삭제</span>
						</div>
					</div>
				</div>
			</div>
				`;
				
				const itemTotal = item.it_price * item.order_qty;
				totalSum += itemTotal;		
				
		
		v_html = `
				 <div id="payment_price" >
					<div>
						<span>주문금액</span>
					</div>
					
					<div>
						<span id="price_sum">${totalSum.toLocaleString('en')} 원</span>
					</div>
				</div>
				
				<div id="delivery_charge">
					<div >
						<span>배송비</span>
					</div>
					
					<div>
						<span><span id="free_charge">3만원 이상 구매 시 무료배송</span>&nbsp;&nbsp;&nbsp;0 원</span>
					</div>
				</div>
				
				<div id="payment_all_price">
					<div>
						<span>총 금액</span>
					</div>
					
					<div>
						<span id="price_total">${totalSum.toLocaleString('en')} 원</span>
					</div>
				</div>   
				    
				
				`;
							
			});// end of $.each(json, function(index,item)-------------------------------------
			
			
			$("div#shop_bag").html(html);
			$("div#payment").html(v_html);
			
			
			// 기존에 넘어온 db값은 삭제해준다.
			
			
			
			
			
			$.ajax({
			url:"cartDeleteJSON.tam",
			type:"post",
			data:{"userid":userid
				  },	
			dataType:"json",
			success:function(json){
			console.log("json.n : ",json.n);
			
				
				
			},
			error: function(request, status, error){
	          alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        }
		});			
			
			
			
			
			
							   
}// end of function updateInfoCart(obj) {-----------------------------------------------
		
		
			
	
	

// 쇼핑백의 삭제버튼 클릭 시 tbl_cart에 insert 되어있는 회원아이디, 제품번호 delete 해주기
function deleteInfoBag() {
	
	const iname = $(event.target).parent().parent().parent().find("span.cart_item_name").text();
	console.log("iname => ",iname);
	const indexno = $(event.target).parent().parent().parent().parent().find("input.indexno").val();
	console.log("indexno => ",indexno);

	let storedCartData = sessionStorage.getItem("cartData");
	console.log("storedCartData => ",storedCartData);
	
	let cartDataList = JSON.parse(storedCartData);
	console.log("cartDataList => ",cartDataList);
	cartDataList.splice(indexno, 1);
	
	// console.log(cartDataList);
	
	sessionStorage.setItem("cartData",JSON.stringify(cartDataList) );
	
	
    storedCartData = sessionStorage.getItem("cartData");



	cartDataList = JSON.parse(storedCartData);
	
	
	let totalSum = 0; 
	let html = ``;
	let v_html = ``;
	if(cartDataList.length != 0) {

	$.each(cartDataList, function(index,item){
	html += `
			<div id="cart_item">
				<div id="cart_product_mini_photo">
					<img src="/tempSemi/images/wh/${item.img_file}" class="img-fluid mb-1 img-sm" alt="Responsive image"> 
				</div>

				<input type="hidden" class="itemno" name="itemno" value="${item.fk_it_seq_no}" />
				
				<input type="hidden" class="indexno" name="indexno" value="${index}" />


				<div id="cart_item_info">
					<div id="cart_product_name">
						<span style="font-weight:bold;">${item.it_name}</span> 
						<span>${item.item_category}</span>
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
						<span class="item_price">${(item.it_price*item.order_qty).toLocaleString('en')} 원</span>
						<div>
							<span id="delete" class="delete" onclick="deleteInfoBag(this)" >삭제</span>
						</div>
					</div>
				</div>
			</div>
				`;
				
				const itemTotal = item.it_price * item.order_qty;
				totalSum += itemTotal;		
				
		
		v_html = `
				 <div id="payment_price" >
					<div>
						<span>주문금액</span>
					</div>
					
					<div>
						<span id="price_sum">${totalSum.toLocaleString('en')} 원</span>
					</div>
				</div>
				
				<div id="delivery_charge">
					<div >
						<span>배송비</span>
					</div>
					
					<div>
						<span><span id="free_charge">3만원 이상 구매 시 무료배송</span>&nbsp;&nbsp;&nbsp;0 원</span>
					</div>
				</div>
				
				<div id="payment_all_price">
					<div>
						<span>총 금액</span>
					</div>
					
					<div>
						<span id="price_total">${totalSum.toLocaleString('en')} 원</span>
					</div>
				</div>   
				    
				`;
							
			});// end of $.each(json, function(index,item)-------------------------------------
			
			
			$("div#shop_bag").html(html);
			$("div#payment").html(v_html);
			}
			else {
				
				html = `<div id="cart_null">장바구니에 담긴 상품이 없습니다</div>`;
				
				$("div#shop_bag").html(html);
				$("div#payment").html("");
				
				
			}	
			

}

