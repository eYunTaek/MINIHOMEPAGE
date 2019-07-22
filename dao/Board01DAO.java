package project03.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import project03.vo.Board;

public class Board01DAO {

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
	public ArrayList<Board> board01List(int mem_no){
		ArrayList<Board> list = new ArrayList<Board>();
		try {
			setConn();
			String sql = "SELECT ROW_NUMBER() OVER(ORDER BY board_no) AS rn, a.* \r\n" + 
					"FROM board a\r\n" + 
					"WHERE board_category='게시글' AND mem_no="+mem_no+"\r\n" + 
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
				board.setBoard_title(rs.getString(5));
				board.setBoard_content(rs.getString(6));
				board.setBoard_regdate(rs.getDate(7));
				board.setBoard_view(rs.getInt(8));
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
	
	// 상세 조회
	public Board getBoard01(int board_no) {
		Board b = new Board();
		try {
			setConn();
			con.setAutoCommit(false);
			String sql = "UPDATE board SET board_view=board_view+1 WHERE board_no="+board_no;		// 조회수 1 증가
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			String sql2 = "SELECT * FROM board WHERE board_no="+board_no;		// 상세 조회
			Statement stmt2 = con.createStatement();
			ResultSet rs2 = stmt.executeQuery(sql2);
			if(rs2.next()) {
				b.setBoard_no(rs2.getInt(1));
				b.setMem_no(rs2.getInt(2));
				b.setBoard_memno(rs2.getInt(3));
				b.setBoard_title(rs2.getString(4));
				b.setBoard_content(rs2.getString(5));
				b.setBoard_regdate(rs2.getDate(6));
				b.setBoard_view(rs2.getInt(7));
				b.setBoard_pubyn(rs2.getString(8));
				b.setBoard_category(rs2.getString(9));
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
		return b;
	}
	
	// 등록
	public boolean insertBoard01(Board ins) {
		boolean isSess = false;
		try {
			setConn();
			con.setAutoCommit(false);
			String sql = "INSERT INTO board values(board_seq.nextval, ?, ?, ?, ?, sysdate, 0, ?, '게시글')";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, ins.getMem_no());
			pstmt.setInt(2, ins.getBoard_memno());
			pstmt.setString(3, ins.getBoard_title());
			pstmt.setString(4, ins.getBoard_content());
			pstmt.setString(5, ins.getBoard_pubyn());
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
	public boolean updateBoard01(Board upt) {
		boolean isSess = false;
		try {
			setConn();
			con.setAutoCommit(false);
			String sql = "UPDATE board SET board_title=?, board_content=?, board_pubyn=? WHERE board_no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, upt.getBoard_title());
			pstmt.setString(2, upt.getBoard_content());
			pstmt.setString(3, upt.getBoard_pubyn());
			pstmt.setInt(4, upt.getBoard_no());
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
	public boolean deleteBoard01(int board_no) {
		boolean isSess = false;
		try {
			setConn();
			String sql = "DELETE FROM board WHERE board_no=?";
			con.setAutoCommit(false);
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
	
	// 댓글수
	public Board countCmt(int board_no) {
		Board b = new Board();
		try {
			setConn();
			String sql = "SELECT a.board_no, COUNT(*)\r\n" + 
					"FROM board a, comments b\r\n" + 
					"WHERE a.board_no=b.board_no AND a.board_no="+board_no+"\r\n" + 
					"group BY a.board_no";
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			if(rs.next()) {
				b.setBoard_no(rs.getInt(1));
				b.setCnt(rs.getInt(2));
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
		return b;
	}
	
}
