<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/db/mypage/mypageConsumerService_return.css" />

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

<%-- 직접 만든 JS --%> <%-- 아직 없음 --%>
<%-- 
<script type="text/javascript" src="<%= ctxPath%>/js/db/mypage/mypageConsumerService_return.js"></script>
--%>

<link rel="icon" href="<%= ctxPath%>/images/jy/fav_tamburins.png">


</head>
<jsp:include page="../../jy/header_revised.jsp" />

<body>
	<div id="member">
		<jsp:include page="./mypageLeft_bar.jsp" />
		
		
		<div id="mypage_right">
			<div class="head_div">
				<div class="page_title">
					<h3>고객서비스</h3>
					<ul class="ul__cate">
						<li><a class="cate" href="mypageConsumerService.tam">결제</a></li>
						<li><a class="cate" href="mypageConsumerService_del.tam">배송</a></li>
						<li><a class="cate __ac" href="mypageConsumerService_return.tam">교환/반품</a></li>
					</ul>
				</div>
			</div>
			
			
			<table id="product_info">
				<tr class="bold_line">
					<th colspan="3" class="table_title">탬버린즈 결제 시스템 안내</th>
				</tr>
				<tr>
					<td>
						<ul>
							<li class="list__title">
								모든 교환 및 반품은 구매하신 스토어에서만 가능합니다.
								<br>
								온라인 – 오프라인 스토어 간 교환 및 반품은 불가하며, 아래 절차를 통해 접수해주세요.
							</li>
							<li>
								<table>
									<tr>
										<th class="center__bold"></th>
										<th class="center__bold"></th>
										<th class="center__bold">온라인 공식 스토어</th>
										<th class="center__bold">오프라인 공식 스토어</th>
									</tr>
									<tr>
										<td rowspan="3" class="center__bold">교환</td>
										<td class="center__bold">규정</td>
										<td class="ver__top">												
											<ul>
												<li class="bot__margin">불가</li>
												<li>*제품 이상 시만 동일 제품으로만 가능</li>
												<li>*단순변심 시, 반품 후 재구매</li>
											</ul>
										</td>
										<td class="ver__top">
											<ul class="__disc">
												<li>제품 구매 후 7일 이내 가능</li>
												<li>제품을 개봉하거나 개봉 스티커를 제거한 경우 불가</li>
												<li>파손 및 오염으로 정상 판매가 불가한 경우 불가 (겉박스 포함)</li>
											</ul>
										</td>
									</tr>
									<tr>
										<td class="center__bold">절차</td>
										<td class="ver__top">
											<ul class="num__li">
												<li class="num__height bot__margin">제품 이상 시 교환 절차</li>
												<li >① [메뉴>문의하기] 하단의 ‘말풍선 아이콘 클릭하여 ‘클라이언트 서비스팀 연결’ – 반품 접수</li>
												<li >② 제품 이상 증상 및 교환 가능 여부 확인</li>
												<li >③ 제품 회수</li>
												<li >④ 입고 및 검수 확인 후 교환 진행</li>
											</ul>
										</td>
										<td class="ver__top">
											<ul class="num__li">
												<li >① 결제 수단 및 구매 영수증(내역) 지참하여 구매한 오프라인 스토어로 방문</li>
												<li >② 제품 검수 및 교환 가능 여부 확인 (개봉 및 파손/오염)</li>
												<li >② 제품 이상 증상 및 교환 가능 여부 확인</li>
												<li >③ 제품 교환 진행</li>
											</ul>
										</td>
									</tr>
									<tr>
										<td class="center__bold">선물<br>구매</td>
										<td>
											<ul>
												<li>불가</li>
											</ul>
										</td>
										<td class="ver__top">
											<ul class="__disc">
												<li>제품 구매 후 7일 이내 교환 가능</li>
												<li>선물 영수증 지참하여 구매한 오프라인 스토어로 방문</li>
												<li>동일가 또는 *상액 제품으로 교환을 원할 경우 : 가능</li>
												<li class="add__notice t__none">*상액 제품 : 추가결제진행</li>
												<li>하액 제품으로 교환을 원할 경우 : 불가</li>
											</ul>
										</td>
									</tr>
									<tr>
										<td rowspan="3" class="center__bold">반품</td>
										<td class="center__bold">규정</td>
										<td class="ver__top">
											<ul class="__disc">
												<li>제품 수령 후 7일 이내 가능</li>
												<li>제품을 개봉하거나 개봉 스티커를 제거한 경우 불가</li>
												<li>파손 및 오염으로 정상 판매가 불가한 경우 불가 (겉박스 포함)</li>
											</ul>
										</td>
										<td class="ver__top">
											<ul class="__disc">
												<li>제품 구매 후 7일 이내 가능</li>
												<li>제품을 개봉하거나 개봉 스티커를 제거한 경우 불가</li>
												<li>파손 및 오염으로 정상 판매가 불가한 경우 불가 (겉박스 포함)</li>
											</ul>
										</td>
									</tr>
									<tr>
										<td class="center__bold">절차</td>
										<td class="ver__top">
											<ul class="num__li">
												<li >① [마이페이지>배송>주문 상세보기] 하단의 ‘반품하기‘ 접수</li>
												<li >② 제품 회수</li>
												<li >③ 입고 및 검수 확인 후 환불 진행</li>
												<li class="add__notice">*초기 배송비를 포함한 반품 배송비 5,000원 제외 금액으로 최종 환불</li>
											</ul>
										</td>
										<td class="ver__top">
											<ul class="num__li">
												<li >① 결제 수단 및 구매 영수증(내역) 지참하여 구매한 오프라인 스토어로 방문</li>
												<li >② 제품 검수 및 환불 가능 여부 확인 (개봉 및 파손/오염)</li>
												<li>③ 제품 환불 진행</li>
											</ul>
										</td>
									</tr>
									<tr>
										<td class="center__bold">선물<br>구매</td>
										<td>
											<ul>
												<li>불가</li>
											</ul>
										</td>
										<td>
											<ul>
												<li>불가</li>
											</ul>
										</td>
									</tr>
								</table>
							</li>
                            <li class="add__notice">
                            	*해당 정책 내 사유 또는 절차 외의 방법으로 반품 및 교환 진행은 불가합니다.
                            	<br>
                            	*탬버린즈의 교환 및 반품 정책은 변경될 수 있습니다
                            </li>
						</ul>
						
					</td>
				</tr>
								
			</table>
		</div>
	</div>		
	<br>
</body>

<jsp:include page="../../jh/footer.jsp" />

</html>