package wh.myshop.controller;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import wh.myshop.domain.CartVO;
import wh.myshop.model.*;

import jh.myshop.domain.CategoryVO;
import jh.myshop.domain.ImageVO;
import jh.myshop.model.ImageDAO;
import jh.myshop.model.ImageDAO_imple;
import jh.myshop.model.CategoryDAO;
import jh.myshop.model.CategoryDAO_imple;
import jh.user.model.*;

import jh.user.domain.HeartVO;
import jh.user.domain.UserVO;

public class Order_paymentAction extends AbstractController {

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
		  // System.out.println("userid =>" + userid);
		  request.setAttribute("userid", userid); 
		 
		  CartDAO cdao = new CartDAO_imple();
			  
	      List<CartVO> orderList = cdao.orderListInfo(userid); 
		    
	      request.setAttribute("orderList", orderList); 
	    
		
		
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/wh/order_payment.jsp");
		
		
	}

}
