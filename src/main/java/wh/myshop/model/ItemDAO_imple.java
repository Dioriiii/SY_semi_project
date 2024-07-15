package wh.myshop.model;

import java.sql.*;
import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import wh.myshop.domain.*;

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
	
	
	
	// 상세페이지에 보여지는 상품정보를 모두 조회(select)하는 메소드 
	@Override
	public List<ItemVO> itemInfoAll(Map<String, String> paraMap) throws SQLException {

		List<ItemVO> infoList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select ca_name, it_name, it_price, it_theme, it_describe, it_describe_simple, it_ingredient, ca_how_to_use, ca_caution, ca_expired, G.img_file "
					   + " from tbl_category c join tbl_item i "
					   + " on c.CA_ID = i.FK_CA_ID "
					   + " join tbl_img G "
					   + " on i.it_seq_no = G.fk_it_seq_no "
					   + " where it_seq_no = ? and is_main_img = 0 ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("it_seq_no"));
			
			
			rs = pstmt.executeQuery();
			
			
			
			while(rs.next()) {
			// ca_name, it_name, it_price, it_ingredient, it_describe, G.img_file	
			
				ItemVO itemvo = new ItemVO();
				
				itemvo.setIt_name(rs.getString("it_name"));
				itemvo.setIt_price(rs.getInt("it_price"));
				itemvo.setIt_theme(rs.getString("it_theme"));
				itemvo.setIt_ingredient(rs.getString("it_ingredient"));
				itemvo.setIt_describe(rs.getString("it_describe"));
				itemvo.setIt_describe_simple(rs.getString("it_describe_simple"));
				
				CategoryVO categvo = new CategoryVO();	
				categvo.setCa_name(rs.getString("ca_name"));
				categvo.setCa_how_to_use(rs.getString("ca_how_to_use"));
				categvo.setCa_caution(rs.getString("ca_caution"));
				categvo.setCa_expired(rs.getString("ca_expired"));
				itemvo.setCategvo(categvo);
				
				ImageVO imgvo = new ImageVO();				
				imgvo.setImg_file(rs.getString("img_file"));
				itemvo.setImgvo(imgvo);
				
				infoList.add(itemvo);
				
			};
			
			
			
		} finally {
			close();
		}
		
		return infoList;
	}// end of public List<ImageVO> imageSelectAll() throws SQLException ------------

	
	
	
	
	
	
	/*
	
	// 장바구니 테이블에 제품 정보(제품번호, 수량)를 추가(insert)하는 메소드
	@Override
	public int insertCartItem(Map<String, String> paraMap) throws SQLException {
		
		int n = 0;
		int it_seq_no = Integer.parseInt(paraMap.get("it_seq_no"));
		int order_qty = Integer.parseInt(paraMap.get("order_qty"));
		
		
		try {
			conn = ds.getConnection();
			
			String sql = " insert into tbl_cart(ct_seq_no, fk_it_seq_no, order_qty) "
						+" values(SEQ_CART.nextval, ?, ?) ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, it_seq_no );
			pstmt.setInt(2, order_qty ); 
		
			n = pstmt.executeUpdate();
			
			
		} finally {
			close();
		}
		
		return n;
		
	}

	

	
	
	// 장바구니의 select 의 옵션을 변경 할 때마다 tbl_cart의 제품 수량 update 해주기
	@Override
	public int updateCartItemInfo(Map<String, String> paraMap) throws SQLException {
			int n = 0;
			
			int order_qty = Integer.parseInt(paraMap.get("order_qty"));
			int it_seq_no = Integer.parseInt(paraMap.get("it_seq_no"));
			
			
			try {
				conn = ds.getConnection();
				
				String sql = " update tbl_cart set order_qty = ? "
						   + " where fk_it_seq_no = ? ";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setInt(1, order_qty);
				pstmt.setInt(2, it_seq_no); 
			
				n = pstmt.executeUpdate();
				
			} finally {
				close();
			}
			
			return n;
		}

	
	
	
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
	public int deleteCartItem(String item_number) throws SQLException {

		int n = 0;
		
		
		try {
			conn = ds.getConnection();
			
			String sql = " delete from tbl_cart "
					   + " where fk_it_seq_no = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, item_number );
		
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

	
	// 쇼핑백 페이지에 보여지는 상품 정보 및 가격을 조회(select)하는 메소드
	@Override
	public List<ItemVO> shopBagInfoAll(Map<String, String> paraMap) throws SQLException {
		List<ItemVO> shopBagInfoList = new ArrayList<>();
		
		
		int sb_itSeqNO = Integer.parseInt(paraMap.get("cart_it_seq_no"));
		int sb_itQty = Integer.parseInt(paraMap.get("cart_it_qty"));
		
		try {
			conn = ds.getConnection();
			
			String sql = " select rno, fk_it_seq_no, it_name, it_price, img_file, order_qty, ca_name "
					   + " from "
					   + " ( "
					   + " select row_number() over(partition by it_seq_no "
					   + " order by it_seq_no asc ) as rno, G.fk_it_seq_no, it_name, it_price, G.img_file, c.order_qty, ca_name "
					   + " from tbl_cart C join tbl_item I "
					   + " on C.fk_it_seq_no = I.it_seq_no "
					   + " join tbl_category a "
					   + " on i.FK_CA_ID = a.CA_ID "
					   + " join tbl_img G "
					   + " on I.it_seq_no = G.fk_it_seq_no "
					   + " ) V "
					   + " where rno = 5 and fk_it_seq_no = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, sb_itSeqNO);
			
			
			rs = pstmt.executeQuery();
			
			
			
			while(rs.next()) {
			// ca_name, it_name, it_price, it_ingredient, it_describe, G.img_file	
			
				ItemVO itemvo = new ItemVO();
				
				itemvo.setIt_name(rs.getString("it_name"));
				itemvo.setIt_price(rs.getInt("it_price"));
				itemvo.setIt_describe_simple(rs.getString("it_describe_simple"));
				
				CategoryVO categvo = new CategoryVO();	
				categvo.setCa_name(rs.getString("ca_name"));
				categvo.setCa_how_to_use(rs.getString("ca_how_to_use"));
				categvo.setCa_caution(rs.getString("ca_caution"));
				categvo.setCa_expired(rs.getString("ca_expired"));
				itemvo.setCategvo(categvo);
				
				ImageVO imgvo = new ImageVO();				
				imgvo.setImg_file(rs.getString("img_file"));
				itemvo.setImgvo(imgvo);
				
				shopBagInfoList.add(itemvo);
				
			};
			
			
			
		} finally {
			close();
		}
		
		return shopBagInfoList;
	}

	
	*/
	
	
	
	
}
