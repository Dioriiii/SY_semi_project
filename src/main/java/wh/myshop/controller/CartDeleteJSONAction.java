package wh.myshop.controller;

import java.sql.SQLException;
import java.util.*;

import wh.myshop.model.CartDAO;
import wh.myshop.model.CartDAO_imple;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import common.controller.AbstractController;
import jh.myshop.domain.*;
import jh.myshop.model.*;
import jh.user.domain.*;
import jh.user.model.*;

public class CartDeleteJSONAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		String method = request.getMethod();
	      
	      if(!"POST".equalsIgnoreCase(method)) {
	         // GET 방식이라면
	         
	         String message = "비정상적인 경로로 들어왔습니다";
	         String loc = "javascript:history.back()";
	         
	         request.setAttribute("message", message);
	         request.setAttribute("loc", loc);
	         
	         super.setViewPage("/WEB-INF/msg.jsp");
	         return;
	    }
		
		
	      else if("POST".equalsIgnoreCase(method)) {
		
		String userid = request.getParameter("userid");  
		
		CartDAO cdao = new CartDAO_imple();
		
		// 장바구니 테이블에서 특정제품을 장바구니에서 비우기
		int n = cdao.deleteCartInfo(userid); 
		
		JSONObject jsonObj = new JSONObject();	// {}
		
		jsonObj.put("n",n);		
		
		String json = jsonObj.toString();
		//System.out.println("json : " + json);
		
		request.setAttribute("json", json);
				
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/wh/jsonview.jsp");
		
	    }	
		
		
		
	}

}
