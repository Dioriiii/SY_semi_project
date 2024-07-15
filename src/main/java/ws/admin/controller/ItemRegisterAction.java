package ws.admin.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import common.controller.AbstractController;
import jh.user.domain.UserVO;
import ws.shop.model.*;
import ws.shop.domain.*;

public class ItemRegisterAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();

		UserVO loginuser = (UserVO)session.getAttribute("loginuser");
		ItemDAO idao = new ItemDAO_imple();

		if(loginuser != null && "admin@naver.com".equals(loginuser.getUserid()) ) {//////////"admin@naver.com"
			// 관리자로 로그인함.
			String method = request.getMethod();
			if(!"POST".equalsIgnoreCase(method)) { // get


			List<CategoryVO> categoryList = idao.searchCategoryList();

			request.setAttribute("categoryList", categoryList);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/ws/mypage/admin/itemRegister.jsp");
				
			}
			else {									// post

				MultipartRequest mtrequest = null;
			
				ServletContext svlCtx = session.getServletContext();
				
				//tempSemi    C:\Users\82105\Desktop\쌍용\java파일\NCS\workspace_jsp\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\tempSemi\images\\ws\header_footer
				String uploadFileDir = "C:\\NCS\\workspace_jsp\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\tempSemi\\images\\wh";
				
				//realSemi
				//String uploadFileDir = "C:\\Users\\82105\\Desktop\\쌍용\\java파일\\NCS\\workspace_jsp\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\realSemi\\images\\jh\\index";
				
				try {
					mtrequest = new MultipartRequest(request, uploadFileDir,10*1024*1024,"UTF-8",new DefaultFileRenamePolicy());
				} catch (IOException e) {
					System.out.println("~~~ 파일 업로드 실패 에러메시지 ==> " + e.getMessage());
					
					request.setAttribute("message", "업로드 되어질 경로가 잘못되었거나 또는 최대용량 10MB를 초과했으므로 파일업로드 실패함!!");
					request.setAttribute("loc", request.getContextPath()+"/admin/itemRegister.tam");
					
					super.setRedirect(false);
					super.setViewPage("/WEB-INF/ws/msg.jsp");
					return;
					
				} // end of catch()------------------------
			
				String fk_ca_id = mtrequest.getParameter("fk_ca_id");				// 카테고리 아이디
				String it_name = mtrequest.getParameter("it_name");					// 상품명
				String it_price = mtrequest.getParameter("it_price");				// 가격
				String it_theme = mtrequest.getParameter("it_theme");				// 키워드
				String it_ingredient = mtrequest.getParameter("it_ingredient");		// 성분
				it_ingredient = it_ingredient.replace("\r\n", "<br>");	// 입력한 내용중 엔터는 <br> 로 변환
				
				
				// 크로스 사이트 스크립트 공격에 대응하는 시큐어코드 시작 //
				String it_describe_simple = mtrequest.getParameter("it_describe_simple"); 		// 설명
				String it_describe = mtrequest.getParameter("it_describe"); 		// 설명
				it_describe = it_describe.replace("<", "&lt;");
				it_describe = it_describe.replace(">", "&gt;");
				it_describe = it_describe.replace("\r\n", "<br>");	// 입력한 내용중 엔터는 <br> 로 변환
				// 크로스 사이트 스크립트 공격에 대응하는 시큐어코드 끝 //
				
				String it_stock = mtrequest.getParameter("it_stock");				// 재고
				String it_volume = mtrequest.getParameter("it_volume");				// 용량
				String unit = mtrequest.getParameter("unit");
				
				it_volume = it_volume + unit;						// 단위 합치기
				int it_seq_no = idao.getSeqNoOfProduct();			// 제품번호 채번
				
				
				
				ItemVO ivo = new ItemVO();
				ivo.setIt_seq_no(it_seq_no);						// 제품일련번호
				ivo.setFk_ca_id(fk_ca_id);
				ivo.setIt_name(it_name);
				ivo.setIt_price(Integer.parseInt(it_price));
				ivo.setIt_theme(it_theme);
				ivo.setIt_ingredient(it_ingredient);
				ivo.setIt_describe_simple(it_describe_simple);
				ivo.setIt_describe(it_describe);
				ivo.setIt_stock(Integer.parseInt(it_stock));
				ivo.setIt_volume(it_volume);

				
				String message = "";
				String loc ="";
				
				try {
					// tbl_item 테이블에 제품정보 insert 하기

					int n = idao.itemInsert(ivo);
				
					String attachCount = mtrequest.getParameter("attachCount");
					//System.out.println("attachCount" + attachCount);					
					int n_attachCount = 0;

					if(!"".equals(attachCount)) {
						n_attachCount = Integer.parseInt(attachCount);
					}
					
					
					Map<String,String> paraMap = new HashMap<>();
					paraMap.put("it_seq_no", String.valueOf(it_seq_no));
					
					if(n==1 && n_attachCount > 0 ) {	// 테이블에 insert 가 성공하고 추가 이미지 파일이 하나라도 있다면
						
						
						//System.out.println("n_attachCount => " + n_attachCount);						
						
					
						String attachCountFileName ="";	
						
						// 추가이미지 넣기
						for(int i=0; i< n_attachCount; i++) {
							attachCountFileName = mtrequest.getFilesystemName("attach"+i);
							paraMap.put("attachCountFileName",attachCountFileName);
							System.out.println("attachCountFileName   =>> 111"  +attachCountFileName);
						// tbl_img 테이블에 제품의 이미지 파일명 insert 해버리기 // int result =
						int result1 = idao.img_insert(paraMap);
						 
						if(result1==1) {
							System.out.println("이미지넣기성공1!");
							} else {
								System.out.println("이미지넣기실패1!"); 
							}
						 
						} // end of for 추가이미지-----------------------------------------

						
						// 메인 이미지 넣기 시작
						attachCountFileName = mtrequest.getFilesystemName("img_file");
						
						System.out.println("attachCountFileName   =>> 222"  +attachCountFileName);
						paraMap.put("attachCountFileName", attachCountFileName);
						paraMap.put("main_img", "1");
						
						
					//	System.out.println("이미지 insert에 들어간다");
						
						// tbl_img 테이블에 제품의 이미지 파일명 insert 해버리기 //
						int result2 = idao.img_insert(paraMap);
					// 메인 이미지 넣기 끝
						
						if(result2==1) {
							System.out.println("이미지넣기성공2!");
						}
						else {
							System.out.println("이미지넣기실패2!");
						}
						
						
					}// end of it---------------------------------------
					

					message = "제품 등록에 성공하였습니다.";
					loc = request.getContextPath() + "/admin/itemRegister.tam"; // 상품등록 페이지로 이동
					
				} catch (Exception e) {
					e.printStackTrace();
					message="제품 등록에 실패하였습니다! \n 다시 시도해 주시기 바랍니다.";
					loc = request.getContextPath() + "/admin/itemRegister.tam"; // 상품등록 페이지로 이동
				}
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				// super.setRedirect(false);
				super.setViewPage("/WEB-INF/ws/msg.jsp");
		
		} // end of else----------------------------------------------
					
			
		}
		else {
			String message = "관리자만 접근이 가능합니다.";
			String loc = "";

			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
		      
		    // super.setRedirect(false);
			super.setViewPage("/WEB-INF/jh/index.jsp");
		}

	}

}
