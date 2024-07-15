$(document).ready(function(){
	
	$(".like").hide();
	
	$(".dislike").click(function(e){
		$(e.target).hide();
		$(e.target).parent().parent().find(".like").show();
	});
	
	$(".alreadylike").click(function(e){
		$(e.target).hide();
		$(e.target).parent().parent().find(".dislike").show();
	});
	
	$(".like").click(function(e){
		console.log("클릭");
		$(e.target).hide();
		$(e.target).parent().parent().find(".dislike").show();
	});
	
});


// 특정 사용자가 좋아요 누를때 좋아요 테이블에 insert 해주는 메소드 
function plus_heart(userid, it_seq_no){
	
	console.log("좋아요", userid, it_seq_no)
	
	$.ajax({
		url:"plusHeartJSON.tam",
		type:"get",
		data:{"userid":userid,
		      "it_seq_no":it_seq_no},
		dataType:"json",
		success:function(json){
			$("button."+it_seq_no+"dislike").parent().parent().find(".after_like").show();
			$("button."+it_seq_no+"dislike").find(".before_like").hide();
		},
		error: function(request, status, error){
			alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		}
		
	});
	
}

// 특정 사용자가 싫어요 누를때 좋아요 테이블에 insert 해주는 메소드 
function minus_heart(userid, it_seq_no){
	
	console.log("싫어요", userid, it_seq_no)
	
	$.ajax({
		url:"minusHeartJSON.tam",
		type:"get",
		data:{"userid":userid,
		      "it_seq_no":it_seq_no},
		dataType:"json",
		success:function(json){
			$("button."+it_seq_no+"dislike").parent().parent().find(".after_like").show();
			$("button."+it_seq_no+"dislike").find(".before_like").hide();
		},
		error: function(request, status, error){
			alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		}
		
	}); // end of ajax
	
}

function heartshow(n, login_userid, it_seq_no, div_id) {
	
	if(n == 0){
		console.log(n, "화면에 띄움, div_id : ", div_id);
		
		document.getElementById(div_id).remove();
		
		document.getElementById("heart_btn_" + it_seq_no).innerHTML = `<div class="item_image" style="font-family: sans-serif;" id="${it_seq_no}div" onclick="heartclick(${1},'${login_userid}', '${it_seq_no}', '${it_seq_no}div')">
													                       <button class="like" id="${it_seq_no}like">
							       							                   <i class="fa-solid fa-star after_like" style="color: #333333; font-family: 'Font Awesome 6 Free' !important;"></i>
							     						                   </button>
							     					                    </div>`;
		
		return;
	}
	
	
	if(n == 1) {
		console.log(n, "화면에 띄움, div_id : ", div_id);
		
		document.getElementById(div_id).remove();
		
		document.getElementById("heart_btn_" + it_seq_no).innerHTML = `<div class="item_image" style="font-family: sans-serif;" id="${it_seq_no}div" onclick="heartclick(${0},'${login_userid}', '${it_seq_no}', '${it_seq_no}div')">
													                       <button class="dislike" id="${it_seq_no}dislike">
							       							                   <i class="fa-regular fa-star before_like" style="color: #333333; font-family: 'Font Awesome 6 Free' !important;"></i>
							     						                   </button>
							     					                   </div>`;
		
		return;
	}
	
	if(n == 2){
		console.log(n, "화면에 띄움, div_id : ", div_id);
		
		$("heart_btn_" + it_seq_no).empty();
		
		document.getElementById("heart_btn_" + it_seq_no).innerHTML = `<div class="item_image" style="font-family: sans-serif;" id="${it_seq_no}div" onclick="heartclick(${3},'${login_userid}', '${it_seq_no}', '${it_seq_no}div')">
													          <button class="already_dislike" id="${it_seq_no}already_dislike">
							       							     <i class="fa-regular fa-star before_like" style="color: #333333; font-family: 'Font Awesome 6 Free' !important;"></i>
							     						      </button>
							     					      </div>`;
		
		return;
	}
	
	if(n == 3) {
		console.log(n, "화면에 띄움, div_id : ", div_id);
		
		$("heart_btn_" + it_seq_no).empty();
		
		document.getElementById("heart_btn_" + it_seq_no).innerHTML = `<div class="item_image" style="font-family: sans-serif;" id="${it_seq_no}div" onclick="heartclick(${2},'${login_userid}', '${it_seq_no}', '${it_seq_no}div')">
													          <button class="already_like" id="${it_seq_no}already_like">
							       							     <i class="fa-solid fa-star after_like" style="color: #333333; font-family: 'Font Awesome 6 Free' !important;"></i>
							     						      </button>
							     					      </div>`;
		
		return;
	}
	
}

