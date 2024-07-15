package jy.store.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import common.controller.AbstractController;
import jy.store.domain.StoreVO;
import jy.store.model.StoreDAO;
import jy.store.model.StoreDAO_imple;

public class FindStoreLocationJSON extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		
		String storeno = request.getParameter("storeno");
		
		StoreDAO stdo = new StoreDAO_imple();
		StoreVO svo = stdo.seletStoreInfo(storeno);
		
		
		JSONObject jsonObj = new JSONObject();
		
		jsonObj.put("svo", svo);
		
		String json = jsonObj.toString(); // 문자열 형태인 "{"isMatch":true}" 또는 "{"isMatch":false}" 으로 만들어준다.
	    System.out.println(">>> 확인용 json => " + json);

		
		request.setAttribute("json", json);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/jy/jsonview.jsp");
	}
		
}
