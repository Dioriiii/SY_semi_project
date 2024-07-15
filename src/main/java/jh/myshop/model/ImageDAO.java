package jh.myshop.model;

import java.sql.SQLException;
import java.util.List;

import jh.myshop.domain.ImageVO;

public interface ImageDAO {
	
	// DB에서 이미지를 꺼내오는 메소드(test)
	ImageVO getImage() throws SQLException;
	
	// DB에서 카테고리의 상품이미지를 한개씩 꺼내오는 메소드
	List<ImageVO> imageSelectOne() throws SQLException;

	// DB에서 특정 카테고리의 상품이미지를 한개씩 꺼내오는 메소드
	List<ImageVO> imageSelectOne(String ca_id) throws SQLException;

}
