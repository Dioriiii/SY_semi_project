package db.myshop.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import common.controller.AbstractController;
import db.myshop.model.*;

public class ReivewDelAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String method =request.getMethod();
		
		if("post".equalsIgnoreCase(method)) {
			
			String o_detail_seq_no = request.getParameter("o_detail_seq_no");
			
			MyshopDAO mdao = new MyshopDAO_imple();
			
			int result = mdao.reviewDel(o_detail_seq_no);
			// result 삭제성공 1, 삭제실패 0
			
			JSONObject jsonObj = new JSONObject();
			
			jsonObj.put("result", result);
		//	System.out.println("jsonObj => " + jsonObj);
			
			String json = jsonObj.toString();
			
			request.setAttribute("json", json);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/db/jsonview.jsp");
		}
		else {
			
			String message = "잘못된 접근입니다.";
			String loc = request.getContextPath()+"/index.up";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/db/msg.jsp");
		}
		
		
	}// end of public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception

}
