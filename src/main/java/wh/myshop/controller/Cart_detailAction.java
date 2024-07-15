package wh.myshop.controller;

import java.sql.*;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import wh.myshop.domain.CartVO;
import wh.myshop.model.CartDAO;
import wh.myshop.model.CartDAO_imple;
import jh.myshop.model.*;
import jh.myshop.domain.CategoryVO;
import jh.myshop.domain.ImageVO;
import jh.user.domain.*;
import jh.user.model.*;



public class Cart_detailAction extends AbstractController {

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
		
	      
	      
		String userid = request.getParameter("userid");
		// System.out.println(userid);
		request.setAttribute("userid", userid); 
		
		CartDAO cdao = new CartDAO_imple();
			  
	    List<CartVO> shopBagList = cdao.shopBagInfo(userid); 
		  
	    request.setAttribute("shopBagList", shopBagList); 
	    
	
			  
		super.setRedirect(false); 
		super.setViewPage("/WEB-INF/wh/cart_detail.jsp");
		
	}

}
