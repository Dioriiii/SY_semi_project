package db.mypage.orderInfo.model;

import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import db.mypage.orderInfo.domain.*;
import jh.user.domain.*;

import my.util.security.AES256;
import my.util.security.SecretMyKey;

public class OrderInfoDAO_imple implements OrderInfoDAO {
	
	private DataSource ds; // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool)이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private AES256 aes;
	
	
	// 사용한 자원을 반납하는 close() 메소드 생성하기 
    private void close() {
       try {
          if(rs != null)    {rs.close();    rs=null;}
          if(pstmt != null) {pstmt.close(); pstmt=null;}
          if(conn != null)  {conn.close();  conn=null;}
       } catch(SQLException e) {
          e.printStackTrace();
       }
    }
	
	
    // 생성자
 	public OrderInfoDAO_imple() {
 		try {
 			Context initContext = new InitialContext();
 			Context envContext  = (Context)initContext.lookup("java:/comp/env");
 			ds = (DataSource)envContext.lookup("jdbc/semi_oracle");
 			
 			aes = new AES256(SecretMyKey.KEY);
 			// SecretMyKey.KEY 은 우리가 만든 암호화/복호화 키이다.
 			
 		} catch(NamingException e) {
 			e.printStackTrace();
 		} catch(UnsupportedEncodingException e) {
 			e.printStackTrace();
 		}
 	} // end of 생성자
	
	
	// ** 로그인 유저의 최근 주문일련번호 4개 가져오기 ** //
	@Override
	public List<UserVO> getOrderNoLastFour(String userid) throws SQLException {
		
		List<UserVO> uvoList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();

			String sql = " SELECT order_seq_no " 
					   + " FROM "
					   + " ( "
					   + "     select row_number() over(order by order_date desc) AS RNO , order_seq_no "
					   + "     from tbl_order "
					   + "     where fk_userid = ? "
					   + " ) "
					   + " WHERE RNO <= 4 "
					   + " ORDER BY RNO DESC ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, userid);
		
			rs = pstmt.executeQuery();

			while (rs.next()) {
				UserVO uvo = new UserVO();
				
				OrderVO ovo = new OrderVO();
				ovo.setOrder_seq_no(rs.getString("ORDER_SEQ_NO"));
				
				uvo.setOvo(ovo);
				
				uvoList.add(uvo);
			}
			
		} finally {
			close();
		}

