$(document).ready(function(){
	
	$("div.board").click(function(e){
		
		$("div#board_content_container").css({'display':'none'});
		$("table#hidden_bar").css({'display':'block'});	
		
		$("input[name='content_seq_no']").each(function(index,item){
			
			if($(item).val() == $(e.currentTarget).find("input[name='board_seq_no']").val()){
				$(item).parent().css({'display':'block'});
			}
		});
		
		document.getElementById("hidden_title").innerText = $(e.currentTarget).find("span.board_title").text();
		document.getElementById("hidden_resisterday").innerText = $(e.currentTarget).find("span.board_registerDay").text();
	});
	
});


function goList(){
	$("div#board_content_container").css({'display':''});
	$("table#hidden_bar").css({'display':'none'});
	$("div.board_content").css({'display':'none'});
	window.scrollTo({ top: 0, behavior: "smooth" });  
}