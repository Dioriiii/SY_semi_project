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

public class UserRegisterAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod(); // "GET" 또는 "POST"
		
		if("GET".equalsIgnoreCase(method)) {
//			super.setRedirect(false);
			super.setViewPage("/WEB-INF/jy/login/userRegister.jsp");
		}
		
		else {
			String userid = request.getParameter("userid");
			String pwd = request.getParameter("pwd");
			String name = request.getParameter("name");
			String birthday = request.getParameter("birthday");
			String mobile = request.getParameter("mobile");
			String gender = request.getParameter("gender");
			String postcode = request.getParameter("postcode");
			String address = request.getParameter("address");
			String detailaddress = request.getParameter("detailaddress");
			String extraaddress = request.getParameter("extraaddress");
			
			UserVO user = new UserVO();
			user.setUserid(userid);
			user.setEmail(userid);
			user.setPwd(pwd);
			user.setGender(gender);
			user.setName(name);
			user.setMobile(mobile);
			user.setBirthday(birthday);
			user.setPostcode(postcode);
			user.setAddress(address);
			user.setDetailaddress(detailaddress);
			user.setExtraaddress(extraaddress);
			
			UserDAO udao = new UserDAO_imple();
			
			
			// === 회원가입이 성공되어지면 "회원가입 성공" 이라는 alert를 띄우고 시작페이지로 이동한다. === //
		/*	
		
			String message = "";
			String loc = "";
			
			try {
				int n = udao.registerMember(user);
				if(n==1) {
					message = "회원가입이 완료되었습니다";
					loc = request.getContextPath()+"/login/testStore.tam";// 시작페이지로 이동한다.
				}
				
			} catch(SQLException e){
				message = "SQL 구문 에러발생";
				loc = "javascript:history.back()";// 자바스크립트를 이용한 이전페이지로 이동하는 것.
				e.printStackTrace();
			}
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/jy/msg.jsp");
		*/
		
			// #### 회원가입이 성공되어지면 자동으로 로그인 되도록 하겠다. #### //	
			
			try {
				int n = udao.registerUser(user);
				
				
				if(n==1) {
					request.setAttribute("userid", user.getUserid());
					request.setAttribute("pwd", pwd);
					
					
					super.setRedirect(false);
					super.setViewPage("/WEB-INF/jy/login/register_autoLogin.jsp");
					
				}
				
			} catch(SQLException e){
				e.printStackTrace();
				
				String message = "SQL 구문 에러발생";
				String loc = "javascript:history.back()";// 자바스크립트를 이용한 이전페이지로 이동하는 것.
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
				
			}
			
		}
		
	}

}
