package jh.mypage.orderInfo.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import jh.mypage.orderInfo.domain.*;

public class OrderDAO_imple implements OrderDAO {

	private DataSource ds; // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool)이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	// 생성자
	public OrderDAO_imple() {
			
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



	
	// 주문정보에 대해 조회하는 메소드
	@Override
	public List<OrderVO> selectOneOrderList() throws SQLException {

		List<OrderVO> orderOneList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select B.order_seq_no, B.fk_userid, B.sh_name, B.sh_mobile, B.sh_postcode, B.sh_address "
					   + "      , B.sh_detailaddress, B.sh_extraaddress, B.sh_msg, B.order_date, count "
					   + " FROM "
					   + " ( "
					   + " select count(*) AS count, order_seq_no "
					   + " from tbl_order O "
					   + " join tbl_detail D "
					   + " on O.order_seq_no = D.fk_order_seq_no "
					   + " group by order_seq_no "
					   + " ) A "
					   + " JOIN tbl_order B "
					   + " ON A.order_seq_no = B.order_seq_no ";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				OrderVO odvo = new OrderVO();

				odvo.setOrder_seq_no(rs.getString(1));
				odvo.setFk_userid(rs.getString(2));
				odvo.setSh_name(rs.getString(3));
				odvo.setSh_mobile(rs.getString(4));
				odvo.setSh_postcode(rs.getString(5));
				odvo.setSh_address(rs.getString(6));
				odvo.setSh_detailaddress(rs.getString(7));
				odvo.setSh_extraaddress(rs.getString(8));
				odvo.setSh_msg(rs.getString(9));
				odvo.setOrder_date(rs.getString(10));
				odvo.setOrder_count(rs.getInt(11));
				
				orderOneList.add(odvo);
				
			}// end of while(rs.next())
			
		} finally {
			close();
		}
		
		return orderOneList;
	}


	// Ajax(JSON)를 사용하여 주문목록을 "스크롤" 방식으로 페이징 처리
	@Override
	public int totalOrderCount() throws SQLException {

		int totalCount = 0;

		try {
			conn = ds.getConnection();
			
			String sql = " select count(*) "
					   + " from tbl_order ";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			rs.next();
			
			totalCount = rs.getInt(1);
			
		} finally {
			close();
		}
		
		return totalCount;
		
	} // end of public int totalOrderCount() throws SQLException
	
}
