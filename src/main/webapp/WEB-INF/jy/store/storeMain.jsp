<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%
	String ctxPath = request.getContextPath();
%>    
<!DOCTYPE html>
<%-- 헤더 시작 --%>
<html lang="ko">
 <head>
  <%-- Required meta tags --%>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

  <title>플래그십스토어 | TAMBURINS</title>
  

 <style>
    .wrap {position: absolute;left: 0;bottom: 40px;width: 288px;height: 132px;margin-left: -144px;text-align: left;overflow: hidden;font-size: 12px;font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;line-height: 1.5;}
    .wrap * {padding: 0;margin: 0;}
    .wrap .info {width: 286px;height: 120px;border-radius: 5px;border-bottom: 2px solid #ccc;border-right: 1px solid #ccc;overflow: hidden;background: #fff;}
    .wrap .info:nth-child(1) {border: 0;box-shadow: 0px 1px 2px #888;}
    .info .title {padding: 5px 0 0 10px;height: 30px;background: #eee;border-bottom: 1px solid #ddd;font-size: 15px;font-weight: bold;}
    .info .close {position: absolute;top: 10px;right: 10px;color: #888;width: 17px;height: 17px;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/overlay_close.png');}
    .info .close:hover {cursor: pointer;}
    .info .body {position: relative;overflow: hidden;}
    .info .desc {position: relative;margin: 13px 0 0 90px;height: 75px;}
    .desc .ellipsis {overflow: hidden;text-overflow: ellipsis;white-space: nowrap;}
    .desc .jibun {font-size: 11px;color: #888;margin-top: -2px;}
    .info .img {position: absolute;top: 6px;left: 5px;width: 73px;height: 71px;border: 1px solid #ddd;color: #888;overflow: hidden;}
    .info:after {content: '';position: absolute;margin-left: -12px;left: 50%;bottom: 0;width: 22px;height: 12px;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
    .info .link {color: #5085BB;}
</style>
  
  
  <%-- Bootstrap CSS --%>
  <link rel="stylesheet" href="<%= ctxPath%>/bootstrap-4.6.2-dist/css/bootstrap.min.css" type="text/css">
  
  <%-- Font Awesome 5 Icons --%>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
  
  <%-- 직접만든 CSS --%>
  <link rel="stylesheet" href="<%= ctxPath%>/css/font.css" type="text/css">
  <link rel="stylesheet" href="<%= ctxPath%>/css/jy/store/storeMain.css" type="text/css">

  <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2f907461e044a99123a3e7b82800cec7"></script> 

  <%-- favcon --%>
  <link rel="icon" href="<%= ctxPath%>/images/jy/fav_tamburins.png">
  
  <jsp:include page="header_category_store.jsp" />
  <script>
  
  $(document).ready(function () {
	  		
		// 지도보기 버튼 클릭 시, 지도 div show & hide
		$("div.showMap").click(function (e) {
			map.relayout();
			$(e.target).parent().parent().find("div.map").toggle();
			map.relayout();
		});
		
		
		// div 지도 만들기
		const mapList = document.getElementsByClassName('map');
		// console.log(mapList.length);
		for(let i=1; i<mapList.length+1; i++){
			var mapContainer = document.getElementById('map'+i), // 지도를 표시할 div 
		    mapOption = { 
		        center: new kakao.maps.LatLng($("input#lat"+i).val(), $("input#lng"+i).val()), // 지도의 중심좌표
		        level: 4 // 지도의 확대 레벨
		    };

			var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
		
			var lat = $("input#lat"+i).val();
			var lng = $("input#lng"+i).val();
			// 마커를 표시할 위치입니다 
			var position =  new kakao.maps.LatLng(lat, lng);
			
			
			// 마커를 생성합니다
			var marker = new kakao.maps.Marker({
			  position: position
			});
		
			// 마커를 지도에 표시합니다.
			marker.setMap(map);
		
			// 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
			var mapTypeControl = new kakao.maps.MapTypeControl();
		
			// 지도에 컨트롤을 추가해야 지도위에 표시됩니다
			// kakao.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
			map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
		
			// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
			var zoomControl = new kakao.maps.ZoomControl();
			map.addControl(zoomControl, kakao.maps.ControlPosition.T);
			
			var storeName = $("input#store_name"+i).val();
			var storeAddress = $("input#store_address"+i).val();
			var storeContact = $("input#store_contact"+i).val();
			
			
			// 커스텀 오버레이에 표시할 컨텐츠 입니다
			// 커스텀 오버레이는 아래와 같이 사용자가 자유롭게 컨텐츠를 구성하고 이벤트를 제어할 수 있기 때문에
			// 별도의 이벤트 메소드를 제공하지 않습니다
	<%--		$.ajax({
				
				
				
				url:"<%= ctxPath%>/shop/storeLocationJSON.tam",
				async:false, // !!!!! 지도는 비동기 통신이 아닌 동기 통신으로 해야 한다.!!!!!!
				data:{"storeno",$("input#store"+i).val()},
	    		dataType:"json",
	    		success:function(json){
	    			
	    			console.log(json.svo);
	    			
	    			
	    		},
				error: function(request, status, error){
    				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
    	    	}
			})--%>
			var content = '<div class="wrap">' + 
			            '    <div class="info">' + 
			            '        <div class="title">' 
			            			+ storeName + 
			            '            <div class="close" onclick="closeOverlay()" title="닫기"></div>' + 
			            '        </div>' + 
			            '        <div class="body">' + 
			            '            <div class="img">' +
			            '                <img src="<%= ctxPath%>/images/jy/fav_tamburins.png" width="73" height="70">' +
			            '           </div>' + 
			            '            <div class="desc">' + 
			            '                <div class="ellipsis">'+storeAddress+'</div>' + 
			            '                  <div class="jibun ellipsis">'+storeContact+'</div>' +
			            '                <div><a href="https://map.kakao.com/link/to/'+storeName+','+lat+','+lng+'" class="link">길찾기</a></div>' +  
			            '            </div>' + 
			            '        </div>' + 
			            '    </div>' +    
			            '</div>';

			// 마커 위에 커스텀오버레이를 표시합니다
			// 마커를 중심으로 커스텀 오버레이를 표시하기위해 CSS를 이용해 위치를 설정했습니다
			var overlay = new kakao.maps.CustomOverlay({
			    content: content,
			    map: map,
			    position: marker.getPosition()       
			});} 

			// 마커를 클릭했을 때 커스텀 오버레이를 표시합니다
			kakao.maps.event.addListener(marker, 'click', function() {
			    overlay.setMap(map);
			});

			// 커스텀 오버레이를 닫기 위해 호출되는 함수입니다 
			function closeOverlay() {
			    overlay.setMap(null);     
			}
			
		
		$("div.map").hide()
		
		});
  

  
  </script>


<body>
	<div id="store_container">
		<c:if test="${not empty requestScope.flgList}">
			<c:forEach var="flgSvo" items="${requestScope.flgList}" varStatus="status">
				<div class="inner-item mx-auto d-block">
					<div id="tamburins${status.count}" class="carousel slide" data-ride="">									
						<div class="carousel-inner">			
							 <c:forEach var="ivo" items="${requestScope.imgList}">
							 	<c:if test="${ivo.fk_store_no eq flgSvo.store_no}">			
									 <c:if test="${ivo.is_main_img eq 1}">
										 <div class="carousel-item active">
											 <c:if test="${ivo.file_type == 'i'}">
											 	<img src="<%= ctxPath%>/images/jy/store/${ivo.store_img_file}" class="d-block w-100" alt="..." />
										 	 </c:if>
										 	 <c:if test="${ivo.file_type == 'v'}">
										 	 	<video class="video--transform w-100 h-100" playsinline="" autoplay="" muted="" loop="">
					                            	<source src="<%= ctxPath%>/images/jy/store/${ivo.store_img_file}" type="video/mp4">
					                        	</video>
										 	 </c:if>
									 	 </div>
								 	 </c:if>
								 	 <c:if test="${ivo.is_main_img eq 0}">
								 	 	<div class="carousel-item">
											 <c:if test="${ivo.file_type eq 'i'}">
											 	<img src="<%= ctxPath%>/images/jy/store/${ivo.store_img_file}" class="d-block w-100" alt="..." />
										 	 </c:if>
										 	 <c:if test="${ivo.file_type eq 'v'}">
										 	 	<video class="video--transform w-100 h-100" playsinline="" autoplay="" muted="" loop="">
					                            	<source src="<%= ctxPath%>/images/jy/store/${ivo.store_img_file}" type="video/mp4">
					                        	</video>
										 	 </c:if>
									 	 </div>
								 	 </c:if>
							 	 </c:if>
						 	 </c:forEach>
							<a class="carousel-control-prev" href="#tamburins${status.count}" data-slide="prev">
							   <span class="carousel-control-prev-icon"></span>
							</a>
							<a class="carousel-control-next" href="#tamburins${status.count}" data-slide="next">
							   <span class="carousel-control-next-icon"></span>
							</a>
						</div>
					</div>
					<div class="text_storeInfo pt-5">
							<div class="text-center fs_name font--kr pb-4">${flgSvo.store_name}</div>
							<div class="text-center fs_address font--kr">${flgSvo.store_address}</div>
							<div class="text-center fs_tel font--kr">${flgSvo.store_contact}</div>
							<div class="text-center fs_hour font--kr">${flgSvo.store_hours}</div>
							<br>
							<c:if test="${requestScope.country eq 'kr'}">
								<div class="showMap text-center pt-2" ><a style="text-decoration:underline; color: black;">지도보기</a></div>
								<input type="hidden" id="lat${status.count}" value="${flgSvo.lat}"/>
								<input type="hidden" id="lng${status.count}" value="${flgSvo.lng}"/>
								<input type="hidden" id="store_name${status.count}" value="${flgSvo.store_name}"/>
								<input type="hidden" id="store_address${status.count}" value="${flgSvo.store_address}"/>
								<input type="hidden" id="store_contact${status.count}" value="${flgSvo.store_contact}"/>
								<div id="map${status.count}" class="map" style="width:100%; height:350px; background-color: green; margin: 20px auto; "></div>
							</c:if>
					</div>
				</div>
			</c:forEach>
		</c:if>	
		<c:if test="${not empty requestScope.dptList}"> 
		<div class="store_container mx-auto d-block">
			<div class="text_retailer">
	          <strong>백화점 / 면세점</strong>
	        </div>		
			<div class="store_list  mx-auto">
				<c:forEach var="dptSvo" items="${requestScope.dptList}">
		            <div class="store_item">
		                <div class="store_name font--kr">${dptSvo.store_name}</div>
		                <div class="store_address font--kr">${dptSvo.store_address}</div>
		                <div class="store_tel font--kr">${dptSvo.store_contact}</div>
		                <div class="store_hour font--kr">${dptSvo.store_hours}</div>
		            </div>
	            </c:forEach>
			</div>			
		</div>
		</c:if>
		
		<c:if test="${not empty requestScope.stkList}"> 
		<div class="store_container mx-auto d-bloclist-titlek">
               <div class="text_retailer">
                   <strong>스톡키스트</strong>
               </div>
           	<div class="store_list  mx-auto">
				<c:forEach var="stkSvo" items="${requestScope.stkList}">
		            <div class="store_item">
		                <div class="store_name font--kr">${stkSvo.store_name}</div>
		                <div class="store_address font--kr">${stkSvo.store_address}</div>
		                <div class="store_tel font--kr">${stkSvo.store_contact}</div>
		                <div class="store_hour font--kr">${stkSvo.store_hours}</div>
		            </div>
	            </c:forEach>	            	
       		</div>
   		</div>
   		</c:if>	
   			
	</div>

	
</body>


<jsp:include page="../../jh/footer.jsp" />
