package jh.mypage.orderInfo.domain;

import jh.myshop.domain.ImageVO;
import jh.myshop.domain.ItemVO;

public class DetailVO {
	
	// field
	private String o_detail_seq_no;		// 주문상세일련번호
	private String fk_order_seq_no;		// 주문일련번호
	private int fk_it_seq_no;			// 제품일련번호
	private int o_qty;					// 주문수량
	private int o_price;				// 주문금액
	private int o_status;				// 주문상태
	private String deliverd_date;		// 배송완료일자
	
	private OrderVO ovo;
	private ImageVO imgvo;
	private ItemVO itvo;
	
	
	// getter setter
	public String getO_detail_seq_no() {
		return o_detail_seq_no;
	}
	public void setO_detail_seq_no(String o_detail_seq_no) {
		this.o_detail_seq_no = o_detail_seq_no;
	}
	public String getFk_order_seq_no() {
		return fk_order_seq_no;
	}
	public void setFk_order_seq_no(String fk_order_seq_no) {
		this.fk_order_seq_no = fk_order_seq_no;
	}
	public int getFk_it_seq_no() {
		return fk_it_seq_no;
	}
	public void setFk_it_seq_no(int fk_it_seq_no) {
		this.fk_it_seq_no = fk_it_seq_no;
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
	public String getDeliverd_date() {
		return deliverd_date;
	}
	public void setDeliverd_date(String deliverd_date) {
		this.deliverd_date = deliverd_date;
	}
	

	
	public OrderVO getOvo() {
		return ovo;
	}
	public void setOvo(OrderVO ovo) {
		this.ovo = ovo;
	}
	public ImageVO getImgvo() {
		return imgvo;
	}
	public void setImgvo(ImageVO imgvo) {
		this.imgvo = imgvo;
	}
	public ItemVO getItvo() {
		return itvo;
	}
	public void setItvo(ItemVO itvo) {
		this.itvo = itvo;
	}
	

} // end of public class DetailVO {
