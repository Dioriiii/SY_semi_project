package ws.admin.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import jh.user.domain.UserVO;
import ws.shop.domain.DetailVO;
import ws.shop.model.ItemDAO;
import ws.shop.model.ItemDAO_imple;

public class ItemMangeAction extends AbstractController {

   @Override
   public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      
      HttpSession session = request.getSession();
      UserVO loginuser = (UserVO)session.getAttribute("loginuser");
      
      if(session.getAttribute("loginuser") != null && "admin@naver.com".equals(loginuser.getUserid())) {
         
         // 관리자로 로그인 하여 접근한 경우
      
         ItemDAO idao = new ItemDAO_imple();
         
         String ca_id = "";
         
         List<DetailVO> itemList = idao.itemSelectList(ca_id);
         
         request.setAttribute("itemList", itemList);
         
         // super.setRedirect(false);
         super.setViewPage("/WEB-INF/jh/admin/adminItem.jsp");

      }
      else {
         // 관리자로 로그인 하여 접근하지 않은 경우
         request.setAttribute("message", "접근할 수 없는 페이지입니다.");
         request.setAttribute("loc", request.getContextPath() + "/main.tam");

         super.setRedirect(false);
         super.setViewPage("/WEB-INF/jh/msg.jsp");
      }
      
   
   }

}