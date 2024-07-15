package ws.admin.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import common.controller.AbstractController;
import ws.shop.domain.DetailVO;
import ws.shop.model.*;

public class ItemByCategoryListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String ca_id = request.getParameter("ca_id");
		
		ItemDAO idao = new ItemDAO_imple();
		
		System.out.println(ca_id);
		//bw
		List<DetailVO> d_itemList = idao.itemSelectList(ca_id);
		
		System.out.println(d_itemList.toString());
		
		
		JSONArray jsonArr = new JSONArray();
		
		//
		
		if(d_itemList.size() > 0) {
			for(DetailVO dvo : d_itemList) {
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("it_seq_no",dvo.getIvo().getIt_seq_no());  
				jsonObj.put("it_name",dvo.getIvo().getIt_name());
				jsonObj.put("it_price",dvo.getIvo().getIt_price());
				jsonObj.put("ca_name",dvo.getIvo().getCvo().getCa_name());
				jsonObj.put("it_theme",dvo.getIvo().getIt_theme());
				jsonObj.put("it_volume",dvo.getIvo().getIt_volume());
				jsonObj.put("it_stock",dvo.getIvo().getIt_stock());
				jsonObj.put("it_status",dvo.getIvo().getIt_status());
				jsonObj.put("it_create_date",dvo.getIvo().getIt_create_date());
				
				jsonObj.put("img_file",dvo.getIvo().getImvo().getImg_file());
				
				jsonArr.put(jsonObj);
				
			} // end of for---------------------
		}// end of if-----------------------------------------
		
		String json = jsonArr.toString();
		//System.out.println(json);
		
		request.setAttribute("json", json);
		
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/ws/jsonview.jsp");
		
	}

}
