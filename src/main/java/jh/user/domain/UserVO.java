package jh.user.domain;

import db.mypage.orderInfo.domain.*;

public class UserVO {

   // field
   private String userid; // 회원아이디
   private String pwd; // 비밀번호 (SHA-256 암호화 대상)
   private String name; // 회원명
   private String birthday; // 생년월일
   private String email; // 이메일 (AES-256 암호화/복호화 대상)
   private String mobile; // 연락처 (AES-256 암호화/복호화 대상)
   private String gender; // 성별 남자:1 / 여자:2
   private String postcode; // 우편번호
   private String address; // 주소
   private String detailaddress; // 상세주소
   private String extraaddress; // 참고항목
   private String registerdate; // 가입일자
   private String last_pwd_changedate; // 마지막으로 암호를 변경한 날짜
   private int status; // 회원상태 0: 관리자 / 2: 휴면중 / 1: 사용가능(가입중, 활동중)

   //////////////////////////////////////////////////////////////////////////////////////

   private boolean requirePwdChange = false;
   // 마지막으로 암호를 변경한 날짜가 현재시각으로 부터 3개월이 지났으면 true
   // 마지막으로 암호를 변경한 날짜가 현재시각으로 부터 3개월이 지나지 않았으면 false

   //////////////////////////////////////////////////////////////////////////////////////

   // DAO field
   private OrderVO ovo;
   private CategoryVO cavo;
   private DetailVO dvo;
   private ImageVO imvo;
   private ItemVO itvo;

   
   
   
   public OrderVO getOvo() {
      return ovo;
   }

   public void setOvo(OrderVO ovo) {
      this.ovo = ovo;
   }

   public CategoryVO getCavo() {
      return cavo;
   }

   public void setCavo(CategoryVO cavo) {
      this.cavo = cavo;
   }

   public DetailVO getDvo() {
      return dvo;
   }

   public void setDvo(DetailVO dvo) {
      this.dvo = dvo;
   }

   public ImageVO getImvo() {
      return imvo;
   }

   public void setImvo(ImageVO imvo) {
      this.imvo = imvo;
   }

   public ItemVO getItvo() {
      return itvo;
   }

   public void setItvo(ItemVO itvo) {
      this.itvo = itvo;
   }

   private int total_o_qty; // 총 주문수량
   private int total_o_price; // 총 주문금액

   
   
   // method
   public String getUserid() {
      return userid;
   }

   public void setUserid(String userid) {
      this.userid = userid;
   }

   public String getPwd() {
      return pwd;
   }

   public void setPwd(String pwd) {
      this.pwd = pwd;
   }

   public String getName() {
      return name;
   }

   public void setName(String name) {
      this.name = name;
   }

   public String getBirthday() {
      return birthday;
   }

   public void setBirthday(String birthday) {
      this.birthday = birthday;
   }

   public String getEmail() {
      return email;
   }

   public void setEmail(String email) {
      this.email = email;
   }

   public String getMobile() {
      return mobile;
   }

   public void setMobile(String mobile) {
      this.mobile = mobile;
   }

   public String getGender() {
      return gender;
   }

   public void setGender(String gender) {
      this.gender = gender;
   }

   public String getPostcode() {
      return postcode;
   }

   public void setPostcode(String postcode) {
      this.postcode = postcode;
   }

   public String getAddress() {
      return address;
   }

   public void setAddress(String address) {
      this.address = address;
   }

   public String getDetailaddress() {
      return detailaddress;
   }

   public void setDetailaddress(String detailaddress) {
      this.detailaddress = detailaddress;
   }

   public String getExtraaddress() {
      return extraaddress;
   }

   public void setExtraaddress(String extraaddress) {
      this.extraaddress = extraaddress;
   }

   public String getRegisterdate() {
      return registerdate;
   }

   public void setRegisterdate(String registerdate) {
      this.registerdate = registerdate;
   }

   public String getLast_pwd_changedate() {
      return last_pwd_changedate;
   }

   public void setLast_pwd_changedate(String last_pwd_changedate) {
      this.last_pwd_changedate = last_pwd_changedate;
   }

   public int getStatus() {
      return status;
   }

   public void setStatus(int status) {
      this.status = status;
   }

   public boolean isRequirePwdChange() {
      return requirePwdChange;
   }

   public void setRequirePwdChange(boolean requirePwdChange) {
      this.requirePwdChange = requirePwdChange;
   }

   public int getTotal_o_qty() {
      return total_o_qty;
   }

   public void setTotal_o_qty(int total_o_qty) {
      this.total_o_qty = total_o_qty;
   }

   public int getTotal_o_price() {
      return total_o_price;
   }

   public void setTotal_o_price(int total_o_price) {
      this.total_o_price = total_o_price;
   }

   
}