		return uvoList;
	} // end of public List<UserVO> getOrderNoLastFour(String userid) throws SQLException {

	
	
	// ** 가져온 주문일련번호 안의 주문상세일련번호 중 가장 비싼 상품이름, 수량, 진행상황, 이미지파일 가져오기 ** //
	@Override
	public UserVO getMostExpensivProd(String order_seq_no) throws SQLException {
		
		UserVO uvo_getFromImple = new UserVO();
		
		try {
			conn = ds.getConnection();

			String sql = " SELECT IT.it_name ,D2.o_qty, D2.o_status, IM.img_file "
					   + " FROM "
					   + " ( "
					   + "     select fk_it_seq_no, o_qty, o_status "
					   + "     from  "
					   + "     ( "
					   + "         select row_number() over(order by o_price desc) as rno, fk_it_seq_no, o_qty, o_status "
					   + "         from tbl_detail "
					   + "         where fk_order_seq_no = ? "
					   + "     ) D "
					   + "     where rno = 1 "
					   + " ) D2 JOIN tbl_item IT "
					   + " ON D2.fk_it_seq_no = IT.it_seq_no "
					   + " JOIN tbl_img IM "
					   + " ON D2.fk_it_seq_no = IM.fk_it_seq_no "
					   + " WHERE IM.is_main_img = 1 ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, order_seq_no);
		
			rs = pstmt.executeQuery();

			if(rs.next()) {
				ItemVO itvo = new ItemVO();
				itvo.setIt_name(rs.getString("IT_NAME"));	// 상품명
				uvo_getFromImple.setItvo(itvo);
				
				DetailVO dvo = new DetailVO();
				dvo.setO_qty(rs.getInt("O_QTY")); 			// 주문수량
				dvo.setO_status(rs.getInt("O_STATUS"));		// 주문상태
				uvo_getFromImple.setDvo(dvo);
				
				ImageVO imvo = new ImageVO();
				imvo.setImg_file(rs.getString("IMG_FILE")); // 이미지파일
				uvo_getFromImple.setImvo(imvo);
			}
			
		} finally {
			close();
		}

		return uvo_getFromImple;
	} // public Map<String, String> getMostExpensivProd(int order_seq_no) {

	
	
	// ** 주문일련번호의 총 구매제품수, 총 구매가격 가져오기 ** //
	@Override
	public Map<String, String> getTotalProgress(String order_seq_no) throws SQLException {

		Map<String, String> getMap = new HashMap<>();
		
		try {
			conn = ds.getConnection();

			String sql = " select sum(o_qty) as TOTAL_O_QTY, sum(o_price) as TOTAL_O_PRICE "
					   + " from tbl_detail "
					   + " where fk_order_seq_no = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, order_seq_no);
		
			rs = pstmt.executeQuery();

			if(rs.next()) {
				getMap.put("total_o_qty", rs.getString("TOTAL_O_QTY"));
				getMap.put("total_o_price", rs.getString("TOTAL_O_PRICE"));
			}
			
		} finally {
			close();
		}

		return getMap;
	} // end of public Map<String, String> getTotalProgress(int order_seq_no) throws SQLException {


	
	// ** tbl_order 주문일련번호 -> 수령인, 수령인 연락처, 우편번호, 배송수령지(상세주소 도) , 주문일자, 주문번호, 총 금액 ** //
	@Override
	public UserVO getOrderInfo(Map<String, String> paraMap) throws SQLException {
		UserVO uservo = null;
		
		try {
			conn = ds.getConnection();

			String sql = " SELECT sh_name, sh_mobile, sh_postcode, sh_address, sh_detailaddress, sh_extraaddress, to_char(order_date, 'yyyy-mm-dd') as order_date, total_o_price, order_seq_no "
					   + " FROM "
					   + " ( "
					   + "     select order_seq_no, sh_name, sh_mobile, sh_postcode, sh_address, sh_detailaddress, sh_extraaddress, order_date "
					   + "     from tbl_order "
					   + "     where fk_userid = ? and order_seq_no = ?  "
					   + " ) O JOIN "
					   + " ( "
					   + "     select fk_order_seq_no, sum(o_price) AS TOTAL_O_PRICE "
					   + "     from tbl_detail "
					   + "     where fk_order_seq_no = ? "
					   + "     group by fk_order_seq_no "
					   + " ) D  "
					   + " ON O.order_seq_no = D.fk_order_seq_no ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, paraMap.get("userid"));
			pstmt.setString(2, paraMap.get("order_seq_no"));
			pstmt.setString(3, paraMap.get("order_seq_no"));
		
			rs = pstmt.executeQuery();

			if(rs.next()) {
				OrderVO ovo = new OrderVO();
				ovo.setSh_name(rs.getString("SH_NAME")); 			// 수령인
				ovo.setSh_mobile(rs.getString("SH_MOBILE")); 		// 수령인 연락처
				ovo.setSh_postcode(rs.getString("SH_POSTCODE")); 	// 우편번호
				ovo.setSh_address(rs.getString("SH_ADDRESS")); 		// 배송수령지
				ovo.setSh_detailaddress(rs.getString("SH_DETAILADDRESS")); 	// 상세주소
				ovo.setSh_extraaddress(rs.getString("SH_EXTRAADDRESS")); 	// 참고사항
				ovo.setOrder_date(rs.getString("ORDER_DATE")); 		// 주문일자
				ovo.setOrder_seq_no(rs.getString("ORDER_SEQ_NO")); 	// 주문번호
				
				uservo = new UserVO();
				uservo.setOvo(ovo);
				uservo.setTotal_o_price(rs.getInt("TOTAL_O_PRICE")); // 총 금액
			}
			
		} finally {
			close();
		}
		
		return uservo;
	} // end of public UserVO getOrderInfo(Map<String, String> paraMap) throws SQLException {

	
	
	// ** 주문일련번호=> 제품일련번호 -> 제품명, 구매수량, 구매가격, 용량, 진행상황, 제품메인이미지파일 ** //
	@Override
	public List<UserVO> getOrderDetailInfo(Map<String, String> paraMap) throws SQLException {
		
		List<UserVO> uvoList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();

			String sql = " SELECT it_name, o_qty, o_price, o_status, img_file, it_volume "
					   + " FROM "
					   + " ( "
					   + "     SELECT D.fk_it_seq_no ,D.o_qty, D.o_price, D.o_status, I.img_file "
					   + "     FROM "
					   + "     ( "
					   + "         select fk_it_seq_no, o_qty, o_price, o_status "
					   + "         from tbl_detail "
					   + "         where fk_order_seq_no = ? "
					   + "     ) D JOIN "
					   + "     ( "
					   + "         select fk_it_seq_no, img_file "
					   + "         from tbl_img "
					   + "         where is_main_img = 1 "
					   + "     ) I ON D.fk_it_seq_no = I.fk_it_seq_no "
					   + " ) V JOIN tbl_item IT "
					   + " ON V.fk_it_seq_no = IT.it_seq_no ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, paraMap.get("order_seq_no"));
		
			rs = pstmt.executeQuery();

			while(rs.next()) {
			// it_name, o_qty, O_PRICE, O_STATUS, IMG_FILE
				UserVO uvo = new UserVO();
				
				ItemVO itvo = new ItemVO();
				itvo.setIt_name(rs.getString("IT_NAME")); // 제품명
				itvo.setIt_volume(rs.getString("IT_VOLUME")); // 용량
				
				uvo.setItvo(itvo);
				
				DetailVO dvo = new DetailVO();
				dvo.setO_qty(rs.getInt("O_QTY")); // 주문수량
				dvo.setO_price(rs.getInt("O_PRICE")); // 주문금액
				dvo.setO_status(rs.getInt("O_STATUS")); // 배송상태 0 배송준비 1 배송중 2 배송완료
				
				uvo.setDvo(dvo);
				
				ImageVO imvo = new ImageVO(); 
				imvo.setImg_file(rs.getString("IMG_FILE")); // 이미지 파일
				
				uvo.setImvo(imvo);
				
				uvoList.add(uvo);
			}
			
		} finally {
			close();
		}
		
		return uvoList;
	} // end of public List<UserVO> getOrderDetailInfo(Map<String, String> paraMap) throws SQLException {


	// ** userid를 통해서 주문일자, 주문일련번호, 제품일련번호, 제품명, 용량, 주문수량, 주문금액, 주문상태, 이미지 ** //
	@Override
	public List<List<UserVO>> getOrderDeliverInfoView(String userid) throws SQLException {
		
		List<List<UserVO>> uvoListInList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			// userid로 주문일련번호 list 가져오기
			String sql = " select order_seq_no "
					   + " from tbl_order "
					   + " where fk_userid = ? "
					   + " order by order_date desc ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, userid);
		
			rs = pstmt.executeQuery();
			
			List<UserVO> uvoList = new ArrayList<>();
			
			while(rs.next()) {
				UserVO uvo = new UserVO();
				
				OrderVO ovo = new OrderVO();
				ovo.setOrder_seq_no(rs.getString("ORDER_SEQ_NO"));
				
				uvo.setOvo(ovo);
				
				uvoList.add(uvo); // 주문일련번호 리스트!
				
			}
		//	System.out.println(uvoList.get(0).getOvo().getOrder_seq_no());
			// order_seq_no 891011 
		//	System.out.println(uvoList.size());
			// 1
			if(uvoList.size() > 0) {
				
				// 같은 주문일련번호에 해당하는 제품 와 배송정보 받아오기 정보받아오기
				List<UserVO> uvoovoList = new ArrayList<>();
				
				// 주문일련번호 주문일자  제품일련번호, 제품명, 용량, 주문수량, 주문금액, 주문상태, 이미지 //
				sql = " SELECT O.order_seq_no, to_char(O.order_date, 'yyyy-mm-dd') as order_date, D.fk_it_seq_no, IT.it_name, IT.it_volume, D.o_qty, D.o_price, D.o_status, IM.img_file, D.o_detail_seq_no"
	                + " FROM  "
	                + " ( "
	                + "     select order_seq_no, order_date "
	                + "     from tbl_order "
	                + "     where order_seq_no = ? "
	                + " ) O JOIN "   
	                + " ( "
	                + "     select fk_order_seq_no, fk_it_seq_no, o_qty, o_price, o_status, o_detail_seq_no "
	                + "     from tbl_detail "
	                + "     where fk_order_seq_no = ? "
	                + " ) D ON O.order_seq_no = D.fk_order_seq_no JOIN "
	                + " ( "
	                + "     select it_seq_no, it_name, it_volume "
	                + "     from tbl_item "
	                + " ) IT ON D.fk_it_seq_no = IT.it_seq_no JOIN "
	                + " ( "
	                + "     select fk_it_seq_no, img_file "
	                + "     from tbl_img "
	                + "     where is_main_img = 1 "
	                + " ) IM ON IT.it_seq_no = IM.fk_it_seq_no "
	                + " order by D.o_price desc ";
		 
				for(int i=0 ; i<uvoList.size() ; i++) {
					pstmt = conn.prepareStatement(sql);
					
					pstmt.setString(1, uvoList.get(i).getOvo().getOrder_seq_no());
					pstmt.setString(2, uvoList.get(i).getOvo().getOrder_seq_no());
					
					rs = pstmt.executeQuery();
					
					// O.주문일련번호  O.주문일자  D.제품일련번호, IT.제품명, IT.용량, D.주문수량, D.주문금액, D.주문상태, IM.이미지 //
					List<UserVO> uvoInfoList = new ArrayList<>();
					while(rs.next()) {
						UserVO uvo = new UserVO();
		                  
		                  OrderVO ovo = new OrderVO(); 
		                  ovo.setOrder_date(rs.getString("ORDER_DATE"));       // O.주문일자
		                  ovo.setOrder_seq_no(rs.getString("ORDER_SEQ_NO"));     // O.주문일련번호
		                  uvo.setOvo(ovo);
		                  
		                  ItemVO itvo = new ItemVO();      
		                  itvo.setIt_name(rs.getString("IT_NAME"));          // IT.제품명
		                  itvo.setIt_volume(rs.getString("IT_VOLUME"));      // IT.용량
		                                                         
		                  uvo.setItvo(itvo);
		         
		                  DetailVO dvo = new DetailVO();
		                  dvo.setFk_it_seq_no(rs.getInt("FK_IT_SEQ_NO"));   // D.제품일련번호
		                  dvo.setO_qty(rs.getInt("O_QTY"));            // D.주문수량
		                  dvo.setO_price(rs.getInt("O_PRICE"));         // D.주문금액
		                  dvo.setO_status(rs.getInt("O_STATUS"));         // D.주문상태
		                  dvo.setO_detail_seq_no(rs.getString("O_DETAIL_SEQ_NO")); //  D.주문상세일련번호
		                  
		                  uvo.setDvo(dvo);
		                  
		                  ImageVO imvo = new ImageVO();
		                  imvo.setImg_file(rs.getString("IMG_FILE")); // IM.이미지
		                  uvo.setImvo(imvo);
		                  
		                  uvoInfoList.add(uvo);
					}
					
					uvoListInList.add(uvoInfoList);
				}// end of for for(int i=0 ; i<uvoList.size() ; i++) {
			
			}// if(uvoList.size() > 0) {
			
		} finally {
			close();
		}
		
		return uvoListInList;
	}// end of public List<List<UserVO>> getOrderDeliverInfoView(String userid) throws SQLException {


	
	@Override
	public boolean setDetailAddressUpdate(Map<String, String> paraMap) throws SQLException {
		boolean UpdateCheck = false;

		Map<String, String> getMap = new HashMap<>();

		try {
			conn = ds.getConnection();
					// 수령인, 수령인연락처, 우편번호, 배송수령지, 배송상세주소, 배송참고항목
			String sql = " update tbl_order set SH_NAME=? ,SH_MOBILE=?, SH_POSTCODE=?, SH_ADDRESS=?, SH_DETAILADDRESS=?, SH_EXTRAADDRESS=? "
					   + " where order_seq_no = ? ";

			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, paraMap.get("name"));			// 수령인
			pstmt.setString(2, paraMap.get("user_mobile"));		// 연락처
			pstmt.setString(3, paraMap.get("postcode"));		// 우편번호
			pstmt.setString(4, paraMap.get("address"));			// 수령지
			pstmt.setString(5, paraMap.get("detailAddress"));	// 상세주소
			pstmt.setString(6, paraMap.get("extraAddress"));	// 참고항목
			pstmt.setString(7, paraMap.get("order_seq_no"));	// 주문일련번호
			
			int n = pstmt.executeUpdate();

			if (n == 1) {
				UpdateCheck = true;
			}

		} finally {
			close();
		}

		return UpdateCheck;
	}// end of public boolean setDetailAddressUpdate(Map<String, String> paraMap) -----------

	
    
 	
} // end of public class OrderInfoDAO_imple implements OrderInfoDAO {
