$(document).ready(function() {

	// *** === 질문 클릭시 이벤트 === *** //
	$("div.FAQ__question").bind("click", e => {
		
		$(e.currentTarget).next("div").slideToggle(370);
		
		if( $(e.currentTarget).find("svg").hasClass("turn__180") ){
			$(e.currentTarget).find("svg").removeClass("turn__180")
		}
		else{
			$(e.currentTarget).find("svg").addClass("turn__180");	
		}
		
		$(e.currentTarget).parent("li").siblings("li").children("div.FAQ__answer").slideUp(370);
		$(e.currentTarget).parent("li").siblings("li").find("svg").removeClass("turn__180");
		
	})// end of $(".FAQ__ul > li > a").bind("click",function(){---	

}); // end of $(document).ready(function() { --------------



