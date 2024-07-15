package db.mypage.customerCare.model;

import java.io.UnsupportedEncodingException;
import java.sql.*;
import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import db.mypage.customerCare.domain.CustomerCareVO;
import my.util.security.AES256;
import my.util.security.SecretMyKey;

public class CustomerCareDAO_imple implements CustomerCareDAO {

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
 	public CustomerCareDAO_imple() {
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
    
	
	// --- *** 자주 묻는 질문 카테고리를 가져와 항목으로 만든다. *** --- //
	@Override
	public List<Map<String, String>> CustomerCareCategory() throws SQLException {
		
		List<Map<String, String>> categoryList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select qna_cate_no, qna_cate_name "
					   + " from tbl_qna_category ";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
				
			while( rs.next() ) {
				Map<String, String> paraMap = new HashMap<>();
				paraMap.put("qna_cate_no", rs.getString(1));
				paraMap.put("qna_cate_name", rs.getString(2));
				
				categoryList.add( paraMap );
			}
		} finally {
			close();
		}
		
		return categoryList;
	} // end of public List<String> CustomerCareCategory() throws SQLException {

	
	
	// 질문과 답변을 가져온다
	@Override
	public List<CustomerCareVO> CustomerCareFAQ(Map<String, String> paraMap) throws SQLException{
		
		List<CustomerCareVO> cuvoList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();

			String sql = " SELECT q_title, q_content "
					   + " FROM "
					   + " ( "
					   + "     select row_number() over(order by q_seq_no asc) as RNO, q_seq_no, fk_qna_cate_no , q_title, q_content "
					   + "     from tbl_qna "
					   + "     where fk_qna_cate_no = ? "
					   + "     order by q_seq_no asc "
					   + " ) "
					   + " WHERE RNO BETWEEN ? AND ? ";
			
			pstmt = conn.prepareStatement(sql);
			/*
		 	=== 페이징처리의 공식 ===
where RNO between (조회하고자하는페이지번호 * 한페이지당보여줄행의개수) - (한페이지당보여줄행의개수 - 1) and (조회하고자하는페이지번호 * 한페이지당보여줄행의개수);
		 */
			
			pstmt.setString(1, paraMap.get("q_ca"));
			pstmt.setInt(2, (Integer.parseInt(paraMap.get("page")) * 8) - (8 - 1));
			pstmt.setInt(3, (Integer.parseInt(paraMap.get("page")) * 8));
		
			rs = pstmt.executeQuery();

			while (rs.next()) {
				CustomerCareVO cuvo = new CustomerCareVO();
				cuvo.setQ_title(rs.getString("Q_TITLE"));
				cuvo.setQ_content(rs.getString("Q_CONTENT"));
				
				cuvoList.add(cuvo);
			}
		} finally {
			close();
		}

		return cuvoList;
	} // end of public CustomerCareVO CustomerCareFAQ(String q_ca) {

	
	
	// 카테고리별로 표시할 페이지 수를 가져온다.
	@Override
	public int getTotalPage(Map<String, String> paraMap) throws SQLException {

		int totalPage = 0; 

		try {
			conn = ds.getConnection();

			String sql = " select ceil(count(*)/8) "
					   + " from tbl_qna "
					   + " where fk_qna_cate_no = ? ";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("q_ca"));

			rs = pstmt.executeQuery();

			rs.next();
			
			totalPage = rs.getInt(1);
			
		} finally {
			close();
		}

		return totalPage;
	} // end of public int selectTotalPage(Map<String, String> paraMap) throws SQLException {
	
	 	
}
