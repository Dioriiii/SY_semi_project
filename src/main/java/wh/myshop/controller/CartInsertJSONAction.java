package wh.myshop.controller;

import java.sql.SQLException;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.*;

import common.controller.AbstractController;
import jh.user.domain.HeartVO;
import jh.user.domain.UserVO;
import jh.user.model.*;
import jh.myshop.domain.CategoryVO;
import jh.myshop.domain.ImageVO;
import jh.myshop.model.*;


import wh.myshop.model.CartDAO;
import wh.myshop.model.CartDAO_imple;
import wh.myshop.domain.CartVO;

public class CartInsertJSONAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// ID 관련 시작

		ImageDAO imgdao = new ImageDAO_imple();
		CategoryDAO cadao = new CategoryDAO_imple();
		HeartDAO hdao = new HeartDAO_imple();

		try {

			List<ImageVO> imgList = imgdao.imageSelectOne();
			request.setAttribute("imgList", imgList);

			List<CategoryVO> cateList = cadao.categoryCount();
			request.setAttribute("cateList", cateList);

			List<CategoryVO> cateImgList = cadao.categoryHeader();
			request.setAttribute("cateImgList", cateImgList);

			HttpSession session = request.getSession();
			UserVO loginuser = (UserVO) session.getAttribute("loginuser");

			if (loginuser != null) { // 누구인지 모르지만 로그인 상태라면
				List<HeartVO> heartList = hdao.heartUser(loginuser);
				request.setAttribute("heartList", heartList);
			}

			// super.setRedirect(false);
			// super.setViewPage("/WEB-INF/jh/index.jsp");

		} catch (SQLException e) {
			e.printStackTrace();
			super.setRedirect(true);
			super.setViewPage(request.getContextPath() + "/error.tam");
		}

		// ID 관련 끝
		
		
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
        
        
		
			
	      
	        
		int isSuccess = cdao.insertCartItem(paraMap,userid);
		//System.out.println("isSuccess"+ isSuccess);	
	
			
				
			JSONObject jsobj = new JSONObject(); // {}
		    jsobj.put("isSuccess", isSuccess);	 // {"isSuccess":1} 또는 {"isSuccess":0}
		    
		   
		    String json = jsobj.toString();
	        request.setAttribute("json", json);
	       
	        super.setRedirect(false);
	        super.setViewPage("/WEB-INF/wh/jsonview.jsp");
			
			
			}
		

	}


