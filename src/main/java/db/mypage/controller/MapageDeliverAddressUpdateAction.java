package db.mypage.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import common.controller.AbstractController;
import jh.user.domain.UserVO;
import db.mypage.orderInfo.model.*;

public class MapageDeliverAddressUpdateAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		UserVO loginuser = (UserVO) session.getAttribute("loginuser");
		
		if(loginuser == null) {
		// 로그인되어 있지 않은 경우
		}
		else {
		// 로그인되어 있는 경우
			OrderInfoDAO indao = new OrderInfoDAO_imple();
			
			String order_seq_no = request.getParameter("order_seq_no");
			String name = request.getParameter("name");
			String postcode = request.getParameter("postcode");
			String address = request.getParameter("address");
			String detailAddress = request.getParameter("detailAddress");
			String user_mobile = request.getParameter("user_mobile");
			String extraAddress = request.getParameter("extraAddress");
			
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("order_seq_no", order_seq_no);
			paraMap.put("name", name);
			paraMap.put("postcode", postcode);
			paraMap.put("address", address);
			paraMap.put("detailAddress", detailAddress);
			paraMap.put("user_mobile", user_mobile);
			paraMap.put("extraAddress", extraAddress);
			
			// ** 주문상세페이지에서 tbl_order 테이블 우편번호, 배송수령지, 배송상세주소, 배송참고항목 변경 ** //
			boolean UpdateCheck = indao.setDetailAddressUpdate(paraMap);
				// 업데이트 성공시 true
			
			JSONObject jsonObj = new JSONObject(); // {}
			jsonObj.put("UpdateCheck", UpdateCheck); // {"UpdateCheck": true, false}
			
			String json = jsonObj.toString();
		//	System.out.println("확인용 json ==> " + json);
			// {"UpdateCheck":true}
			request.setAttribute("json", json);
			
		} // end of if(loginuser == null) else -------------------
	
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/db/jsonview.jsp");
	}// public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception { ----

}
