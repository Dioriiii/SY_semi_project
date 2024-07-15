package jh.admin.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.*;
import org.json.simple.JSONObject;

import common.controller.AbstractController;
import jh.mypage.orderInfo.model.*;
import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

public class StatusChangeJSONAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String o_detail_seq_no = request.getParameter("o_detail_seq_no");
		String o_status = request.getParameter("o_status");
		String user_id = request.getParameter("user_id");
		String it_name = request.getParameter("it_name");
		String sh_name = request.getParameter("sh_name");
		String sh_mobile = request.getParameter("sh_mobile");
		
		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("o_detail_seq_no", o_detail_seq_no);
		paraMap.put("o_status", o_status);
		
		DetailDAO dtdao = new DetailDAO_imple();
		
		// 주문상세일련번호의 주문상태를 변경하는 메소드
		int result = dtdao.changeStatus(paraMap);
		
		org.json.JSONObject jsonObj = new org.json.JSONObject();
		
		// jsonObj.putOpt{"키":값}
		jsonObj.putOpt("result", result);
		
		String json = jsonObj.toString();
		
		request.setAttribute("json", json);
	
		if(result == 1 && "1".equals(o_status)) {
			// === 배송을 했다라는 확인 문자(SMS)를 주문을 한 사람(여러명)에게 보내기 시작 ===
			
			// System.out.println("주문한 사람 : " + user_id);
			// System.out.println("주문한 상품 : " + it_name);
			// System.out.println("수령할 사람 : " + sh_name);
				
        	// 주문코드 전표(key)소유주에 대한 사용자 정보를 조회해오는 것.
       
        	//String api_key = "발급받은 본인의 API Key";  // 발급받은 본인 API Key
        	String api_key = "NCSVCB7CVNEGXVD4";
        	//String api_secret = "발급받은 본인의 API Secret";  // 발급받은 본인 API Secret
        	String api_secret = "RVEKJJKFIPWDUBWSWKT7UZ9EOZT1XFI5";
        	Message coolsms = new Message(api_key, api_secret);
        	// net.nurigo.java_sdk.api.Message 임. 
        	// 먼저 다운 받은  javaSDK-2.2.jar 를 /MyMVC/WebContent/WEB-INF/lib/ 안에 넣어서  build 시켜야 함.
                
        	// == 4개 파라미터(to, from, type, text)는 필수사항이다. == 
        	HashMap<String, String> map = new HashMap<String, String>();
        	map.put("to", sh_mobile); // 수신번호
        	map.put("from", "01028548979"); // 발신번호
        	map.put("type", "SMS"); // Message type ( SMS(단문), LMS(장문), MMS, ATA )
        	map.put("text", "Tamburins\n\n" + sh_name + "님 안녕하세요.\n\n" + it_name + " 배송을 시작했습니다."); // 문자내용    
        	map.put("app_version", "JAVA SDK v2.2"); // application name and version

                                     
              try {
                 JSONObject jsobj = (JSONObject) coolsms.send(map);
                 
              } catch (CoolsmsException e) {
                 e.printStackTrace();
              }
            	 
        } // end of if(result == 1 && "1".equals(o_status))
	
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/jh/jsonview.jsp");
		
	}

}
