package jh.index.controller;

import java.sql.SQLException;
import java.util.List;

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

public class Indexcontroller extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		goBackURL(request);
		
		ImageDAO imgdao = new ImageDAO_imple();
		CategoryDAO cadao = new CategoryDAO_imple();
		HeartDAO hdao = new HeartDAO_imple();
		ItemDAO itdao = new ItemDAO_imple();
		
		
		try {
			
			List<ImageVO> imgList = imgdao.imageSelectOne();
			request.setAttribute("imgList", imgList);
			
			List<CategoryVO> cateList = cadao.categoryCount();
			request.setAttribute("cateList", cateList);
			
			List<CategoryVO> cateImgList = cadao.categoryHeader();
			request.setAttribute("cateImgList", cateImgList);
			
			int allItemCount = itdao.getAllItemCount();
			request.setAttribute("allItemCount", allItemCount);

			HttpSession session = request.getSession();
			UserVO loginuser = (UserVO)session.getAttribute("loginuser");
			
			if(loginuser != null) {
				List<HeartVO> heartList = hdao.heartUser(loginuser);
				request.setAttribute("heartList", heartList);
			}
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/jh/index.jsp");
			
		} catch (SQLException e) {
			e.printStackTrace();
			super.setRedirect(true);
			super.setViewPage(request.getContextPath() + "/error.tam");
		}
		
	}
	
}
