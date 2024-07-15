<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 	 <%-- JSTL을 사용할때 필요 --%>   

<%
	String ctxPath = request.getContextPath();
	// ctxPath ==> /tempSemi
%> 
<div class="err_banner">
  		<span id="err_msg"></span>
</div>
<jsp:include page="../../../jy/header_revised.jsp" />
<title>제품등록</title>

<%-- Required meta tags --%>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
 

<%-- Font Awesome 6 Icons --%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/ws/mypage/mypageOrderDeliver.css" />
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/ws/mypage/mypageLeft_bar.css" />
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/ws/mypage/itemRegister.css" />
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/ws/mypage/common.css" />
<link rel="stylesheet" href="<%= ctxPath%>/css/font.css" type="text/css">

<%-- Optional JavaScript --%> 
<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.2-dist/js/bootstrap.bundle.min.js" ></script> 


<%-- jQuery CC 및 JS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.css" />
<script type="text/javascript" src="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.js"></script>

<%-- 직접 만든 JS --%>
<script type="text/javascript" src="<%= ctxPath%>/js/ws/mypage/itemRegister.js"></script>



<script type="text/javascript">

$(document).ready(function(){
	
	
	// 제품 수량에 spinner 달기
	$("input#spinner_it_stock").spinner({
		
		spin:function(event,ui){
            if(ui.value > 999) {
               $(this).spinner("value", 999); 	// 최대 100개까지
               return false;
            }
            else if(ui.value < 1) {
               $(this).spinner("value", 1);		// 최소 1개
               return false;
            }
         }
	}); // end of $("input#spinner_it_stock").spinner---------------------
	
	
	$("input#spinner_img_file").spinner({   		
		spin:function(event,ui){
        if(ui.value > 8) {
           $(this).spinner("value", 8); 	// 최대 8개까지
           return false;
        }
        else if(ui.value < 0) {
           $(this).spinner("value", 0);		// 최소 0개
           return false;
        }
     }
	}); // end of $("input#spinnerImgQty").spinner({})-----------------------
	
	
	$("input#spinner_img_file").bind("spinstop",function(){
		
		let v_html = ``;
		let cnt = $(this).val();
		
	//	console.log("cnt => ",cnt);
		for(let i=0; i<Number(cnt); i++){
			v_html += `<input type="file" name="attach\${i}" style="margin:1% 1%;" class="spinner_imgfile add_attach_file" accept="image/*" />`;
		}										
		
		$("div#img_file_attach").html(v_html);
		$("input:hidden[name='attachCount']").val(cnt); // 추가 이미지 파일 개수
	
	}); // end of $("div#img_file_attach").bind("spinstop",function(){}-----------
	
	
			
	// 이미지 넣기		
	$(document).on("change","input#imgFile",function(e){

		
		const input_file = $(e.target).get(0);

		const fileReader = new FileReader();
		
		fileReader.readAsDataURL(input_file.files[0]);
		
		 fileReader.onload = function(){
			console.log(fileReader.result);
			document.getElementById("previewImg").src = fileReader.result;
			
		}; 
		
	}); // end of $(document).on("change","input#imgFile",function(e)---------------------------------
	
	
			
	
	// 제품 등록하기
	$("button.input__save").click(function(){
	
		let flag = false;
		
		$("img#previewImg").show();
		$("span#err_msg").html(`필수 입력사항을 확인해주세요!`);
		
		
		// 제품명
		if( $("input[name='it_name']").val().trim() == ""){
			$("input[name='it_name']").css("border","1px solid #d12b2b");
			showBanner();
			flag = false;
			return false;
		} else{
			$("input[name='it_name']").css("border","");
			flag = true;
			
		}
		
		// 메인 이미지 사진
		if( $("input[name='img_file']").val()==""){
			$("img#previewImg").css("border","1px solid #d12b2b");
			showBanner();
			flag = false;
			return false;
		} else{
			$("img#previewImg").css("border","");
			flag = true;
		}
		
		// 가격
		if( $("input[name='it_price']").val().trim() == ""){
			$("input[name='it_price']").css("border","1px solid #d12b2b");
			showBanner();
			flag = false;
			return false;
		} else{
			$("input[name='it_price']").css("border","");
			flag = true;
		}
		
		// 용량
		if( $("input[name='it_volume']").val().trim() == ""){
			$("input[name='it_volume']").css("border","1px solid #d12b2b");
			showBanner();
			flag = false;
			return false;
		} else{
			$("input[name='it_volume']").css("border","");
			flag = true;
		}
		
		// 용량 단위
		if( $("select[name='unit']").val().trim() == ""){
			$("select[name='unit']").css("border","1px solid #d12b2b");
			showBanner();
			flag = false;
			return false;
		} else{
			$("select[name='unit']").css("border","");
			flag = true;
		}
		
		// 키워드
		if( $("input[name='it_theme']").val().trim() == ""){
			$("input[name='it_theme']").css("border","1px solid #d12b2b");
			showBanner();
			flag = false;
			return false;
		} else{
			$("input[name='it_theme']").css("border","");
			flag = true;
		}
		
		// 성분
		if( $("textarea[name='it_ingredient']").val().trim() == ""){
			$("textarea[name='it_ingredient']").css("border","1px solid #d12b2b");
			showBanner();
			flag = false;
			return false;
		} else{
			$("textarea[name='it_ingredient']").css("border","");
			flag = true;
		}
		
		// 설명
		if( $("textarea[name='it_describe_simple']").val().trim() == ""){
			$("textarea[name='it_describe_simple']").css("border","1px solid #d12b2b");
			showBanner();
			flag = false;
			return false;
		} else{
			$("textarea[name='it_describe_simple']").css("border","");
			flag = true;
		}
		
		// 카테고리
		if( $("select[name='fk_ca_id']").val().trim() == ""){
			$("select[name='fk_ca_id']").css("border","1px solid #d12b2b");
			showBanner();
			flag = false;
			return false;
		} else{
			$("select[name='fk_ca_id']").css("border","");
			flag = true;
		}
		
		// ==== 추가이미지파일(선택)에서 파일개수 모두에 파일을 적용하지 않고 일부만 적용한 상태인 경우 제품등록을 못하게 하도록 한다. 시작 ==== //
		const add_attach_file_List = document.getElementsByClassName("add_attach_file");
		
		for(let i=0;i<add_attach_file_List.length;i++){
			try{
				console.log(add_attach_file_List[i].files[0].name);
			} catch(e){
				alert("추가이미지파일(선택)에서 파일선택에 파일을 모두 적용하지 않으셨습니다.");
				return;
			}
		}
		// ==== 추가이미지파일(선택)에서 파일개수 모두에 파일을 적용하지 않고 일부만 적용한 상태인 경우 제품등록을 못하게 하도록 한다. 끝 ==== //
		
		
		
		if(flag){
			const frm = document.itemInputFrm;
			frm.submit();
		}
		
	});// end of $("input.input__save").click(function()
	
			
	// 취소하기
	$("button[type='reset']").click(function(){
		
		$("div#img_file_attach").empty();
		document.getElementById("previewImg").src = "<%= ctxPath%>/images/ws/mypage/이미지아이콘.jpg";
		document.getElementById("imgFile").value = "";
	});
	
			
			
			
	
}); // end of $(document).ready(function(){})-----------------



 function showBanner() {
	
	$("div.err_banner").addClass('show');
	$("div.err_banner").removeClass('hide');	
  		
  		setTimeout(() => {
			 
    		$("div.err_banner").removeClass('show');
    		$("div.err_banner").addClass('hide');
    		
  		}, 1500)
 
}// end of function showBanner()--------


