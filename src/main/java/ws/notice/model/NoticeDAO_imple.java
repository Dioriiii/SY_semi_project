package ws.notice.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import ws.notice.domain.NoticeVO;

public class NoticeDAO_imple implements NoticeDAO {

	private DataSource ds; // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool)이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private void close() {
		try {
			if(rs != null) {rs.close(); rs=null;}
			if(pstmt!=null) { pstmt.close(); pstmt=null; }
		}catch(SQLException e) {	
			e.printStackTrace();
		}
	}// end of public class PersonDAO_imple_04------------------
	
	
	public NoticeDAO_imple() {
		try {
			Context initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			ds = (DataSource)envContext.lookup("jdbc/semi_oracle");
			
		} catch(NamingException e) {
			e.printStackTrace();
		}
		
	}
	
	
	@Override
	public List<NoticeVO> noticeDisplay() throws SQLException {
		
		List<NoticeVO> noticeList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select seq_no, title, content, to_char(register_date,'yyyy-mm-dd'), to_char(update_date,'yyyy-mm-dd') "
					   + " from tbl_board "
					   + " order by seq_no desc ";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				NoticeVO nvo = new NoticeVO();
				nvo.setSeq_no(rs.getInt(1));
				nvo.setTitle(rs.getString(2));
				nvo.setContent(rs.getString(3));
				nvo.setRegister_date(rs.getString(4));
				nvo.setUpdate_date(rs.getString(5));
				
				noticeList.add(nvo);
			}
			
		} finally {
			close();
		}
		
		
		return noticeList;
	}

	
	
}
