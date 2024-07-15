package jy.store.controller;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import jy.store.domain.CountryVO;
import jy.store.domain.ImageVO;
import jy.store.domain.StoreVO;
import jy.store.model.StoreDAO;
import jy.store.model.StoreDAO_imple;

public class FindStoreAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		goBackURL(request);
		StoreDAO sdao = new StoreDAO_imple();
		String country = request.getParameter("country");
		
		
		try {
			
			if(country == null) {
				country = "kr";
			}
			
			
			List<StoreVO> flgList = sdao.selectFlgList(country);
			List<StoreVO> dptList = sdao.selectDptList(country);
			List<StoreVO> stkList = sdao.selectStkList(country);
			List<CountryVO> cntryList = sdao.getAllCtyList();
			
			List<ImageVO> imgList = sdao.getAllImgList();
			int storeCnt = sdao.countFlgStore(country);
			
			request.setAttribute("flgList", flgList);
			request.setAttribute("dptList", dptList);
			request.setAttribute("stkList", stkList);
			request.setAttribute("imgList", imgList);
			request.setAttribute("cntryList", cntryList);
			request.setAttribute("country", country);		
			request.setAttribute("storeCnt", storeCnt);		
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/jy/header_category_store.jsp");
			super.setViewPage("/WEB-INF/jy/store/storeMain.jsp");
			
			
		} catch (SQLException e) {
			e.printStackTrace();
			super.setRedirect(true);
			super.setViewPage(request.getContextPath() + "/error.tam");
		}
		
		
	}

}
