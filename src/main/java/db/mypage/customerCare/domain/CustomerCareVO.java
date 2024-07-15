package db.mypage.customerCare.domain;

public class CustomerCareVO {

	// field
	private int    q_seq_no; 		// not null -- 질문번호
	private String q_category;		// not null -- 질문카테고리
	private String q_title;			//			   질문제목
	private	String q_content;		//			   답변내용
	private String q_register_date; // not null -- 답변등록일  
	private String q_update_date;	// 			   답변수정일
	
	
	
	// getter setter
	public int getQ_seq_no() {
		return q_seq_no;
	}
	public void setQ_seq_no(int q_seq_no) {
		this.q_seq_no = q_seq_no;
	}
	public String getQ_category() {
		return q_category;
	}
	public void setQ_category(String q_category) {
		this.q_category = q_category;
	}
	public String getQ_title() {
		return q_title;
	}
	public void setQ_title(String q_title) {
		this.q_title = q_title;
	}
	public String getQ_content() {
		return q_content;
	}
	public void setQ_content(String q_content) {
		this.q_content = q_content;
	}
	public String getQ_register_date() {
		return q_register_date;
	}
	public void setQ_register_date(String q_register_date) {
		this.q_register_date = q_register_date;
	}
	public String getQ_update_date() {
		return q_update_date;
	}
	public void setQ_update_date(String q_update_date) {
		this.q_update_date = q_update_date;
	}
	
	
	
	
}
