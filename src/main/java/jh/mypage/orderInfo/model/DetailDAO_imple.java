package jh.mypage.orderInfo.model;

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

import jh.mypage.orderInfo.domain.*;
import jh.myshop.domain.*;

public class DetailDAO_imple implements DetailDAO {

	private DataSource ds; // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool)이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	// 생성자
	public DetailDAO_imple() {
			
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

	// 관리자가 모든 주문을 조회하는 메소드
	@Override
	public List<jh.mypage.orderInfo.domain.DetailVO> selectAllOrderList() throws SQLException {

		List<DetailVO> orderAllList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " SELECT I.order_seq_no, I.o_detail_seq_no, to_char(I.order_date, 'yyyy-mm-dd hh24:mi:ss') AS order_date, M.img_file, I.fk_it_seq_no, M.it_name, I.o_qty, I.o_price, I.o_status, nvl(to_char(I.deliverd_date, 'yyyy.mm.dd hh24:mi:ss'), '-') AS deliverd_date "
					   + "     , I.fk_userid, I.sh_name, I.sh_mobile, I.sh_postcode, I.sh_address, I.sh_detailaddress, I.sh_extraaddress, I.sh_msg "
					   + " FROM "
					   + " ( "
					   + " select * "
					   + " from tbl_order O "
					   + " join tbl_detail D "
					   + " on O.order_seq_no = D.fk_order_seq_no "
					   + " ) I "
					   + " JOIN "
					   + " ( "
					   + " select is_main_img, fk_it_seq_no, img_file, it_name "
					   + " from tbl_img C "
					   + " join tbl_item S "
					   + " on C.fk_it_seq_no = S.it_seq_no "
					   + " where is_main_img = 1 "
					   + " ) M "
					   + " ON I.fk_it_seq_no = M.fk_it_seq_no "
					   + " order by order_date desc, order_seq_no ";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				DetailVO dtvo = new DetailVO();
				OrderVO ovo = new OrderVO();
				ImageVO imgvo = new ImageVO();
				ItemVO itvo = new ItemVO();
				
				ovo.setOrder_seq_no(rs.getString("ORDER_SEQ_NO"));
				dtvo.setO_detail_seq_no(rs.getString("O_DETAIL_SEQ_NO"));
				ovo.setOrder_date(rs.getString("ORDER_DATE"));
				imgvo.setImg_file(rs.getString("IMG_FILE"));
				ovo.setFk_it_seq_no(rs.getInt("FK_IT_SEQ_NO"));
				itvo.setIt_name(rs.getString("IT_NAME"));
				dtvo.setO_qty(rs.getInt("O_QTY"));
				dtvo.setO_price(rs.getInt("O_PRICE"));
				dtvo.setO_status(rs.getInt("O_STATUS"));
				dtvo.setDeliverd_date(rs.getString("DELIVERD_DATE"));
				ovo.setFk_userid(rs.getString("FK_USERID"));
				ovo.setSh_name(rs.getString("SH_NAME"));
				ovo.setSh_mobile(rs.getString("sh_mobile"));
				ovo.setSh_postcode(rs.getString("sh_postcode"));
				ovo.setSh_address(rs.getString("sh_address"));
				ovo.setSh_detailaddress(rs.getString("sh_detailaddress"));
				ovo.setSh_extraaddress(rs.getString("sh_extraaddress"));
				ovo.setSh_msg(rs.getString("sh_msg"));
				
				dtvo.setOvo(ovo);
				dtvo.setImgvo(imgvo);
				dtvo.setItvo(itvo);
				
				orderAllList.add(dtvo);
				
			}// end of while(rs.next())
			
		} finally {
			close();
		}
		
		return orderAllList;
	}

	
	// 주문상세일련번호의 주문상태를 변경하는 메소드
	@Override
	public int changeStatus(Map<String, String> paraMap) throws SQLException {

		int result = 0;
		
		try {
			conn = ds.getConnection();
			
			String o_status = paraMap.get("o_status");
			
			if("2".equals(o_status)) {
				
				// 배송완료로 변경하는 경우(배송완료일자 추가)
				String sql = " update tbl_detail set o_status = ?, deliverd_date = sysdate "
						   + " where o_detail_seq_no = ? ";
					
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setInt(1, Integer.parseInt(o_status));
				pstmt.setString(2, paraMap.get("o_detail_seq_no"));
				
				result = pstmt.executeUpdate();
			}
			else {

				// 배송준비중, 배송중으로 변경하는 경우
				
				String sql = " select o_status "
						   + " from tbl_detail "
						   + " where o_detail_seq_no = ? and o_status = 2 ";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, paraMap.get("o_detail_seq_no"));
				
				rs = pstmt.executeQuery();
				
				// 배송상태가 배송완료에서 변경되는 경우
				if(rs.next()) {
					
					sql = " update tbl_detail set o_status = ?, deliverd_date = null "
						+ " where o_detail_seq_no = ? ";
					
					pstmt = conn.prepareStatement(sql);
					
					pstmt.setInt(1, Integer.parseInt(o_status));
					pstmt.setString(2, paraMap.get("o_detail_seq_no"));
					
					result = pstmt.executeUpdate();
					
				}
				else {
					
					sql = " update tbl_detail set o_status = ? "
					    + " where o_detail_seq_no = ? ";
					
					pstmt = conn.prepareStatement(sql);
					
					pstmt.setInt(1, Integer.parseInt(o_status));
					pstmt.setString(2, paraMap.get("o_detail_seq_no"));
					
					
					result = pstmt.executeUpdate();
				}
				
			}
				
		} finally {
			close();
		}
		
		return result;
		
	} // end of 
	
	

}
