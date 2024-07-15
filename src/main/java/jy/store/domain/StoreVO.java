package jy.store.domain;

public class StoreVO {
	
	private int store_no; 			// 매장번호
	private String fk_country_code; // 매장 국가
	private String store_name; 		// 매장 이름
	private String store_address;   // 매장 주소
	private String store_contact;   // 매장 연락처	
	private String store_hours; 	// 매장 운영시간
	private String store_ca; 		// 매장 카테고리(유통채널)
	private String store_url; 		// 매장 지도 주소
	private double lat; 		// 매장 지도 주소
	private double lng; 		// 매장 지도 주소
	
	
	public String getStore_url() {
		return store_url;
	}
	public void setStore_url(String store_url) {
		this.store_url = store_url;
	}
	public int getStore_no() {
		return store_no;
	}
	public void setStore_no(int store_no) {
		this.store_no = store_no;
	}

	public String getFk_country_code() {
		return fk_country_code;
	}
	public void setFk_country_code(String fk_country_code) {
		this.fk_country_code = fk_country_code;
	}
	public String getStore_name() {
		return store_name;
	}
	public void setStore_name(String store_name) {
		this.store_name = store_name;
	}
	public String getStore_address() {
		return store_address;
	}
	public void setStore_address(String store_address) {
		this.store_address = store_address;
	}
	public String getStore_contact() {
		return store_contact;
	}
	public void setStore_contact(String store_contact) {
		this.store_contact = store_contact;
	}
	public String getStore_hours() {
		return store_hours;
	}
	public void setStore_hours(String store_hours) {
		this.store_hours = store_hours;
	}
	public String getStore_ca() {
		return store_ca;
	}
	public void setStore_ca(String store_ca) {
		this.store_ca = store_ca;
	}
	public double getLat() {
		return lat;
	}
	public void setLat(double lat) {
		this.lat = lat;
	}
	public double getLng() {
		return lng;
	}
	public void setLng(double lng) {
		this.lng = lng;
	}
	
}
