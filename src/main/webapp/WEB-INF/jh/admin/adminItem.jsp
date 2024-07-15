<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>      
    
<%
    String ctxPath = request.getContextPath();
    //    /MyMVC
%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 상품관리</title>

<%-- Required meta tags --%>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
 
<script src="<%= ctxPath %>/js/jquery-3.7.1.min.js" type="text/javascript"></script>

<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/jh/admin/adminItem.css" />

<%-- 직접 만든 JS --%>
<script type="text/javascript" src="<%= ctxPath%>/js/jh/admin/adminOrder.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/js/jh/admin/cateListJSON.js"></script>

<script type="text/javascript">

$(document).ready(function(){
	// 세상에 셀렉트 값이 변했어요
	// 정말요?
	// 와 대박........ 미쳤다....
	$("select[name='category__List']").on("change", function(e) {

		const ca_id = $(e.target).val();
		
		$.ajax({
			url:"itemByCategoryList.tam",
			type:"post",
			data:{
				"ca_id":ca_id
			},
			dataType:"json",
			success:function(json){
				
				$("tr.dno").css({"display":"none"});
				$("tr.dno").html("");
				//$("tr#item_container").html("젠장");
				
				 let html = ``;// [{"json":jkhjh,   }, {"json":jkhjh,   }]
				// alert(json[0].img_file);
				
				
				$.each(json, function(index, item) {
					
					//html += `<div>젠장1</div><br><br><br><div>젠장1</div><br><br><br><div>젠장2</div><br><br><br><div>젠장3</div><br><br><br><br><br><br><br><br><br><br><br><br>`;
					
					const status_val = (`\${item.it_status}`);
					
					var status = "";
					
					if(status_val == 1){
						status = "판매중";
					}else{
						status = "단종";
					}
					
					
					html += `<tr class="column_text dno"  style="word-break: keep-all;">
								<td class="product_name" width="15%" style="text-align: left; border-bottom:solid 1px #C6C6C6;">
									<div class="div_info text-center">
										No.<span>\${item.it_seq_no}</span>&nbsp;<span>\${item.it_name}</span>
									</div> 
								</td>
								
								<td width="5%" style="border-bottom:solid 1px #C6C6C6;">
									<span>\${item.ca_name}</span>
								</td>
								
								<td class="product_img" width="10%" style="text-align: right; border-bottom:solid 1px #C6C6C6;">
									<div class="div_img" style="text-align:center;">
					
										<img class="product_image" src="<%= ctxPath%>/images/jh/index/\${item.img_file}" width="80px"/>
									</div>
								</td>
								
								<td width="10%" style="border-bottom:solid 1px #C6C6C6;">
									<span>\${item.it_price.toLocaleString('en')}&nbsp;원</span>
								</td>
								
								<td width="15%" style="border-bottom:solid 1px #C6C6C6;">
									<span>\${item.it_theme}</span>
								</td>
								
								<td width="5%" style="border-bottom:solid 1px #C6C6C6;">
									<span>\${item.it_volume}</span>
								</td>
								
								<td width="5%" style="border-bottom:solid 1px #C6C6C6;">
									<span>\${item.it_stock}</span>
								</td>
								
								<td width="5%" style="border-bottom:solid 1px #C6C6C6;">
									<span>
										\${status}
						         	</span>
								</td>
								
								<td width="12%" style="border-bottom:solid 1px #C6C6C6;">
									<span>\${item.it_create_date}</span>
								</td>
								
								<td width="18%" style="border-bottom:solid 1px #C6C6C6;">
									<div style="display: block;">
									<%--
										<button type="button" class="i_status_change_btn" onclick="item_update(this)" style="margin-bottom: 10px;">상품수정하기</button>
									--%>	
										<button type="button" class="i_status_delete_btn" onclick="item_delete(this)" style="width: 100px;">상품삭제하기</button>
										
									</div>
								</td>
					
							</tr>`;
						
				});// end of $.each(json, function(index, item)-----
	
				$("div#item_container").html(html); 
				
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		} 
			
			
		}); // end of $.ajax -----
		
	});

});// end of $(document).ready(function(){})----------------

