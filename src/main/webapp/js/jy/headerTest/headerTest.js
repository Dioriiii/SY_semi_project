
/* Set the width of the sidebar to 250px (show it) */
function openNav() {
  document.getElementById("mySidepanel").style.width = "250px";
}

/* Set the width of the sidebar to 0 (hide it) */
function closeNav() {
  document.getElementById("mySidepanel").style.width = "0";
}

$(document).ready(function(){
	
	$("span.category_img").hover( e =>{ 
	// 카테고리 이미지에 마우스를 올려놓을 때, 테두리 띄우기
	
		$("span.category_img").css( {'border':'1px solid rgba(0,0,0,0)','border-radius':'50%'} );
		
		$(e.currentTarget).css( {'border':'solid 1px black','border-radius':'50%'} );
		$(".cate_img").css( {'border':'1px solid rgba(0,0,0,0)','border-radius':'50%'} );
		
	// 카테고리 이미지에 마우스를 땠을때, 테두리 원상복구	
	},e => {
		$(e.currentTarget).css( {'border':'1px solid rgba(0,0,0,0)','border-radius':'50%'} );
		/*$(".cate_img").css( {'border':'1px solid rgba(0,0,0,0)','border-radius':'50%'} );*/
	});
	
	$("span.category_img_select").css({'border':'solid 1px black','border-radius':'50%'})
	
}); // end of $(document).ready(function(){}