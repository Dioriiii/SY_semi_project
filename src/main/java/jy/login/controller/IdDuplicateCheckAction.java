package jy.login.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import common.controller.AbstractController;
import jy.login.model.UserDAO;
import jy.login.model.UserDAO_imple;

public class IdDuplicateCheckAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod(); // "GET" 또는 "POST"
		
		if("post".equalsIgnoreCase(method)) {
			
			String userid = request.getParameter("userid");
			
			UserDAO udao = new UserDAO_imple();
			
			boolean isExists = udao.idDuplicateCheck(userid);
			
			JSONObject jsonObj = new JSONObject();
			
			boolean sendMailSuccess = false; // 메일이 정상적으로 전송되었는지 유무를 알아오기 위한 용도 
			
			if(!isExists) { // userid 중복이 없을 경우 인증번호 메일을 발송한다.
				
				// 인증키를 랜덤하게 생성하도록 한다.
				Random rnd = new Random();
				
				String certification_code_email = "";
				// 인증키는 영문소문자 3글자 + 숫자 4글자 로 만들겠습니다.
				
				char randchar = ' ';
				for(int i=0; i<3; i++) {
				 /*
				    min 부터 max 사이의 값으로 랜덤한 정수를 얻으려면 
				    int rndnum = rnd.nextInt(max - min + 1) + min;
				       영문 소문자 'a' 부터 'z' 까지 랜덤하게 1개를 만든다.  	
				 */	
					randchar = (char) (rnd.nextInt('Z' - 'A' + 1) + 'A');
					certification_code_email += randchar;
				}// end of for---------------------
				
				int randnum = 0;
				for(int i=0; i<4; i++) {
				 /*
				    min 부터 max 사이의 값으로 랜덤한 정수를 얻으려면 
				    int rndnum = rnd.nextInt(max - min + 1) + min;
				       영문 소문자 'a' 부터 'z' 까지 랜덤하게 1개를 만든다.  	
				 */	
					randnum = rnd.nextInt(9 - 0 + 1) + 0;
					certification_code_email += randnum;
				}// end of for---------------------
								
				// 랜덤하게 생성한 인증코드(certification_code)를 비밀번호 찾기를 하고자 하는 사용자의 email 로 전송시킨다.
				GoogleMail mail = new GoogleMail();
				
				Map<String, String> paraMap = new HashMap <> ();
				paraMap.put("email", userid);
				paraMap.put("contents", "<h2>이메일 인증번호입니다.</h2><br> <span style='font-size: 15pt'>인증번호 : </span><span style='font-size:17pt; color:red;'>"+ certification_code_email +"</span>");
				paraMap.put("subject", "[SemiProject] Tamburins 인증번호 발송");
				System.out.println("certification_code_email =>"+certification_code_email);
				try {
					mail.send_certification_code(paraMap);
					sendMailSuccess = true; // 메일 전송 성공했음을 기록함.
			
					
				} catch(Exception e) {
					// 메일 전송이 실패한 경우 
					e.printStackTrace();
					sendMailSuccess = false; // 메일 전송 실패했음을 기록함.
					
				}
				
				HttpSession session = request.getSession();
				session.setAttribute("certification_code_email", certification_code_email);
			
			}// end of if(userid != null) --------------------

			jsonObj.put("userid", userid);
			jsonObj.put("isExists", isExists);
			jsonObj.put("sendMailSuccess",sendMailSuccess);

			
			String json = jsonObj.toString(); // 문자열 형태인 "{"isExists":true}" 또는 "{"isExists":false}" 으로 만들어 준다.
			
			System.out.println(">>> 확인용 json => "+json);
			
			request.setAttribute("json", json);
			
			super.setViewPage("/WEB-INF/jy/jsonview.jsp");

		}		
		
	}// end of public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception-------------

}
