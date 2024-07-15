package db.mypage.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import db.mypage.customerCare.domain.CustomerCareVO;
import db.mypage.customerCare.model.*;

public class MypageCustomerCare extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 로그인을 하지 않아도 자주 묻는 질문을 볼 수 있다. 로그인 체크x
		
		CustomerCareDAO cusdao = new CustomerCareDAO_imple();

	// --- 카테고리 리스트 시작
		// 카테고리 리스트
		List<Map<String, String>> categoryList = new ArrayList<>();
		
		// --- *** 자주 묻는 질문 카테고리를 가져와 항목으로 만든다. *** --- //
		categoryList = cusdao.CustomerCareCategory();
	
	// --- 카테고리 리스트 끝
		
		
		
		// 자주 묻는 질문 페이지 방문시 "get"방식으로 q_ca=? 값을 받아온다.		
		String q_ca = request.getParameter("q_ca");
	//	System.out.println("q_ca => " + q_ca);
		String page = request.getParameter("page");
		// 현재 보여지는 페이지이다.
		
		
		// 첫 클릭시 값이 없으므로 '배송'=='1' 에 해당하는 값을 가져온다.
			// 한글 입력시 오류 처리 해야됨.
		try {
			
			if( q_ca == null || q_ca.trim().isEmpty() ) {
				q_ca = "1";
			}
			Integer.parseInt(q_ca);
		} catch (NumberFormatException e) {
			q_ca = "1";
		}
		
		// 처음 접속시 보이는 페이지는 첫번째이다.
			// 한글 입력시 오류 처리 해야됨.
		try {
			if( page == null || page.trim().isEmpty() ) {
				page = "1";
			}
			Integer.parseInt(page);
		} catch (NumberFormatException e) {
			page = "1";
		}

			
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("q_ca", q_ca);
		paraMap.put("page", page);
		
		// *** 한 카테고리 별로 8개의 질문과 답변만 가지고 오고 페이징 처리한다. *** //
			// 카테고리별로 표시할 페이지 수를 가져온다.
		int totalPage = cusdao.getTotalPage(paraMap);
	//	System.out.println("totalPage => "+ totalPage);
		/*
		 	totalPage => 2
			totalPage => 1
			totalPage => 1
			totalPage => 1
			totalPage => 2
			totalPage => 1
		 */
		String pageBar = "";
		
		if(totalPage > 1) {
			
			int blockSize = 10;
			// blockSize는 블럭(토막)당 보여지는 페이지 번호의 개수이다.
			
			int loop = 1;
			// loop는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수(지금은 10개)까지만 표시한다.
 			
				// ==== !!! pageNo 구하는 공식 !!! ==== //
			int pageNo = ( (Integer.parseInt(page) - 1)/blockSize ) * blockSize + 1;
			// pageNo는 페이지바에서 보여지는 첫번째 번호이다.
			
			while( !(loop > blockSize || pageNo > totalPage) ) {
				
				if( pageNo == Integer.parseInt(page) ) {
					pageBar += "<li class='page__ active__page'><a class='page__link' href='#'>" + pageNo + "</a></li>";
				}
				else {
					pageBar += "<li class='page__'><a class='page__link' href='mypageCustomerCare.tam?q_ca="+q_ca+"&page="+pageNo+"'>" + pageNo + "</a></li>";
				}
				
				
				loop++; 	// 1 2 3 4 5 6 7 8 9 10
				
				pageNo++; 	// 1  2  3  4  5  6  7  8  9  10
							// 11 12 13 14 15 16 17 18 19 20
							// 21 22 23 24 25 26 27 28 29 30
							// 31 32 33 34 35 36 37 38 39 40
							// 41 42
				
			} // end of while ----------------------
			
		}
		
		
		
		// --- *** 자주 묻는 질문DB에서 답변과 질문을 가져온다. *** --- //
		List<CustomerCareVO> cuvoList = cusdao.CustomerCareFAQ(paraMap);
	//	System.out.println("cuvoList.size() => " + cuvoList.size());
		// cuvoList.size() => 8
		if(cuvoList.size() == 0) {
		// get 방식 없는값 입력시 마이페이지 메인으로 보냄
			String message = "마이페이지를 이용하여 주십시오.";
			String loc = request.getContextPath()+"/mypage/mypage.tam";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/db/msg.jsp");
			
			return;
		}
		
		request.setAttribute("pageBar", pageBar);
		request.setAttribute("categoryList", categoryList); // 카테고리 리스트 
		request.setAttribute("cuvoList", cuvoList); // 질문 답변
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/db/mypage/mypageCustomerCare.jsp");
		
	}

}
