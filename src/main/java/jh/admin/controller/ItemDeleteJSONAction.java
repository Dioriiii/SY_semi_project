package jh.admin.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import common.controller.AbstractController;
import jh.user.domain.UserVO;
import jh.myshop.model.*;

public class ItemDeleteJSONAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		UserVO loginuser = (UserVO)session.getAttribute("loginuser");
		
		if(session.getAttribute("loginuser") != null && "admin@naver.com".equals(loginuser.getUserid())) {
			// 관리자로 로그인 하여 접근한 경우
			ItemDAO itdao = new ItemDAO_imple();
			
			int n = 0;
			
			String it_seq_no = request.getParameter("it_seq_no");
			
			try {
				n = itdao.deleteItem(it_seq_no);
			} catch (Exception e) {
				
			}
			
			JSONObject jsobj = new JSONObject();  
			jsobj.put("n", n);
			// {"n":1} 또는 {"n":0}
			
			String json = jsobj.toString();
			// 문자열 형태로 변환해줌.
			//  "{"n":1}" 또는 "{"n":0}"
		
			request.setAttribute("json", json);

			// super.setRedirect(false);
			super.setViewPage("/WEB-INF/jh/jsonview.jsp");
			
		}
		else {
			// 관리자로 로그인 하여 접근하지 않은 경우
			request.setAttribute("message", "접근할 수 없는 페이지입니다.");
			request.setAttribute("loc", request.getContextPath() + "/index.tam");

			super.setRedirect(false);
			super.setViewPage("/WEB-INF/jh/msg.jsp");
		}
		
	}

}
