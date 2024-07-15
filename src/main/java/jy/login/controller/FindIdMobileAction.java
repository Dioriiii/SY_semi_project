package jy.login.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import common.controller.AbstractController;
import jy.login.model.UserDAO;
import jy.login.model.UserDAO_imple;

public class FindIdMobileAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String method = request.getMethod(); // "GET" 또는 "POST"
		
		if("post".equalsIgnoreCase(method)) {

			String mobile = request.getParameter("mobile");
			
			UserDAO udao = new UserDAO_imple();
			
			String userid = udao.findUserid(mobile);
		//	boolean isExists = false;
			
			JSONObject jsonObj = new JSONObject(); // {}
			
			if(userid != null) {
			//	jsonObj.put("isExists",true); // {"isExists":true} 또는 {"isExists":false} 으로 만들어 준다.
				jsonObj.put("userid",userid); 
			}
			
			else {
	//			jsonObj.put("isExists",false); 
			}			
			
			String json = jsonObj.toString(); // 문자열 형태인 "{"isExists":true}" 또는 "{"isExists":false}" 으로 만들어 준다.
			
			System.out.println(">>> 확인용 json => "+json);
		//	>>> 확인용 json => {"isExists":true}
		//	>>> 확인용 json => {"isExists":false}
			
			request.setAttribute("json", json);
	//		request.setAttribute("userid", userid);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/jy/jsonview.jsp");
			
		}		
		
	}

}
