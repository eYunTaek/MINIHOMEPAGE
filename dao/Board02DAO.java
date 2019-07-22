package project03.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import project03.vo.Board;

public class Board02DAO {

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
	public ArrayList<Board> board02List(int mem_no){
		ArrayList<Board> list = new ArrayList<Board>();
		try {
			setConn();
			String sql = "SELECT ROW_NUMBER() OVER(ORDER BY board_no) AS rn,\r\n" + 
					"	a.board_no, a.mem_no, a.board_memno, b.mem_name, b.mem_id, a.board_content, a.board_regdate, a.board_pubyn, a.board_category\r\n" + 
					"FROM board a, members b\r\n" + 
					"WHERE board_category='방명록' AND a.mem_no="+mem_no+" AND a.board_memno = b.mem_no\r\n" + 
					"ORDER BY rn DESC";
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			Board board = null;
			while(rs.next()) {
				board = new Board();
				board.setBoard_rn(rs.getInt(1));
				board.setBoard_no(rs.getInt(2));
				board.setMem_no(rs.getInt(3));
				board.setBoard_memno(rs.getInt(4));
				board.setMem_name(rs.getString(5));
				board.setMem_id(rs.getString(6));
				board.setBoard_content(rs.getString(7));
				board.setBoard_regdate(rs.getDate(8));
				board.setBoard_pubyn(rs.getString(9));
				board.setBoard_category(rs.getString(10));
				list.add(board);
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
	public boolean insertBoard02(Board ins) {
		boolean isSess = false;
		try {
			setConn();
			con.setAutoCommit(false);
			String sql = "INSERT INTO board(board_no, mem_no, board_memno, board_content, board_regdate, board_pubyn, board_category)\r\n" + 
					"values(board_seq.nextval, ?, ?, ?, sysdate, ?, '방명록')";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, ins.getMem_no());
			pstmt.setInt(2, ins.getBoard_memno());
			pstmt.setString(3, ins.getBoard_content());
			pstmt.setString(4, ins.getBoard_pubyn());
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
	public boolean deleteBoard02(int board_no) {
		boolean isSess = false;
		try {
			setConn();
			con.setAutoCommit(false);
			String sql = "DELETE FROM board WHERE board_no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, board_no);
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
