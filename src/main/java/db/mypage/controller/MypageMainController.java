package db.mypage.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import db.mypage.orderInfo.domain.*;
import jh.user.domain.*;
import db.mypage.orderInfo.model.*;

public class MypageMainController extends AbstractController {
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 로그인을 체크하고 get방식을 막아주어야 한다.
		HttpSession session = request.getSession();
		UserVO loginuser = (UserVO) session.getAttribute("loginuser");
		
		String message = "";
		String loc = "";
		
		// 로그인을 체크한다.
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
		else if( loginuser != null ) {
		//로그인이 되어 있는경우
			
			// DB 접근 dao
			OrderInfoDAO oidao = new OrderInfoDAO_imple();
		
			String userid = loginuser.getUserid();
		//	System.out.println("접속한 user : "+ userid);
			
			// ** 로그인 유저의 최근 주문일련번호 4개 가져오기 ** //
			List<UserVO> uvoList = oidao.getOrderNoLastFour(userid);
			
			if( uvoList.size() > 0 ) { // 최대길이는 4
			// 주문내역이 존재하는 경우
				
				int uvoList_ind = 0;
				
				for(UserVO uvo :uvoList) {
					String order_seq_no = uvo.getOvo().getOrder_seq_no();
					
					// 446852766
					
					// ** 가져온 주문일련번호 안의 주문상세일련번호 중 가장 비싼 상품이름, 수량, 진행상황, 이미지파일 가져오기 ** //				
					UserVO uvo_getFromImple = oidao.getMostExpensivProd(order_seq_no);
					
					uvoList.get(uvoList_ind).setItvo(uvo_getFromImple.getItvo());	// 상품명
					uvoList.get(uvoList_ind).setDvo(uvo_getFromImple.getDvo());		// 수량, 진행상황
					uvoList.get(uvoList_ind).setImvo(uvo_getFromImple.getImvo());	// 이미지파일
					
					int o_qty = uvo_getFromImple.getDvo().getO_qty(); // 제일비싼 상품 수량
					// 뒤에 구할 총 제품수에서 뺀다.
					
					// ** 주문일련번호의 총 구매제품수, 총 구매가격 가져오기 ** //
					Map<String, String> getMap = new HashMap<>();
					getMap = oidao.getTotalProgress(order_seq_no);
					
					// 하나의 제품을 여러개 주문한 경우 총 구매제품수는 0이된다.
					uvoList.get(uvoList_ind).setTotal_o_qty(Integer.parseInt(getMap.get("total_o_qty"))-o_qty);
					uvoList.get(uvoList_ind).setTotal_o_price(Integer.parseInt(getMap.get("total_o_price")));
					
					uvoList_ind++;
					
				}// end of for(UserVO uvo :uvoList) ----------

				request.setAttribute("uvoList", uvoList);
			} // end of if( !(uvoList.size() > 0) ) else -----------------------
			
		} // end of if(loginuser == null) else if ----------------------
	
		
//		super.setRedirect(false);
		super.setViewPage("/WEB-INF/db/mypage/mypageMain.jsp");
	}

}
