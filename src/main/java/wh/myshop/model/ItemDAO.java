package wh.myshop.model;

import java.sql.SQLException;
import java.util.*;

import wh.myshop.domain.*;

public interface ItemDAO {

	// 상세페이지에 보여지는 상품 정보를 모두 조회(select)하는 메소드 
	List<ItemVO> itemInfoAll(Map<String, String> paraMap) throws SQLException;

	
	
	
	/*
	// 장바구니 테이블에 제품 정보를 추가(insert)하는 메소드
	int insertCartItem(Map<String, String> paraMap) throws SQLException;

	
	// 장바구니의 select 의 옵션을 변경 할 때마다 tbl_cart의 제품 수량 변경(update) 하기
	int updateCartItemInfo(Map<String, String> paraMap) throws SQLException;
	
	// update 된 장바구니의 정보를 조회(select)해주는 메소드
	CartVO selectUpdateCart(String s_item_no) throws SQLException;

	
	// 삭제버튼 클릭 시 tbl_cart의 제품 정보를 삭제 하기
	int deleteCartItem(String item_number) throws SQLException;

	// delete 된 장바구니의 정보를 조회(select)해주는 메소드
	CartVO selectDeleteCart(String item_number) throws SQLException;

	*/
	
	
	
}
