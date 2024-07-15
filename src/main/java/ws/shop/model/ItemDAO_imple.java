package ws.shop.model;

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

import ws.shop.domain.*;

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


	   
	// tbl_category 테이블에서 카테고리 아이디, 카테고리 이름, 사용방법, 주의사항, 사용기한을 조회해오기
	@Override
	public List<CategoryVO> searchCategoryList() throws SQLException {
		
		List<CategoryVO> categoryList = new ArrayList<>();

		try {
			conn = ds.getConnection();

			String sql = " select ca_id, ca_name, ca_how_to_use, ca_caution, ca_expired "
				       + " from tbl_category ";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				CategoryVO cvo = new CategoryVO();
				cvo.setCa_id(rs.getString(1));
				cvo.setCa_name(rs.getString(2));
				cvo.setCa_how_to_use(rs.getString(3));
				cvo.setCa_caution(rs.getString(4));
				cvo.setCa_expired(rs.getString(5));
				
				categoryList.add(cvo);
			} // end of while(rs.next())------------
			 
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return categoryList;
	}


	
	// 상품번호 채번하기
	@Override
	public int getSeqNoOfProduct() throws SQLException {
		
		int it_seq_no = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select seq_item.nextval AS it_seq_no "
					   + " from dual ";
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			rs.next();
			it_seq_no = rs.getInt(1);

		} finally {
			close();
		}
		
		return it_seq_no;
	}


	
	// tbl_item 테이블에 제품정보 insert 하기
	@Override
	public int itemInsert(ItemVO ivo) throws SQLException {
		
		int result = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " insert into tbl_item(it_seq_no, fk_ca_id, it_name, it_price, it_theme, it_ingredient, it_describe_simple, it_describe, it_create_date, it_update_date, it_stock, it_volume, it_status) "
					   + " values(?,?,?,?,?,?,?,?,sysdate,sysdate,?,?,1) ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, ivo.getIt_seq_no());
			pstmt.setString(2, ivo.getFk_ca_id());
			pstmt.setString(3, ivo.getIt_name());
			pstmt.setInt(4, ivo.getIt_price());
			pstmt.setString(5, ivo.getIt_theme());
			pstmt.setString(6, ivo.getIt_ingredient());
			pstmt.setString(7, ivo.getIt_describe_simple());
			pstmt.setString(8, ivo.getIt_describe());
			pstmt.setInt(9, ivo.getIt_stock());
			pstmt.setString(10, ivo.getIt_volume());
			
			result = pstmt.executeUpdate();
			
		} finally {
			close();
		}
		
		return result;
	}

	
	
	// tbl_img 테이블에 제품의 이미지 파일명 insert 해버리기 //
	@Override
	public int img_insert(Map<String, String> paraMap) throws SQLException {
		
		int result = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " insert into tbl_img(img_seq_no, fk_it_seq_no, img_file, is_main_img) "
					   + " values(SEQ_IMG.nextval,?,?,?) ";
			
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, Integer.parseInt(paraMap.get("it_seq_no")));
			pstmt.setString(2, paraMap.get("attachCountFileName"));
			
			if(paraMap.containsKey("main_img")) {
				pstmt.setInt(3, Integer.parseInt("1"));
				System.out.println("메인이미지");
			}
			else {
				pstmt.setInt(3, Integer.parseInt("0"));
				System.out.println("서브이미지");
			}
			 	
			result = pstmt.executeUpdate();
			
		} finally {
			close();
		}
		
		return result;
	}


	
	/*
	// 제품관리에 사용되는 제품리스트를 가져오는 메소드
	@Override
	public List<DetailVO> itemByCategoryList(String ca_id) throws SQLException {
		
		List<DetailVO> d_item_List = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select it_seq_no, ca_name, it_name, it_price,it_theme,it_stock,it_volume,it_status,img_file,to_char(it_create_date,'yyyy-mm-dd') as it_create_date "
					   + " from tbl_item I "
					   + " join tbl_category C "
					   + " on I.fk_ca_id = C.ca_id "
					   + " join ( select * "
					   + "       from tbl_img "
					   + "       where is_main_img = 1) M "
					   + " on I.it_seq_no = M.fk_it_seq_no "
					   + " where ca_id = ? "
					   + " order by it_seq_no ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, ca_id);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				  
				ItemVO ivo = new ItemVO();
				ivo.setIt_seq_no(rs.getInt("IT_SEQ_NO"));
				ivo.setIt_name(rs.getString("IT_NAME"));
				ivo.setIt_theme(rs.getString("IT_THEME"));
				ivo.setIt_price(rs.getInt("IT_PRICE"));
				ivo.setIt_create_date(rs.getString("IT_CREATE_DATE"));
				ivo.setIt_stock(rs.getInt("IT_STOCK"));
				ivo.setIt_volume(rs.getString("IT_VOLUME"));
				ivo.setIt_status(rs.getInt("IT_STATUS"));
				
				ImageVO imvo = new ImageVO();
				imvo.setImg_file(rs.getString("IMG_FILE"));
				
				CategoryVO cvo = new CategoryVO();
				cvo.setCa_name(rs.getString("CA_NAME"));
				
				DetailVO dvo = new DetailVO();
				
				ivo.setImvo(imvo);
				ivo.setCvo(cvo);
				dvo.setIvo(ivo);
				
				d_item_List.add(dvo);
			}
			
		} finally {
			close();
		}
		
		return d_item_List;
	} */

	
	
	// 제품관리에 사용되는 제품리스트를 가져오는 메소드
	@Override
	public List<DetailVO> itemSelectList(String ca_id) throws SQLException {
		
		List<DetailVO> itemList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			
			if(ca_id.equals("")) {
				String sql = " select it_seq_no, ca_name, it_name, it_price,it_theme,it_stock,it_volume,it_status,img_file,to_char(it_create_date,'yyyy-mm-dd') as it_create_date "
					   + " from tbl_item I "
					   + " join tbl_category C "
					   + " on I.fk_ca_id = C.ca_id "
					   + " join ( select * "
					   + "       from tbl_img "
					   + "       where is_main_img = 1) M "
					   + " on I.it_seq_no = M.fk_it_seq_no "
					   + " order by it_seq_no ";
				pstmt = conn.prepareStatement(sql);
			}
			
			else {
				String sql = " select it_seq_no, ca_name, it_name, it_price,it_theme,it_stock,it_volume,it_status,img_file,to_char(it_create_date,'yyyy-mm-dd') as it_create_date "
						   + " from tbl_item I "
						   + " join tbl_category C "
						   + " on I.fk_ca_id = C.ca_id "
						   + " join ( select * "
						   + "       from tbl_img "
						   + "       where is_main_img = 1) M "
						   + " on I.it_seq_no = M.fk_it_seq_no "
						   + " where ca_id = ? "
						   + " order by it_seq_no ";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, ca_id);
			}
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				  
				ItemVO ivo = new ItemVO();
				ivo.setIt_seq_no(rs.getInt("IT_SEQ_NO"));
				ivo.setIt_name(rs.getString("IT_NAME"));
				ivo.setIt_theme(rs.getString("IT_THEME"));
				ivo.setIt_price(rs.getInt("IT_PRICE"));
				ivo.setIt_create_date(rs.getString("IT_CREATE_DATE"));
				ivo.setIt_stock(rs.getInt("IT_STOCK"));
				ivo.setIt_volume(rs.getString("IT_VOLUME"));
				ivo.setIt_status(rs.getInt("IT_STATUS"));
				
				ImageVO imvo = new ImageVO();
				imvo.setImg_file(rs.getString("IMG_FILE"));
				
				CategoryVO cvo = new CategoryVO();
				cvo.setCa_name(rs.getString("CA_NAME"));
				
				DetailVO dvo = new DetailVO();
				
				ivo.setImvo(imvo);
				ivo.setCvo(cvo);
				dvo.setIvo(ivo);
				
				itemList.add(dvo);
			}
			
		} finally {
			close();
		}
		
		return itemList;
	}



	
	
	

	   
	   
	   
	   
}
