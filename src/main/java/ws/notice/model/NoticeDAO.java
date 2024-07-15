package ws.notice.model;

import java.sql.SQLException;
import java.util.*;

import ws.notice.domain.NoticeVO;

public interface NoticeDAO {

	// 공지사항 조회하기
	List<NoticeVO> noticeDisplay() throws SQLException;
}
