package ws.mypage.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import ws.notice.domain.NoticeVO;
import ws.notice.model.NoticeDAO;
import ws.notice.model.NoticeDAO_imple;

public class NoticeShowAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		goBackURL(request);
		NoticeDAO ndao = new NoticeDAO_imple();
		
		List<NoticeVO> noticeList = ndao.noticeDisplay();
		// 공지사항 조회하기
		
		request.setAttribute("noticeList", noticeList);
		
		
	//  super.setRedirect(false);
		super.setViewPage("/WEB-INF/ws/mypage/noticeShow.jsp");
		
	}

}
