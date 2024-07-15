package ws.mypage.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import ws.shop.domain.DetailVO;
import jh.user.domain.UserVO;
import ws.user.model.UserDAO;
import ws.user.model.UserDAO_imple;

public class PaymentEndAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 결제 페이지에서 배송수령인, 배송지 or 배송코드 를 request.setAttribute("",) 로 받아와야 한다. 즉, 같은 결제를 한 주문들만 넘어와야한다.
		// 그리고 결제페이지가 끝나고 주문완료 페이지로 오면 그때 주문일련번호가 생성되야한다. yyyymmdd + 랜덤4글자
		
		//String sh_postcode = request.getParameter("sh_postcode");
		//String sh_name = request.getParameter("sh_name");
		
		String sh_postcode = "22399";	// 임시 
		String sh_name = "테스토스테론";			// 임시
		
		HttpSession session = request.getSession();
		
		UserVO loginuser = (UserVO) session.getAttribute("loginuser");
		String login_userid = loginuser.getUserid();
		

		UserDAO mdao = new UserDAO_imple();
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("login_userid",login_userid);		// 회원아이디 put
		paraMap.put("sh_name",sh_name);					// 수령인 이름 put(임시)
		paraMap.put("sh_postcode",sh_postcode);			// 수령인 배송지코드 put(임시)
		
		// 주문완료된 회원의 정보를 가져오는 메소드
		List<DetailVO> detailList = mdao.paymentEndDisplay(paraMap);
		
		// 주문의 총 금액 정보를 가져오는 메소드
		int showTotalPrice = mdao.sumTotalPrice(paraMap);
		
		request.setAttribute("detailList", detailList);
		request.setAttribute("showTotalPrice", showTotalPrice);
		
		
	//  super.setRedirect(false);
		super.setViewPage("/WEB-INF/ws/order/paymentEnd.jsp");
		
		}

}
