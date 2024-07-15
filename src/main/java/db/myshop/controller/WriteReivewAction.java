package db.myshop.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import common.controller.AbstractController;
import db.myshop.model.*;

public class WriteReivewAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		if("post".equalsIgnoreCase(method)) {
		// post 방식
			
			String re_content = request.getParameter("re_content");			
			String o_detail_seq_no = request.getParameter("o_detail_seq_no");
			// !!!! 크로스 사이트 스크립트 공격에 대응하는 안전한 코드(시큐어코드) 작성하기 !!!! //
            re_content = re_content.replaceAll("<", "&lt;");
            re_content = re_content.replaceAll(">", "&gt;");
            
            // 입력한 내용에서 엔터는 <br>로 변환시키기
            re_content = re_content.replaceAll("\r\n", "<br>"); 
            // !!!! 크로스 사이트 스크립트 공격에 대응하는 안전한 코드(시큐어코드) 작성하기 !!!! //
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("re_content", re_content);
			paraMap.put("o_detail_seq_no", o_detail_seq_no);
			
			MyshopDAO mdao = new MyshopDAO_imple();
			
			int result = mdao.writeReview(paraMap);
			// result  1 입력성공 // 2 입력실패 (없을듯)
			
			
			JSONObject jsonObj = new JSONObject();	// {} 
			jsonObj.put("result", result);
			
			String json = jsonObj.toString();
			
			request.setAttribute("json", json);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/db/jsonview.jsp");
		}
		else {
		// get 방식	
			// 없음
		}
		
	} // end of public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

}
