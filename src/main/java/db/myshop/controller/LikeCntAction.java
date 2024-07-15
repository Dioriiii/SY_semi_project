package db.myshop.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import common.controller.AbstractController;
import db.myshop.model.*;
import jh.user.domain.HeartVO;
public class LikeCntAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		if("post".equalsIgnoreCase(method)) {
		// post
			// 좋아요 수만 체크한다.
			String it_seq_no = request.getParameter("it_seq_no");
			
			MyshopDAO mshdao = new MyshopDAO_imple(); 
			
			// 제품페이지의 해당 제품의 좋아요수를 가져온다.
			int likeCnt = mshdao.getItemLikeCnt(it_seq_no);
		//	System.out.println("likeCnt => "+ likeCnt);
			JSONObject jobj = new JSONObject(); // {}
			jobj.put("likeCnt", likeCnt); // {"likeCnt":likeCnt}
			
			String json = jobj.toString(); // "{"likeCnt":likeCnt}"
			
			request.setAttribute("json", json);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/db/jsonview.jsp");
		}
		else {
		// not post
			request.setAttribute("message", "정상적인 접근이 아닙니다.");
			request.setAttribute("loc",	request.getContextPath()+"/index.tam");
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/db/msg.jsp");
		}
		
	}// end of public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

}
