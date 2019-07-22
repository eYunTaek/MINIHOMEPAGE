package project03.vo;

public class Members {
	private int mem_no,mem_cong;
	private String mem_id,mem_pwd,mem_name,mem_secunum,mem_phone,mem_email,mem_addr;
	
	public int getMem_no() {
		return mem_no;
	}
	public void setMem_no(int mem_no) {
		this.mem_no = mem_no;
	}
	public int getMem_cong() {
		return mem_cong;
	}
	public void setMem_cong(int mem_cong) {
		this.mem_cong = mem_cong;
	}
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public String getMem_pwd() {
		return mem_pwd;
	}
	public void setMem_pwd(String mem_pwd) {
		this.mem_pwd = mem_pwd;
	}
	public String getMem_name() {
		return mem_name;
	}
	public void setMem_name(String mem_name) {
		this.mem_name = mem_name;
	}
	public String getMem_secunum() {
		return mem_secunum;
	}
	public void setMem_secunum(String mem_secunum) {
		this.mem_secunum = mem_secunum;
	}
	public String getMem_phone() {
		return mem_phone;
	}
	public void setMem_phone(String mem_phone) {
		this.mem_phone = mem_phone;
	}
	public String getMem_email() {
		return mem_email;
	}
	public void setMem_email(String mem_email) {
		this.mem_email = mem_email;
	}
	public String getMem_addr() {
		return mem_addr;
	}
	public void setMem_addr(String mem_addr) {
		this.mem_addr = mem_addr;
	}
	
	public Members() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public Members(String mem_id, String mem_pwd, String mem_name, String mem_secunum, String mem_phone,
			String mem_email, String mem_addr) {
		super();
		this.mem_id = mem_id;
		this.mem_pwd = mem_pwd;
		this.mem_name = mem_name;
		this.mem_secunum = mem_secunum;
		this.mem_phone = mem_phone;
		this.mem_email = mem_email;
		this.mem_addr = mem_addr;
	}
	public Members(int mem_no, String mem_id, String mem_pwd, String mem_name, String mem_secunum,
			String mem_phone, String mem_email, String mem_addr, int mem_cong) {
		super();
		this.mem_no = mem_no;
		this.mem_cong = mem_cong;
		this.mem_id = mem_id;
		this.mem_pwd = mem_pwd;
		this.mem_name = mem_name;
		this.mem_secunum = mem_secunum;
		this.mem_phone = mem_phone;
		this.mem_email = mem_email;
		this.mem_addr = mem_addr;
	}
	public Members(String mem_id, String mem_pwd) {
		super();
		this.mem_id = mem_id;
		this.mem_pwd = mem_pwd;
	}
	public Members(int mem_no, String mem_pwd, String mem_name, String mem_secunum, String mem_phone, String mem_email,
			String mem_addr) {
		super();
		this.mem_no = mem_no;
		this.mem_pwd = mem_pwd;
		this.mem_name = mem_name;
		this.mem_secunum = mem_secunum;
		this.mem_phone = mem_phone;
		this.mem_email = mem_email;
		this.mem_addr = mem_addr;
	}
}
