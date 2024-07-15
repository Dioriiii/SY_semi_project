package jh.user.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import jh.user.domain.UserVO;

public interface UserDAO {

	// 입력받은 paraMap 을 가지고 한명의 회원정보를 리턴시켜주는 메소드(로그인 처리)
	UserVO selectOneMember(Map<String, String> paraMap) throws SQLException;

	// 휴면회원의 status를 1(활동중)로 변경하는 메소드
	void changeStatus(String sleepUserid) throws SQLException;

	// 모든 회원을 조회하는 메소드
	List<UserVO> userSelectAll() throws SQLException;
	
	// 카테고리별로 표시할 페이지 수를 가져온다.
	int getTotalPage(Map<String, String> paraMap) throws SQLException;

	// 페이징 처리를 한 검색한 회원 목록 보여주기
	List<UserVO> select_User_paging(Map<String, String> paraMap) throws SQLException;

}
