package ws.notice.domain;

public class NoticeVO {
	
	private int seq_no;				// 글번호
	private String title;			// 글제목
	private String content; 		// 글내용
	private String register_date;	// 글등록일
	private String update_date;		// 글수정일
	
	
	//////////////////////////////////////////////
	
	
	public int getSeq_no() {
		return seq_no;
	}
	
	public void setSeq_no(int seq_no) {
		this.seq_no = seq_no;
	}
	
	public String getTitle() {
		return title;
	}
	
	public void setTitle(String title) {
		this.title = title;
	}
	
	public String getContent() {
		return content;
	}
	
	public void setContent(String content) {
		this.content = content;
	}
	
	public String getRegister_date() {
		return register_date;
	}
	
	public void setRegister_date(String register_date) {
		this.register_date = register_date;
	}
	
	public String getUpdate_date() {
		return update_date;
	}
	
	public void setUpdate_date(String update_date) {
		this.update_date = update_date;
	}
	
	

}
