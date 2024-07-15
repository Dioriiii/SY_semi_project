package wh.user.controller;

import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import jh.user.model.*;
import jh.user.domain.*;
import wh.myshop.domain.CartVO;
import wh.myshop.domain.OrderVO;
import wh.myshop.model.*;

public class PaymentUpdateLoginUserAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String method = request.getMethod();
		
		if("post".equalsIgnoreCase(method)) {
			// POST 방식
			
			String userid = request.getParameter("userid");					// 주문자 ID
			String payment_price = request.getParameter("payment_price");	// 총 결제금액
			String name = request.getParameter("name");						// 주문자 이름	
			String email1 = request.getParameter("email1");					// 주문자 이메일 앞
			String email2 = request.getParameter("email2");					// 주문자 이메일 뒤
			String email = email1+"@"+email2;
			String mobile = request.getParameter("mobile");					// 주문자 연락처
			String sh_name = request.getParameter("sh_name");				// 수령인 이름
			String sh_mobile = request.getParameter("sh_mobile");			// 수령인 연락처
			String postcode = request.getParameter("postcode");				// 우편번호
			String address = request.getParameter("address");				// 배송지
			String detailAddress = request.getParameter("detailAddress");   // 세부 배송지
			String tomsg = request.getParameter("tomsg");  				    // 기사님께 하는 메세지
				
			/*
			 * System.out.println("확인용 userid => "+userid);
			 * System.out.println("확인용 payment_price => "+payment_price);
			 * System.out.println("확인용 name => "+name);
			 * System.out.println("확인용 email1 => "+email1);
			 * System.out.println("확인용 email2 => "+email2);
			 * System.out.println("확인용 mobile => "+mobile);
			 * System.out.println("확인용 sh_name => "+sh_name);
			 * System.out.println("확인용 sh_mobile => "+sh_mobile);
			 * System.out.println("확인용 address => "+address);
			 * System.out.println("확인용 detailAddress => "+detailAddress);
			 * System.out.println("확인용 tomsg => "+tomsg);
			 */
			
			
			
			
			
			Map<String, String> paraMap = new HashMap<>();
			
			paraMap.put("userid", userid);
			paraMap.put("payment_price", payment_price);
			paraMap.put("name", name);
			paraMap.put("email", email);
			paraMap.put("mobile", mobile);
			paraMap.put("sh_name", sh_name);
			paraMap.put("sh_mobile", sh_mobile);
			paraMap.put("address", address);
			paraMap.put("postcode", postcode);
			paraMap.put("detailAddress", detailAddress);
			paraMap.put("tomsg", tomsg);
			
			OrderDAO odao = new OrderDAO_imple();
			CartDAO cdao = new CartDAO_imple();
			
			List<CartVO> orderList = cdao.orderListInfo(userid);
			
			
			String message = "";
		    String loc = "";
			
			
			try {
				int n = odao.PaymentUpdateLoginUser(paraMap); // DB에 주문내역 추가하기
				System.out.println("tbl_order insert 확인용 ~~~ n =>"+n);
				if(n == 1) {
					
					OrderVO odrvo = odao.paymentListView(userid);
					
					int order_seq_no = odrvo.getOrder_seq_no();
					System.out.println("확인용 ~~~~ order_seq_no : " + order_seq_no);
					
					int isSuccess = odao.PaymentDetailUpdateLoginUser(order_seq_no,orderList);
					System.out.println("tbl_detail insert 확인용 ~~~ isSuccess =>"+isSuccess);
					
					
					
					message = "주문 결제가 완료됐습니다.";
					loc = "mypage/paymentEnd.tam";
					///mypage/paymentEnd.tam
					
					
				}
				
				
			} catch(SQLException e) {
				message = "주문 결제가 완료됐습니다.";
				loc = "mypage/paymentEnd.tam";
			}

			 request.setAttribute("message", message);
		     request.setAttribute("loc", loc);
		      
  	   //    super.setRedirect(false);
	 	     super.setViewPage("/WEB-INF/wh/msg.jsp");
			 
			
			
		}
		else {
			// GET 방식
			
			String message = "비정상적인 경로로 들어왔습니다.";
		    String loc = "javascript:history.back()";
		      
		    request.setAttribute("message", message);
		    request.setAttribute("loc", loc);
		      
	   //   super.setRedirect(false);
		    super.setViewPage("/WEB-INF/wh/msg.jsp");
		}
		
	}

	

}
