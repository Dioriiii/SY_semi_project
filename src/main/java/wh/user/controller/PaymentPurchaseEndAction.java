package wh.user.controller;

import java.sql.SQLException;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import jh.user.model.*;

import jh.myshop.domain.CategoryVO;
import jh.myshop.domain.ImageVO;
import jh.myshop.model.ImageDAO;
import jh.myshop.model.ImageDAO_imple;
import jh.myshop.model.CategoryDAO;
import jh.myshop.model.CategoryDAO_imple;

import jh.user.domain.HeartVO;
import jh.user.domain.UserVO;


public class PaymentPurchaseEndAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// 원포트(구 아임포트) 결제창을 하기 위한 전제조건은 먼저 로그인을 해야 하는 것이다.
			
				

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
				
		
		
		
				
				String userid = request.getParameter("userid");
				System.out.println("userid => "+userid);
				HttpSession session = request.getSession();
				UserVO loginuser = (UserVO)session.getAttribute("loginuser");
				
				if(loginuser.getUserid().equals(userid)) {
					// 로그인 한 사용자가 자신의 장바구니의 제품을 결제하는 경우
					
					String payment_price = request.getParameter("payment_price");
					System.out.println("payment_price => "+payment_price);
					String productName = "상품결제"; // 제품 이름
					int productPrice = 100;
					
					request.setAttribute("productName", productName);
					request.setAttribute("productPrice", productPrice);
					request.setAttribute("email", loginuser.getEmail());
					request.setAttribute("name", loginuser.getName());
					request.setAttribute("mobile", loginuser.getMobile());
					
					request.setAttribute("userid", userid);
					request.setAttribute("payment_price", payment_price);
					
					super.setRedirect(false);
					super.setViewPage("/WEB-INF/wh/paymentGateway.jsp");
					
				}
				
				else {
					// 로그인 한 사용자가 다른 사용자의 장바구니 안의 제품을 구매하려고 결제를 시도하는 경우
					String message="다른 사용자의 장바구니 제품 결제 시도는 불가합니다!!";
					String loc="javascript:history.back()";
					
					request.setAttribute("message", message);
					request.setAttribute("loc", loc);
					
					super.setRedirect(false);
					super.setViewPage("/WEB-INF/msg.jsp");
				}
				
				
				
				
			
			/*
			 else {
			 
				// 로그인을 안했으면
				String message="코인충전 결제를 하기 위해서는 먼저 로그인을 하세요!!!";
				String loc="javascript:history.back()";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
				
			}
			*/
		
	}

}
