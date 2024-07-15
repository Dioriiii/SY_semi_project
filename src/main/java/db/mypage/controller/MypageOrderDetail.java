package db.mypage.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import db.mypage.orderInfo.domain.*;
import jh.user.domain.*;
import db.mypage.orderInfo.model.OrderInfoDAO;
import db.mypage.orderInfo.model.OrderInfoDAO_imple;

public class MypageOrderDetail extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// get방식으로 들어온다.. 단, 로그인 유무를 체크해야된다.
		HttpSession session = request.getSession();
		UserVO loginuser = (UserVO) session.getAttribute("loginuser");
	//	System.out.println("loginuser => "+ loginuser);
		
		
		String message = "";
		String loc = "";
		
		if(loginuser == null) {
		//로그인이 되어 있지 않은 경우
			// 로그인 페이지로 보내버린다.
			
			message = "마이페이지는 로그인 후 이용 가능합니다.";
			loc = request.getContextPath()+"/login/login.tam";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/db/msg.jsp");
			return;
		}
		else {
		// 로그인을 한 경우
			
			String userid = loginuser.getUserid();
			String order_seq_no = request.getParameter("order_seq_no");
			
			try {
				// get방식으로 입력해온 주소가 정상이 아니다
				Long.parseLong(order_seq_no);
			} catch (NumberFormatException e) {
				message = "마이페이지를 이용하여 주십시오.";
				loc = request.getContextPath()+"/mypage/mypage.tam";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/db/msg.jsp");
				
				return;
			}
			
			// 주문일련번호가 정상이라면
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("userid", userid);
			paraMap.put("order_seq_no", order_seq_no);

			OrderInfoDAO oidao = new OrderInfoDAO_imple();

	// ** tbl_order 주문일련번호 -> 수령인, 수령인 연락처, 우편번호, 배송수령지(상세주소 참고사항) , 주문일자, 주문번호, 총금액 ** //
			UserVO uservo = oidao.getOrderInfo(paraMap);
			// 다른 사용자의 주문일련번호을 주소에 입력할 경우 uservo == null 이다.

			request.setAttribute("uservo", uservo);

			if (uservo != null) {
			// 로그인한 사용자의 주문일련번호인 경우
				
			// ** 주문일련번호 => 제품일련번호 -> 제품명, 구매수량, 구매가격, 용량, 진행상황, 제품메인이미지파일 ** //
				List<UserVO> uvoList = oidao.getOrderDetailInfo(paraMap);

				request.setAttribute("uvoList", uvoList);
			} 
			else {
			// 로그인한 사용자의 주문일련번호가 아닌경우
				message = "마이페이지를 이용하여 주십시오.";
				loc = request.getContextPath()+"/mypage/mypage.tam";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/db/msg.jsp");
				
				return;
			}
			
		} // end of if(loginuser == null) else if -------- 로그인 체크
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/db/mypage/mypageOrderDetail.jsp");
		
	} // end of public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

}
