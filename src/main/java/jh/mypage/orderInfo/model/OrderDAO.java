package jh.mypage.orderInfo.model;

import java.sql.SQLException;
import java.util.*;

import jh.mypage.orderInfo.domain.*;

public interface OrderDAO {

	// 주문정보에 대해 조회하는 메소드
	List<OrderVO> selectOneOrderList() throws SQLException;

	// Ajax(JSON)를 사용하여 주문목록을 "스크롤" 방식으로 페이징 처리
	int totalOrderCount() throws SQLException;

}
