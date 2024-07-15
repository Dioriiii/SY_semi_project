package jh.login.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.text.Document;

import common.controller.AbstractController;
import jh.myshop.domain.ImageVO;
import jh.user.domain.*;
import jh.user.model.*;

public class LoginCheckAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String method = request.getMethod(); // "GET" 또는 "POST"	
		
		if(!"POST".equalsIgnoreCase(method)) {
			// POST 방식으로 넘어온것이 아니라면
			String message = "비정상적인 경로로 접근하셨습니다!";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			// super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			
			return; // execute(HttpServletRequest request, HttpServletResponse response) 메소드 종료
		}
	
		// POST 방식으로 넘어왔다면
		String userid = request.getParameter("userid");
		String pwd= request.getParameter("pwd");
		
		// 클라이언트에 접속한 아이피 주소 알아오기
		String login_ip = request.getRemoteAddr();
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("userid", userid);
		paraMap.put("pwd", pwd);
		paraMap.put("login_ip", login_ip);
		
		UserDAO udao = new UserDAO_imple();
		
		UserVO loginuser = udao.selectOneMember(paraMap);
		if(loginuser != null) {
			
			if(loginuser.getStatus() == 2) {
				// 마지막으로 로그인 한 것이 1년 이상 지난 경우
				
				String sleepUserid = paraMap.get("userid");
				
				// 휴면회원의 status를 1(활동중)로 변경하는 메소드
				udao.changeStatus(sleepUserid);
				
				String message = "회원님의 계정이 휴면해제 처리 되었습니다.\\n확인을 누르시면 로그인 화면으로 이동합니다.";
				String loc = request.getContextPath() + "/login/pwdUpdate_3m.tam";
				
				HttpSession session = request.getSession();
				session.setAttribute("loginuser", loginuser);
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/jh/msg.jsp");
				
				return; // 메소드 종료
			}
			// 로그인 성공시 세션에 로그인정보 저장
			// System.out.println(">>> 확인용 로그인한 사용자명 : " + loginuser.getName());
			
			HttpSession session = request.getSession();
			// WAS 매모리에 생성되어져 있는 session을 불러오는 것이다.
			
			session.setAttribute("loginuser", loginuser);
			// 세션(session)에 로그인되어진 사용자 정보인 loginuser 의 키이름을 "loginuser" 로 저장시켜두는 것이다.
			
			
			if (loginuser.isRequirePwdChange()) {
				// 비밀번호를 변경한지 3개월 이상 지난 경우
				String message = "비밀번호를 변경하신지 3개월이 지났습니다!\\n암호를 변경하는 페이지로 이동합니다!";
				String loc = request.getContextPath() + "/login/pwdUpdate_3m.tam";
				// 원래는 위와 같이 index.up 이 아니라 암호 변경 페이지로 URL을 잡아줘야 한다!!  
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/jh/msg.jsp");
				
				return; // 메소드 종료
			}
			else {
				// 비밀번호를 변경한지 3개월 미만인 경우
				 
				// 페이지 이동을 시킨다.
				super.setRedirect(true);
				
				// 로그인을 하면 시작페이지index.up)로 가는 것이 아니라 로그인을 시도하려고 머물렀던 그 페이지로 가기 위한 것이다)
				String goBackURL = (String) session.getAttribute("goBackURL");
				// System.out.println(goBackURL);
				// null
				// 또는
				// /shop/prodView.up?pnum=13
				// /shop/prodView.up?pnum=4
				
				if(goBackURL != null) {
					super.setViewPage(request.getContextPath()+ goBackURL);
				}
				
				else {
					super.setViewPage(request.getContextPath()+ "/main.tam"); // 시작페이지로 이동
				}
			}
			
			
		}
		else {
			
			System.out.println("로그인 실패(로그인체크액션)");
			
			String message = "가입된 회원아이디가 아니거나 비밀번호가 틀립니다!\\n비밀번호는 대소문자를 구분합니다.";
			String loc = request.getContextPath() + "/login/login.tam";
			// 원래는 위와 같이 index.up 이 아니라 휴면해제 페이지로 URL을 잡아줘야 한다!!  
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/jh/msg.jsp");
			
		}
		
	}

}
