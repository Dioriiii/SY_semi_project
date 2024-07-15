package jh.mypage.orderInfo.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import jh.mypage.orderInfo.domain.*;

public interface DetailDAO {

	// 관리자가 모든 주문을 조회하는 메소드
	List<DetailVO> selectAllOrderList() throws SQLException;

	// 주문상세일련번호의 주문상태를 변경하는 메소드
	int changeStatus(Map<String, String> paraMap) throws SQLException;
	
}
