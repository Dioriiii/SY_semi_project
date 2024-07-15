<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<%
	// 컨텍스트 패스명(context path name)을 알아오고자 한다.
	String ctxPath = request.getContextPath();
	// ctxPath ==> /tempSemi
%> 


<jsp:include page="../../jy/header_revised.jsp" />

<title>결제완료페이지</title>

<link rel="stylesheet"  href="<%= ctxPath%>/css/ws/paymentEnd.css" type="text/css">
<link rel="stylesheet"  href="<%= ctxPath%>/font/font.css" type="text/css">


<c:if test="${empty requestScope.detailList}">

   <div class="alert_thanks" style="width:50%;">결제된 상품이 존재하지 않습니다.<br>감사합니다.</div>
   
   <div id="btn_container">
		<button type="button" class="btn btn-dark" style="background-color:black;">주문내역 조회하기</button>
		<button type="button" class="btn btn-white" style="background-color:white;">쇼핑 계속하기</button>	
	</div>
   
</c:if>

<c:if test="${not empty requestScope.detailList}">


<div class="alert_thanks">주문이 완료되었습니다.<br>감사합니다.</div>

<c:forEach var="dList" items="${requestScope.detailList}" begin="0" end="0">

<div class="alert_summary">
	<p>${dList.ivo.it_name} / ${dList.ivo.it_volume} / ${dList.o_qty}개 외 ${dList.except_order_cnt} 건</p>
	<p>${dList.ovo.order_date} 주문하신 주문번호는 ${dList.ovo.order_seq_no} 입니다.</p>
</div>

<div id="tbl_container">
	<table id="tbl_payment_info">
		<thead>
			<tr>
				<th>상품 정보</th>
					
				<th>배송지 정보</th>
				
				<th>결제 정보</th>
			</tr>
		</thead>
		
		<tbody>
			<tr>
				<td colspan="3">
					<span>&nbsp;주문일자 : ${dList.ovo.order_date}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span> <%-- sysdate --%>
					<span>주문번호 : ${dList.ovo.order_seq_no}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span> <%-- sysdate + 6352509(랜덤번호?) --%>
					<span>주문자 : ${fn:substring(dList.ovo.uvo.name,0,1)}*${fn:substring(dList.ovo.uvo.name,2,6)}(${dList.ovo.uvo.email})</span> <%-- 앞에 4자리 이후 *찍기 --%>
					       
				</td>
			</tr>
			
			<tr>
				<td>
					<div class="item_info">
						<p>${dList.ivo.it_name}</p>
						<p>${dList.ivo.it_volume} / ${dList.o_qty}개 외 ${dList.except_order_cnt} 건</p>
						<p><fmt:formatNumber pattern="#,###">${requestScope.showTotalPrice}</fmt:formatNumber></p>
						<p><a>더보기</a></p><br>
					</div>
				</td>
				<td>
					<div class="delivery_info">
						<p>${fn:substring(dList.ovo.sh_name,0,1)}*${fn:substring(dList.ovo.sh_name,2,6)}</p>
						<p>${dList.ovo.sh_postcode} ${dList.ovo.sh_address} ${dList.ovo.sh_detailaddress} ${dList.ovo.sh_extraaddress}</p>
						<p>${fn:substring(dList.ovo.sh_mobile,0,3)}-****-${fn:substring(dList.ovo.sh_mobile,7,11)}</p>
					</div>
				</td>
				<td>
					<div class="payment_info">
						<p>NAVERPAY</p> <%-- 결제수단 --%>
						<p><span style="font-weight:700;"><fmt:formatNumber pattern="#,###">${requestScope.showTotalPrice+2500}</fmt:formatNumber></span>&nbsp;&nbsp;원</p>

						<table id="sub_table" style="width:100%;">
						<tbody>
							<tr>
								<td style="float:left;">주문 금액</td>
								<td style="float:right;"><span><fmt:formatNumber pattern="#,###">${requestScope.showTotalPrice}</fmt:formatNumber> 원</span></td>
							</tr>
							
							<tr>
								<td style="float:left;">배송비</td>
								<td style="float:right;"><span>+<fmt:formatNumber pattern="#,###">2500</fmt:formatNumber> 원</span></td>
							</tr>
							
							<tr>
								<td style="float:left;">총 금액 금액</td>
								<td style="float:right;"><span><fmt:formatNumber pattern="#,###">${requestScope.showTotalPrice+2500}</fmt:formatNumber> 원</span></td>
							</tr>
						</tbody>
						</table>
						
					</div>
				</td>
			</tr>
		</tbody>
			
	</table>
</div>
</c:forEach>

<div id="btn_container">
	<button type="button" class="btn btn-dark" style="background-color:black;">주문내역 조회하기</button>
	<button type="button" class="btn btn-white" style="background-color:white;" onclick="location.href='<%= ctxPath%>/index.tam'">쇼핑 계속하기</button>	
</div> 
</c:if>



<jsp:include page="../../jh/footer.jsp" />


