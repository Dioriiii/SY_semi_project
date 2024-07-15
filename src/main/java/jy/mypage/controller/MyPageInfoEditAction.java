package jy.mypage.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import jh.user.domain.UserVO;
import jy.login.model.UserDAO;
import jy.login.model.UserDAO_imple;

public class MyPageInfoEditAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod(); // "GET" 또는 "POST"
		
		if("post".equalsIgnoreCase(method)) { // "POST" 방식으로 접근
		
			if(super.checkLogin(request)) {
				
				HttpSession session = request.getSession();
				UserVO loginuser = (UserVO) session.getAttribute("loginuser");
				
				// 입력받은 비밀번호
				String pwd = request.getParameter("pwd");
				String userid = loginuser.getUserid();
				
				Map<String, String> paraMap = new HashMap <>();
				paraMap.put("pwd", pwd);
				paraMap.put("userid", userid);
				
				UserDAO udao = new UserDAO_imple();
				
				boolean isMatch =  udao.pwdCheck(paraMap);
				
				if(isMatch) {
					request.setAttribute("userid", userid);
					request.setAttribute("name", loginuser.getName());
					request.setAttribute("mobile", loginuser.getMobile());
					request.setAttribute("postcode", loginuser.getPostcode());
					request.setAttribute("address", loginuser.getAddress());
					request.setAttribute("detailaddress", loginuser.getDetailaddress());
					request.setAttribute("extraaddress", loginuser.getExtraaddress());
					
					super.setRedirect(false);
					super.setViewPage("/WEB-INF/jy/mypage/mypageInfo_edit.jsp");
				}
				
				else {
					
					String message = "비밀번호가 일치하지 않습니다";
					String loc = "javascript:history.back()";
					
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
		
		else {
			
			String message = "올바른 접근이 아닙니다.";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/jy/msg.jsp");
		}
		
	}

}
