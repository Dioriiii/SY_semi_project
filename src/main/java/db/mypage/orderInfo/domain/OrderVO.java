package db.mypage.orderInfo.domain;

public class OrderVO {
	
	private String order_seq_no;		// 1  주문일련번호
	private String fk_userid;			// 2  회원아이디
	private int fk_it_seq_no;			// 3  제품일련번호
	private String sh_name;				// 4  수령인
	private String sh_mobile;			// 5  수령인연락처
	private String sh_postcode;			// 6  우편번호
	private String sh_address;			// 7  배송수령지
	private String sh_detailaddress;	// 8  배송상세주소
	private String sh_extraaddress;		// 9  배송참고항목
	private String sh_msg;				// 10 배송메세지
	private String order_date;			// 11 주문일자
	
	
	
		// getter setter
	public String getOrder_seq_no() {
		return order_seq_no;
	}
	public void setOrder_seq_no(String order_seq_no) {
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
	public String getSh_detailaddress() {
		return sh_detailaddress;
	}
	public void setSh_detailaddress(String sh_detailaddress) {
		this.sh_detailaddress = sh_detailaddress;
	}
	public String getSh_extraaddress() {
		return sh_extraaddress;
	}
	public void setSh_extraaddress(String sh_extraaddress) {
		this.sh_extraaddress = sh_extraaddress;
	}
	public String getSh_msg() {
		return sh_msg;
	}
	public void setSh_msg(String sh_msg) {
		this.sh_msg = sh_msg;
	}
	public String getOrder_date() {
		return order_date;
	}
	public void setOrder_date(String order_date) {
		this.order_date = order_date;
	}
	
	
	
} // end of public class OrderVO ------------------------------------------
