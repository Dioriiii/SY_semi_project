package db.mypage.customerCare.model;

import java.sql.SQLException;

import java.util.*;

import db.mypage.customerCare.domain.CustomerCareVO;

public interface CustomerCareDAO {

	// --- *** 자주 묻는 질문 카테고리를 가져와 항목으로 만든다. *** --- //
	List<Map<String, String>> CustomerCareCategory() throws SQLException;

	// 질문과 답변을 가져온다
	List<CustomerCareVO> CustomerCareFAQ(Map<String, String> paraMap) throws SQLException;

	// 카테고리별로 표시할 페이지 수를 가져온다.
	int getTotalPage(Map<String, String> paraMap) throws SQLException;

}
