package jy.store.domain;

public class CountryVO {
	
	private String cty_code; // 국가 코드 (kr, cn)
	private String cty_name; // 국가 이름
	private String cty_img; // 국가 메인 이미지
	
	
	public String getCty_code() {
		return cty_code;
	}
	public void setCty_code(String cty_code) {
		this.cty_code = cty_code;
	}
	public String getCty_name() {
		return cty_name;
	}
	public void setCty_name(String cty_name) {
		this.cty_name = cty_name;
	}
	public String getCty_img() {
		return cty_img;
	}
	public void setCty_img(String cty_img) {
		this.cty_img = cty_img;
	}
	
	
}
