package jh.admin.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import jh.user.domain.UserVO;
import jh.mypage.orderInfo.domain.*;
import jh.mypage.orderInfo.model.*;

public class AdminOrderAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		UserVO loginuser = (UserVO)session.getAttribute("loginuser");
		
		if(session.getAttribute("loginuser") != null && "admin@naver.com".equals(loginuser.getUserid())) {
			
			// 관리자로 로그인 하여 접근한 경우
			
			DetailDAO dtdao = new DetailDAO_imple(); 
			OrderDAO oddao = new OrderDAO_imple();
			
			
			// 주문정보에 대해 조회하는 메소드
			List<OrderVO> orderOneList = oddao.selectOneOrderList();
			if(orderOneList.size() != 0) {
				request.setAttribute("orderOneList", orderOneList);
			}
			
			
			// 모든 주문을 조회하는 메소드
			List<DetailVO> orderAllList = dtdao.selectAllOrderList();
			if(orderAllList.size() != 0) {
				request.setAttribute("orderAllList", orderAllList);
			}
			
			
			// Ajax(JSON)를 사용하여 주문목록을 "스크롤" 방식으로 페이징 처리
			int totalOrderCount = oddao.totalOrderCount(); // HIT 상품의 전체개수를 알아온다.
			
			// System.out.println("확인용 totalHITCount : " + totalHITCount);
			// 확인용 totalHITCount : 36
			
			request.setAttribute("totalOrderCount", totalOrderCount);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/jh/admin/adminOrder.jsp");
			
		}
		else {
			// 관리자로 로그인 하여 접근하지 않은 경우
			request.setAttribute("message", "접근할 수 없는 페이지입니다.");
			request.setAttribute("loc", request.getContextPath() + "/index.tam");

			super.setRedirect(false);
			super.setViewPage("/WEB-INF/jh/msg.jsp");
		}
		
	}

}
