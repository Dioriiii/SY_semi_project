package ws.admin.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import common.controller.AbstractController;
import ws.shop.domain.*;
import ws.shop.model.*;

public class CateListJSONAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		

		ItemDAO idao = new ItemDAO_imple();
		
		// tbl_category 테이블에서 카테고리 아이디, 카테고리 이름, 사용방법, 주의사항, 사용기한을 조회해오기 (카테고리 가져오는 용)
		List<CategoryVO> cateList = idao.searchCategoryList();
		
		JSONArray jsonArr = new JSONArray();
		
		if(cateList.size() > 0) {
			for(CategoryVO cvo : cateList) {
				
				JSONObject jsonObj= new JSONObject();
				jsonObj.put("ca_id", cvo.getCa_id());   
				jsonObj.put("ca_name", cvo.getCa_name()); 
				
		        jsonArr.put(jsonObj); 
				
			} // end of for------------------
			
		}// end of if(cateList.size() > 0)------------------
		
		String json = jsonArr.toString(); // 문자열로 변환
		// System.out.println(json);
		// [{"ca_name":"샤워리바디","ca_id":"bw"},{"ca_name":"퍼퓸","ca_id":"pf"},{"ca_name":"퍼퓸 핸드","ca_id":"ph"},{"ca_name":"퍼퓸 비누","ca_id":"ps"},{"ca_name":"튜브 핸드","ca_id":"th"}]
		request.setAttribute("json", json);
		
		super.setRedirect(false);
	    super.setViewPage("/WEB-INF/ws/jsonview.jsp");   

	}

}
