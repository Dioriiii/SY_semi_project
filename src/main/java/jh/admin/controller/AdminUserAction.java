package jh.admin.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import jh.user.model.*;
import my.util.MyUtil;
import jh.user.domain.*;

public class AdminUserAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// == 관리자(admin)로 로그인 했을 때만 회원조회가 가능하도록 해야 한다. == //
		HttpSession session = request.getSession();
		UserVO loginuser = (UserVO) session.getAttribute("loginuser");
		
		if(loginuser != null && "admin@naver.com".equals(loginuser.getUserid())) {// 관리자(admin)로 로그인 했을 경우
			
			UserDAO udao = new UserDAO_imple();
			
			String searchType = request.getParameter("searchType");
			String searchWord = request.getParameter("searchWord");
			String sizePerPage = "5"; 
			String pageNo = request.getParameter("pageNo"); 
			
			
			//////////////////////////검색해야할 정보가 null 일때 ////////////////////////////
			if(searchType == null || 
			(!"name".equals(searchType) && 
			!"userid".equals(searchType) &&
			!"email".equals(searchType)) ) {
				searchType = "";
			}
			
			if(searchWord == null || 
			(searchWord != null && searchWord.trim().isEmpty()) ) {
				searchWord = "";
			}
			
			if(sizePerPage == null || 
			(!"10".equals(sizePerPage) &&
			!"5".equals(sizePerPage) &&
			!"3".equals(sizePerPage) ) ) {
				sizePerPage = "10";
			}
			
			if(pageNo == null) {
				pageNo = "1";
			}
			//////////////////////////////////////////////////////
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("searchType", searchType);
			paraMap.put("searchWord", searchWord);
			paraMap.put("sizePerPage", sizePerPage); // 한페이지당 보여줄 행의 개수 
			paraMap.put("pageNo", pageNo); // 조회하고자 하는 페이지 번호 
			
			
			// 페이징 처리를 위한 검색이 있는 또는 검색이 없는 회원에 대한 총페이지수 알아오기 //
			int totalPage = udao.getTotalPage(paraMap);
			
			try {
				if( Integer.parseInt(pageNo) > totalPage || 
					Integer.parseInt(pageNo) <= 0 ) {
					pageNo = "1";
					paraMap.put("pageNo", pageNo);
				}
			} catch(NumberFormatException e) {
				pageNo = "1";
				paraMap.put("pageNo", pageNo);
			}
			
			// *** ====== 페이지바 만들기 시작 ====== *** //
			/*
			    1개 블럭당 10개씩 잘라서 페이지 만든다.
			    1개 페이지당 3개행 또는 5개행 또는 10개행을 보여주는데
			        만약에 1개 페이지당 5개행을 보여준다라면 
			        총 몇개 블럭이 나와야 할까? 
			        총 회원수가 207명 이고, 1개 페이지당 보여줄 회원수가 5 이라면
			    207/5 = 41.4 ==> 42(totalPage)        
			        
			    1블럭               1 2 3 4 5 6 7 8 9 10 [다음]
			    2블럭   [이전] 11 12 13 14 15 16 17 18 19 20 [다음]
			    3블럭   [이전] 21 22 23 24 25 26 27 28 29 30 [다음]
			    4블럭   [이전] 31 32 33 34 35 36 37 38 39 40 [다음]
			    5블럭   [이전] 41 42 
			*/
			
			// ==== !!! pageNo 구하는 공식 !!! ==== // 
		/*
		    1  2  3  4  5  6  7  8  9  10  -- 첫번째 블럭의 페이지번호 시작값(pageNo)은  1 이다.
		    11 12 13 14 15 16 17 18 19 20  -- 두번째 블럭의 페이지번호 시작값(pageNo)은 11 이다.	
		    21 22 23 24 25 26 27 28 29 30  -- 세번째 블럭의 페이지번호 시작값(pageNo)은 21 이다.
		    
		     currentShowPageNo        pageNo  ==> ( (currentShowPageNo - 1)/blockSize ) * blockSize + 1 
		    ---------------------------------------------------------------------------------------------
		           1                   1 = ( (1 - 1)/10 ) * 10 + 1 
		           2                   1 = ( (2 - 1)/10 ) * 10 + 1 
		           3                   1 = ( (3 - 1)/10 ) * 10 + 1 
		           4                   1 = ( (4 - 1)/10 ) * 10 + 1  
		           5                   1 = ( (5 - 1)/10 ) * 10 + 1 
		           6                   1 = ( (6 - 1)/10 ) * 10 + 1 
		           7                   1 = ( (7 - 1)/10 ) * 10 + 1 
		           8                   1 = ( (8 - 1)/10 ) * 10 + 1 
		           9                   1 = ( (9 - 1)/10 ) * 10 + 1 
		          10                   1 = ( (10 - 1)/10 ) * 10 + 1 	           

		 */
				String pageBar = "";
				
				int blockSize = 10;
				// blockSize 는 블럭(토막)당 보여지는 페이지 번호의 개수이다.
				
				int loop = 1;
				// loop 는 1 부터 증가하여 1개 블럭을 이루는 페이지번호의 개수(지금은 10개)까지만 증가하는 용도이다.
				
				// ==== !!! 다음은 pageNo 구하는 공식이다. !!! ==== //
				int pageNoFirst  = ( ( Integer.parseInt(pageNo) - 1)/blockSize ) * blockSize + 1; 
				// pageNo 는 페이지바에서 보여지는 첫번째 번호이다.
				
				
				// **** [맨처음][이전] 만들기 **** //
				// 
				pageBar += "<li class='page-item'><a class='page-link' href='adminUser.tam?searchType="+searchType+"&searchWord="+searchWord+"&sizePerPage="+sizePerPage+"&pageNo=1'>[맨처음]</a></li>"; 
				
				if( pageNoFirst != 1 ) {
					pageBar += "<li class='page-item'><a class='page-link' href='adminUser.tam?searchType="+searchType+"&searchWord="+searchWord+"&sizePerPage="+sizePerPage+"&pageNo="+(pageNoFirst-1)+"'>[이전]</a></li>";
				}
				
				while( !(loop > blockSize || pageNoFirst > totalPage) ) {
					
					if(pageNoFirst == Integer.parseInt(pageNo)) {
						pageBar += "<li class='page-item active'><a class='page-link' href='#'>"+pageNoFirst+"</a></li>"; 
					}
					else {
						pageBar += "<li class='page-item'><a class='page-link' href='adminUser.tam?searchType="+searchType+"&searchWord="+searchWord+"&sizePerPage="+sizePerPage+"&pageNo="+pageNoFirst+"'>"+pageNoFirst+"</a></li>"; 
					}
					
					loop++;    //  1 2 3 4 5 6 7 8 9 10
					
					pageNoFirst++;  //  1  2  3  4  5  6  7  8  9 10
					           // 11 12 13 14 15 16 17 18 19 20
					           // 21 22 23 24 25 26 27 28 29 30
					           // 31 32 33 34 35 36 37 38 39 40
					           // 41 42 
				}// end of while------------------
				
				// **** [다음][마지막] 만들기 **** //
				// pageNo ==> 11
				if( pageNoFirst <= totalPage ) {
					pageBar += "<li class='page-item'><a class='page-link' href='adminUser.tam?searchType="+searchType+"&searchWord="+searchWord+"&sizePerPage="+pageNo+"&pageNo="+pageNoFirst+"'>[다음]</a></li>"; 
				}
				pageBar += "<li class='page-item'><a class='page-link' href='adminUser.tam?searchType="+searchType+"&searchWord="+searchWord+"&sizePerPage="+pageNo+"&pageNo="+totalPage+"'>[마지막]</a></li>";
				
				
				// *** ====== 페이지바 만들기 끝 ====== *** //
			
			
			// **** 페이징 처리를 한 모든 회원 또는 검색한 회원 목록 보여주기 **** //
		    
			// 모든 회원을 조회하는 메소드
			// List<UserVO> userAllList =  udao.userSelectAll();
			//request.setAttribute("userAllList", userAllList);
			
			// *** ====== 현재 페이지를 돌아갈 페이지(goBackURL)로 주소 지정하기 ======= *** //
			String currentURL = MyUtil.getCurrentURL(request);
			// 회원조회를 했을시 현재 그 페이지로 그대로 되돌아가길 위한 용도로 쓰임.	
				
			// 페이징 처리를 한 검색한 회원 목록 보여주기
			List<UserVO> userList = udao.select_User_paging(paraMap);
			
			request.setAttribute("userList", userList);
			request.setAttribute("searchType", searchType);
			request.setAttribute("searchWord", searchWord);
			request.setAttribute("sizePerPage", sizePerPage);
			request.setAttribute("pageBar", pageBar);
			request.setAttribute("currentURL", currentURL);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/jh/admin/adminUser.jsp");
			
			
		}
		else {
			// 로그인을 안한 경우 또는 일반사용자로 로그인 한 경우 
			String message = "관리자만 접근이 가능합니다.";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/jy/msg.jsp");
		}
		
		
		
	}

}
