package wh.myshop.domain;

import jh.user.domain.UserVO;

public class OrderVO {

	
	private int order_seq_no; // 주문일련번호
	private String fk_userid; // 회원아이디
	private int fk_it_seq_no; // 제품일련번호
	private String sh_name; // 수령인
	private String sh_mobile; // 수령인연락처
	private String sh_postcode; // 우편번호
	private String sh_address; // 배송수령지
	private String sh_msg; // 배송메세지
	
	private ItemVO ivo;
	private ImageVO imgvo;
	private CategoryVO categvo;
	private UserVO uservo;
	
	
	
	public int getOrder_seq_no() {
		return order_seq_no;
	}
	public void setOrder_seq_no(int order_seq_no) {
		this.order_seq_no = order_seq_no;
	}
	public String getFk_userid() {
		return fk_userid;
	}
	public void setFk_userid(String fk_userid) {
		this.fk_userid = fk_userid;
	}
	public int getFk_it_seq_no() {
		return fk_it_seq_no;
	}
	public void setFk_it_seq_no(int fk_it_seq_no) {
		this.fk_it_seq_no = fk_it_seq_no;
	}
	public String getSh_name() {
		return sh_name;
	}
	public void setSh_name(String sh_name) {
		this.sh_name = sh_name;
	}
	public String getSh_mobile() {
		return sh_mobile;
	}
	public void setSh_mobile(String sh_mobile) {
		this.sh_mobile = sh_mobile;
	}
	public String getSh_postcode() {
		return sh_postcode;
	}
	public void setSh_postcode(String sh_postcode) {
		this.sh_postcode = sh_postcode;
	}
	public String getSh_address() {
		return sh_address;
	}
	public void setSh_address(String sh_address) {
		this.sh_address = sh_address;
	}
	public String getSh_msg() {
		return sh_msg;
	}
	public void setSh_msg(String sh_msg) {
		this.sh_msg = sh_msg;
	}
	public ItemVO getIvo() {
		return ivo;
	}
	public void setIvo(ItemVO ivo) {
		this.ivo = ivo;
	}
	public ImageVO getImgvo() {
		return imgvo;
	}
	public void setImgvo(ImageVO imgvo) {
		this.imgvo = imgvo;
	}
	public CategoryVO getCategvo() {
		return categvo;
	}
	public void setCategvo(CategoryVO categvo) {
		this.categvo = categvo;
	}
	public UserVO getUservo() {
		return uservo;
	}
	public void setUservo(UserVO uservo) {
		this.uservo = uservo;
	}
	
	
}