function heartclick(n, login_userid, it_seq_no, div_id){
	
	if(n == 0){
		console.log("div_id : ", div_id);
		
		plus_heart(login_userid, it_seq_no);
		
		document.getElementById(div_id).remove();
		
		document.getElementById("heart_btn_" + it_seq_no).innerHTML = `<div class="item_image" style="font-family: sans-serif;" id="${it_seq_no}div" onclick="heartclick(${1},'${login_userid}', '${it_seq_no}', '${it_seq_no}div')">
													                       <button class="like" id="${it_seq_no}like">
							       							                   <i class="fa-solid fa-star after_like" style="color: #333333; font-family: 'Font Awesome 6 Free' !important;"></i>
							     						                   </button>
							     					                    </div>`;
		
		return;
	}
	
	
	if(n == 1) {
		console.log("div_id : ", div_id);
							     					      
		minus_heart(login_userid, it_seq_no);
		
		document.getElementById(div_id).remove();
		
		document.getElementById("heart_btn_" + it_seq_no).innerHTML = `<div class="item_image" style="font-family: sans-serif;" id="${it_seq_no}div" onclick="heartclick(${0},'${login_userid}', '${it_seq_no}', '${it_seq_no}div')">
													                       <button class="dislike" id="${it_seq_no}dislike">
							       							                   <i class="fa-regular fa-star before_like" style="color: #333333; font-family: 'Font Awesome 6 Free' !important;"></i>
							     						                   </button>
							     					                   </div>`;
		
		return;
	}
	
	if(n == 2){
		console.log(n, "눌림, div_id : ", div_id);
		
		minus_heart(login_userid, it_seq_no);
		
		$("heart_btn_" + it_seq_no).empty();
		
		document.getElementById("heart_btn_" + it_seq_no).innerHTML = `<div class="item_image" style="font-family: sans-serif;" id="${it_seq_no}div" onclick="heartclick(${3},'${login_userid}', '${it_seq_no}', '${it_seq_no}div')">
													          <button class="already_dislike" onclick="plus_heart('${login_userid}', '${it_seq_no}')" id="${it_seq_no}already_dislike">
							       							     <i class="fa-regular fa-star before_like" style="color: #333333; font-family: 'Font Awesome 6 Free' !important;"></i>
							     						      </button>
							     					      </div>`;
		
		return;
	}
	
	if(n == 3) {
		console.log(n, "눌림, div_id : ", div_id);
							     					      
		plus_heart(login_userid, it_seq_no);
		
		$("heart_btn_" + it_seq_no).empty();
		
		document.getElementById("heart_btn_" + it_seq_no).innerHTML = `<div class="item_image" style="font-family: sans-serif;" id="${it_seq_no}div" onclick="heartclick(${2},'${login_userid}', '${it_seq_no}', '${it_seq_no}div')">
													          <button class="already_like" onclick="minus_heart('${login_userid}', '${it_seq_no}')" id="${it_seq_no}already_like">
							       							     <i class="fa-solid fa-star after_like" style="color: #333333; font-family: 'Font Awesome 6 Free' !important;"></i>
							     						      </button>
							     					      </div>`;
		
		return;
	}
	
}
