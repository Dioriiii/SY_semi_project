package db.mypage.orderInfo.model;

import java.sql.SQLException;
import java.util.*;

import db.mypage.orderInfo.domain.*;
import jh.user.domain.*;


public interface OrderInfoDAO {

	// ** 로그인 유저의 최근 주문일련번호 4개 가져오기 ** //
	List<UserVO> getOrderNoLastFour(String userid) throws SQLException;

	// ** 가져온 주문일련번호 안의 주문상세일련번호 중 가장 비싼 상품이름, 수량, 진행상황, 이미지파일 가져오기 ** //
	UserVO getMostExpensivProd(String order_seq_no) throws SQLException;

	// ** 주문일련번호의 총 구매제품수, 총 구매가격 가져오기 ** //
	Map<String, String> getTotalProgress(String order_seq_no) throws SQLException;

	// ** tbl_order 주문일련번호 -> 수령인, 수령인 연락처, 우편번호, 배송수령지(상세주소 도) ** //
	UserVO getOrderInfo(Map<String, String> paraMap) throws SQLException;

	// ** 주문일련번호=> 제품일련번호 -> 제품명, 구매수량, 구매가격, 진행상황, 제품메인이미지파일 ** //
	List<UserVO> getOrderDetailInfo(Map<String, String> paraMap) throws SQLException;

	// ** userid를 통해서 주문일자, 주문일련번호, 제품일련번호, 제품명, 용량, 주문수량, 주문금액, 주문상태, 이미지 ** //
	List<List<UserVO>> getOrderDeliverInfoView(String userid) throws SQLException;

	// ** 주문상세페이지에서 tbl_order 테이블 우편번호, 배송수령지, 배송상세주소, 배송참고항목 변경 ** //
	boolean setDetailAddressUpdate(Map<String, String> paraMap) throws SQLException;


	

	

}
