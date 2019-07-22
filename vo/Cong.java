package project03.vo;

import java.util.Date;

public class Cong {
	
	private int mem_no;
	private int cnt;
	private String use_content;
	private String buy_way;
	private Date date;
	
	public int getMem_no() {
		return mem_no;
	}
	public void setMem_no(int mem_no) {
		this.mem_no = mem_no;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public String getUse_content() {
		return use_content;
	}
	public void setUse_content(String use_content) {
		this.use_content = use_content;
	}
	public String getBuy_way() {
		return buy_way;
	}
	public void setBuy_way(String buy_way) {
		this.buy_way = buy_way;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	
}
