package ws.user.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import ws.shop.domain.DetailVO;
import ws.shop.domain.OrderVO;

public interface UserDAO {
	
	// 주문완료된 회원의 정보를 가져오는 메소드
	List<DetailVO> paymentEndDisplay(Map<String, String> paraMap) throws SQLException;
	
	// 주문의 총 금액 정보를 가져오는 메소드
	int sumTotalPrice(Map<String, String> paraMap) throws SQLException;
	

	

	
 

	
}
