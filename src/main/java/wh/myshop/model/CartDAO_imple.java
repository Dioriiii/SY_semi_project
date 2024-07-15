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

public class CartDAO_imple implements CartDAO {

	private DataSource ds; // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool)이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private AES256 aes;
	
	// 생성자
	public CartDAO_imple() {
		
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
	
	
	
	

	
	// 장바구니에 tbl_cart의 정보를 조회(select)해주는 메소드
		@Override
		public List<CartVO> cartItemInfo(Map<String, String> paraMap) throws SQLException {
			
			List<CartVO> cartList = new ArrayList<>();
			
			
			try {
				conn = ds.getConnection();
				
				String sql = " select fk_userid, ct_seq_no, fk_it_seq_no, order_qty, it_name, it_price, it_volume, img_file, ca_name, is_main_img "
						   + " from "
						   + " ( "
						   + "    select C.fk_userid, C.ct_seq_no, C.fk_it_seq_no, c.order_qty, it_name, it_price, it_volume, G.img_file, a.ca_name, G.is_main_img "
						   + "    from tbl_cart C join tbl_item I "
						   + "    on C.fk_it_seq_no = I.it_seq_no "
						   + "    join tbl_category a "
						   + "    on i.FK_CA_ID = a.CA_ID "
						   + "    join tbl_img G "
						   + "    on I.it_seq_no = G.fk_it_seq_no "
						   + " )V "
						   + " where is_main_img = 1 and fk_userid = ? ";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, paraMap.get("it_seq_no"));
				
				
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
				
					CartVO cartvo = new CartVO();
					cartvo.setCt_seq_no(rs.getInt("ct_seq_no"));
					cartvo.setFk_it_seq_no(rs.getInt("fk_it_seq_no"));
					cartvo.setOrder_qty(rs.getInt("order_qty"));
					
					ItemVO ivo = new ItemVO();
					ivo.setIt_price(rs.getInt("it_price"));
					ivo.setIt_name(rs.getString("it_name"));
					cartvo.setIvo(ivo);
					
					ImageVO imgvo = new ImageVO();
					imgvo.setImg_file(rs.getString("img_file"));
					cartvo.setImgvo(imgvo);
					
					cartList.add(cartvo);
				};
				
			} finally {
				close();
			}
			
