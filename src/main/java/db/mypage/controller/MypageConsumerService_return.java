package db.mypage.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

public class MypageConsumerService_return extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/db/mypage/mypageConsumerService_return.jsp");
	} // end of public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

}
