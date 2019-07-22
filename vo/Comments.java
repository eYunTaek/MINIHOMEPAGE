package project03.vo;

import java.util.Date;

public class Comments {
	
	private int cmt_no;
	private int board_no;
	private int mem_no;
	private int cmt_memno;
	private String cmt_content;
	private Date cmt_regdate;
	private String cmt_pubyn;
	private String cmt_category;
	private String mem_id;
	private String mem_name;
	
	public Comments() {
		super();
	}
	public Comments(String cmt_content, String cmt_pubyn) {
		super();
		this.cmt_content = cmt_content;
		this.cmt_pubyn = cmt_pubyn;
	}

	public int getCmt_no() {
		return cmt_no;
	}
	public void setCmt_no(int cmt_no) {
		this.cmt_no = cmt_no;
	}
	public int getBoard_no() {
		return board_no;
	}
	public void setBoard_no(int board_no) {
		this.board_no = board_no;
	}
	public int getMem_no() {
		return mem_no;
	}
	public void setMem_no(int mem_no) {
		this.mem_no = mem_no;
	}
	public int getCmt_memno() {
		return cmt_memno;
	}
	public void setCmt_memno(int cmt_memno) {
		this.cmt_memno = cmt_memno;
	}
	public String getCmt_content() {
		return cmt_content;
	}
	public void setCmt_content(String cmt_content) {
		this.cmt_content = cmt_content;
	}
	public Date getCmt_regdate() {
		return cmt_regdate;
	}
	public void setCmt_regdate(Date cmt_regdate) {
		this.cmt_regdate = cmt_regdate;
	}
	public String getCmt_pubyn() {
		return cmt_pubyn;
	}
	public void setCmt_pubyn(String cmt_pubyn) {
		this.cmt_pubyn = cmt_pubyn;
	}
	public String getCmt_category() {
		return cmt_category;
	}
	public void setCmt_category(String cmt_category) {
		this.cmt_category = cmt_category;
	}
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public String getMem_name() {
		return mem_name;
	}
	public void setMem_name(String mem_name) {
		this.mem_name = mem_name;
	}
	
}
