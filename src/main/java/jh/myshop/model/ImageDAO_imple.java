package jh.myshop.model;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import jh.myshop.domain.CategoryVO;
import jh.myshop.domain.ImageVO;
import jh.myshop.domain.ItemVO;

public class ImageDAO_imple implements ImageDAO {

	private DataSource ds; // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool)이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	// 생성자
	public ImageDAO_imple() {
			
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
	
	// DB에서 이미지를 꺼내오는 메소드(test)
	@Override
	public ImageVO getImage() throws SQLException {
		
		ImageVO ivo = null;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " select img_seq_no, fk_it_seq_no, img_file "
					   + " from tbl_img "
					   + " where img_seq_no = 1 ";

			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				ivo = new ImageVO(); 
				
				ivo.setImg_seq_no(rs.getInt(1));
				ivo.setFk_it_seq_no(rs.getInt(2));
				ivo.setImg_file(rs.getString(3));
				
			} // end of if(rs.next())-----------------------------------------------
			
		} finally {
			close();
		}
		
		return ivo;
	} // end of public ImageVO getImage()
	
	
	
	// DB에서 카테고리의 상품이미지를 한개씩 꺼내오는 메소드
	@Override
	public List<ImageVO> imageSelectOne() throws SQLException {
		
		List<ImageVO> imgList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " SELECT ca_id, ca_name, it_seq_no, it_name, it_theme, it_price, it_volume, img_seq_no, img_file "
					   + " FROM "
					   + " ( "
					   + " SELECT rank() OVER(partition by ca_id ORDER BY ca_id, it_create_date) AS rank, "
					   + "        ca_id, ca_name, it_seq_no, it_name, it_theme, it_price, it_volume, img_seq_no, img_file "
					   + " FROM "
					   + " ( "
					   + " select * "
					   + " from tbl_img A "
					   + " join tbl_item B "
					   + " on A.fk_it_seq_no = B.it_seq_no "
					   + " where is_main_img = 1 "
					   + " ) V "
					   + " JOIN tbl_category X "
					   + " ON V.fk_ca_id = X.ca_id "
					   + " ORDER BY ca_name desc, it_create_date "
					   + " ) "
					   + " WHERE rank <= 4 ";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				ImageVO imgvo = new ImageVO();
				CategoryVO cavo = new CategoryVO();
				ItemVO itvo = new ItemVO();
				
				cavo.setCa_id(rs.getString(1));
				cavo.setCa_name(rs.getString(2));
				imgvo.setCavo(cavo);
				
				itvo.setIt_seq_no(rs.getInt(3));
				itvo.setIt_name(rs.getString(4));
				itvo.setIt_ingredient(rs.getString(5));
				itvo.setIt_price(rs.getInt(6));
				itvo.setIt_volume(rs.getString(7));
				imgvo.setItvo(itvo);
				
				imgvo.setImg_seq_no(rs.getInt(8));
				imgvo.setImg_file(rs.getString(9));
				imgList.add(imgvo);
				
			}// end of while(rs.next())
			
		} finally {
			close();
		}
		
		return imgList;
	}

	
	// DB에서 특정 카테고리의 상품이미지를 한개씩 꺼내오는 메소드
	@Override
	public List<ImageVO> imageSelectOne(String ca_id) throws SQLException {

		List<ImageVO> imgList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " SELECT ca_id, ca_name, it_seq_no, it_name, it_theme, it_price, it_volume, img_seq_no, img_file "
					   + " FROM "
					   + " ( "
					   + " SELECT rank() OVER(partition by ca_id ORDER BY ca_id, it_create_date) AS rank, "
					   + "        ca_id, ca_name, it_seq_no, it_name, it_theme, it_price, it_volume, img_seq_no, img_file "
					   + " FROM "
					   + " ( "
					   + " select * "
					   + " from tbl_img A "
					   + " join tbl_item B "
					   + " on A.fk_it_seq_no = B.it_seq_no "
					   + " where is_main_img = 1 "
					   + " ) V "
					   + " JOIN tbl_category X "
					   + " ON V.fk_ca_id = X.ca_id "
					   + " WHERE ca_id = ? "
					   + " ORDER BY ca_name desc, it_create_date "
					   + " ) ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, ca_id);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				ImageVO imgvo = new ImageVO();
				CategoryVO cavo = new CategoryVO();
				ItemVO itvo = new ItemVO();
				
				cavo.setCa_id(rs.getString(1));
				cavo.setCa_name(rs.getString(2));
				imgvo.setCavo(cavo);
				
				itvo.setIt_seq_no(rs.getInt(3));
				itvo.setIt_name(rs.getString(4));
				itvo.setIt_ingredient(rs.getString(5));
				itvo.setIt_price(rs.getInt(6));
				itvo.setIt_volume(rs.getString(7));
				imgvo.setItvo(itvo);
				
				imgvo.setImg_seq_no(rs.getInt(8));
				imgvo.setImg_file(rs.getString(9));
				imgList.add(imgvo);
				
			}// end of while(rs.next())
			
		} finally {
			close();
		}
		
		return imgList;
	}
	
	
	
}
