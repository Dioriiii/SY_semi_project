package wh.myshop.model;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.*;
import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import org.json.JSONObject;

import jh.user.domain.UserVO;
import my.util.security.AES256;
import my.util.security.SecretMyKey;
import wh.myshop.domain.*;

public class OrderDAO_imple implements OrderDAO {

	private DataSource ds; // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool)이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private AES256 aes;
	
	// 생성자
	public OrderDAO_imple() {
		
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

	   
	   
	// 결제완료 후 결제한 정보를 DB에 update 해주는 메소드   
	@Override
	public int PaymentUpdateLoginUser(Map<String, String> paraMap) throws SQLException {
		
		
		int n = 0;
		
		
		try {
			conn = ds.getConnection();
			
			String sql = " insert into tbl_order(order_seq_no, fk_userid, sh_name, sh_mobile, sh_postcode, sh_address ,sh_extraaddress, sh_msg) "
					   + " values(sysdate, ?, ? ,?, ?, ?, ?, ?) ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("userid") );
			pstmt.setString(2, paraMap.get("sh_name") );
			pstmt.setString(3, paraMap.get("sh_mobile") );
			pstmt.setString(4, paraMap.get("postcode") );
			pstmt.setString(5, paraMap.get("address") );
			pstmt.setString(6, paraMap.get("detailAddress") );
			pstmt.setString(7, paraMap.get("tomsg") );
		
			n = pstmt.executeUpdate();
			
			
		} finally {
			close();
		}
		
		return n;
	}

	
	
	
	// 결제 후 update 된 tbl_order 의 정보를 select 해주는 메소드
	@Override
	public OrderVO paymentListView(String userid) throws SQLException {

		OrderVO odrvo = new OrderVO();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select ORDER_SEQ_NO "
					   + " from tbl_order "
					   + " where FK_USERID = ? ";				
			
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			
			
			rs = pstmt.executeQuery();
			
			
			if(rs.next()) {
				
				odrvo.setOrder_seq_no(rs.getInt("ORDER_SEQ_NO"));
			};
			
		} finally {
			close();
		}
		
		return odrvo;
		
		
		
	}

	
	
	
	// tbl_cart의 정보를 결제 후 tbl_detail 의 정보로 insert 해주는 메소드
	@Override
	public int PaymentDetailUpdateLoginUser(int order_seq_no, List<CartVO> orderList) throws SQLException {
		int n = 0;
		int cnt = 0;
		int isSuccess = 0;
		
		
		try {
			conn = ds.getConnection();
			
			for (CartVO cartvo : orderList) {
			    
				cartvo = new CartVO();
				
				int fk_it_seq_no = cartvo.getFk_it_seq_no();
			    int fk_order_qty = cartvo.getOrder_qty();

			   
			    String sql = " insert into tbl_detail(o_detail_seq_no, fk_order_seq_no, fk_it_seq_no, o_qty, o_status) "
						   + " values(sysdate, ?, ?, ?, 0) ";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setInt(1, order_seq_no);
				pstmt.setInt(2, fk_it_seq_no);
				pstmt.setInt(3, fk_order_qty);
				
			
				n = pstmt.executeUpdate();
			
				cnt++;
			
			}
			
			
			if( orderList.size() == cnt) {
				
				
				isSuccess = 1;
			}
			
			
		} finally {
			close();
		}
		
		return isSuccess;
	}

	



}
