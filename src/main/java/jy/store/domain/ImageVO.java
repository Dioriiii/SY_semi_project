package jy.store.domain;

public class ImageVO {
	
	private int store_img_no;      // 매장 이미지 고유번호
	private int fk_store_no;       // 매장 고유번호
	private String store_img_file; // 이미지 파일명
	private int is_main_img;       // 메인 이미지(1: 메인이미지 / 0: 읿반)
	private String file_type;      // 파일 타입 (i: 이미지 파일 / v: 비디오 파일)

	public int getStore_img_no() {
		return store_img_no;
	}
	public void setStore_img_no(int store_img_no) {
		this.store_img_no = store_img_no;
	}
	public int getFk_store_no() {
		return fk_store_no;
	}
	public void setFk_store_no(int fk_store_no) {
		this.fk_store_no = fk_store_no;
	}
	public int getIs_main_img() {
		return is_main_img;
	}
	public void setIs_main_img(int is_main_img) {
		this.is_main_img = is_main_img;
	}
	
	public String getStore_img_file() {
		return store_img_file;
	}
	public void setStore_img_file(String store_img_file) {
		this.store_img_file = store_img_file;
	}
	public String getFile_type() {
		return file_type;
	}
	public void setFile_type(String file_type) {
		this.file_type = file_type;
	}
		
}
