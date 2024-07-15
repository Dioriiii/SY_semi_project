package db.myshop.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import common.controller.AbstractController;
import db.myshop.model.MyshopDAO;
import db.myshop.model.MyshopDAO_imple;

public class ReivewUpdateAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

String method =request.getMethod();
		
		if("post".equalsIgnoreCase(method)) {
			
			String o_detail_seq_no = request.getParameter("o_detail_seq_no");
			String re_content = request.getParameter("re_content");
			
			// **** 크로스 사이트 스크립트 공격에 대응하는 안전한 코드(시큐어 코드) 작성하기 **** //
			re_content = re_content.replaceAll("<", "&lt;");
			re_content = re_content.replaceAll(">", "&gt;");
			
			// 입력한 내용에서 엔터는 <br>로 변환시키기
			re_content.replaceAll("\r\n", "<br>");
			
			
			Map<String,String> paraMap = new HashMap<>();
			paraMap.put("o_detail_seq_no", o_detail_seq_no);
			paraMap.put("re_content", re_content);
			
			MyshopDAO mdao = new MyshopDAO_imple();
			
			
			int result = mdao.reviewUpdate(paraMap);
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
