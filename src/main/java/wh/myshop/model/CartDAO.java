package wh.myshop.model;

import java.sql.SQLException;
import java.util.*;

import wh.myshop.domain.*;

public interface CartDAO {


	// 장바구니에 tbl_cart의 정보를 조회(select)해주는 메소드
	List<CartVO> cartItemInfo(Map<String, String> paraMap) throws SQLException;
	
	// 추가할 제품이 장바구니 안에 없을 때 장바구니 테이블에 제품 정보를 추가(insert)하는 메소드
	int insertCartItem( Map<String, String[]> paraMap, String userid) throws SQLException;
	
	// 쇼핑백 페이지에 보여지는 상품 정보 및 가격을 조회(select)하는 메소드
    List<CartVO> shopBagInfo(String userid) throws SQLException;

    // 쇼핑백 페이지에 보여지는 상품의 삭제 클릭 시 정보를 삭제하는(delete)하는 메소드
	int deleteCartInfo(String userid) throws SQLException;

	
	// 쇼핑백 페이지의 결제하기 클릭 시 현재 세션스토리지에 담겨있는 정보들을 DB에 추가하는(insert)하는 메소드
	int insertBagItem(Map<String, String[]> paraMap, String userid) throws SQLException;
	
	// 주문 결제창에 보여지는 주문정보를 조회(select)하는 메소드
	List<CartVO> orderListInfo(String userid) throws SQLException;
	
	
	
	// 장바구니 테이블에 제품 정보를 추가(insert) 하고 tbl_cart의 정보를 조회(select) 해주는 메소드
	// CartVO selectInsertCart(String it_seq_no) throws SQLException;
	
	


	
	

	

	
	
	
	


	

	
	
	
}
