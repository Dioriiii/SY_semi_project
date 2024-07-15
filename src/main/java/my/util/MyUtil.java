package my.util;

import javax.servlet.http.HttpServletRequest;

public class MyUtil {

   // *** ? 다음의 데이터까지 포함한 현재 URL 주소를 알려주는 메소드를 생성 *** //
   public static String getCurrentURL(HttpServletRequest request) {
      
      String currentURL = request.getRequestURL().toString();
      // stringbuffer인 getRequestURL 을 string으로 바꿔준다.
      // currentURL => http://localhost:9090/MyMVC/member/memberList.up
      // 물음표 전 

      String queryString = request.getQueryString();
 //     System.out.println("queryString => " + queryString);
      // queryString => searchType=name&searchWord=%EC%9B%90%EC%84%9D&sizePerPage=10&currentShowPageNo=2
      // queryString => null(POST 방식인 경우)
      // 물음표 다음
      
      if(queryString != null) { // get방식인 경우
         currentURL += "?"+queryString;
      }
      
      String ctxPath = request.getContextPath();
      //      /MyMVC
      
      int beginIndex  = currentURL.indexOf(ctxPath) + ctxPath.length();
      //         21            +      6
      
      currentURL = currentURL.substring(beginIndex);
      
      currentURL.substring(0);
      
      return currentURL;
   } // end of public static String getCurrentURL(HttpServletRequest request)
}