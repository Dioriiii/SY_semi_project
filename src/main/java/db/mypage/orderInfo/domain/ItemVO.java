package db.mypage.orderInfo.domain;

public class ItemVO {
	
	// field
	private int it_seq_no;         // 제품일련번호
	private String fk_ca_id;       // 카테고리 아이디
	private String it_name;        // 상품명
	private int it_price;          // 가격
	private String it_ingredient;  // 성분
	private String it_describe;    // 설명
	private String it_create_date; // 제품생성일
	private String it_update_date; // 제품수정일
	private int it_stock;          // 재고
	private String it_volume;      // 용량
	private int it_status;         // 단종여부(0 : 단종 / 1 : 판매중)
	
	
	// method
	public int getIt_seq_no() {
		return it_seq_no;
	}
	
	public void setIt_seq_no(int it_seq_no) {
		this.it_seq_no = it_seq_no;
	}
	
	public String getFk_ca_id() {
		return fk_ca_id;
	}
	
	public void setFk_ca_id(String fk_ca_id) {
		this.fk_ca_id = fk_ca_id;
	}
	
	public String getIt_name() {
		return it_name;
	}
	
	public void setIt_name(String it_name) {
		this.it_name = it_name;
	}
	
	public int getIt_price() {
		return it_price;
	}
	
	public void setIt_price(int it_price) {
		this.it_price = it_price;
	}
	
	public String getIt_ingredient() {
		return it_ingredient;
	}
	
	public void setIt_ingredient(String it_ingredient) {
		this.it_ingredient = it_ingredient;
	}
	
	public String getIt_describe() {
		return it_describe;
	}
	
	public void setIt_describe(String it_describe) {
		this.it_describe = it_describe;
	}
	
	public String getIt_create_date() {
		return it_create_date;
	}
	
	public void setIt_create_date(String it_create_date) {
		this.it_create_date = it_create_date;
	}
	
	public String getIt_update_date() {
		return it_update_date;
	}
	
	public void setIt_update_date(String it_update_date) {
		this.it_update_date = it_update_date;
	}
	
	public int getIt_stock() {
		return it_stock;
	}
	
	public void setIt_stock(int it_stock) {
		this.it_stock = it_stock;
	}
	
	public String getIt_volume() {
		return it_volume;
	}
	
	public void setIt_volume(String it_volume) {
		this.it_volume = it_volume;
	}
	
	public int getIt_status() {
		return it_status;
	}
	
	public void setIt_status(int it_status) {
		this.it_status = it_status;
	}
	
	
	
	
}
