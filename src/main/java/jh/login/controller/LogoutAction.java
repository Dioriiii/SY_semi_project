package jh.login.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import jh.user.domain.UserVO;

public class LogoutAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// 로그아웃 처리하기
		
		// 세션 불러오기
		HttpSession session = request.getSession();
		
		// 로그아웃을 하면 시작페이지로 가는 것이 아니라 방금 보았던 그 페이지로 그대로 가기 위한 것임. 
		String goBackURL = (String) session.getAttribute("goBackURL");
		// System.out.println("~~~확인용 => "+ goBackURL);
		// ~~~확인용 => /shop/prodView.up?pnum=65
		// ~~~확인용 => /shop/mallHomeMore.up
				
		if(goBackURL != null) {
			goBackURL = request.getContextPath()+goBackURL;
		}
		
		UserVO loginuser = (UserVO) session.getAttribute("loginuser");
		
		String login_userid = loginuser.getUserid();
		
		// WAS 메모리 상에서 세션을 아예 삭제해버리기
		session.invalidate();

		super.setRedirect(true);
		
		
		if(goBackURL != null && !"admin".equalsIgnoreCase(login_userid)) {
			// 관리자가 아닌 일반 사용자로 들어와서 돌아갈 페이지가 있다라면 돌아갈 페이지로 돌아간다.
			super.setViewPage(goBackURL);
		}
		
		else {
			// 돌아갈 페이지가 없거나 또는  관리자로 로그아웃을 하면 무조건 /MyMVC/index.up 페이지로 돌아간다.
			super.setViewPage(request.getContextPath()+"/main.tam");
		}
		
	}

}
