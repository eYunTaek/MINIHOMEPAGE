package project03.vo;

import java.util.Date;

public class Notice {
	
	private int notice_rn;	// 화면 상 글번호
	private int notice_no;
	private String notice_title;
	private String notice_content;
	private Date notice_regdate;
	private int notice_view;
	
	public Notice() {
		super();
	}
	public Notice(String notice_title, String notice_content) {
		super();
		this.notice_title = notice_title;
		this.notice_content = notice_content;
	}
	public Notice(int notice_no, String notice_title, String notice_content, Date notice_regdate, int notice_view) {
		super();
		this.notice_no = notice_no;
		this.notice_title = notice_title;
		this.notice_content = notice_content;
		this.notice_regdate = notice_regdate;
		this.notice_view = notice_view;
	}
	public Notice(int notice_no, String notice_title, String notice_content) {
		super();
		this.notice_no = notice_no;
		this.notice_title = notice_title;
		this.notice_content = notice_content;
	}
	
	public int getNotice_rn() {
		return notice_rn;
	}
	public void setNotice_rn(int notice_rn) {
		this.notice_rn = notice_rn;
	}
	public int getNotice_no() {
		return notice_no;
	}
	public void setNotice_no(int notice_no) {
		this.notice_no = notice_no;
	}
	public String getNotice_title() {
		return notice_title;
	}
	public void setNotice_title(String notice_title) {
		this.notice_title = notice_title;
	}
	public String getNotice_content() {
		return notice_content;
	}
	public void setNotice_content(String notice_content) {
		this.notice_content = notice_content;
	}
	public Date getNotice_regdate() {
		return notice_regdate;
	}
	public void setNotice_regdate(Date notice_regdate) {
		this.notice_regdate = notice_regdate;
	}
	public int getNotice_view() {
		return notice_view;
	}
	public void setNotice_view(int notice_view) {
		this.notice_view = notice_view;
	}
	
}
