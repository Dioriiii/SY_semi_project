package ws.user.model;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import ws.shop.domain.DetailVO;
import ws.shop.domain.ItemVO;
import ws.shop.domain.OrderVO;
import jh.user.domain.UserVO;
import my.util.security.AES256;
import my.util.security.SecretMyKey;


public class UserDAO_imple implements UserDAO {

	private DataSource ds; // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool)이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private AES256 aes;

	
	
	// 생성자
		public UserDAO_imple() {
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
	   
	   
	   
	// 주문완료된 회원의 정보를 가져오는 메소드
	@Override
	public List<DetailVO> paymentEndDisplay(Map<String, String> paraMap) throws SQLException {
		
		List<DetailVO> detailList = null;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select to_char(order_date,'yyyy.mm.dd') as order_date "
					   + "     , U.name "
					   + "     , U.email "
					   + "     , I.it_name "
					   + "     , I.it_volume "
					   + "     , D.o_qty "
					   + "     , D.o_price "
					   + "     , ( select count(*)-1 "
					   + "        from tbl_order A "
					   + "        join tbl_detail B "
					   + "        on A.order_seq_no = B.fk_order_seq_no "
					   + "        where fk_userid = ? and sh_name = ? and sh_postcode = ? ) as except_order_cnt "
					   + "     , O.order_seq_no "
					   + "     , O.sh_name "
					   + "     , O.sh_postcode "
					   + "     , O.sh_address "
					   + "     , O.sh_detailaddress "
					   + "     , O.sh_extraaddress "
					   + "     , O.sh_mobile "
					   + " from tbl_order O "
					   + " join "
					   + " tbl_user U "
					   + " on O.fk_userid = U.userid "
					   + " Join tbl_detail D "
					   + " on O.order_seq_no = D.fk_order_seq_no "
					   + " join tbl_item I "
					   + " on I.it_seq_no = D.fk_it_seq_no "
					   + " where fk_userid = ? and sh_name = ? and sh_postcode = ? "
			           + " order by it_name desc ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,paraMap.get("login_userid"));
			pstmt.setString(2,paraMap.get("sh_name"));
			pstmt.setString(3,paraMap.get("sh_postcode"));
			pstmt.setString(4,paraMap.get("login_userid"));
			pstmt.setString(5,paraMap.get("sh_name"));
			pstmt.setString(6,paraMap.get("sh_postcode"));
			
			System.out.println(paraMap.get("login_userid") + paraMap.get("sh_name") + paraMap.get("sh_postcode"));
			
			rs = pstmt.executeQuery();
			int cnt = 0;
			while(rs.next()) {
				cnt++;
				
				if(cnt==1) {
					detailList = new ArrayList<>();
				}
				

				UserVO uvo = new UserVO();
				uvo.setName(rs.getString("NAME"));
				uvo.setEmail(aes.decrypt(rs.getString("EMAIL")));
				
				
				ItemVO ivo = new ItemVO();
				ivo.setIt_name(rs.getString("IT_NAME"));
				ivo.setIt_volume(rs.getString("IT_VOLUME"));
				ivo.setTotalPriceTotalPayment(rs.getInt("O_QTY"));
				
				
				OrderVO ovo = new OrderVO();
				ovo.setOrder_date(rs.getString("ORDER_DATE"));
				ovo.setOrder_seq_no(rs.getString("ORDER_SEQ_NO"));
				ovo.setSh_name(rs.getString("SH_NAME"));
				ovo.setSh_postcode(rs.getString("SH_POSTCODE"));
				ovo.setSh_address(rs.getString("SH_ADDRESS"));
				ovo.setSh_detailaddress(rs.getString("SH_DETAILADDRESS"));
				ovo.setSh_extraaddress(rs.getString("SH_EXTRAADDRESS"));
				ovo.setSh_mobile(rs.getString("SH_MOBILE"));
				
				DetailVO dvo = new DetailVO();
				dvo.setO_qty(rs.getInt("O_QTY"));
				dvo.setO_price(rs.getInt("o_price"));
				dvo.setExcept_order_cnt(Integer.parseInt(rs.getString("EXCEPT_ORDER_CNT")));
				
	            ovo.setUvo(uvo);
				dvo.setOvo(ovo);
				dvo.setIvo(ivo);
			
				detailList.add(dvo);
	            
	            
			}// end of while()-----------------

		} catch(GeneralSecurityException | UnsupportedEncodingException e) {
			e.printStackTrace();
		} finally {
			close();
		}
	
		return detailList;
	} // end of public List<DetailVO> paymentEndDisplay(Map<String, String> paraMap)-----------

	
	
	
	// 주문의 총 금액 정보를 가져오는 메소드
	@Override
	public int sumTotalPrice(Map<String, String> paraMap) throws SQLException {
		
		int n = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select sum(totalprice) as totalprice"
					   + " from "
					   + " ( "
					   + " select D.o_qty "
					   + "     , D.o_price "
					   + "     , (D.o_qty * D.o_price) as totalprice "
					   + "     , O.sh_name "
					   + "     , O.sh_postcode "
					   + " from tbl_order O "
					   + " join "
					   + " tbl_user U "
					   + " on O.fk_userid = U.userid "
					   + " Join tbl_detail D "
					   + " on O.order_seq_no = D.fk_order_seq_no "
					   + " join tbl_item I "
					   + " on I.it_seq_no = D.fk_it_seq_no "
					   + " where fk_userid = ? and sh_name = ? and sh_postcode = ? "
					   + " order by it_name desc "
					   + " ) V ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,paraMap.get("login_userid"));
			pstmt.setString(2,paraMap.get("sh_name"));
			pstmt.setString(3,paraMap.get("sh_postcode"));
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				n = rs.getInt("TOTALPRICE");
			}

		} finally {
			close();
		}
		
		return n;
	} // end of public int sumTotalPrice(Map<String, String> paraMap)


}
