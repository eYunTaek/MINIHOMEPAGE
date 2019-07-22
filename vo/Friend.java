package project03.vo;

import java.sql.Date;

public class Friend {
	//memno,friendsno,friendsname,friendsregdate
	private int mem_no;
	private String friends_id,friends_name;
	private Date friends_regdate;
	private int friends_no;

	
	public int getFriends_no() {
		return friends_no;
	}
	public void setFriends_no(int friends_no) {
		this.friends_no = friends_no;
	}
	public Friend(int mem_no, String friends_id, String friends_name, Date friends_regdate) {
		super();
		this.mem_no = mem_no;
		this.friends_id = friends_id;
		this.friends_name = friends_name;
		this.friends_regdate = friends_regdate;
	}
	public Friend() {
		super();
		// TODO Auto-generated constructor stub
	}
	public int getMem_no() {
		return mem_no;
	}
	public void setMem_no(int mem_no) {
		this.mem_no = mem_no;
	}
	public String getFriends_id() {
		return friends_id;
	}
	public void setFriends_id(String friends_id) {
		this.friends_id = friends_id;
	}
	public String getFriends_name() {
		return friends_name;
	}
	public void setFriends_name(String friends_name) {
		this.friends_name = friends_name;
	}
	public Date getFriends_regdate() {
		return friends_regdate;
	}
	public void setFriends_regdate(Date friends_regdate) {
		this.friends_regdate = friends_regdate;
	}
	
}
