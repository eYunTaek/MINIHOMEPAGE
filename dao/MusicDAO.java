package project03.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import project03.vo.Music;

public class MusicDAO {
	
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
	
	// 회원이 현재 설정한 배경음악
	public Music getMusic(int mem_no) {
		Music m = new Music();
		try {
			setConn();
			con.setAutoCommit(false);
			String sql = "SELECT b.music_file\r\n" + 
					"FROM minihome a, musicfile b\r\n" + 
					"WHERE (a.music = b.music_no) AND a.mem_no="+mem_no;
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			if(rs.next()) {
				m.setMusic_file(rs.getString(1));
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
		return m;
	}
	
	// 회원이 보유한 음악목록 조회
	public ArrayList<Music> musicList(int mem_no) {
		ArrayList<Music> list = new ArrayList<Music>();
		try {
			setConn();
			String sql = "SELECT a.music_title, b.music_file\r\n" + 
					"FROM music a, musicfile b, (SELECT * FROM membermusic WHERE mem_no="+mem_no+") c\r\n" + 
					"WHERE a.music_no = b.music_no AND b.music_no = c.music_no";
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			Music music = null;
			while(rs.next()) {
				music = new Music();
				music.setMusic_title(rs.getString(1));
				music.setMusic_file(rs.getString(2));
				list.add(music);
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
	
	// 수정
	public boolean updateMusic(Music upt, int mem_no) {
		boolean isSess = false;
		try {
			setConn();
			con.setAutoCommit(false);
			String sql = "UPDATE minihome\r\n" + 
					"SET music=(SELECT music_no FROM musicfile WHERE music_file=?)\r\n" + 
					"WHERE mem_no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, upt.getMusic_file());
			pstmt.setInt(2, mem_no);
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
	public ArrayList<Music> mem_music(int mem_no){
		ArrayList<Music> mlist = new ArrayList<Music>();
		try {
			setConn();
			String sql = "SELECT b.MEM_NO, b.MUSIC_NO, a.MUSIC_TITLE FROM music a, MEMBERMUSIC b WHERE (a.MUSIC_NO=b.MUSIC_NO) and b.mem_no=" +mem_no;
			stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			Music m = null;
			while(rs.next()) {
				m = new Music();
				m.setMem_no(rs.getInt(1));
				m.setMusic_no(rs.getInt(2));
				m.setMusic_title(rs.getString(3));
				mlist.add(m);
			}
			rs.close();
			stmt.close();
			con.close();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			try {
				if(rs != null)rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				if(stmt != null)stmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				if(con != null)con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return mlist;
	}

	public ArrayList<Music> totmusicList(){
		ArrayList<Music> mlist = new ArrayList<Music>();
		try {
			setConn();
			String sql = "select * from music";
			stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			Music m = null;
			while(rs.next()) {
				m = new Music();
				m.setMusic_no(rs.getInt(1));
				m.setMusic_title(rs.getString(2));
				m.setMusic_genre(rs.getString(3));
				m.setMusic_price(rs.getInt(4));
				mlist.add(m);
			}
			rs.close();
			stmt.close();
			con.close();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			try {
				if(rs != null)rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				if(stmt != null)stmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				if(con != null)con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return mlist;
	}

}
