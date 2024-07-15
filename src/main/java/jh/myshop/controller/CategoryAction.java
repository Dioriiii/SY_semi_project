package jh.myshop.controller;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import jh.myshop.domain.*;
import jh.myshop.model.*;
import jh.user.domain.HeartVO;
import jh.user.domain.UserVO;
import jh.user.model.HeartDAO;
import jh.user.model.HeartDAO_imple;

public class CategoryAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		goBackURL(request);
		String ca_id = request.getParameter("ca_id"); // 카테고리 아이디
		
		ItemDAO itdao = new ItemDAO_imple();
		
		if(!itdao.isExist_ca_id(ca_id)) {
			// 입력받은 ca_id이 DB에 존재하지 않는 경우는 사용자가 장난친 경우
			super.setRedirect(true);
			super.setViewPage(request.getContextPath() + "/index.tam");
		}
		else{
			// 입력받은 ca_id가 DB에 존재하는 경우
			
			ImageDAO imgdao = new ImageDAO_imple();
			CategoryDAO cadao = new CategoryDAO_imple();
			HeartDAO hdao = new HeartDAO_imple();
			
			request.setAttribute("ca_id", ca_id);

			try {
				
				List<ImageVO> imgList = imgdao.imageSelectOne(ca_id);
				request.setAttribute("imgList", imgList);
				
				List<CategoryVO> cateList = cadao.categoryCount();
				request.setAttribute("cateList", cateList);
				
				List<CategoryVO> cateImgList = cadao.categoryHeader();
				request.setAttribute("cateImgList", cateImgList);
				
				Map<String, String> cateMainMap = cadao.categoryMain(ca_id);
				request.setAttribute("cateMainMap", cateMainMap);
				
				HttpSession session = request.getSession();
				UserVO loginuser = (UserVO)session.getAttribute("loginuser");
				
				if(loginuser != null) {
					List<HeartVO> heartList = hdao.heartUser(loginuser);
					request.setAttribute("heartList", heartList);
				}
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/jh/category/category.jsp");
				
			} catch (SQLException e) {
				e.printStackTrace();
				super.setRedirect(true);
				super.setViewPage(request.getContextPath() + "/error.tam");
			}
			
		}
		
	}

}
