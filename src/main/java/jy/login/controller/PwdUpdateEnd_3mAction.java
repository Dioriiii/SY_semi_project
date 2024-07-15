package jy.login.controller;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import jh.user.domain.UserVO;
import jy.login.model.UserDAO;
import jy.login.model.UserDAO_imple;

public class PwdUpdateEnd_3mAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod(); // "GET" 또는 "POST" 
		
		HttpSession session = request.getSession();
		UserVO loginuser = (UserVO) session.getAttribute("loginuser");
		
		if("POST".equalsIgnoreCase(method)) {
			// "POST" 방식으로 넘어온 것이라면
			
	//		String userid = "test1@naver.com";
			String userid = loginuser.getUserid();
			String new_pwd = request.getParameter("new_pwd");			
			
			UserDAO udao = new UserDAO_imple();
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("userid", userid);
			paraMap.put("new_pwd", new_pwd);
			
			System.out.println("new_pwd =>"+new_pwd);
			int n = 0;
			
			String message = "";
			String loc = "";
			
			try {
				 n = udao.pwdUpdate(paraMap);
				 
				 if(n==1) {
					 
				//	 loginuser.setPwd(new_pwd);
					 
					 message = "비밀번호가 변경되었습니다.";
					 loc = request.getContextPath()+"/main.tam";// 시작페이지로 이동한다.					 
				 }
				 
			} catch (SQLException e) {
				
				message = "SQL 구문 에러발생";
				loc = "javascript:history.back()";// 자바스크립트를 이용한 이전페이지로 이동하는 것.
				e.printStackTrace();				
			}

			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
		}// end of if("POST".equalsIgnoreCase(method))-------
		
		else { // 90일 뒤 변경으로 눌렀을 때
			
			String userid = loginuser.getUserid();
			
			UserDAO udao = new UserDAO_imple();
			
			int n = 0;
			
			String message = "";
			String loc = "";
			
			try {
				 n = udao.nextUpdate(userid);
				 
				 if(n==1) {
					 
				//	 loginuser.setPwd(new_pwd);
					 
					 message = "새로운 비밀번호는 90일 뒤에 변경해주세요.\\n메인페이지로 이동합니다.";
					 loc = request.getContextPath()+"/main.tam";// 시작페이지로 이동한다.					 
				 }
				 
			} catch (SQLException e) {
				
				message = "SQL 구문 에러발생";
				loc = "javascript:history.back()";// 자바스크립트를 이용한 이전페이지로 이동하는 것.
				e.printStackTrace();				
			}

			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
		}
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/jy/msg.jsp");
		
	}

}
