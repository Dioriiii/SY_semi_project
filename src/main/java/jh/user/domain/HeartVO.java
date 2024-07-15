package jh.user.domain;

public class HeartVO {
	
	// field
	private String fk_userid;    // 회원아이디
	private String fk_it_seq_no; // 제품아이디
	private String heart;        // 0 : 싫어요 / 1 : 좋아요
	
	
	// method
	public String getFk_userid() {
		return fk_userid;
	}
	
	public void setFk_userid(String fk_userid) {
		this.fk_userid = fk_userid;
	}
	
	public String getFk_it_seq_no() {
		return fk_it_seq_no;
	}
	
	public void setFk_it_seq_no(String fk_it_seq_no) {
		this.fk_it_seq_no = fk_it_seq_no;
	}
	
	public String getHeart() {
		return heart;
	}
	
	public void setHeart(String heart) {
		this.heart = heart;
	}
	
}
