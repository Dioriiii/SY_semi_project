package db.myshop.model;

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

import my.util.security.AES256;
import my.util.security.SecretMyKey;

public class MyshopDAO_imple implements MyshopDAO {
	
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
 	public MyshopDAO_imple() {
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
	

	// 제품페이지의 해당 제품의 좋아요 수를 가져온다.
	@Override
	public int getItemLikeCnt(String it_seq_no) throws SQLException {
		
		int likeCnt = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select count(*) as LIKECNT "
					   + " from tbl_heart "
					   + " where fk_it_seq_no = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, it_seq_no);
			
			rs = pstmt.executeQuery();
			
			rs.next();
			// 좋아요가 없으면 0이다, 있다면 값이 나온다.
			likeCnt = rs.getInt("LIKECNT");
			
		} finally {
			close();
		}
		
		return likeCnt;
	} // end of public int getItemLikeCnt(String it_seq_no) throws SQLException {

	
	
	// 사용자가 좋아요를 눌러 확인한다.
	@Override
	public int addLike(Map<String, String> paraMap) throws SQLException {
		
		int result = 0;
		
		try {
			conn = ds.getConnection();
			
			// 좋아요를 누른 해당 제품 구매 이력이 존재하는지 
			String sql = " SELECT fk_userid, fk_it_seq_no "
					   + " FROM "
					   + " ( "
					   + "     select fk_userid, order_seq_no "
					   + "     from tbl_order "
					   + "     where fk_userid = ? "
					   + " ) O JOIN "
					   + " ( "
					   + "     select fk_order_seq_no, fk_it_seq_no "
					   + "     from tbl_detail "
					   + "     where fk_it_seq_no = ? "
					   + " ) D "
					   + " ON O.order_seq_no = D.fk_order_seq_no ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, paraMap.get("userid"));
			pstmt.setString(2, paraMap.get("it_seq_no"));
			
			rs = pstmt.executeQuery();
			
			// 제품을 구매하지 않았다면 
			if(!rs.next()) {
				result = 2;
				return result;
			}
			
			sql = " select count(*) AS LIKECHECK "
				+ " from tbl_heart "
			    + " where fk_userid = ? and fk_it_seq_no = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, paraMap.get("userid"));
			pstmt.setString(2, paraMap.get("it_seq_no"));
			
			rs = pstmt.executeQuery();
			
			rs.next();
			
			// 좋아요가 있다 1, 없다 0
			result = rs.getInt("LIKECHECK");
			
			if(result == 1) {
			// 이미 좋아요를 눌렀다.
				result = 0;
			}
			else {
			// 좋아요를 tbl_heart에 추가한다.
				sql = " insert into tbl_heart(FK_USERID, FK_IT_SEQ_NO, HEART) values(?, ?, 1) ";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, paraMap.get("userid"));
				pstmt.setString(2, paraMap.get("it_seq_no"));
				
				result = pstmt.executeUpdate();
				// result == 1
			}
			
			
		} finally {
			close();
		}
		
		return result;
	}// end of 	public int addLike(Map<String, String> paraMap) throws SQLException {

	
	
	// "주문상세일련번호"로 작성된 리뷰가 존재하는지 확인한다.
	@Override
	public boolean ReviewExistCheck(String o_detail_seq_no) throws SQLException {

		boolean existCheck = false;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select FK_O_DETAIL_SEQ_NO "
					   + " from tbl_review "
					   + " where fk_o_detail_seq_no = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, o_detail_seq_no);
			
			rs = pstmt.executeQuery();
			
			existCheck = rs.next();
			// 작성된 리뷰가 있다. true
			// 작성된 리뷰가 없다. false
			
		} finally {
			close();
		}
		
		return existCheck;
	}// end of 	public boolean ReviewExistCheck() throws SQLException {

	
	
	// 상품후기 작성
	@Override
	public int writeReview(Map<String, String> paraMap) throws SQLException {
		int result = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " insert into tbl_review(re_seq_no, fk_o_detail_seq_no, re_content) values(seq_tbl_review.nextval, ?, ?) ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, paraMap.get("o_detail_seq_no"));
			pstmt.setString(2, paraMap.get("re_content"));
			
			result = pstmt.executeUpdate();
			// 작성 성공 1 실패 0
			
		} finally {
			close();
		}
		
		return result;
	}// end of public int writeReview(Map<String, String> paraMap) throws SQLException {


	
	// 내가 작성했던 리뷰내용을 가져오는 것
	@Override
	public String reviewUpdate(String o_detail_seq_no) throws SQLException {
		String re_content = "";
		
		try {
			conn = ds.getConnection();
			
			String sql = " select re_content "
					   + " from tbl_review "
					   + " where fk_o_detail_seq_no = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, o_detail_seq_no);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				re_content = rs.getString("RE_CONTENT");
			}
			// 작성되었던 리뷰값 가져가기
			
		} finally {
			close();
		}
		
		return re_content;
	}// end of public String reviewUpdate(String review_seq) throws SQLException {

	
	
	// 사용자가 작성한 리뷰 삭제
	@Override
	public int reviewDel(String o_detail_seq_no) throws SQLException {
		int result = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " delete from tbl_review where fk_o_detail_seq_no = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, o_detail_seq_no);
			
			result = pstmt.executeUpdate();
			// 삭제성공 1  삭제실패0
			
		} finally {
			close();
		}
		
		return result;
	} // end of public int reviewDel(String o_detail_seq_no) throws SQLException


	// 사용자가 작성한 리뷰 수정하기
	@Override
	public int reviewUpdate(Map<String, String> paraMap) throws SQLException {
		int result = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " update tbl_review set re_content = ? "
					   + " where fk_o_detail_seq_no = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, paraMap.get("re_content"));
			pstmt.setString(2, paraMap.get("o_detail_seq_no"));
			
			result = pstmt.executeUpdate();
			// 수정성공 1  수정실패0
			
		} finally {
			close();
		}
		
		return result;
	}// end of 	public int reviewUpdate(Map<String, String> paraMap) throws SQLException

	
 	
} // end of public class OrderInfoDAO_imple implements OrderInfoDAO {
