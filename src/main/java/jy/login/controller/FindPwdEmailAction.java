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


public class FindPwdEmailAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		if("POST".equalsIgnoreCase(method)) { // POST 방식으로 접근 시,
			
			String email = request.getParameter("email");
			
			UserDAO udao = new UserDAO_imple();
			
			String userid = udao.selectUserid_Email(email);
			
			boolean sendMailSuccess = false; // 메일이 정상적으로 전송되었는지 유무를 알아오기 위한 용도 
			
			JSONObject jsonObj = new JSONObject();
			
			if(userid != null) { // 회원이 존재할 경우
				// 인증키를 랜덤하게 생성하도록 한다.
				char pwCollection[] = new char[] {
	                        '1','2','3','4','5','6','7','8','9','0',
	                        'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z',
	                        'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z',
	                        '!','@','#','$','%','^','&','*','(',')'};//배열에 선언

				String new_pwd = "";

			    for (int i = 0; i < 10; i++) {
			      int selectRandomPw = (int)(Math.random()*(pwCollection.length));//Math.rondom()은 0.0이상 1.0미만의 난수를 생성해 준다.
			      new_pwd += pwCollection[selectRandomPw];
			    }
								
				// 랜덤하게 생성한 인증코드(certification_code)를 비밀번호 찾기를 하고자 하는 사용자의 email 로 전송시킨다.
				GoogleMail mail = new GoogleMail();
				
				String contents = "<h2>아이디 "+userid+"님의 임시 비밀번호입니다.</h2><br> <span style='font-size: 15pt'>임시 비밀번호 : </span><span style='font-size:17pt; color:red;'>"+new_pwd+"</span>";
				String subject = " [SemiProject] Tamburins 임시 비밀번호 발송 ";
				Map<String, String> paraMap = new HashMap <> ();
				paraMap.put("userid", userid);
				paraMap.put("email", email);
				paraMap.put("new_pwd", new_pwd);
				paraMap.put("contents", contents);
				paraMap.put("subject", subject);
				
				try {;
					mail.send_certification_code(paraMap);
					sendMailSuccess = true; // 메일 전송 성공했음을 기록함.
					
					// 메일 전송이 성공 시, 비밀번호를 업데이트 해준다.
					int n = 0;
					
					n = udao.pwdUpdate(paraMap);
					
					
				} catch(Exception e) {
					// 메일 전송이 실패한 경우 
					e.printStackTrace();
					sendMailSuccess = false; // 메일 전송 실패했음을 기록함.
					
				}
				
				jsonObj.put("userid", userid);
				jsonObj.put("email", email);
				jsonObj.put("sendMailSuccess",sendMailSuccess);
			
			}// end of if(userid != null) --------------------

			
			String json = jsonObj.toString(); // 문자열 형태인 "{"isExists":true}" 또는 "{"isExists":false}" 으로 만들어 준다.
			
			System.out.println(">>> 확인용 json => "+json);
			
			request.setAttribute("json", json);
			
			super.setViewPage("/WEB-INF/jy/jsonview.jsp");

		}
		
	}

}
