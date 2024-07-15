package ws.shop.domain;

import jh.user.domain.UserVO;

public class DetailVO {
	
	private int o_detail_seq_no;		// 주문상세일련번호
	private String fk_order_seq_no;		// 주문일련번호
	private int o_qty;					// 주문수량
	private int o_price;				// 주문금액
	private int o_status;				// 주문상태
	private int deliverd_date;			// 배송완료일자
	
	private int except_order_cnt;		// 주문건수-1 
	
	private UserVO uvo;
	private OrderVO ovo;
	private ItemVO ivo;
	private ImageVO imvo;
	private CategoryVO cvo;
	
	
	// getter setter
	public int getO_detail_seq_no() {
		return o_detail_seq_no;
	}
	public void setO_detail_seq_no(int o_detail_seq_no) {
		this.o_detail_seq_no = o_detail_seq_no;
	}
	public String getFk_order_seq_no() {
		return fk_order_seq_no;
	}
	public void setFk_order_seq_no(String fk_order_seq_no) {
		this.fk_order_seq_no = fk_order_seq_no;
	}
	public int getO_qty() {
		return o_qty;
	}
	public void setO_qty(int o_qty) {
		this.o_qty = o_qty;
	}
	public int getO_price() {
		return o_price;
	}
	public void setO_price(int o_price) {
		this.o_price = o_price;
	}
	public int getO_status() {
		return o_status;
	}
	public void setO_status(int o_status) {
		this.o_status = o_status;
	}
	public int getDeliverd_date() {
		return deliverd_date;
	}
	public void setDeliverd_date(int deliverd_date) {
		this.deliverd_date = deliverd_date;
	}
	public int getExcept_order_cnt() {
		return except_order_cnt;
	}
	public void setExcept_order_cnt(int except_order_cnt) {
		this.except_order_cnt = except_order_cnt;
	}
	public UserVO getUvo() {
		return uvo;
	}
	public void setUvo(UserVO uvo) {
		this.uvo = uvo;
	}
	public OrderVO getOvo() {
		return ovo;
	}
	public void setOvo(OrderVO ovo) {
		this.ovo = ovo;
	}
	public ItemVO getIvo() {
		return ivo;
	}
	public void setIvo(ItemVO ivo) {
		this.ivo = ivo;
	}
	public ImageVO getImvo() {
		return imvo;
	}
	public void setImvo(ImageVO imvo) {
		this.imvo = imvo;
	}
	public CategoryVO getCvo() {
		return cvo;
	}
	public void setCvo(CategoryVO cvo) {
		this.cvo = cvo;
	}
	

} // end of public class DetailVO {
