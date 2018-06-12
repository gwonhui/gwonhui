package domain;

import java.sql.Timestamp;

public class My_Member {
	private String id;
	private String passwd;
	private String name;
	private Integer age;
	private String gender;
	private String email;
	private Timestamp reg_date;
	private String address;
	private String tel;
	private String mtel;
	private int male;
	private int female;
	private Integer re_lev;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Timestamp getReg_date() {
		return reg_date;
	}
	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getMtel() {
		return mtel;
	}
	public void setMtel(String mtel) {
		this.mtel = mtel;
	}
	public int getMale() {
		return male;
	}
	public void setMale(int male) {
		this.male = male;
	}
	public int getFemale() {
		return female;
	}
	public void setFemale(int female) {
		this.female = female;
	}
	public Integer getRe_lev() {
		return re_lev;
	}
	public void setRe_lev(Integer re_lev) {
		this.re_lev = re_lev;
	}
	public void setAge(Integer age) {
		this.age = age;
	}
	
}
