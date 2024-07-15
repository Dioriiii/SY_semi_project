<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
	String ctxPath = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지 주문/배송</title>


<%-- Required meta tags --%>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
 

<%-- Font Awesome 6 Icons --%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/db/mypage/mypageOrderDeliver.css" />

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
<script type="text/javascript" src="<%= ctxPath%>/js/db/mypage/mypageOrderDeliver.js"></script>
<link rel="icon" href="<%= ctxPath%>/images/jy/fav_tamburins.png">

</head>
<jsp:include page="../../jy/header_revised.jsp" />

<body>
	<div id="member">
		<jsp:include page="./mypageLeft_bar.jsp" />
		
		
		<div id="mypage_right">
			<div class="head_div">
				<div class="page_title">
					<h3>주문내역/배송현황</h3>
				</div>
			</div>
			<table id="product_info">
				<tr class="bold_line">
					<th colspan="3" class="table_title">상품 정보</th>
				</tr>
				
				<%-- DB 구매내역이 없는 경우 --%>
				<c:if test="${empty requestScope.userListInList}">
					<tr class="non_order_list_tr none_line">
						<td colspan="3" class="non_order_list_td">구매내역이 없습니다.</td>
					</tr>
				</c:if>
				<%-- DB 구매내역이 있는 경우 (반복) --%>
				<%-- // 주문일련번호를  O.주문일자  D.제품일련번호, IT.제품명, IT.용량, D.주문수량, D.주문금액, D.주문상태, IM.이미지 // --%>
				<c:if test="${not empty requestScope.userListInList}">
					<c:forEach var="userList" items="${requestScope.userListInList}">
						<c:forEach var="uvo" items="${userList}" varStatus="status">
							<c:if test="${status.index eq 0}">
								<tr class="bold_line" >
									<td colspan="3" style="border-top: solid 1px #000"><div id="date_info"><div class="order_date">주문일자&nbsp;:&nbsp;<span id="order_date">${uvo.ovo.order_date}</span></div><div class="order_detail_view_div"><a class="order_detail_view_a" href="mypageOrderDetail.tam?order_seq_no=${uvo.ovo.order_seq_no}">주문상세></a></div></div></td>
								</tr>
							</c:if>
							<tr class="product_detail opac_line">
								<td>
									<img class="product_image" src="<%= ctxPath%>/images/db/mypage/${uvo.imvo.img_file}" />
								</td>
								<td>
									<ul class="ul_info">
										<li class="product__name">${uvo.itvo.it_name}</li>
										<li><span class="product__volume">${uvo.itvo.it_volume}</span>&nbsp;/&nbsp;<span class="product__o_qty">${uvo.dvo.o_qty}개</span></li>
										<li class="product__o_price"><fmt:formatNumber value="${uvo.dvo.o_price}" pattern="#,###"/>원</li>
										<li class="product__o_status">
											<c:if test="${uvo.dvo.o_status eq 0}">배송준비중</c:if>
											<c:if test="${uvo.dvo.o_status eq 1}">배송중</c:if>
											<c:if test="${uvo.dvo.o_status eq 2}">배송완료</c:if>
										</li>
									</ul>
								</td>
								<td>
									<c:if test="${uvo.dvo.o_status eq 2}">
										<button type="button" class="product_review_btn">리뷰 작성 하기</button>
										<input class="modal_o_detail_seq_no" value="${uvo.dvo.o_detail_seq_no}" type="hidden" />
										<input class="modal_img_file" value="<%= ctxPath%>/images/db/mypage/${uvo.imvo.img_file}" type="hidden" />
										
									</c:if>
									<button type="button" class="product_detail_view_btn" onclick="location.href='<%= ctxPath%>/product_detail.tam?it_seq_no=${uvo.dvo.fk_it_seq_no}'">제품 상세 보기</button>
								</td>
							</tr>
							
							
						</c:forEach>
					</c:forEach>
				</c:if>
				<%-- DB 구매내역이 있는 경우 (반복) --%>
				
			</table>
		</div>
	</div>		
	<br>
</body>

<input class="ctxPath" type="hidden" value="<%= ctxPath%>" />
	<!-- Modal -->
<input class="modal_btn" type="hidden" data-toggle="modal" data-target="#idFind_Modal"/>
<div class="modal fade" id="idFind_Modal" data-backdrop="static" >
  <div class="modal-dialog">
    <div class="modal-content">
      
      <!-- Modal header -->
      <div class="modal-header">
        <h5 class="modal-title">리뷰 작성하기</h5>
        <img class="review_product_image" src="" />
        <div>
        	<div class="review_product_name"></div>
        	<div class="review_product_volume"></div>
        	<input id="o_detail_seq_no"  type="hidden" />
        </div>
        <button type="button" class="close my_close" data-dismiss="modal" aria-label="Close">&times;</button>
        
      </div>
      
      <!-- Modal body -->
      <div class="modal-body">
	        <textarea class="review_contents" style="font-size: 12pt; width: 100%; height: 150px;"></textarea>
      </div>
      
      <!-- Modal footer -->
      <div class="modal-footer">
      	<%-- 
      	<button type="button" class="btn btn-primary review__btn" >작성하기</button>
        <button type="button" class="btn btn-danger my_close" data-dismiss="modal" >취소하기</button>
        --%>
      </div>
    </div>
  </div>
</div>



<jsp:include page="../../jh/footer.jsp" />

</html>