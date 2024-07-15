<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
    
<%
	String ctxPath = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 주문관리</title>


<%-- Required meta tags --%>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
 

<%-- Font Awesome 6 Icons --%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/ws/admin/itemManage.css" />

<%-- bootstrap CSS --%>
<link rel="stylesheet" href="<%= ctxPath%>/bootstrap-4.6.2-dist/css/bootstrap.min.css" type="text/css">

<%-- font CSS--%>
<link rel="stylesheet" href="<%= ctxPath%>/css/font.css" type="text/css">

<%-- Optional JavaScript --%> 
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.2-dist/js/bootstrap.bundle.min.js" ></script> 


<%-- jQuery CC 및 JS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.css" />
<script type="text/javascript" src="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.js"></script>

<%-- 직접 만든 JS --%>
<script type="text/javascript" src="<%= ctxPath%>/js/jh/admin/adminOrder.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/js/ws/admin/cateListJSON.js"></script>


<script type="text/javascript">

$(document).ready(function(){
	//세상에 셀렉트 값이 변했어요
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
					
					
					html += `<tr class="column_text">
					<td class="product_name" width="10%" style="text-align: left; border-bottom:solid 1px #C6C6C6;">
						<div class="div_info">
							No.<span>\${item.it_seq_no}</span>&nbsp;<span>\${item.it_name}</span>
						</div> 
					</td>
					
					<td width="10%" style="border-bottom:solid 1px #C6C6C6;">
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
					
					<td width="10%" style="border-bottom:solid 1px #C6C6C6;">
						<span>\${item.it_theme}</span>
					</td>
					
					<td width="10%" style="border-bottom:solid 1px #C6C6C6;">
						<span>\${item.it_volume}</span>
					</td>
					
					<td width="10%" style="border-bottom:solid 1px #C6C6C6;">
						<span>\${item.it_stock}</span>
					</td>
					
					<td width="10%" style="border-bottom:solid 1px #C6C6C6;">
						<span>
							\${status}
			         	</span>
					</td>
					
					<td width="10%" style="border-bottom:solid 1px #C6C6C6;">
						<span>\${item.it_create_date}</span>
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






</script>



</head>

<jsp:include page="../../jy/header_revised.jsp" />

	<div id="member">
		<div id="mypage_left">
			<h3 id="mypage_link"><a href="<%= ctxPath%>/mypage/mypage.tam">관리페이지</a></h3>
			<p id="p_user_info"><span id="user_name">관리자</span></p>
			<ul class="list_md">
				<li class="list_head">주문</li>
				<li><a href="<%= ctxPath%>/mypage/mypageOrderDeliver.tam">주문 관리</a></li>
			</ul>
			
			<ul class="list_md">
				<li class="list_head">회원</li>
				<li><a href="">회원 관리</a></li>
			</ul>
			
			<ul>
				<li class="list_head">상품</li>
				<li><a href="<%= ctxPath%>/mypage/mypageNotice.tam">상품 관리</a></li>
			</ul>
		</div>
		
		<div id="mypage_right">
			<table id="shopping_info">
				<tr>
					<th colspan="2" class="table_title"><div id="cate_select_List"></div></th>
					<th colspan="5" class="table_title page_title" style="margin-right:50px;">상품 관리</th>
					<th colspan="2" class="table_title"></th>
				</tr>
				<tr>
					<th class="table_field_1" width="10%">제품이름</th>
					<th class="table_field_2" width="10%">카테고리</th>
					<th class="table_field_3" width="10%">이미지</th>
					<th class="table_field_5" width="10%">가격</th>
					<th class="table_field_6" width="10%" >성분</th>
					<th class="table_field_6" width="10%" >용량</th>
					<th class="table_field_6" width="10%" >재고</th>
					<th class="table_field_6" width="10%" >상태</th>
					<th class="table_field_6" width="10%" >등록날짜</th>
					
				</tr>
				
				
		
		<c:if test="${empty requestScope.itemList}">
			상품이 존재하진 않습니다.
		</c:if>
				
		<c:if test="${not empty requestScope.itemList}">
			<c:forEach var="items" items="${requestScope.itemList}" >
				<tr class="column_text dno">
				
					<td class="product_name" width="10%" style="text-align: left;">
						<div class="div_info">
							No.<span>${items.ivo.it_seq_no}</span>&nbsp;<span>${items.ivo.it_name}</span>
						</div> 
					</td>
					
					<td width="10%">
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
					
					<td width="10%">
						<span>${items.ivo.it_volume}</span>
					</td>
					
					<td width="10%">
						<span>${items.ivo.it_stock}</span>
					</td>
					
					<td width="10%">
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
					
					<td width="10%">
						<span>${items.ivo.it_create_date}</span>
					</td>
					
				</tr>
				
			</c:forEach>
			
		</c:if>	
			
				

			</table><div id="item_container" style="margin-bottom:45px;"></div>	
		</div>
	</div>	
	<br>
<jsp:include page="../../jh/footer.jsp" />

</html>