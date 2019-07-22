package project03.vo;

import java.util.Date;

public class Board {
	
	private int board_rn;	// 화면 상 글번호
	private int board_no;
	private int mem_no;
	private int board_memno;
	private String mem_name;
	private String mem_id;
	private String board_title;
	private String board_content;
	private Date board_regdate;
	private int board_view;
	private String board_pubyn;
	private String board_category;
	private int cnt;	// 댓글수
	//mem.getMem_no(), board_memno, content, pubyn
	public Board() {
		super();
	}
	
	public Board(int mem_no, int board_memno, String board_content, String board_pubyn) {
		super();
		this.mem_no = mem_no;
		this.board_memno = board_memno;
		this.board_content = board_content;
		this.board_pubyn = board_pubyn;
	}

	public Board(int board_rn, int board_no, int mem_no, int board_memno, String mem_name, String mem_id,
			String board_content, Date board_regdate, String board_pubyn, String board_category) {
		super();
		this.board_rn = board_rn;
		this.board_no = board_no;
		this.mem_no = mem_no;
		this.board_memno = board_memno;
		this.mem_name = mem_name;
		this.mem_id = mem_id;
		this.board_content = board_content;
		this.board_regdate = board_regdate;
		this.board_pubyn = board_pubyn;
		this.board_category = board_category;
	}
	public Board(int board_rn, int board_no, int mem_no, int board_memno, String board_title, String board_content,
			Date board_regdate, int board_view, String board_pubyn, String board_category) {
		super();
		this.board_rn = board_rn;
		this.board_no = board_no;
		this.mem_no = mem_no;
		this.board_memno = board_memno;
		this.board_title = board_title;
		this.board_content = board_content;
		this.board_regdate = board_regdate;
		this.board_view = board_view;
		this.board_pubyn = board_pubyn;
		this.board_category = board_category;
	}
	public Board(int mem_no, int board_memno, String board_title, String board_content, String board_pubyn) {
		super();
		this.mem_no = mem_no;
		this.board_memno = board_memno;
		this.board_title = board_title;
		this.board_content = board_content;
		this.board_pubyn = board_pubyn;
	}
	public Board(int board_no, String board_title, String board_content, String board_pubyn) {
		super();
		this.board_no = board_no;
		this.board_title = board_title;
		this.board_content = board_content;
		this.board_pubyn = board_pubyn;
	}
	public Board(int mem_no, String board_content, String board_pubyn) {
		super();
		this.mem_no = mem_no;
		this.board_content = board_content;
		this.board_pubyn = board_pubyn;
	}
	
	public int getBoard_rn() {
		return board_rn;
	}
	public void setBoard_rn(int board_rn) {
		this.board_rn = board_rn;
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
	public int getBoard_memno() {
		return board_memno;
	}
	public void setBoard_memno(int board_memno) {
		this.board_memno = board_memno;
	}
	public String getMem_name() {
		return mem_name;
	}
	public void setMem_name(String mem_name) {
		this.mem_name = mem_name;
	}
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public String getBoard_title() {
		return board_title;
	}
	public void setBoard_title(String board_title) {
		this.board_title = board_title;
	}
	public String getBoard_content() {
		return board_content;
	}
	public void setBoard_content(String board_content) {
		this.board_content = board_content;
	}
	public Date getBoard_regdate() {
		return board_regdate;
	}
	public void setBoard_regdate(Date board_regdate) {
		this.board_regdate = board_regdate;
	}
	public int getBoard_view() {
		return board_view;
	}
	public void setBoard_view(int board_view) {
		this.board_view = board_view;
	}
	public String getBoard_pubyn() {
		return board_pubyn;
	}
	public void setBoard_pubyn(String board_pubyn) {
		this.board_pubyn = board_pubyn;
	}
	public String getBoard_category() {
		return board_category;
	}
	public void setBoard_category(String board_category) {
		this.board_category = board_category;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	
}
