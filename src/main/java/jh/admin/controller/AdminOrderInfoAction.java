package jh.admin.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

public class AdminOrderInfoAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		//super.setRedirect(false);
		super.setViewPage("/WEB-INF/jh/admin/orderInfo.jsp");
		
	}

}
