package ws.shop.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import ws.shop.domain.*;

public interface ItemDAO {

	// tbl_category 테이블에서 카테고리 아이디, 카테고리 이름, 사용방법, 주의사항, 사용기한을 조회해오기
	List<CategoryVO> searchCategoryList() throws SQLException;
	
	// 상품번호 채번하기
	int getSeqNoOfProduct() throws SQLException;

	// tbl_item 테이블에 제품정보 insert 하기
	int itemInsert(ItemVO ivo) throws SQLException;

	// tbl_img 테이블에 제품의 이미지 파일명 insert 해버리기 //
	int img_insert(Map<String, String> paraMap) throws SQLException;

	// 제품관리에 사용되는 카테고리별 제품리스트를 가져오는 메소드
	//List<DetailVO> itemByCategoryList(String ca_id) throws SQLException;

	// 제품관리에 사용되는 제품리스트를 가져오는 메소드
	List<DetailVO> itemSelectList(String ca_id) throws SQLException;


}
