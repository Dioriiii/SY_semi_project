package wh.myshop.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import common.controller.AbstractController;

import wh.myshop.model.*;

public class BagInsertJSONAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		String userid = request.getParameter("userid");
		String arr_fk_it_seq_no_join = request.getParameter("arr_fk_it_seq_no_join");
		String arr_order_qty_join = request.getParameter("arr_order_qty_join");
		
		//System.out.println("userid => "+userid);
		//System.out.println("arr_fk_it_seq_no_join => "+arr_fk_it_seq_no_join);
		//System.out.println("arr_order_qty_join => "+arr_order_qty_join);
		
		
		
		String[] arr_fk_it_seq_no = arr_fk_it_seq_no_join.split("\\,");
		String[] arr_order_qty = arr_order_qty_join.split("\\,");

		//System.out.println("arr_fk_it_seq_no => "+arr_fk_it_seq_no);
		//System.out.println("arr_order_qty => "+arr_order_qty);
		
		
		
		CartDAO cdao = new CartDAO_imple();
		
        Map<String, String[]> paraMap = new HashMap<>();
        paraMap.put("arr_fk_it_seq_no", arr_fk_it_seq_no);
        paraMap.put("arr_order_qty", arr_order_qty);
        
        
		
			
	      
	        
		int isSuccess = cdao.insertBagItem(paraMap,userid);
	
			
				
		JSONObject jsobj = new JSONObject(); // {}
	    jsobj.put("isSuccess", isSuccess);	 // {"isSuccess":1} 또는 {"isSuccess":0}
	    //System.out.println("isSuccess : "+ isSuccess);	
	   
	    String json = jsobj.toString();
        request.setAttribute("json", json);
       
        super.setRedirect(false);
        super.setViewPage("/WEB-INF/wh/jsonview.jsp");
		
		
		
	}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	}


