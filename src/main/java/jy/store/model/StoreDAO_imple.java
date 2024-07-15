package jy.store.model;

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

import jy.store.domain.CountryVO;
import jy.store.domain.ImageVO;
import jy.store.domain.StoreVO;

public class StoreDAO_imple implements StoreDAO {

	private DataSource ds; // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	// 생성자
	public StoreDAO_imple() {

		try {
			Context initContext = new InitialContext();
			Context envContext = (Context) initContext.lookup("java:/comp/env");
			ds = (DataSource) envContext.lookup("jdbc/semi_oracle");

		} catch (NamingException e) {
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
	
	
	
	// 플래그십스토어(flg) 카테고리 store List 조회하기
	@Override
	public List<StoreVO> selectFlgList(String country) throws SQLException {
		
		List<StoreVO> flgList = new ArrayList<>();
		
		try {
		
			conn = ds.getConnection();
		
			String sql = " select store_name, store_address, store_contact, store_hours, store_ca, store_no, lat, lng "
					   + " from tbl_store "
					   + " where fk_cty_code = ? and store_ca = 'flg' "; 
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, country);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				StoreVO svo = new StoreVO();
				svo.setStore_name(rs.getString(1));
				svo.setStore_address(rs.getString(2));
				svo.setStore_contact(rs.getString(3));
				svo.setStore_hours(rs.getString(4));
				svo.setStore_ca(rs.getString(5));
				svo.setStore_no(rs.getInt(6));
				svo.setLat(rs.getDouble(7));
				svo.setLng(rs.getDouble(8));
				
				flgList.add(svo);
			}
			
		} finally {
			close();
		}
		
		return flgList;
	}
	
	// 백화점/면세점(dpt) 카테고리 store List 조회하기
	@Override
	public List<StoreVO> selectDptList(String country) throws SQLException {
		
		List<StoreVO> dptList = new ArrayList<>();
		
		try {
		
			conn = ds.getConnection();
		
			String sql = " select store_name, store_address, store_contact, store_hours, store_ca, store_no "
					   + " from tbl_store "
					   + " where fk_cty_code = ? and store_ca = 'dpt' "; 
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, country);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				StoreVO svo = new StoreVO();
				svo.setStore_name(rs.getString(1));
				svo.setStore_address(rs.getString(2));
				svo.setStore_contact(rs.getString(3));
				svo.setStore_hours(rs.getString(4));
				svo.setStore_ca(rs.getString(5));
				svo.setStore_no(rs.getInt(6));
				
				dptList.add(svo);
			}
			
		} finally {
			close();
		}
		
		return dptList;
	}

	// 스톡키스트(stk) 카테고리 store List 조회하기
	@Override
	public List<StoreVO> selectStkList(String country) throws SQLException {
		
		List<StoreVO> stkList = new ArrayList<>();
		
		try {
		
			conn = ds.getConnection();
		
			String sql = " select store_name, store_address, store_contact, store_hours, store_ca, store_no "
					   + " from tbl_store "
					   + " where fk_cty_code = ? and store_ca = 'stk' "; 
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, country);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				StoreVO svo = new StoreVO();
				svo.setStore_name(rs.getString(1));
				svo.setStore_address(rs.getString(2));
				svo.setStore_contact(rs.getString(3));
				svo.setStore_hours(rs.getString(4));
				svo.setStore_ca(rs.getString(5));
				svo.setStore_no(rs.getInt(6));
				
				stkList.add(svo);
			}
			
		} finally {
			close();
		}
		
		return stkList;
	}

	// 전체 image List 조회하기
	@Override
	public List<ImageVO> getAllImgList() throws SQLException {
		
		List<ImageVO> imgList = new ArrayList<>();
		
		try {
		
			conn = ds.getConnection();
		
			String sql = " select S.store_no, I.store_img_file, I.is_main_img, I.file_type "
					   + " from "
					   + " ( "
					   + "    select store_no, fk_cty_code, store_name, store_address, store_contact, store_hours, store_ca "
					   + "    from tbl_store "
					   + " ) S "
				       + " join tbl_store_img I "
					   + " on S.store_no = I.fk_store_no "; 
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ImageVO ivo= new ImageVO();
				ivo.setFk_store_no(rs.getInt(1));
				ivo.setStore_img_file(rs.getString(2));
				ivo.setIs_main_img(rs.getInt(3));
				ivo.setFile_type(rs.getString(4));
				
				imgList.add(ivo);
			}
			
		} finally {
			close();
		}
		
		return imgList;
	}// end of public List<ImageVO> getAllImgList() throws SQLException {}-------

	// 전체 store_country List 조회하기
	@Override
	public List<CountryVO> getAllCtyList() throws SQLException {
		
		List<CountryVO> cntryList = new ArrayList<>();
		
		try {
		
			conn = ds.getConnection();
		
			String sql = " select cty_code, cty_name, cty_img "
					   + " from tbl_store_country ";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				CountryVO cvo = new CountryVO();
				cvo.setCty_code(rs.getString(1));
				cvo.setCty_name(rs.getString(2));
				cvo.setCty_img(rs.getString(3));
				
				cntryList.add(cvo);
			}
			
		} finally {
			close();
		}
		
		return cntryList;
	}// end  of public List<CountryVO> getAllCtyList() throws SQLException {}---------

	@Override
	public int countFlgStore(String country) throws SQLException {

		int storeCnt = 0;
		
		try {
		
			conn = ds.getConnection();
		
			String sql = "   select count(*) as cnt "
					   + "   from tbl_store "
					   + "   where fk_cty_code = ? and store_ca='flg'";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, country);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				storeCnt = rs.getInt(1);
			}
			
		} finally {
			close();
		}
		
		return storeCnt;
	}

	// 매장 지도에 넣어줄 정보 select
	@SuppressWarnings("null")
	@Override
	public StoreVO seletStoreInfo(String storeno) throws SQLException {
		
		StoreVO svo = null;
		
		try {
			
			conn = ds.getConnection();
		
			String sql = " select store_name, store_address,lat ,lng "
					   + " from tbl_store "
					   + " where store_no= ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, storeno);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				svo.setStore_name(rs.getString(1));
				svo.setStore_address(rs.getString(2));
				svo.setLat(rs.getDouble(3));
				svo.setLng(rs.getDouble(4));
			}
									
		} finally {
			close();
		}
		
		return svo;
	}
	
}
