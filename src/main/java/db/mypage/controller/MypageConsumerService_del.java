package db.mypage.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

public class MypageConsumerService_del extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/db/mypage/mypageConsumerService_del.jsp");
	} // end of public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

}
