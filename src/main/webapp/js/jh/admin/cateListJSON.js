

$(document).ready(function(){
   
	$.ajax({
		url:"cateListJSON.tam",
		async:false,
		dataType:"json",
		success:function(json){
			
			let v_html = ``;

			if (json.length == 0) {
				v_html = `<select name="category__List">
            				<option value="" selected>:::카테고리선택:::</option>
                     	  </select>`;
				$("div#cate_select_List").html(v_html);
			}
			else if (json.length > 0) {
				// 데이터가 존재하는 경우
			//	console.log("확인용 json => ", JSON.stringify(json));

				v_html = `<select name="category__List">
            				  <option value="" selected>:::전체보기:::</option>`;

				$.each(json, function(index, item) {

					v_html += `<option value="${item.ca_id}">${item.ca_name}</option>`;

				});// end of $.each(json, function(index, item)-----

				v_html += `</select>`;


				// 카테고리 출력하기
				$("div#cate_select_List").html(v_html);

			}// end of else if(json.length > 0)----------------
			
		},
		error: function(request, status, error){
			alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		}      
	});
   
   
	
   
});// end of $(document).ready(function(){})----------------


