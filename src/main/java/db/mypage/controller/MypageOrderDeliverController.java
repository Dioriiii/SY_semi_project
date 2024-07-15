package db.mypage.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import db.mypage.orderInfo.domain.*;
import jh.user.domain.*;
import db.mypage.orderInfo.model.*;
import oracle.net.aso.l;

public class MypageOrderDeliverController extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		UserVO loginuser = (UserVO) session.getAttribute("loginuser");
		
		String message = "";
		String loc = "";
		
		if(loginuser == null) {
		//로그인이 되어 있지 않은 경우
			// 로그인 페이지로 보내버린다.
			
			message = "마이페이지는 로그인 후 이용 가능합니다.";
			loc = "/tempSemi/login/login.tam";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/db/msg.jsp");
			return;
		}
		else {
		// 로그인이 되어 있는 경우
			String userid = loginuser.getUserid();
			
			OrderInfoDAO oidao = new OrderInfoDAO_imple();
			
			// ** userid를 통해서 주문일자, 주문일련번호, 제품일련번호, 제품명, 용량, 주문수량, 주문금액, 주문상태, 이미지 ** //		
			List<List<UserVO>> userListInList = oidao.getOrderDeliverInfoView(userid);
			
			
			request.setAttribute("userListInList", userListInList);
		}
		
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/db/mypage/mypageOrderDeliver.jsp");
	} // end of public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

}
