<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 

<%
    String ctxPath = request.getContextPath();
    //    /tempSemi
%>

<%-- Font Awesome 6 Icons --%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/jh/index/index.css" />

<jsp:include page="../header_category.jsp" />

<c:forEach var="imgvo" items="${requestScope.imgList}" begin="1" end="1">
	<title>${imgvo.cavo.ca_name} | Tamburins</title>
</c:forEach>


	<div class="mx-auto container-xl" style="max-width: 1300px; margin-bottom: 150px;">
			
			<div class="category">
			
				<div class="row div_category_item">		
					
						<c:if test="${not empty requestScope.imgList}">
								
							<c:forEach var="imgvo" items="${requestScope.imgList}">
								
								<c:if test="${requestScope.ca_id eq imgvo.cavo.ca_id}" >
									<div class="col-6 col-lg-3 px-1 item">
										
										<div class="div_item_image">
											<div class="click_boundary">
												
												<%-- 로그인 한 경우에만 좋아요 할 수 있는 버튼을 보여줌 --%>
												<c:if test="${not empty sessionScope.loginuser}">
												
													<%-- 로그인 한 사람이 좋아요 누른적이 있는 경우 --%>
													<c:if test="${not empty requestScope.heartList}">
													
														<%-- 반복문 탈출 플래그 설정 --%>
														<c:set var="heartList_flag" value="false" />
														
														<%-- 아이템을 꺼내는 반복문 한번마다 그 회원의 좋아요 테이블 반복 --%>
														<c:forEach var="hvo" items="${requestScope.heartList}">
														
															<%-- 반복문 탈출 지점 --%>
															<c:if test="${not heartList_flag}">
																
																<c:choose>
																
																	<%-- 해당 아이템과 좋아요 테이블의 아이디가 다른 경우 --%>
																	<c:when test="${hvo.fk_it_seq_no ne imgvo.itvo.it_seq_no}">
																		<div id="heart_btn_${imgvo.itvo.it_seq_no}">
																			<script>heartshow(2, "${(sessionScope.loginuser).userid}", "${imgvo.itvo.it_seq_no}", "${imgvo.itvo.it_seq_no}div");</script>
																		</div>
																	</c:when>
																
																	<%-- 해당 아이템과 좋아요 테이블의 아이디가 같은 경우 --%>
																	<c:when test="${hvo.fk_it_seq_no eq imgvo.itvo.it_seq_no}">
																		<div id="heart_btn_${imgvo.itvo.it_seq_no}">
																			<script>heartshow(3, "${(sessionScope.loginuser).userid}", "${imgvo.itvo.it_seq_no}", "${imgvo.itvo.it_seq_no}div");</script>
																			
																		</div>
																		
																		<%--  반복문으로 계속 div에 button 덮어 씌우다가 하트를 누른 아이템이면 탈출플래그 설정 --%>
																		<c:set var="heartList_flag" value="true" />
																	</c:when>
																	
																</c:choose>
																
															</c:if>
															
														
														</c:forEach>
													</c:if>
														
													<%-- 로그인 한 사람이 좋아요 누른적이 없는 경우 --%>
													<c:if test="${empty requestScope.heartList}">
														<div id="heart_btn_${imgvo.itvo.it_seq_no}">
															<div class="item_image" style="font-family: sans-serif;" id="${imgvo.itvo.it_seq_no}div" onclick="heartclick(${0},'${(sessionScope.loginuser).userid}', '${imgvo.itvo.it_seq_no}', '${imgvo.itvo.it_seq_no}div')">
																<button class="dislike" id="${imgvo.itvo.it_seq_no}dislike">
																	<i class="fa-regular fa-star before_like" style="color: #333333;"></i>
																</button>
															</div>
														</div>
													</c:if>
													
												</c:if>
													
												<a href="/tempSemi/product_detail.tam?it_seq_no=${imgvo.itvo.it_seq_no}" class="a_item ">
													<img src="<%= ctxPath%>/images/wh/${imgvo.img_file}" class="img-fluid" />
													<div class="div_item_desc">
														<div class="div_item_ingredient">${imgvo.itvo.it_ingredient}</div>
														<div class="div_item_name">${imgvo.itvo.it_name}</div>
														<div class="div_item_extra">
															<span class="span_item_price"><fmt:formatNumber value="${imgvo.itvo.it_price}" pattern="###,###" />&nbsp;원</span><span class="span_item_volume">${imgvo.itvo.it_volume}</span>
														</div>
													</div>
												</a>
											</div>
										</div>
										
									</div>
								</c:if>	
								
							</c:forEach>
								
						</c:if>
					
				</div>
			</div>
		
	</div>
</body>

<jsp:include page="../footer.jsp" />