package jh.index.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import common.controller.AbstractController;
import jh.user.model.*;

public class PlusHeartJSONAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String userid = request.getParameter("userid");
		String it_seq_no = request.getParameter("it_seq_no");
		
		HeartDAO hdao = new HeartDAO_imple();
		
		int result = hdao.plusHeart(userid, it_seq_no);
		
		JSONArray jsonArr = new JSONArray(); // []로 바꿔줌
		JSONObject jsonObj = new JSONObject();// {}로 바꿔줌
		
		// jsonObj.putOpt{"키":값}
		jsonObj.putOpt("heart", result); 
		jsonArr.put(jsonObj);
		
		request.setAttribute("json", jsonArr);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/jh/jsonview.jsp");
	}

}
