package project03.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import project03.vo.Members;

public class MembersDAO {
	private Connection con;
	private Statement stmt;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public void setConn() throws ClassNotFoundException, SQLException {
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		Class.forName("oracle.jdbc.driver.OracleDriver");
		con = DriverManager.getConnection(url,"LYT","duddj");
		System.out.println("DB 정상 접속");
	}
	public boolean addMemberMusic(int mem_no,int music_no) {
		boolean isSess = false;
		try {
			setConn();
			con.setAutoCommit(false);
			String sql = "INSERT INTO MEMBERMUSIC values(?, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1,mem_no);
			pstmt.setInt(2,music_no);
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
			try {
				con.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			System.out.println(e.getMessage());
		} catch(Exception e) {
			System.out.println(e.getMessage());
		}finally {
			try {
				if(pstmt != null)pstmt.close();
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
		
		return isSess;
	}
	public int wave() {
		int mem_no =0;
		try {
			setConn();
			String sql = "SELECT ROUND(DBMS_RANDOM.VALUE(1, sum(count(*))),0) FROM MEMBERS GROUP BY mem_no";
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			if(rs.next()) {
				mem_no = rs.getInt(1);
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
				if(rs!=null) rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				if(stmt!=null) stmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				if(con!=null) con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}			
		}
		return mem_no;
	}
	public boolean updateMembers2(int mem_no , int cnt) {
		boolean isSess = false;
		
		try {
			setConn();
			//자동 commit 방지 처리!
			con.setAutoCommit(false);
			String sql = "UPDATE Members SET MEM_CONG = MEM_CONG + ?"+ 
					"WHERE MEM_NO = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, cnt);
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
				System.out.println(e.getMessage());
			} 
			
		} catch (Exception e) {
			System.out.println("기타 예외 발생:"+e.getMessage());
		}finally {
			try {
				if(pstmt!=null) pstmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				System.out.println(e.getMessage());
			}
			try {
				if(pstmt!=null) con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				System.out.println(e.getMessage());
			}
			
		}
		return isSess;
	}
	public boolean buycong2(int mem_no , int cnt, String buyway) {
		boolean isSess = false;
		
		try {
			setConn();
			//자동 commit 방지 처리!
			con.setAutoCommit(false);
			String sql = "INSERT INTO buycong VALUES(?, ?, ?, sysdate)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, mem_no);
			pstmt.setInt(2, cnt);
			pstmt.setString(3, buyway);
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
				System.out.println(e.getMessage());
			} 
			
		} catch (Exception e) {
			System.out.println("기타 예외 발생:"+e.getMessage());
		}finally {
			try {
				if(pstmt!=null) pstmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				System.out.println(e.getMessage());
			}
			try {
				if(pstmt!=null) con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				System.out.println(e.getMessage());
			}
			
		}
		return isSess;
	}
	public boolean addMemberitem(int mem_no,int item_no) {
		boolean isSess = false;
		try {
			setConn();
			con.setAutoCommit(false);
			String sql = "INSERT INTO memberitem values(?, ?, (SELECT item_type FROM item WHERE item_no=?))";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1,mem_no);
			pstmt.setInt(2,item_no);
			pstmt.setInt(3,item_no);
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
			try {
				con.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			System.out.println(e.getMessage());
		} catch(Exception e) {
			System.out.println(e.getMessage());
		}finally {
			try {
				if(pstmt != null)pstmt.close();
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
		
		return isSess;
	}
	
	public boolean updateMembers(Members upt) {
		boolean isSess = false;
		try {
			setConn();
			con.setAutoCommit(false);
			String sql = "UPDATE members SET mem_pwd=?, mem_name=?, mem_secunum=?, mem_phone=?, mem_email=?, mem_addr=? WHERE mem_no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, upt.getMem_pwd());
			pstmt.setString(2, upt.getMem_name());
			pstmt.setString(3, upt.getMem_secunum());
			pstmt.setString(4, upt.getMem_phone());
			pstmt.setString(5, upt.getMem_email());
			pstmt.setString(6, upt.getMem_addr());
			pstmt.setInt(7, upt.getMem_no());
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
	public boolean updateMembers(int mem_no, int price) {
		boolean isSess = false;
		
		try {
			setConn();
			//자동 commit 방지 처리!
			con.setAutoCommit(false);
			String sql = "UPDATE Members SET MEM_CONG = MEM_CONG - ?"+ 
						"WHERE MEM_NO = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, price);
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
				System.out.println(e.getMessage());
			} 

		} catch (Exception e) {
			System.out.println("기타 예외 발생:"+e.getMessage());
		}finally {
			try {
				if(pstmt!=null) pstmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				System.out.println(e.getMessage());
			}
			try {
				if(pstmt!=null) con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				System.out.println(e.getMessage());
			}
			
		}
		return isSess;
	}
	public Members login(Members m) {
		Members mb = null;
		try {
			setConn();
			String sql = "select * from MEMBERS where mem_id=? and mem_pwd=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, m.getMem_id());
			pstmt.setString(2, m.getMem_pwd());
			rs = pstmt.executeQuery();
			if(rs.next()) {
				mb = new Members(rs.getInt(1),rs.getString(2),rs.getString(3),rs.getString(4),rs.getString(5),rs.getString(6),rs.getString(7),rs.getString(8),rs.getInt(9));
			}
			rs.close();
			pstmt.close();
			con.close();
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			e.getMessage();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			e.getMessage();
		}catch(Exception e) {
			System.out.println("기타 예외 발생:"+e.getMessage());
		}finally {
			// 정상 여부 상관 없이 현재 자원이 해제 되지 않았을 때,
			// 자원 해제 처리..
			try {
				if(rs!=null) rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				System.out.println("rs시  자원해제시 에러발생:"+e.getMessage());
			}
			try {
				if(pstmt!=null) pstmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				System.out.println("pstmt시  자원해제시 에러발생:"+e.getMessage());
			}
			try {
				if(con!=null) con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				System.out.println("con시  자원해제시 에러발생:"+e.getMessage());
			}
		}
		return mb;
	}
	public Members getMemNo(int mem_no) {
		Members m = new Members();
		try {
			setConn();
			String sql = "SELECT * FROM members WHERE mem_no='"+mem_no+"'";
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			if(rs.next()) {
				//memno,memid,mempwd,memname,memsecunum,memphone,mememail,memaddr,memcong
				m = new Members(rs.getInt(1),rs.getString(2),rs.getString(3),rs.getString(4),rs.getString(5),rs.getString(6),rs.getString(7),rs.getString(8),rs.getInt(9));
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
				if(rs!=null) rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				if(stmt!=null) stmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				if(con!=null) con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}			
		}
		return m;
	}
	public Members getMem(String id) {
		Members m = new Members();
		try {
			setConn();
			String sql = "SELECT * FROM members WHERE mem_id='"+id+"'";
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			if(rs.next()) {
				//memno,memid,mempwd,memname,memsecunum,memphone,mememail,memaddr,memcong
				m = new Members(rs.getInt(1),rs.getString(2),rs.getString(3),rs.getString(4),rs.getString(5),rs.getString(6),rs.getString(7),rs.getString(8),rs.getInt(9));
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
				if(rs!=null) rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				if(stmt!=null) stmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				if(con!=null) con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}			
		}
		return m;
	}
	public boolean insertMini(int mem_no) {
		boolean isSess = false;
		try {
			setConn();
			con.setAutoCommit(false);
			String sql = "insert into MINIHOME(mem_no) values(?)";
			//memno,memid,mempwd,memname,memsecunum,memphone,mememail,memaddr,memcong
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, mem_no);
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
	public boolean insertMem(Members ins) {
		boolean isSess = false;
		try {
			setConn();
			con.setAutoCommit(false);
			String sql = "insert into members values(SEQ_MemNo.nextval,?,?,?,?,?,?,?,0)";
			//memno,memid,mempwd,memname,memsecunum,memphone,mememail,memaddr,memcong
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, ins.getMem_id());
			pstmt.setString(2, ins.getMem_pwd());
			pstmt.setString(3, ins.getMem_name());
			pstmt.setString(4, ins.getMem_secunum());
			pstmt.setString(5, ins.getMem_phone());
			pstmt.setString(6, ins.getMem_email());
			pstmt.setString(7, ins.getMem_addr());
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
	public Members getId(String name,String phone) {
		Members mem = null;
		try {
			setConn();
			String sql = "select * from MEMBERS where mem_name=? and mem_phone=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setString(2, phone);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				mem = new Members(rs.getInt(1),rs.getString(2),rs.getString(3),rs.getString(4),rs.getString(5),rs.getString(6),rs.getString(7),rs.getString(8),rs.getInt(9));
			}
			rs.close();
			pstmt.close();
			con.close();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}catch(Exception e) {
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
		return mem;
	}
	public Members getPass(String id,String phone) {
		Members mem = null;
		try {
			setConn();
			String sql = "select * from MEMBERS where mem_id=? and mem_phone=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, phone);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				mem = new Members(rs.getInt(1),rs.getString(2),rs.getString(3),rs.getString(4),rs.getString(5),rs.getString(6),rs.getString(7),rs.getString(8),rs.getInt(9));
			}
			rs.close();
			pstmt.close();
			con.close();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return mem;
	}
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		//SEQ_MemNo
	}

}
