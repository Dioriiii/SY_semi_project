package jy.login.model;

import java.sql.SQLException;
import java.util.Map;

import jh.user.domain.UserVO;


public interface UserDAO {
	
	// 회원가입을 해주는 메소드 (tbl_user 테이블에 insert)
	int registerUser(UserVO user) throws SQLException;

	// ID 중복검사 (tbl_user 테이블에서 userid 가 존재하면 true를 리턴해주고, userid 가 존재하지 않으면 false를 리턴한다)
	boolean idDuplicateCheck(String userid) throws SQLException;

	// Pwd 확인 (tbl_user 테이블에서 입력한 pwd 와 loginuser 의 pwd 와 같으면 true 리턴해줌)
	boolean pwdCheck(Map<String, String> paraMap) throws SQLException;

	// 회원수정을 해주는 메소드 (tbl_user 테이블에 update)
	int updateUserInfo(UserVO user) throws SQLException;
	
	// Pwd 변경해주는 메소드 (tbl_user 테이블에 update)
	int pwdUpdate(Map<String, String> paraMap) throws SQLException;

	// mobile 
	String findUserid(String mobile) throws SQLException;

	// 입력한 email 이 회원에 존재하는지 확인
	boolean isEmailExist(String email) throws SQLException;

	// 입력한 email 로 userid 가지고오기
	String selectUserid_Email(String email) throws SQLException;

	// 입력받은 paraMap 을 가지고 한명의 회원정보를 리턴시켜주는 메소드(로그인 처리)
	UserVO selectOneUser(Map<String, String> paraMap) throws SQLException;

	// 비밀번호 90일 뒤에 변경하는 메소드
	int nextUpdate(String userid) throws SQLException;
	
	// 
	
	
	
}
