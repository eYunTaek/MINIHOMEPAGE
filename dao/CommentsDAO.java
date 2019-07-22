package project03.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import project03.vo.Comments;

public class CommentsDAO {

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
	public ArrayList<Comments> cmtList(int board_no){
		ArrayList<Comments> list = new ArrayList<Comments>();
		try {
			setConn();
			String sql = "SELECT a.*, b.mem_id, b.mem_name\r\n" + 
					"FROM comments a, members b\r\n" + 
					"WHERE a.board_no="+board_no+" AND a.cmt_memno=b.mem_no\r\n" + 
					"ORDER BY a.cmt_regdate";
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			Comments cmt = null;
			while(rs.next()) {
				cmt = new Comments();
				cmt.setCmt_no(rs.getInt(1));
				cmt.setBoard_no(rs.getInt(2));
				cmt.setMem_no(rs.getInt(3));
				cmt.setCmt_memno(rs.getInt(4));
				cmt.setCmt_content(rs.getString(5));
				cmt.setCmt_regdate(rs.getDate(6));
				cmt.setCmt_pubyn(rs.getString(7));
				cmt.setCmt_category(rs.getString(8));
				cmt.setMem_id(rs.getString(9));
				cmt.setMem_name(rs.getString(10));
				list.add(cmt);
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
	
	// 등록
	public boolean insertComments(Comments ins, int board_no, int mem_no) {
		boolean isSess = false;
		try {
			setConn();
			con.setAutoCommit(false);
			String sql = "INSERT INTO comments values(\r\n" + 
					"	comments_seq.nextval, ?, (SELECT mem_no FROM board WHERE board_no=?),\r\n" + 
					"	?, ?, sysdate, ?, '게시글'\r\n" + 
					")";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, board_no);
			pstmt.setInt(2, board_no);
			pstmt.setInt(3, mem_no);
			pstmt.setString(4, ins.getCmt_content());
			pstmt.setString(5, ins.getCmt_pubyn());
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
	
	// 삭제
	public boolean deleteComments(int cmt_no) {
		boolean isSess = false;
		try {
			setConn();
			con.setAutoCommit(false);
			String sql = "DELETE FROM comments WHERE cmt_no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, cmt_no);
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
