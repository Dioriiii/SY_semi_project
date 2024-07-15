package db.myshop.model;

import java.sql.SQLException;
import java.util.*;

import db.mypage.orderInfo.domain.*;
import jh.user.domain.*;


public interface MyshopDAO {

	// 제품페이지의 해당 제품의 좋아요수를 가져온다.
	int getItemLikeCnt(String it_seq_no) throws SQLException;

	// 사용자가 좋아요를 눌러 확인한다.
	int addLike(Map<String, String> paraMap) throws SQLException;

	// "주문상세일련번호"로 작성된 리뷰가 존재하는지 확인한다.
	boolean ReviewExistCheck(String o_detail_seq_no) throws SQLException;

	// 상품후기 작성
	int writeReview(Map<String, String> paraMap) throws SQLException;

	// 내가 작성했던 리뷰내용을 가져오는 것
	String reviewUpdate(String review_seq) throws SQLException;

	// 사용자가 작성한 리뷰 삭제하기
	int reviewDel(String o_detail_seq_no) throws SQLException;

	// 사용자가 작성한 리뷰 수정하기
	int reviewUpdate(Map<String, String> paraMap) throws SQLException;

	
	
	

}
