package wh.myshop.model;

import java.sql.SQLException;
import java.util.*;

import wh.myshop.domain.*;

public interface OrderDAO {

	
	
	// 결제완료 후 결제한 정보를 DB에 update 해주는 메소드
	int PaymentUpdateLoginUser(Map<String, String> paraMap) throws SQLException;

	
	// 결제 후 update 된 tbl_order 의 정보를 select 해주는 메소드
	OrderVO paymentListView(String userid) throws SQLException;

	// tbl_cart의 정보를 결제 후 tbl_detail 의 정보로 insert 해주는 메소드
	int PaymentDetailUpdateLoginUser(int order_seq_no, List<CartVO> orderList) throws SQLException;


	
	


	

	
	
	
}
