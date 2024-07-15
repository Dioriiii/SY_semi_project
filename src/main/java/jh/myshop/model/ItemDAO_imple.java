package jh.myshop.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class ItemDAO_imple implements ItemDAO {

	private DataSource ds; // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool)이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	// 생성자
	public ItemDAO_imple() {
			
		try {
			Context initContext = new InitialContext();
		    Context envContext  = (Context)initContext.lookup("java:/comp/env");
		    ds = (DataSource)envContext.lookup("jdbc/semi_oracle");
			
		    
		} catch(NamingException e) {
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
	
	// ca_id(카테고리번호)이 tbl_category 테이블에 존재하는지 존재하지 않는지 알아오기
	@Override
	public boolean isExist_ca_id(String ca_id) throws SQLException {
		
		boolean isExist = false;
	      
	      try {
	         conn = ds.getConnection();
	         
	         String sql = " select * "  
	                    + " from tbl_category "
	                    + " where ca_id = ? "; 
	         
	         pstmt = conn.prepareStatement(sql);
	         
	         pstmt.setString(1, ca_id);
	               
	         rs = pstmt.executeQuery();
	         
	         isExist = rs.next();
	         
	      } finally {
	         close();
	      }      
	      
	      return isExist;
	}


	// 모든 아이템의 갯수를 알아오는 메소드
	@Override
	public int getAllItemCount() throws SQLException {
		
		int n = 0;
	      
		try {
			conn = ds.getConnection();
			
			String sql = " select count(*) "
					   + " from tbl_item "; 
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			rs.next();
			
			n = rs.getInt(1);
			
		} finally {
			close();
		}      
		
		return n;
	} // end of public int getAllItemCount()


	// 특정 아이템을 삭제하는 메소드
	@Override
	public int deleteItem(String it_seq_no) throws SQLException {
		
		int n = 0;
	      
		try {
			conn = ds.getConnection();
			
			String sql = " delete from tbl_item "
					   + " where it_seq_no = ? "; 
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, it_seq_no);
			
			n = pstmt.executeUpdate();
			
		} finally {
			close();
		}      
		
		return n;
	} // end of public int deleteItem(String it_seq_no)

}
