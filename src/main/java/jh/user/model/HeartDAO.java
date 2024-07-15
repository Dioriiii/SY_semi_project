package jh.user.model;

import java.sql.SQLException;
import java.util.List;

import jh.user.domain.HeartVO;
import jh.user.domain.UserVO;

public interface HeartDAO {

	// 좋아요 테이블에 insert 해주는 method
	int plusHeart(String userid, String it_seq_no) throws SQLException;

	// 좋아요 테이블에서 delete 해주는 method
	int minusHeart(String userid, String it_seq_no) throws SQLException;

	// 좋아요 테이블에서 특정 로그인 유저의 좋아요 목록을 select 하는 method
	List<HeartVO> heartUser(UserVO loginuser) throws SQLException;
	

}
