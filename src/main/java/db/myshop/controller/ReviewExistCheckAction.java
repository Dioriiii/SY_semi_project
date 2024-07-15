package db.myshop.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import common.controller.AbstractController;

import db.myshop.model.*;

public class ReviewExistCheckAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		if("post".equalsIgnoreCase(method)) {
		// post 방식
			
			String o_detail_seq_no = request.getParameter("o_detail_seq_no");
			
			MyshopDAO mdao = new MyshopDAO_imple();
			
			boolean existCheck = mdao.ReviewExistCheck(o_detail_seq_no);
			// 리뷰 존재하면 true  리뷰 없으면 false
			
			JSONObject jsonObj = new JSONObject();	// {} 
			jsonObj.put("existCheck", existCheck);
			
			String json = jsonObj.toString();
			
			request.setAttribute("json", json);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/db/jsonview.jsp");
		}
		else {
		// get 방식	
			// 없음
		}
		
	}// end of public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

}
