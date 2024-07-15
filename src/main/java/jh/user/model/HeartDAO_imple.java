package jh.user.model;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import jh.myshop.domain.CategoryVO;
import jh.user.domain.HeartVO;
import jh.user.domain.UserVO;
import my.util.security.AES256;
import my.util.security.SecretMyKey;
import my.util.security.Sha256;

public class HeartDAO_imple implements HeartDAO {

	private DataSource ds; // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool)이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private AES256 aes;
	
	// 생성자
	public HeartDAO_imple() {
			
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
	}
	
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

    
	// 좋아요 테이블에 insert 해주는 method n, userid, it_seq_no, button_id, div_id
	@Override
	public int plusHeart(String userid, String it_seq_no) throws SQLException {
		
		int result = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select fk_userid, fk_it_seq_no, heart "
					   + " from tbl_heart "
					   + " where fk_userid = ? and fk_it_seq_no = ? ";
				
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, userid);
			pstmt.setString(2, it_seq_no);
		
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				sql = " delete from tbl_heart "
					+ " where fk_userid = ? and fk_it_seq_no = ? ";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, userid);
				pstmt.setString(2, it_seq_no);
				
				result = pstmt.executeUpdate();
				
			}
			else {
				sql = " insert into tbl_heart(fk_userid, fk_it_seq_no, heart) "
					+ " values(?, ?, ?) ";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, userid);
				pstmt.setString(2, it_seq_no);
				pstmt.setString(3, "1");
			
				result = pstmt.executeUpdate();
			}
			
				
		} finally {
			close();
		}
		
		return result;
		
	} // end of public void plusHeart(String userid, String it_seq_no) throws SQLException


	
	// 좋아요 테이블에서 delete 해주는 method
	@Override
	public int minusHeart(String userid, String it_seq_no) throws SQLException {

		int result = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " delete from tbl_heart "
					   + " where fk_userid = ? and fk_it_seq_no = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, userid);
			pstmt.setString(2, it_seq_no);
			
			result = pstmt.executeUpdate();
		

		} finally {
			close();
		}
		
		return result;
		
	} // end of public void minusHeart(String userid, String it_seq_no) throws SQLException


	// 좋아요 테이블에서 특정 로그인 유저의 좋아요 목록을 select 하는 method
	@Override
	public List<HeartVO> heartUser (UserVO loginuser) throws SQLException {

		List<HeartVO> heartUserList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select fk_userid, fk_it_seq_no, heart "
					   + " from tbl_heart "
					   + " where fk_userid = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, loginuser.getUserid());
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				HeartVO hvo = new HeartVO();
				
				hvo.setFk_userid(rs.getString(1));
				hvo.setFk_it_seq_no(rs.getString(2));
				hvo.setHeart(rs.getString(3));
				
				heartUserList.add(hvo);
				
			}// end of while(rs.next())
			
		} finally {
			close();
		}
		
		return heartUserList;
		
	} // end of public List<HeartVO> heartUser (UserVO loginuser) throws SQLException

}
