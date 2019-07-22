package project03.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import project03.vo.Notice;

public class NoticeDAO {
	
	private Connection con;
	private Statement stmt;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public void setConn() throws ClassNotFoundException, SQLException {
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		Class.forName("oracle.jdbc.driver.OracleDriver");
		con = DriverManager.getConnection(url, "LYT", "duddj");
		System.out.println("DB 정상 접속");
	}
	
	// 전체 조회
	public ArrayList<Notice> noticeList(){
		ArrayList<Notice> list = new ArrayList<Notice>();
		try {
			setConn();
			String sql = "SELECT ROW_NUMBER() OVER(ORDER BY notice_no) AS rn, a.*\r\n" + 
					"FROM notice a\r\n" + 
					"ORDER BY rn DESC";
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			Notice notice = null;
			while(rs.next()) {
				notice = new Notice();
				notice.setNotice_rn(rs.getInt(1));
				notice.setNotice_no(rs.getInt(2));
				notice.setNotice_title(rs.getString(3));
				notice.setNotice_content(rs.getString(4));
				notice.setNotice_regdate(rs.getDate(5));
				notice.setNotice_view(rs.getInt(6));
				list.add(notice);
			}
			rs.close();
			stmt.close();
			con.close();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null) rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			try {
				if(stmt!=null) stmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			try {
				if(con!=null) con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	
	// 상세 조회
	public Notice getNotice(int notice_no) {
		Notice n = new Notice();
		try {
			setConn();
			con.setAutoCommit(false);
			String sql = "UPDATE notice SET notice_view=notice_view+1 WHERE notice_no="+notice_no;		// 조회수 1 증가
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			String sql2 = "SELECT * FROM notice WHERE notice_no="+notice_no;		// 상세 조회
			Statement stmt2 = con.createStatement();
			ResultSet rs2 = stmt.executeQuery(sql2);
			if(rs2.next()) {
				n.setNotice_no(rs2.getInt(1));
				n.setNotice_title(rs2.getString(2));
				n.setNotice_content(rs2.getString(3));
				n.setNotice_regdate(rs2.getDate(4));
				n.setNotice_view(rs2.getInt(5));
			}
			rs2.close();
			rs.close();
			stmt2.close();
			stmt.close();
			con.close();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return n;
	}
	
	// 등록
	public boolean insertNotice(Notice insert) {
		boolean isSess = false;
		try {
			setConn();
			con.setAutoCommit(false);
			String sql = "INSERT INTO notice values(notice_seq.nextval, ?, ?, sysdate, 0)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, insert.getNotice_title());
			pstmt.setString(2, insert.getNotice_content());
			pstmt.executeUpdate();
			pstmt.close();
			con.close();
			isSess = true;
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
			try {
				con.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt!=null) pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			try {
				if(con!=null) con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return isSess;
	}
	
	// 수정
	public boolean updateNotice(Notice upt) {
		boolean isSess = false;
		try {
			setConn();
			con.setAutoCommit(false);
			String sql = "UPDATE notice SET notice_title=?, notice_content=? WHERE notice_no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, upt.getNotice_title());
			pstmt.setString(2, upt.getNotice_content());
			pstmt.setInt(3, upt.getNotice_no());
			pstmt.executeUpdate();
			con.commit();
			pstmt.close();
			con.close();
			isSess = true;
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt!=null) pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			try {
				if(con!=null) con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return isSess;
	}
	
	// 삭제
	public boolean deleteNotice(int notice_no) {
		boolean isSess = false;
		try {
			setConn();
			String sql = "DELETE FROM notice WHERE notice_no=?";
			con.setAutoCommit(false);
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, notice_no);
			pstmt.executeUpdate();
			con.commit();
			pstmt.close();
			con.close();
			isSess = true;
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt!=null) pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			try {
				if(con!=null) con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return isSess;
	}
	
}
