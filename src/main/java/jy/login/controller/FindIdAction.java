package jy.login.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import jh.user.domain.UserVO;

public class FindIdAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		UserVO loginuser = (UserVO) session.getAttribute("loginuser");
		
		if(loginuser != null) { // 로그인 중일때,
			String message = "이미 로그인 중입니다.";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/jy/msg.jsp");
		}
		else {
			super.setViewPage("/WEB-INF/jy/login/findId.jsp");
		}
		
		
	}

}
