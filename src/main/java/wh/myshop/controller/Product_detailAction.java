package wh.myshop.controller;

import java.sql.SQLException;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import jh.myshop.domain.CategoryVO;
import jh.myshop.domain.ImageVO;
import jh.myshop.model.ImageDAO;
import jh.myshop.model.ImageDAO_imple;
import jh.myshop.model.CategoryDAO;
import jh.myshop.model.CategoryDAO_imple;
import jh.user.domain.HeartVO;
import jh.user.domain.UserVO;
import jh.user.model.HeartDAO;
import jh.user.model.HeartDAO_imple;
import wh.myshop.domain.CartVO;
import wh.myshop.domain.ItemVO;
import wh.myshop.model.CartDAO;
import wh.myshop.model.CartDAO_imple;
import wh.myshop.model.ItemDAO;
import wh.myshop.model.ItemDAO_imple;

public class Product_detailAction extends AbstractController {

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
	         UserVO loginuser = (UserVO)session.getAttribute("loginuser");
	         
	         if(loginuser != null) {
	            List<HeartVO> heartList = hdao.heartUser(loginuser);
	            request.setAttribute("heartList", heartList);
	         
	         
	         }
	         
	         //super.setRedirect(false);
	         //super.setViewPage("/WEB-INF/jh/index.jsp");
	         
	      } catch (SQLException e) {
	         e.printStackTrace();
	         super.setRedirect(true);
	         super.setViewPage(request.getContextPath() + "/error.tam");
	      }
		
	    // ID 관련 끝 
	      
	      
	   // index 페이지에서 제품 클릭 시 받아옴.
	      String it_seq_no =  request.getParameter("it_seq_no");
	      
	      CartDAO cdao = new CartDAO_imple();
	      ItemDAO idao = new ItemDAO_imple();
	      
          Map<String, String> paraMap = new HashMap<>();
			paraMap.put("it_seq_no", it_seq_no);
			 
			
			List<ItemVO> infoList = idao.itemInfoAll(paraMap); 
			List<CartVO> cartList = cdao.cartItemInfo(paraMap); 
			
			
			request.setAttribute("infoList", infoList); 
			request.setAttribute("cartList", cartList); 
			  
			  // System.out.println(infoList.get(0).getCategvo().getCa_name());
			  /*
			      for(ItemVO info : infoList) {
			   
				  System.out.println("infoList :" +info.getImgvo().getImg_file());
				  
			  }
			  */
			request.setAttribute("it_seq_no", it_seq_no);
			  
			super.setRedirect(false); 
		    super.setViewPage("/WEB-INF/wh/product_detail.jsp"); 
	      
	      
	      
	      
	      
	      
		
	}

}
