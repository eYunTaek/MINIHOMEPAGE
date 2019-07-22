package project03.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;


import project03.vo.Friend;

public class FriendDAO {
	private Connection con;
	private Statement stmt;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public void setConn() throws ClassNotFoundException, SQLException {
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		Class.forName("oracle.jdbc.driver.OracleDriver");
		con = DriverManager.getConnection(url,"LYT","duddj");
		//System.out.println("DB 정상 접속");
	}
	
	public boolean cuttingOff(String id, int mem_no) {
		boolean isSess = false;
		try {
			setConn();
			con.setAutoCommit(false);
			String sql = "DELETE FROM friends WHERE friends_id=? and mem_no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setInt(2, mem_no);
			pstmt.executeUpdate();
			con.commit();
			pstmt.close();
			con.close();
			isSess = true;
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println(e.getMessage());
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println(e.getMessage());
			try {
				con.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
				System.out.println(e1.getMessage());
			}
		} catch(Exception e) {
			System.out.println(e.getMessage());
		}finally {
			try {
				if(pstmt!=null)pstmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				System.out.println(e.getMessage());
			}
			try {
				if(con!=null)con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				System.out.println(e.getMessage());
			}
		}
		return isSess;
	}
	
	public int getno(String fid) {
		int fno = 0;
		try {
			setConn();
			String sql = "SELECT b.MEM_NO FROM FRIENDS a, MEMBERS b where (a.FRIENDS_ID = b.MEM_ID) AND a.FRIENDS_ID='"+fid+"'";
			stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			if(rs.next()) { // 각 행마다 반복처리 첫번째 row부터 다음 row에 데이터가 없을 때까지 반복 처리
				fno = rs.getInt(1);
			}
			rs.close();
			stmt.close();
			con.close();

		}  catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("드라이버 메모리 로딩 문제 발생");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("DB 처리 관련 문제 발생");
		} catch (Exception e) { // 예외는 가장 상위 계층구조의 객체를 마지막으로 해제한다
			System.out.println("기타 예외 : "+e.getMessage());
		} finally {
			// 예외가 발생했을 때, 자원해제 처리
			try {
				if(rs != null) rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				System.out.println("rs 자원 해제 관련 예외 처리");
			}
			try {
				if(stmt != null) stmt.close();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
				System.out.println("stmt 자원 해제 관련 예외 처리");
			}
			try {
				if(con != null) con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				System.out.println("con 자원 해제 관련 예외 처리");
			}
		}
		return fno;
	}

	public boolean delreq(int mem_no ,String fname) {
		boolean isSess = false;
		try {
			setConn();
			con.setAutoCommit(false);
			//DELETE FROM FRIENDSTAND WHERE mem_no = '내번호' AND FRIENDS_NAME = '';
			String sql = "DELETE FROM FRIENDSTAND WHERE friend_no = ? AND FRIENDS_NAME=?";
			//memno,memid,mempwd,memname,memsecunum,memphone,mememail,memaddr,memcong
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, mem_no);
			pstmt.setString(2,fname);
			pstmt.executeUpdate();
			con.commit();
			pstmt.close();
			con.close();
			isSess = true;
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println(e.getMessage());
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println(e.getMessage());
			try {
				con.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
				System.out.println(e1.getMessage());
			}
		} catch(Exception e) {
			System.out.println(e.getMessage());
		}finally {
			try {
				if(pstmt!=null)pstmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				System.out.println(e.getMessage());
			}
			try {
				if(con!=null)con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				System.out.println(e.getMessage());
			}
		}
		return isSess;
	}
	public boolean addfriend(int mem_no, String fid, String fname) {
		boolean isSess = false;
		try {
			setConn();
			con.setAutoCommit(false);
			String sql = "INSERT INTO friends VALUES(?,?,?,sysdate)";
			//memno,memid,mempwd,memname,memsecunum,memphone,mememail,memaddr,memcong
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, mem_no);
			pstmt.setString(2, fid);
			pstmt.setString(3, fname);
			pstmt.executeUpdate();
			con.commit();
			pstmt.close();
			con.close();
			isSess = true;
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println(e.getMessage());
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println(e.getMessage());
			try {
				con.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
				System.out.println(e1.getMessage());
			}
		} catch(Exception e) {
			System.out.println(e.getMessage());
		}finally {
			try {
				if(pstmt!=null)pstmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				System.out.println(e.getMessage());
			}
			try {
				if(con!=null)con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				System.out.println(e.getMessage());
			}
		}
		return isSess;
	}
	public ArrayList<Friend> appList(int mem_no){ // 일촌 수락 리스트
		ArrayList<Friend> list = new ArrayList<Friend>();
		try {
			// 1. 연결
			setConn();
			// 2. 대화
			String sql = "SELECT a.mem_no, b.MEM_ID, a.FRIENDS_NAME FROM FRIENDSTAND a, members b WHERE (a.MEM_NO=b.MEM_NO) AND a.friend_no="+mem_no;
			stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			Friend mem = null;
			while(rs.next()) { // 각 행마다 반복처리 첫번째 row부터 다음 row에 데이터가 없을 때까지 반복 처리
				mem = new Friend();
				mem.setMem_no(rs.getInt(1)); // select의 순서로도 처리할 수 있다
				mem.setFriends_id(rs.getString(2));
				mem.setFriends_name(rs.getString(3));
				// ArrayList에 추가
				list.add(mem);
			}
			rs.close();
			stmt.close();
			con.close();

		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("드라이버 메모리 로딩 문제 발생");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("DB 처리 관련 문제 발생");
		} catch (Exception e) { // 예외는 가장 상위 계층구조의 객체를 마지막으로 해제한다
			System.out.println("기타 예외 : "+e.getMessage());
		} finally {
			// 예외가 발생했을 때, 자원해제 처리
			try {
				if(rs != null) rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				System.out.println("rs 자원 해제 관련 예외 처리");
			}
			try {
				if(stmt != null) stmt.close();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
				System.out.println("stmt 자원 해제 관련 예외 처리");
			}
			try {
				if(con != null) con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				System.out.println("con 자원 해제 관련 예외 처리");
			}
		}
		return list;
	}
	public ArrayList<Friend> reqList(int mem_no){ // 일촌 대기 리스트
		ArrayList<Friend> list = new ArrayList<Friend>();
		try {
			// 1. 연결
			setConn();
			// 2. 대화
			String sql = "SELECT a.FRIEND_NO, a.mem_no, b.MEM_ID, a.FRIENDS_NAME FROM FRIENDSTAND a, members b WHERE (a.FRIEND_NO=b.MEM_NO) AND a.mem_no="+mem_no;
			stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			Friend mem = null;
			while(rs.next()) { // 각 행마다 반복처리 첫번째 row부터 다음 row에 데이터가 없을 때까지 반복 처리
				mem = new Friend();
				mem.setFriends_no(rs.getInt(1));
				mem.setMem_no(rs.getInt(2)); // select의 순서로도 처리할 수 있다
				mem.setFriends_id(rs.getString(3));
				mem.setFriends_name(rs.getString(4));
				// ArrayList에 추가
				list.add(mem);
			}
			rs.close();
			stmt.close();
			con.close();

		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("드라이버 메모리 로딩 문제 발생");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("DB 처리 관련 문제 발생");
		} catch (Exception e) { // 예외는 가장 상위 계층구조의 객체를 마지막으로 해제한다
			System.out.println("기타 예외 : "+e.getMessage());
		} finally {
			// 예외가 발생했을 때, 자원해제 처리
			try {
				if(rs != null) rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				System.out.println("rs 자원 해제 관련 예외 처리");
			}
			try {
				if(stmt != null) stmt.close();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
				System.out.println("stmt 자원 해제 관련 예외 처리");
			}
			try {
				if(con != null) con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				System.out.println("con 자원 해제 관련 예외 처리");
			}
		}
		return list;
	}
	public boolean reqFriend(int mem_no, int f_no, String fname) { // 일촌 신청 하면 일촌 대기리스트로 넘김
		boolean isSess = false;
		try {
			setConn();
			con.setAutoCommit(false);
			String sql = "INSERT INTO FRIENDSTAND VALUES(?,?,?)";
			//INSERT INTO FRIENDSTAND VALUES(memno,fno,fname)
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, mem_no);
			pstmt.setInt(2, f_no);
			pstmt.setString(3, fname);
			pstmt.executeUpdate();
			con.commit();
			pstmt.close();
			con.close();
			isSess = true;
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println(e.getMessage());
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println(e.getMessage());
			try {
				con.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
				System.out.println(e1.getMessage());
			}
		} catch(Exception e) {
			System.out.println(e.getMessage());
		}finally {
			try {
				if(pstmt!=null)pstmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				System.out.println(e.getMessage());
			}
			try {
				if(con!=null)con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				System.out.println(e.getMessage());
			}
		}
		return isSess;
	}
	public ArrayList<Friend> friendList(int mem_no){ // 일촌 리스트
		ArrayList<Friend> list = new ArrayList<Friend>();
		try {
			// 1. 연결
			setConn();
			// 2. 대화
			String sql = "select * from friends where mem_no ="+mem_no;
			stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			Friend mem = null;
			while(rs.next()) { // 각 행마다 반복처리 첫번째 row부터 다음 row에 데이터가 없을 때까지 반복 처리
				mem = new Friend();
				mem.setMem_no(rs.getInt(1)); // select의 순서로도 처리할 수 있다
				mem.setFriends_id(rs.getString(2));
				mem.setFriends_name(rs.getString(3));
				mem.setFriends_regdate(rs.getDate(4));
				// ArrayList에 추가
				list.add(mem);
			}
			rs.close();
			stmt.close();
			con.close();

		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("드라이버 메모리 로딩 문제 발생");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("DB 처리 관련 문제 발생");
		} catch (Exception e) { // 예외는 가장 상위 계층구조의 객체를 마지막으로 해제한다
			System.out.println("기타 예외 : "+e.getMessage());
		} finally {
			// 예외가 발생했을 때, 자원해제 처리
			try {
				if(rs != null) rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				System.out.println("rs 자원 해제 관련 예외 처리");
			}
			try {
				if(stmt != null) stmt.close();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
				System.out.println("stmt 자원 해제 관련 예외 처리");
			}
			try {
				if(con != null) con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				System.out.println("con 자원 해제 관련 예외 처리");
			}
		}
		return list;
	}
	
}