</script>


<body>
	<div id="member">
	
		<div id="mypage_left">
			<h3 id="mypage_link">관리페이지</h3>
			<p id="p_user_info"><span id="user_name">${(sessionScope.loginuser).name} 님</span></p>
			<ul class="list_md">
				<li class="list_head">주문</li>
				<li><a href="<%= ctxPath%>/adminOrder.tam">주문 관리</a></li>
			</ul>
			
			<ul class="list_md">
				<li class="list_head">회원</li>
				<li><a href="<%= ctxPath%>/adminUser.tam">회원 조회</a></li>
			</ul>
			
			<ul>
				<li class="list_head">상품</li>
				<li><a href="<%= ctxPath%>/adminItem.tam">상품 관리</a></li>
				<li><a href="<%= ctxPath%>/admin/itemRegister.tam">상품 등록</a></li>
			</ul>
		</div>
		
		<%-- 공지사항 목록 시작 --%>
		<div id="mypage_right">
			<div class="head_div">
				<div class="page_title">
					<h3 style="font-size:14pt;">제품등록</h3>
				</div>
			</div>
			<div id="board_content_container">		
				<table id="board_table">
					<tr class="bold_line">
						<th id="table_title">제품정보</th>
					</tr>
				</table>
				
				<form name="itemInputFrm" action="<%= ctxPath%>/admin/itemRegister.tam" method="POST" enctype="multipart/form-data">
					<table id="itemInputTbl">
						<tbody>
							
							
							<%-- 제품 테이블 --%>							
							<tr class="Input_tr">
								<td class="Input_title">제품명</td>
								<td>
									<input type="text" name="it_name" class="infoData" size="50" maxlength="50" />
								</td>
								
								<%-- 제품사진 테이블 --%>
								<td rowspan="6" class="main_img_tr">
									<div style="height:66%;">
									
										<input type="file" id="imgFile" name="img_file" class="infoData img_file" accept='image/*' /><%-- name 넣어야함--%>
										<img id="previewImg" class="bord_radius" src="<%= ctxPath%>/images/ws/mypage/이미지아이콘.jpg" style="width:66%;" onclick="goInput()">		
									</div>
								</td>
							</tr>
							
							<tr class="Input_tr">
								<td class="Input_title">제품수량</td> 
								<td>
									<input id="spinner_it_stock" name="it_stock" value="1" style="width: 30px; height: 20px;" /><%-- disabled 시키기 --%> <%-- it_stock 에서 더하기--%>
								</td>
							</tr>
							
							<tr class="Input_tr">
								<td class="Input_title">가격</td>
								<td>
									<input type="text" name="it_price" class="infoData" min="10" max="10" /> 원
								</td>
								
							</tr>
												
							<tr class="Input_tr">
								<td class="Input_title">용량</td> 
								<td>
									<input type="text" class="infoData" name="it_volume" /> <%-- disabled 시키기 --%>
									<select name="unit" class="infoData">
									
										<option value="" selected>:::용량단위:::</option>
						            	<option value="g">g</option>
						            	<option value="mL">mL</option>

					            	</select>
								</td>
								
							</tr>
							
							<tr class="Input_tr">
								<td class="Input_title">키워드</td> 
								<td>
									<input type="text" class="infoData" name="it_theme" /> <%-- disabled 시키기 --%>
								</td>
							</tr>
							
							<tr class="Input_tr">
								<td class="Input_title">성분</td> 
								<td>
									<textarea id="ingreComment" name="it_ingredient" class="infoData" rows="3" cols="50"></textarea> <%-- disabled 시키기 --%>
								</td>
								
								
								
							</tr>
							
							<tr class="Input_tr">
								<td class="Input_title">설명</td> 
								<td>
									<textarea id="describeComment" name="it_describe_simple" class="infoData" rows="7" cols="50"></textarea> <%-- disabled 시키기 --%>
								</td>
								
								<td rowspan="3" style="vertical-align:top; margin-left:1000px;"> 추가 파일갯수
				         			<input id="spinner_img_file" value="0" style="width: 30px; height: 20px;" disabled>
				         			
				         			<div id="img_file_attach"></div>
					            		
				            		<input type="hidden" name="attachCount" />
								</td>
								
							</tr>
							
							<tr class="Input_tr">
								<td class="Input_title">설명(선택)</td> 
								<td>
									<textarea class="describeComment" name="it_describe" rows="7" cols="50"></textarea> <%-- disabled 시키기 --%>
								</td>
								
								
							</tr>
							
							
							<%-- 카테고리 테이블 --%>
							
							<tr class="Input_tr">
								<td class="Input_title">카테고리명</td>
								<td>
									<select name="fk_ca_id" class="infoData">
									<option value="" selected>:::선택하세요:::</option>
										<c:forEach var="cvo" items="${requestScope.categoryList}">
						            		<option value="${cvo.ca_id}">${cvo.ca_name}</option>
						            	</c:forEach>
					            	</select>
				            	</td>

							</tr>
							
						</tbody>
					</table>
					

					
					<button type="button" class="input__save input__float_right" style="width:10%;">저장하기</button>
					<button type="reset" class="input__cancel input__float_right" style="width:10%;">취소하기</button>
					
					
					
					
				</form>
				

			</div>
		</div>
	</div>		
	<br>
</body>



<%-- <jsp:forward page="이동할페이지"/> --%>

<jsp:include page="../../../jh/footer.jsp" />

       
       
       
	
	
	
	
	
	