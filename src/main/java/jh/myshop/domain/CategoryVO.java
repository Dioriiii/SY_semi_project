package jh.myshop.domain;

public class CategoryVO {
	
	// field
	private String ca_id;         // 카테고리 아이디
	private String ca_name;       // 카테고리 이름
	private String ca_how_to_use; // 사용방법
	private String ca_caution;    // 주의사항
	private String ca_expired;    // 사용기한
	private String ca_img_file;    // 사용기한
	
	private int ca_count;
	
	


	// method
	public String getCa_id() {
		return ca_id;
	}
	
	public void setCa_id(String ca_id) {
		this.ca_id = ca_id;
	}
	
	public String getCa_name() {
		return ca_name;
	}
	
	public void setCa_name(String ca_name) {
		this.ca_name = ca_name;
	}
	
	public String getCa_how_to_use() {
		return ca_how_to_use;
	}
	
	public void setCa_how_to_use(String ca_how_to_use) {
		this.ca_how_to_use = ca_how_to_use;
	}
	
	public String getCa_caution() {
		return ca_caution;
	}
	
	public void setCa_caution(String ca_caution) {
		this.ca_caution = ca_caution;
	}
	
	public String getCa_expired() {
		return ca_expired;
	}
	
	public void setCa_expired(String ca_expired) {
		this.ca_expired = ca_expired;
	}

	public int getCa_count() {
		return ca_count;
	}

	public void setCa_count(int ca_count) {
		this.ca_count = ca_count;
	}
	
	public String getCa_img_file() {
		return ca_img_file;
	}

	public void setCa_img_file(String ca_img_file) {
		this.ca_img_file = ca_img_file;
	}
	
	
}
