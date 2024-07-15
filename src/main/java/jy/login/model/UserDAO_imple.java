package jy.login.model;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import jh.user.domain.UserVO;
import my.util.security.AES256;
import my.util.security.SecretMyKey;
import my.util.security.Sha256;

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
			Context envContext = (Context) initContext.lookup("java:/comp/env");
			ds = (DataSource) envContext.lookup("jdbc/semi_oracle");

			aes = new AES256(SecretMyKey.KEY);
			// SecretMyKey.KEY 은 우리가 만든 암호화/복호화 키이다.

		} catch (NamingException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	}

	// 사용한 자원을 반납하는 close() 메소드 생성하기
	private void close() {
		try {
			if (rs != null) {
				rs.close();
				rs = null;
			}
			if (pstmt != null) {
				pstmt.close();
				pstmt = null;
			}
			if (conn != null) {
				conn.close();
				conn = null;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	// 회원가입을 해주는 메소드 (tbl_user 테이블에 insert)
	@Override
	public int registerUser(UserVO user) throws SQLException {
		int result = 0;

		try {
			conn = ds.getConnection();

			String sql = " insert into tbl_user(userid, pwd, name, birthday, email, mobile, gender, postcode, address, detailaddress, extraaddress, status) "
					+ " values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 1) ";

			pstmt = conn.prepareStatement(sql);

			System.out.println("확인용 userDAO_imple user.getUserid() =>" + user.getUserid());

			pstmt.setString(1, user.getUserid());
			pstmt.setString(2, Sha256.encrypt(user.getPwd())); // 암호를 SHA256 알고리즘으로 단방향 암호화 시킨다.
			pstmt.setString(3, user.getName());
			pstmt.setString(4, user.getBirthday());
			pstmt.setString(5, aes.encrypt(user.getUserid())); // 이메일을 AES256 알고리즘으로 양방향 암호화 시킨다.
			pstmt.setString(6, aes.encrypt(user.getMobile()));// 휴대폰번호를 AES256 알고리즘으로 양방향 암호화 시킨다.
			pstmt.setString(7, user.getGender());
			pstmt.setString(8, user.getPostcode());
			pstmt.setString(9, user.getAddress());
			pstmt.setString(10, user.getDetailaddress());
			pstmt.setString(11, user.getExtraaddress());

			result = pstmt.executeUpdate();

		} catch (GeneralSecurityException | UnsupportedEncodingException e) {
			e.printStackTrace();
		} finally {
			close();
		}

		return result;
	}// end of public int registerMember(UserVO user) throws SQLException
		// {}-------------------

	// ID 중복검사 (tbl_user 테이블에서 userid 가 존재하면 true를 리턴해주고, userid 가 존재하지 않으면 false를
	// 리턴한다)
	@Override
	public boolean idDuplicateCheck(String userid) throws SQLException {

		boolean isExists = false;

		try {
			conn = ds.getConnection();

			String sql = " select userid " + " from tbl_user " + " where userid = ? ";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, userid);

			rs = pstmt.executeQuery();

			isExists = rs.next(); // 행이 있으면(중복된 userid) true
									// 행이 없으면(사용 가능한 userid) false

		} finally {
			close();
		}

		return isExists;
	}// end of public boolean idDuplicateCheck(Map<String, String> paraMap) throws
		// SQLException {}------------------

	// 회원수정 전 Pwd 확인 (tbl_user 테이블에서 입력한 pwd 와 loginuser 의 pwd 와 같으면 true 리턴해줌)
	@Override
	public boolean pwdCheck(Map<String, String> paraMap) throws SQLException {

		boolean isMatch = false;

		try {
			conn = ds.getConnection();

			String sql = " select userid " + " from tbl_user " + " where userid = ? and pwd = ? ";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, paraMap.get("userid"));
			pstmt.setString(2, Sha256.encrypt(paraMap.get("pwd")));

			rs = pstmt.executeQuery();

			isMatch = rs.next(); // 행이 있으면(중복된 userid) true
								 // 행이 없으면(사용 가능한 userid) false

		} finally {
			close();
		}

		return isMatch;
	}// end of public boolean pwdCheck(Map<String, String> paraMap) throws
		// SQLException {}---------------------------

	// 회원수정을 해주는 메소드 (tbl_user 테이블에 update)
	@Override
	public int updateUserInfo(UserVO user) throws SQLException {

		int result = 0;

		try {
			conn = ds.getConnection();

			String sql = " update tbl_user set email = ? "
			        + "  				     , pwd= ? "
					+ "		   			     , gender = ? "
			        + "  				     , mobile = ? "
					+ "  				     , birthday = ? "
					+ "  				     , postcode = ? "
			        + "  				     , address = ? "
					+ "  				     , detailaddress = ? "
			        + "  				     , extraaddress = ? "
			        + " where userid = ? ";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, aes.encrypt(user.getEmail()));// 이메일주소를 AES256 알고리즘으로 양방향 암호화 시킨다.
			pstmt.setString(2, Sha256.encrypt(user.getPwd())); // 암호를 SHA256 알고리즘으로 단방향 암호화 시킨다.
			pstmt.setString(3, user.getGender()); //
			pstmt.setString(4, aes.encrypt(user.getMobile()));// 휴대폰번호를 AES256 알고리즘으로 양방향 암호화 시킨다.
			pstmt.setString(5, user.getBirthday());
			pstmt.setString(6, user.getPostcode());
			pstmt.setString(7, user.getAddress());
			pstmt.setString(8, user.getDetailaddress());
			pstmt.setString(9, user.getExtraaddress());
			pstmt.setString(10, user.getUserid());

			result = pstmt.executeUpdate();

		} catch (GeneralSecurityException | UnsupportedEncodingException e) {
			e.printStackTrace();
		} finally {
			close();
		}

		return result;
	}

	// Pwd 변경해주는 메소드 (tbl_user 테이블에 update)
	@Override
	public int pwdUpdate(Map<String, String> paraMap) throws SQLException {
			int result = 0;

			try {
				conn = ds.getConnection();

				String sql = " update tbl_user set pwd = ? , last_pwd_changedate = sysdate "
				           + " where userid = ? ";

				pstmt = conn.prepareStatement(sql);

				pstmt.setString(1, Sha256.encrypt(paraMap.get("new_pwd"))); // 암호를 SHA256 알고리즘으로 단방향 암호화 시킨다.
				pstmt.setString(2, paraMap.get("userid"));
				
				result = pstmt.executeUpdate();

			} finally {
				close();
			}

			return result;
	}

	// mobile 번호로 userid 를 찾아주는 메소드
	@Override
	public String findUserid(String mobile) throws SQLException {
		
		String userid = null;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select userid "
					   + " from tbl_user "
					   + " where mobile = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, aes.encrypt(mobile));
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				userid = rs.getString(1);
			}
			
		} catch (GeneralSecurityException | UnsupportedEncodingException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return userid;
	}
	
	// 입력한 email 이 회원에 존재하는지 확인
	@Override
	
	public boolean isEmailExist(String email) throws SQLException {
		
		boolean isEmailExist = false;

		try {
			conn = ds.getConnection();

			String sql = " select userid " + " from tbl_user " + " where email = ? ";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, aes.encrypt(email));

			rs = pstmt.executeQuery();

			isEmailExist = rs.next(); // 행이 있으면(중복된 userid) true
								 // 행이 없으면(사용 가능한 userid) false

		} catch (GeneralSecurityException | UnsupportedEncodingException e) {
			e.printStackTrace();
		} finally {
			close();
		}

		return isEmailExist;
	}
	
	// 입력한 email 로 userid 가지고오기
	@Override
	public String selectUserid_Email(String email) throws SQLException {
		
		String userid = null;
		
		try {
			conn = ds.getConnection();

			String sql = " select userid " + " from tbl_user " + " where email = ? ";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, aes.encrypt(email));

			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				userid = rs.getString(1);
			}
			
		} catch (GeneralSecurityException | UnsupportedEncodingException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return userid;
	}
	
	// 입력받은 paraMap 을 가지고 한명의 회원정보를 리턴시켜주는 메소드(로그인 처리)
	@Override
	public UserVO selectOneUser(Map<String, String> paraMap) throws SQLException {
		UserVO user = null;
		
		try {
			conn = ds.getConnection();
			
			String sql = " SELECT userid, name, birthday, email, mobile, gender, postcode, address, detailaddress, extraaddress, registerdate, pwdchangegap "
					   + "      , nvl( lastlogingap, trunc(months_between(sysdate, to_date(registerdate, 'yyyy-mm-dd'))) ) AS lastlogingap, status "
					   + " FROM "
					   + " ( "
					   + "     select userid, name, birthday, email, mobile, gender, postcode, address, detailaddress, extraaddress"
					   + "          , to_char(registerdate, 'yyyy-mm-dd') AS registerdate, trunc(months_between(sysdate, last_pwd_changedate)) AS pwdchangegap, status "
					   + " 	   from tbl_user "
					   + " 	   where status = 1 and userid = ? and pwd = ? "
					   + " ) M "
					   + " CROSS JOIN "
					   + " ( "
					   + "     select trunc(months_between(sysdate, max(login_date))) AS lastlogingap "
					   + "     from tbl_login_log "
					   + "     where fk_userid = ? "
					   + " ) H ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, paraMap.get("userid"));
			pstmt.setString(2, Sha256.encrypt(paraMap.get("pwd")) );
			pstmt.setString(3, paraMap.get("userid"));
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				// userid, name, birthday, email, mobile, gender, postcode
				// address, detailaddress, extraaddress, registerdate, pwdchangegap, lastlogingap, status
				
				user = new UserVO(); 
				
				user.setUserid(rs.getString(1));
				user.setName(rs.getString(2));
				user.setBirthday(rs.getString(3));
				user.setEmail(aes.decrypt(rs.getString(4)));
				user.setMobile(aes.decrypt(rs.getString(5)));
				user.setGender(rs.getString(6));
				user.setPostcode(rs.getString(7));
				user.setAddress(rs.getString(8));
				user.setDetailaddress(rs.getString(9));
				user.setExtraaddress(rs.getString(10));
				user.setRegisterdate(rs.getString(11));
				user.setStatus(rs.getInt(14));
				
				if(rs.getInt(14) == 1 && rs.getInt(12) >= 3) {
					// 휴면이 아니면서
					// 마지막으로 암호를 변경한 날짜가 현재시각으로 부터 3개월이 지났으면 true
					// 마지막으로 암호를 변경한 날짜가 현재시각으로 부터 3개월이 지나지 않았으면 false
					
					user.setRequirePwdChange(true); // 로그인 시 암호를 변경하라는 alert 를 띄우도록 할 때 사용한다.
				}
				
				
				if(rs.getInt(14) == 1 && rs.getInt(13) >= 12) {
					// 휴면이 아니면서
					// 마지막으로 로그인 한 날짜시간이 현재 시각으로부터 1년이 지났으면 휴면 처리하겠다.
					
					user.setStatus(2);
					
					// === tbl_member 테이블의 status 컬럼의 값을 2로 변경하기 ===
					sql = " update tbl_user set status = 2 "
						+ " where userid = ? ";
					
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, paraMap.get("userid"));
					
					pstmt.executeUpdate();
					
				}
				
				// === 휴면이 아닌 회원만 tbl_loginhistory(로그인기록) 테이블에 insert 하기 === //
				if(rs.getInt(14) == 1) {
					
					
					
					sql= " insert into tbl_login_log(login_date, fk_userid, login_ip) "
						+" values(sysdate, ?, ?) ";
					
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, paraMap.get("userid"));
					pstmt.setString(2, paraMap.get("login_ip"));
					
					pstmt.executeUpdate();
				
				}
				
			} // end of if(rs.next())-----------------------------------------------
			
		} catch (GeneralSecurityException | UnsupportedEncodingException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return user;
	}

	// 비밀번호 90일 뒤에 변경하는 메소드
	@Override
	public int nextUpdate(String userid) throws SQLException {
		
		int result = 0;

		try {
			conn = ds.getConnection();

			String sql = " update tbl_user set last_pwd_changedate = sysdate "
			           + " where userid = ? ";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, userid);
			
			result = pstmt.executeUpdate();

		} finally {
			close();
		}

		return result;
	}

}
