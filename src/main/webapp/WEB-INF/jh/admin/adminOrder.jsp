<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
    
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
 
<script src="<%= ctxPath %>/js/jquery-3.7.1.min.js" type="text/javascript"></script>

<%-- Font Awesome 6 Icons --%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/jh/admin/adminOrder.css" />

<script type="text/javascript">

	$(document).ready(function(){
		
		$("span#totalOrderCount").hide();
		$("span#countOrder").hide();
		
		let start = 1;
		let lenOrder = 4;
		
		// displayHIT(start);
		
	}); // end of $(document).ready(function(){});
	
	
	//////////////////////////////////////////////////////////////////////////////////////////////
	
	
	// display 할  HIT상품 정보를 추가 요청하기(Ajax 로 처리함)
	
	
	//////////////////////////////////////////////////////////////////////////////////////////////
	
	function goStatusChange(o_detail_seq_no, user_id, it_name, sh_name, sh_mobile, obj){
		
		const index = $("button.o_status_change_btn").index(obj);
		
		const o_status = $("select.o_status_select option:selected").eq(index).val(); // 장바구니 번호
		
		$.ajax({
			url:"<%=ctxPath%>/admin/statusChangeJSON.tam",
			type:"post",
			data:{"o_detail_seq_no":o_detail_seq_no,
				  "o_status":o_status,
				  "user_id":user_id,
				  "it_name":it_name,
				  "sh_name":sh_name,
				  "sh_mobile":sh_mobile},
			dataType:"json",
			success:function(json){
				if(json.result == 1){
					alert("배송상태가 변경되었습니다.");
					window.location.reload(); // 장바구니 보기 페이지로 간다.
				}
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});	
		
	}; // end of function goStatusChange(o_detail_seq_no)

</script>
<jsp:include page="../../jy/header_revised.jsp" />

<title>주문조회 | Tamburins</title>

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
				<%-- DB 여러개의 값이 들어가야 됨 (반복문) 아래는 예시 -- 쇼핑 정보 상세 ppt-72 --%>
				<%-- 주문횟수마다 반복 --%>
				<c:forEach var="orderCount" items="${requestScope.orderOneList}">
					<c:set var="flag" value="false"/>
						<table class="tbl_order_info">
						<tr>
							<th colspan="9" class="table_title">주문 관리</th>
						</tr>
						<tr class="orderInfoName">
							<th class="table_field_1" width="8%">주문일자</th>
							<th class="table_field_2" width="8%">주문일련번호</th>
							<th class="table_field_3" width="8%">주문상세일련번호</th>
							<th class="table_field_4" width="22%">제품정보</th>
							<th class="table_field_5" width="3%">수량</th>
							<th class="table_field_6" width="5%">금액</th>
							<th class="table_field_7" colspan="2" width="18%">주문상태변경</th>
							<th class="table_field_8" width="8%">배송완료일자</th>
						</tr>
							<%
								int total_price = 0;
							%>
							<%-- 한번 주문에 주문상품 목록 반복 --%>
							<c:forEach var="dtvo" items="${requestScope.orderAllList}" varStatus="status">
								<%-- 주문 일련번호와 같은 주문상세들만 보여줌 --%>
								<c:if test="${orderCount.order_seq_no eq dtvo.ovo.order_seq_no}">
									
									<tr class="column_text" style="border-bottom: black;">
										<c:if test="${not flag}">
										
											<%-- 주문일자 --%>
											<td rowspan="${orderCount.order_count}" width="8%" style="border: none;">
												<span>${orderCount.order_date}</span>
											</td>
											
											<%-- 주문일련번호 --%>
											<td rowspan="${orderCount.order_count}" width="8%">
												<span>${orderCount.order_seq_no}</span>
											</td>
											
											<c:set var="flag" value="true"/>
										</c:if>
											
										<%-- 주문상세일련번호 --%>
										<td width="8%">
											<span>${dtvo.o_detail_seq_no}</span>
										</td>
										
										<%-- 제품정보 --%>
										<td class="product_img" width="22%" style="text-align: right;">
											<div class="div_img">
												<img class="product_image" src="<%= ctxPath%>/images/jh/index/${dtvo.imgvo.img_file}" width="50px"/>
												<div class="div_info">
													<span class="it_seq_no">No.${dtvo.ovo.fk_it_seq_no}</span>&nbsp;<span>${dtvo.itvo.it_name}</span>
												</div> 
											</div>
										</td>
										
										<%-- 수량 --%>
										<td width="3%">
											<span>${dtvo.o_qty}</span>
										</td>
										
										<%-- 금액 --%>
										<td width="5%">
											<span><fmt:formatNumber value="${dtvo.o_price}" pattern="###,###" />&nbsp;원</span>
										</td>
										
										<%-- 주문상태변경 --%>
										<%-- 주문상태 (0 : 배송준비중 / 1 : 배송중 / 2 : 배송완료) --%>
										<td class="status_select o_status_change" width="9%">
											<select name="o_status" class="px-3 o_status_select">
												<c:if test="${dtvo.o_status eq 0}">
													<option value="0" selected>배송준비중</option>
													<option value="1">배송중</option>
													<option value="2">배송완료</option>
												</c:if>
												<c:if test="${dtvo.o_status eq 1}">
													<option value="0">배송준비중</option>
													<option value="1" selected>배송중</option>
													<option value="2">배송완료</option>
												</c:if>
												<c:if test="${dtvo.o_status eq 2}">
													<option value="0">배송준비중</option>
													<option value="1">배송중</option>
													<option value="2" selected>배송완료</option>
												</c:if>
											</select>
										</td>
										
										<td class="o_status_change" width="9%">
											<button type="button" class="o_status_change_btn" onclick="goStatusChange(${dtvo.o_detail_seq_no}, '${dtvo.ovo.fk_userid}', '${dtvo.itvo.it_name}', '${dtvo.ovo.sh_name}', '${dtvo.ovo.sh_mobile}', this)">변경하기</button>
										</td>
										
										<td width="8%">
											<span>${dtvo.deliverd_date}</span>
										</td>
										
									</tr>
									<c:set var="price" value="${dtvo.o_price}"/>

									<%
										int price = (int)pageContext.getAttribute("price");
										total_price = total_price + price;
									%>
								</c:if>
							</c:forEach>
							
							
							
							<tr class="orderInfo text-center">
								<td colspan="9">
									
									<div class="shipping_info">
										<span>배송지 정보</span>
									</div>
									
									<div class="div_order">
										<div class="div_orderInfo">
											<div class="div_orderInfo_1">
												<div>
													<span>주문자 아이디 : </span>
													<span class="order_id">${orderCount.fk_userid}</span>
												</div>
											</div>
											<div class="div_orderInfo_2">
												<div>
													<span>수령인 : </span>
													<span>${orderCount.sh_name}</span>
												</div>
											</div>
											<div class="div_orderInfo_3">
												<div>
													<span>연락처 : </span>
													<span>${orderCount.sh_mobile}</span>
												</div>
											</div>
											<br>
											<div class="div_orderInfo_4">
												<div>
													<span>우편번호 : </span>
													<span>${orderCount.sh_postcode}</span>
												</div>
											</div>
											<div class="div_orderInfo_5">
												<div>
													<span>주소 : </span>
													<span>${orderCount.sh_address} ${orderCount.sh_detailaddress} ${orderCount.sh_extraaddress}</span>
												</div>
											</div>
											<div class="div_orderInfo_6">
												<div>
													<span>배송메세지 : </span>
													<span>${orderCount.sh_msg}</span>
												</div>
											</div>
										</div>
										
										<div class="order_total_price">
											<span>총 주문금액 : <fmt:formatNumber value="<%=total_price%>" pattern="###,###" /> 원</span>
										</div>
										
									</div>
								</td>
							</tr>
						</table>
				</c:forEach>
			</table>
			
			<div>
				<p class="text-center">
					<span id="end" style="display:block; margin:20px; font-size: 14pt; font-weight: bold; color: red;"></span>
					<span id="totalOrderCount">${requestScope.totalOrderCount}</span>
					<span id="countOrder">0</span>
				</p>
			</div>
		<%--	
			<div class="div_btn" style="border-bottom: black; margin-top: 45px;">
				<button id="shopping_view_info_btn" type="button" onclick="location.href='mypageOrderDeliver.tam'">더보기</button>
			</div>
		--%>	
		</div>
	</div>	
	<br>
</body>

<jsp:include page="../footer.jsp" />