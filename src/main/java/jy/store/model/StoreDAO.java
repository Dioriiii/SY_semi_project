package jy.store.model;

import java.sql.SQLException;
import java.util.List;

import jy.store.domain.CountryVO;
import jy.store.domain.ImageVO;
import jy.store.domain.StoreVO;

public interface StoreDAO {

	// 플래그십스토어(flg) 카테고리 store List 조회하기
	List<StoreVO> selectFlgList(String country) throws SQLException;
	
	// 백화점/면세점(dpt) 카테고리 store List 조회하기
	List<StoreVO> selectDptList(String country) throws SQLException;
	
	// 스톡키스트(stk) 카테고리 store List 조회하기
	List<StoreVO> selectStkList(String country) throws SQLException;

	// 전체 image List 조회하기
	List<ImageVO> getAllImgList() throws SQLException;
	
	// 전체 store_country List 조회하기
	List<CountryVO> getAllCtyList() throws SQLException;

	// 플래그십 스토어 count
	int countFlgStore(String country) throws SQLException;

	// 지도에 넣어줄 1개 매장정보 select
	StoreVO seletStoreInfo(String storeno) throws SQLException;
	
}
