package jy.mypage.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import common.controller.AbstractController;
import jh.user.domain.UserVO;
import jy.login.model.UserDAO;
import jy.login.model.UserDAO_imple;

public class MyPagePwdCheckAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
			if("POST".equalsIgnoreCase(method)) {
			
				HttpSession session = request.getSession();
				UserVO loginuser = (UserVO) session.getAttribute("loginuser");
				
				String pwd = request.getParameter("pwd");
				String userid = loginuser.getUserid();
				
				Map<String, String> paraMap = new HashMap <>();
				paraMap.put("pwd", pwd);
				paraMap.put("userid", userid);
				
				UserDAO udao = new UserDAO_imple();
				
				boolean isMatch = udao.pwdCheck(paraMap);
				
				JSONObject jsonObj = new JSONObject(); // { }
				jsonObj.put("isMatch",isMatch);	   //
				
				String json = jsonObj.toString(); // 문자열 형태인 "{"isMatch":true}" 또는 "{"isMatch":false}" 으로 만들어준다.
				// System.out.println(">>> 확인용 json => " + json);

				
				request.setAttribute("json", json);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/jy/jsonview.jsp");
				
				/*
				HttpSession session = request.getSession();
				UserVO loginuser = (UserVO) session.getAttribute("loginuser");
					
				String pwd = request.getParameter("pwd");
				String user_pwd = "qq1234";
				// String user_pwd = loginuser.getPwd();
				
				// System.out.println("~~확인용~~ pwd =>" +pwd);
				// System.out.println("~~확인용~~ user_pwd =>" +user_pwd);
				
				boolean isMatch = false;
				
				if(pwd.equals(user_pwd)) {
					isMatch = true;			
					System.out.println("~~확인용~~ isMatch =>" +isMatch);
				}
				
			
				JSONObject jsonObj = new JSONObject(); // { }
				jsonObj.put("isMatch",isMatch);	   //
				
				String json = jsonObj.toString(); // 문자열 형태인 "{"isMatch":true}" 또는 "{"isMatch":false}" 으로 만들어준다.
				// System.out.println(">>> 확인용 json => " + json);

				
				request.setAttribute("json", json);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/jy/jsonview.jsp");
				*/
		}
	}


}