			return cartList;
			
		}// end of public List<CartVO> cartItemInfo(Map<String, String> paraMap) throws SQLException -----------
	
	
	
	
	
	
	// 추가할 제품이 장바구니 안에 없을 때 장바구니 테이블에 제품 정보를 추가(insert)하는 메소드
	@Override
	public int insertCartItem( Map<String, String[]> paraMap, String userid) throws SQLException {
		
		int cnt = 0;
		int isSuccess = 0;
		
		try {
			conn = ds.getConnection();
			
			String[] arr_fk_it_seq_no = paraMap.get("arr_fk_it_seq_no");
			String[] arr_order_qty = paraMap.get("arr_order_qty");
			
		/*
			String[] arr_it_name = paraMap.get("arr_it_name");
			String[] arr_it_price = paraMap.get("arr_it_price");
			String[] arr_img_file = paraMap.get("arr_img_file");
		*/
			
			
			for(int i = 0; i<arr_fk_it_seq_no.length; i++) {
				
				String sql = " insert into tbl_cart(ct_seq_no, fk_userid, fk_it_seq_no, order_qty) "
						   + " values(SEQ_CART.nextval, ?, to_number(?) ,to_number(?)) ";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, userid);
				pstmt.setString(2, arr_fk_it_seq_no[i]);
				pstmt.setString(3, arr_order_qty[i]);
				
				pstmt.executeUpdate();
				cnt++;
			}
			
			if(cnt == arr_fk_it_seq_no.length) {
				isSuccess = 1;
			}
			
			
			
		} finally {
			close();
		}
		
		return isSuccess;
		
	}

	// 쇼핑백 페이지에 보여지는 상품 정보 및 가격을 조회(select)하는 메소드
		@Override
		public List<CartVO> shopBagInfo(String userid) throws SQLException {
			List<CartVO> shopBagList = new ArrayList<>();
			
			
			
			try {
				conn = ds.getConnection();
				
				String sql = " select fk_userid, ct_seq_no, fk_it_seq_no, order_qty, it_name, it_price, it_volume, img_file, ca_name, is_main_img "
						   + " from "
						   + " ( "
						   + "    select C.fk_userid, C.ct_seq_no, C.fk_it_seq_no, c.order_qty, it_name, it_price, it_volume, G.img_file, a.ca_name, G.is_main_img "
						   + "    from tbl_cart C join tbl_item I "
						   + "    on C.fk_it_seq_no = I.it_seq_no "
						   + "    join tbl_category a "
						   + "    on i.FK_CA_ID = a.CA_ID "
						   + "    join tbl_img G "
						   + "    on I.it_seq_no = G.fk_it_seq_no "
						   + " )V "
						   + " where is_main_img = 1 and fk_userid = ? ";				
				
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, userid);
				
				
				rs = pstmt.executeQuery();
				
				
				while(rs.next()) {
				// fk_userid, ct_seq_no, fk_it_seq_no, order_qty, it_name, it_price, it_volume, img_file, ca_name, is_main_img "
				
					CartVO cartvo = new CartVO();
					cartvo.setCt_seq_no(rs.getInt("ct_seq_no"));
					cartvo.setFk_userid(rs.getString("fk_userid"));
					cartvo.setFk_it_seq_no(rs.getInt("fk_it_seq_no"));
					cartvo.setOrder_qty(rs.getInt("order_qty"));
					
					ItemVO itemvo = new ItemVO();
					itemvo.setIt_name(rs.getString("it_name"));
					itemvo.setIt_price(rs.getInt("it_price"));
					itemvo.setIt_volume(rs.getString("it_volume"));
					cartvo.setIvo(itemvo);
					
					ImageVO imgvo = new ImageVO();				
					imgvo.setImg_file(rs.getString("img_file"));
					imgvo.setIs_main_img(rs.getInt("is_main_img"));
					cartvo.setImgvo(imgvo);
					
					CategoryVO categvo = new CategoryVO();
					categvo.setCa_name(rs.getString("ca_name"));
					cartvo.setCategvo(categvo);
					
					shopBagList.add(cartvo);
					
				};
				
				
				
			} finally {
				close();
			}
			
			return shopBagList;
		}

		
		
		
		// 삭제버튼 클릭 시 tbl_cart의 userid의 장바구니에 담겨있는 제품 정보를 삭제 하기
		@Override
		public int deleteCartInfo(String userid) throws SQLException {
			int n = 0;
			
			
			try {
				conn = ds.getConnection();
				
				String sql = " delete from tbl_cart "
						   + " where fk_userid = ? ";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, userid );
			
				n = pstmt.executeUpdate();
				
				
			} finally {
				close();
			}
			
			return n;
		}

		
		
		// 쇼핑백 페이지의 결제하기 클릭 시 현재 세션스토리지에 담겨있는 정보들을 DB에 추가하는(insert)하는 메소드 
		@Override
		public int insertBagItem(Map<String, String[]> paraMap, String userid) throws SQLException {

			int cnt = 0;
			int isSuccess = 0;
			
			try {
				conn = ds.getConnection();
				
				String[] arr_fk_it_seq_no = paraMap.get("arr_fk_it_seq_no");
				String[] arr_order_qty = paraMap.get("arr_order_qty");
				
			/*
				String[] arr_it_name = paraMap.get("arr_it_name");
				String[] arr_it_price = paraMap.get("arr_it_price");
				String[] arr_img_file = paraMap.get("arr_img_file");
			*/
				
				
				for(int i = 0; i<arr_fk_it_seq_no.length; i++) {
					
					String sql = " insert into tbl_cart(ct_seq_no, fk_userid, fk_it_seq_no, order_qty) "
							   + " values(SEQ_CART.nextval, ?, to_number(?) ,to_number(?)) ";
					
					pstmt = conn.prepareStatement(sql);
					
					pstmt.setString(1, userid);
					pstmt.setString(2, arr_fk_it_seq_no[i]);
					pstmt.setString(3, arr_order_qty[i]);
					
					pstmt.executeUpdate();
					cnt++;
				}
				
				if(cnt == arr_fk_it_seq_no.length) {
					isSuccess = 1;
				}
				
				
				
			} finally {
				close();
			}
			
			return isSuccess;	
			
			
			
		}

		
		
		// 주문 결제창에 보여지는 주문정보를 조회(select)하는 메소드
		@Override
		public List<CartVO> orderListInfo(String userid) throws SQLException {

			List<CartVO> orderList = new ArrayList<>();
			
			try {
				conn = ds.getConnection();
				
				String sql = " select fk_userid, fk_it_seq_no, order_qty, it_name, it_price, it_volume, img_file, ca_name, is_main_img, name, mobile, email "
						   + " from "
						   + " ( "
						   + " select C.fk_userid, C.fk_it_seq_no, c.order_qty, it_name, it_price, it_volume, G.img_file, a.ca_name, G.is_main_img, U.name, U.mobile, U.email "
						   + " from tbl_cart C join tbl_item I "
						   + " on C.fk_it_seq_no = I.it_seq_no "
						   + " join tbl_category a "
						   + " on i.FK_CA_ID = a.CA_ID "
						   + " join tbl_img G "
						   + " on I.it_seq_no = G.fk_it_seq_no "
						   + " join tbl_user U "
						   + " on C.fk_userid = U.userid "
						   + " )V "
						   + " where is_main_img = 1 and fk_userid = ? ";				
				
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, userid);
				
				
				rs = pstmt.executeQuery();
				
				
				while(rs.next()) {
				// fk_userid, ct_seq_no, fk_it_seq_no, order_qty, it_name, it_price, it_volume, img_file, ca_name, is_main_img "
				
					CartVO cartvo = new CartVO();
					cartvo.setFk_userid(rs.getString("fk_userid"));
					cartvo.setFk_it_seq_no(rs.getInt("fk_it_seq_no"));
					cartvo.setOrder_qty(rs.getInt("order_qty"));
					
					ItemVO itemvo = new ItemVO();
					itemvo.setIt_name(rs.getString("it_name"));
					itemvo.setIt_price(rs.getInt("it_price"));
					itemvo.setIt_volume(rs.getString("it_volume"));
					cartvo.setIvo(itemvo);
					
					ImageVO imgvo = new ImageVO();				
					imgvo.setImg_file(rs.getString("img_file"));
					imgvo.setIs_main_img(rs.getInt("is_main_img"));
					cartvo.setImgvo(imgvo);
					
					CategoryVO categvo = new CategoryVO();
					categvo.setCa_name(rs.getString("ca_name"));
					cartvo.setCategvo(categvo);
					
					UserVO uservo = new UserVO();
					uservo.setName(rs.getString("name"));
					uservo.setMobile(aes.decrypt(rs.getString("mobile")));
					uservo.setEmail(aes.decrypt(rs.getString("email")));
					cartvo.setUservo(uservo);
					orderList.add(cartvo);
					
				};
				
				
				
			} catch (GeneralSecurityException | UnsupportedEncodingException e) {
				e.printStackTrace();
			} finally {
				close();
			}
			
			return orderList;
			
			
		}

		
	
	
	
	
	
	
	/*
	
	// 장바구니 테이블에 제품 정보를 추가(insert) 하고 tbl_cart의 정보를 조회(select) 해주는 메소드
	@Override
	public CartVO selectInsertCart(String it_seq_no) throws SQLException{
		
		CartVO cartvo = new CartVO();
		
		
		try {
			conn = ds.getConnection();
			
			String sql = " select ct_seq_no, fk_it_seq_no, it_name, it_price, img_file, order_qty "
					   + " from "
					   + " ( "
				       + " select C.ct_seq_no, C.fk_it_seq_no, it_name, it_price, G.img_file, c.order_qty, ca_name, G.is_main_img "
					   + " from tbl_cart C join tbl_item I "
					   + " on C.fk_it_seq_no = I.it_seq_no "
					   + " join tbl_category a "
					   + " on i.FK_CA_ID = a.CA_ID "
					   + " join tbl_img G "
					   + " on I.it_seq_no = G.fk_it_seq_no "
					   + " )V "
					   + " where is_main_img = 1 and fk_it_seq_no = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, it_seq_no);
			
			
			rs = pstmt.executeQuery();
			
			
			
			if(rs.next()) {
			
				
				
				
				if (rs.getInt("ct_seq_no") != Integer.parseInt(it_seq_no)) {
					
					cartvo = new CartVO();
					cartvo.setCt_seq_no(rs.getInt("ct_seq_no"));
					cartvo.setFk_it_seq_no(rs.getInt("fk_it_seq_no"));
					cartvo.setOrder_qty(rs.getInt("order_qty"));
					
					ItemVO ivo = new ItemVO();
					ivo.setIt_price(rs.getInt("it_price"));
					ivo.setIt_name(rs.getString("it_name"));
					cartvo.setIvo(ivo);
					
					ImageVO imgvo = new ImageVO();
					imgvo.setImg_file(rs.getString("img_file"));
					cartvo.setImgvo(imgvo);
					
				}
				
				else {
					
					
					
					
				}
				
				
				
				
			};
			
		} finally {
			close();
		}
		return cartvo;
	}
	
	

	
	
	// 장바구니의 select 의 옵션을 변경 할 때마다 tbl_cart의 제품 수량 update 해주기
	@Override
	public int updateCartInfo(Map<String, String> paraMap) throws SQLException {
			int n = 0;
			
			
			
			try {
				conn = ds.getConnection();
				
				String sql = " update tbl_cart set order_qty = ? "
						   + " where fk_it_seq_no = ? ";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, paraMap.get("quantity"));
				pstmt.setString(2, paraMap.get("itemno")); 
			
				n = pstmt.executeUpdate();
				
			} finally {
				close();
			}
			
			return n;
		}// end of public int updateCartInfo(Map<String, String> paraMap) throws SQLException ---------------

	
	
	/*
	// update 된 장바구니의 정보를 조회(select)해주는 메소드
	@Override
	public CartVO selectUpdateCart(String it_seq_no) throws SQLException {
		
		CartVO cartvo = new CartVO();
		
		
		try {
			conn = ds.getConnection();
			
			String sql = " select order_qty "
					   + " from tbl_cart "
					   + " where fk_it_seq_no = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, it_seq_no);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
			
				cartvo = new CartVO();
				
				cartvo.setOrder_qty(rs.getInt("order_qty"));
				
			};
			
		} finally {
			close();
		}
		
		return cartvo;
	}

	
	
	
	// 삭제버튼 클릭 시 tbl_cart의 제품 정보를 삭제 하기
	@Override
	public int deleteCartInfo(String itemno) throws SQLException {

		int n = 0;
		
		
		try {
			conn = ds.getConnection();
			
			String sql = " delete from tbl_cart "
					   + " where fk_it_seq_no = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, itemno );
		
			n = pstmt.executeUpdate();
			
			
		} finally {
			close();
		}
		
		return n;
	}

	
	// delete 된 장바구니의 정보를 조회(select)해주는 메소드
	@Override
	public CartVO selectDeleteCart(String item_number) throws SQLException {
		
		CartVO cartvo = new CartVO();
		
		int item_no = Integer.parseInt(item_number);
		
		try {
			conn = ds.getConnection();
			
			String sql = " select ct_seq_no, fk_it_seq_no, order_qty "
					   + " from tbl_cart "
					   + " where fk_it_seq_no = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, item_no);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
			
				cartvo = new CartVO();
				
				cartvo.setOrder_qty(rs.getInt("order_qty"));
				cartvo.setCt_seq_no(rs.getInt("ct_seq_no"));
				cartvo.setFk_it_seq_no(rs.getInt("fk_it_seq_no"));
				
			};
			
		} finally {
			close();
		}
		
		return cartvo;
	}

	*/
	
	
	

	
	
	
	

	
	
	
	
	
	
}

