package jy.mypage.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import jh.user.domain.UserVO;

public class MyPageInfoPwdAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		HttpSession session = request.getSession();
		UserVO loginuser = (UserVO) session.getAttribute("loginuser");
		
		// 내정보(회원정보)를 수정하기 위한 전제조건은 먼저 로그인을 해야 하는 것이다.
		if(loginuser != null) {
			
			// 로그인을 했으면
			String userid = loginuser.getUserid();
			
			if(loginuser.getUserid().equals(userid)) {
				// 로그인한 사용자가 자신의 정보를 수정하는 경우 - ok
				
				request.setAttribute("userid", userid);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/jy/mypage/mypageInfo_pwd.jsp");
				
			}
			else {
				// 로그인한 사용자가 다른 사용자의 정보를 수정하는 경우
				String message = "다른 사용자의 정보 변경은 불가합니다!!";
				String loc = request.getContextPath()+"/index.tam";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/jy/msg.jsp");
			}
			
		}
		
		else {
			// 로그인을 안 했으면
			String message = "회원정보를 수정하기 위해서는 먼저 로그인을 하세요!!";
			String loc = request.getContextPath()+"/login.tam";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/jy/msg.jsp");
		}
	}
}
