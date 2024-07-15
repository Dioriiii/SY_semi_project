package db.myshop.controller;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import common.controller.AbstractController;
import db.myshop.model.*;

public class SelectMyReviewAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
	      
      	if("POST".equalsIgnoreCase(method)) {
      	// post
	         
      		String o_detail_seq_no = request.getParameter("o_detail_seq_no");    		
	        
      		MyshopDAO mdao = new MyshopDAO_imple();
      		
      		// 내가 작성했던 리뷰내용을 가져오는 것
      		String re_content = mdao.reviewUpdate(o_detail_seq_no);
			
      		JSONObject jsobj = new JSONObject();  
      		jsobj.put("re_content", re_content);
	        
      		String json = jsobj.toString();  // 문자열 형태로 변환해줌.
	         
      		request.setAttribute("json", json);
	         
         	super.setRedirect(false);
      		super.setViewPage("/WEB-INF/db/jsonview.jsp");
  		}	
      	else {
      	// post
	         
      		String message = "비정상적인 경로를 통해 들어왔습니다.!!";
      		String loc = "javascript:history.back()";
	         
      		request.setAttribute("message", message);
      		request.setAttribute("loc", loc);
	         
      		super.setViewPage("/WEB-INF/msg.jsp");
      	}
		
		
		
	}// end of public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

}