function item_delete(obj){
		
	const index = $("button.i_status_delete_btn").index(obj);
	// alert(index);
	
	const it_seq_no = $("span.item_no").eq(index).text(); // 제품번호
	console.log(it_seq_no);
	
	if(confirm("정말로 삭제하시겠습니까?")){
		
		$.ajax({
			url:"<%=ctxPath%>/itemDeleteJSON.tam",
			type:"post",
			data:{"it_seq_no":it_seq_no},
			dataType:"json",
			success:function(json){
				// console.log(JSON.stringify(json));
				
				if(json.n == 1){
					alert("삭제되었습니다.");
					location.reload(); // 새로고침
				}
				else{
					alert("삭제에 실패했습니다.");
				}
				
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
			
		});
		
	}
	
} // end of function item_delete()


function item_update(obj){
		
	const index = $("button.i_status_change_btn").index(obj);
	alert(index);
	
	
	
} // end of function item_update(obj)

</script>

<jsp:include page="../../jy/header_revised.jsp" />

<title>회원조회 | Tamburins</title>

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
		
		<div id="mypage_right">
			<table id="shopping_info">
				<tr>
					<th colspan="2" class="table_title"><div id="cate_select_List"></div></th>
					<th colspan="6" class="table_title page_title" style="margin-right:50px;">상품 관리</th>
					<th colspan="2" class="table_title"></th>
				</tr>
				<tr>
					<th class="table_field_1" width="15%">제품이름</th>
					<th class="table_field_2" width="5%">카테고리</th>
					<th class="table_field_3" width="10%">이미지</th>
					<th class="table_field_4" width="10%">가격</th>
					<th class="table_field_5" width="15%" >성분</th>
					<th class="table_field_6" width="5%" >용량</th>
					<th class="table_field_7" width="5%" >재고</th>
					<th class="table_field_8" width="5%" >상태</th>
					<th class="table_field_9" width="12%" >등록날짜</th>
					<th class="table_field_10" width="18%" >수정 및 삭제</th>
					
				</tr>
				
				
		
		<c:if test="${empty requestScope.itemList}">
			상품이 존재하진 않습니다.
		</c:if>
				
		<c:if test="${not empty requestScope.itemList}">
			<c:forEach var="items" items="${requestScope.itemList}" >
				<tr class="column_text dno" style="word-break: keep-all;">
				
					<td class="product_name" width="15%" style="text-align: left;">
						<div class="div_info text-center">
							No.<span class="item_no">${items.ivo.it_seq_no}</span>&nbsp;<span>${items.ivo.it_name}</span>
						</div> 
					</td>
					
					<td width="5%">
						<span>${items.ivo.cvo.ca_name}</span>
					</td>
					
					<td class="product_img" width="10%" style="text-align: right;">
						<div class="div_img" style="text-align:center;"><img class="product_image" src="<%= ctxPath%>/images/jh/index/${items.ivo.imvo.img_file}" width="80px"/>
						</div>
					</td>
					
					<td width="10%">
						<span><fmt:formatNumber pattern="#,###">${items.ivo.it_price}</fmt:formatNumber>&nbsp;원</span>
					</td>
					
					<td width="10%">
						<span>${items.ivo.it_theme}</span>
					</td>
					
					<td width="5%">
						<span>${items.ivo.it_volume}</span>
					</td>
					
					<td width="5%">
						<span>${items.ivo.it_stock}</span>
					</td>
					
					<td width="5%">
						<span>
							<c:choose>
					            <c:when test="${items.ivo.it_status == '1'}">
					               판매중
					            </c:when>
					            <c:otherwise>
					               단종
					            </c:otherwise>
				         	</c:choose>
			         	</span>
					</td>
					
					<td width="12%">
						<span>${items.ivo.it_create_date}</span>
					</td>
					
					<td width="18%">
						<div style="display: block;">
						<%--
							<button type="button" class="i_status_change_btn" onclick="item_update(this)" style="margin-bottom: 10px;">상품수정하기</button>
						--%>	
							<button type="button" class="i_status_delete_btn" onclick="item_delete(this)" style="width: 100px;">상품삭제하기</button>
							
						</div>
					</td>
					
				</tr>
				
			</c:forEach>
			
		</c:if>	
			
				

			</table><div id="item_container" class="shopping_info" style="margin-bottom:45px;"></div>	
		</div>
	</div>	
	<br>
</body>

<jsp:include page="../footer.jsp" />