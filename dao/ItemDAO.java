package project03.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import project03.vo.Item;
import project03.vo.Members;

public class ItemDAO {
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
	public boolean usecong(int mem_no,int cong, String itype) {
		boolean isSess = false;
		try {
			setConn();
			con.setAutoCommit(false);
			String sql = "INSERT INTO usecong values(?, ?, ?, sysdate)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1,mem_no);
			pstmt.setInt(2,cong);
			pstmt.setString(3,itype);
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
	public ArrayList<Item> fileList(){
		ArrayList<Item> flist = new ArrayList<Item>();
		try {
			setConn();
			String sql = "select * from itemfile";
			stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			Item m = null;
			while(rs.next()) {
				m = new Item();
				m.setItem_no(rs.getInt(1));
				m.setItem_file(rs.getString(2));
				flist.add(m);
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
		return flist;
	}
	public ArrayList<Item> itemList(){
		ArrayList<Item> ilist = new ArrayList<Item>();
		try {
			setConn();
			String sql = "select * from item";
			stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			Item m = null;
			while(rs.next()) {
				m = new Item();
				m.setItem_no(rs.getInt(1));
				m.setItem_name(rs.getString(2));
				m.setItem_type(rs.getString(3));
				m.setItem_price(rs.getInt(4));
				ilist.add(m);
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
		return ilist;
	}
	public ArrayList<Item> getptype(int mem_no) {
		ArrayList<Item> tlist = new ArrayList<Item>();
		try {
			setConn();
			String sql = "SELECT b.ITEM_TYPE FROM PUT_ITEM a, ITEM b WHERE (a.ITEM_NO = b.ITEM_NO) AND a.MEM_NO="+mem_no;
			stmt = con.createStatement();
			// 3. 결과값 ArrayList로 변환
			//		1) Statement를 수행하면 수행한 결과를 ResultSet 객체로 받을 수 있다
			ResultSet rs = stmt.executeQuery(sql);
			Item m = null;
			while(rs.next()) {
				m = new Item();
				m.setItem_type(rs.getString(1));; // select의 순서로도 처리할 수 있다
				
				tlist.add(m);
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
		return tlist;
	}
	public boolean wearItem(Members mem, int ino) {
		boolean isSess = false;
		try {
			setConn();
			System.out.println("시작!!");
			con.setAutoCommit(false);
			String sql = "INSERT INTO PUT_ITEM VALUES(?,?,150,200)";
			System.out.println(sql);
			pstmt = con.prepareStatement(sql);
//			sql 안에 있는 ? 순서대로 데이터 입력 하기..
			pstmt.setInt(1, mem.getMem_no());
			pstmt.setInt(2, ino);
			// 실행처리.
			pstmt.executeUpdate();
			System.out.println("실행 완료");
//			4. commit 처리.
			con.commit(); // DML문자 확정..
//			5. 자원 해제, 정상처리 isSess=true;
			pstmt.close();
			con.close();
			isSess = true;
//			6. 예외 처리 -  rollback			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("드라이버 로딩 문제 발생:"+e.getMessage());
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("데이터베이스 처리문제:"+e.getMessage());
			// DB 처리에 문제가 발생시 전체 데이터 rollback 처리..
			try {
				con.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
				System.out.println("rollback문제발생:"+e.getMessage());
			}
		} catch(Exception e) {
			System.out.println("기타 예외 발생:"+e.getMessage());
		}finally {
			// 정상 여부 상관 없이 현재 자원이 해제 되지 않았을 때,
			// 자원 해제 처리..
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
		return isSess;
	}
	public boolean clearItem(Members mem, String ptype) {
		boolean isSess = false;
		try {
			setConn();
			System.out.println("시작!!");
			con.setAutoCommit(false);
			String sql = "DELETE FROM PUT_ITEM WHERE mem_no=? AND "+
					"ITEM_NO=(SELECT b.ITEM_NO FROM item a, PUT_ITEM b WHERE a.ITEM_NO = b.ITEM_NO AND b.MEM_NO =? AND a.item_type =?)";
			System.out.println(sql);
			pstmt = con.prepareStatement(sql);
//			sql 안에 있는 ? 순서대로 데이터 입력 하기..
			pstmt.setInt(1, mem.getMem_no());
			pstmt.setInt(2, mem.getMem_no());
			pstmt.setString(3, ptype);
			// 실행처리.
			pstmt.executeUpdate();
			System.out.println("실행 완료");
//			4. commit 처리.
			con.commit(); // DML문자 확정..
//			5. 자원 해제, 정상처리 isSess=true;
			pstmt.close();
			con.close();
			isSess = true;
//			6. 예외 처리 -  rollback			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("드라이버 로딩 문제 발생:"+e.getMessage());
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("데이터베이스 처리문제:"+e.getMessage());
			// DB 처리에 문제가 발생시 전체 데이터 rollback 처리..
			try {
				con.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
				System.out.println("rollback문제발생:"+e.getMessage());
			}
		} catch(Exception e) {
			System.out.println("기타 예외 발생:"+e.getMessage());
		}finally {
			// 정상 여부 상관 없이 현재 자원이 해제 되지 않았을 때,
			// 자원 해제 처리..
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
		return isSess;
	}
	public Item putBack(int mem_no){ // 장착한 배경화면 출력
		Item p = null;
		try {
			setConn();
			String sql = "SELECT c.ITEM_FILE FROM item a, put_item b, ITEMFILE c WHERE (a.ITEM_NO = b.ITEM_NO) AND (a.ITEM_NO = c.ITEM_NO)AND a.ITEM_type='배경화면' AND b.MEM_NO="+mem_no;
			stmt = con.createStatement();
			// 3. 결과값 ArrayList로 변환
			//		1) Statement를 수행하면 수행한 결과를 ResultSet 객체로 받을 수 있다
			ResultSet rs = stmt.executeQuery(sql);
			while(rs.next()) {
				p = new Item();
				p.setItem_file(rs.getString(1));

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
		return p;
	}
	public Item putItem(Item mem){
		Item p = null;
		try {
			setConn();
			String sql = "SELECT a.ITEM_FILE, b.ITEM_NAME FROM  ITEMFILE a, item b WHERE a.item_no=(SELECT a.item_no FROM put_item a, item b WHERE (a.ITEM_NO = b.ITEM_NO) AND b.ITEM_TYPE ='"+mem.getMitem_type()+"' AND mem_no ="+mem.getMem_no()+")" +"AND a.ITEM_NO = b.ITEM_NO";
			stmt = con.createStatement();
			// 3. 결과값 ArrayList로 변환
			//		1) Statement를 수행하면 수행한 결과를 ResultSet 객체로 받을 수 있다
			ResultSet rs = stmt.executeQuery(sql);
			while(rs.next()) {
				p = new Item();
				p.setItem_file(rs.getString(1));
				p.setItem_name(rs.getString(2));

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
		return p;
	}
	public ArrayList<Item> memItem(int mem_no){ // 회원의 가지고있는 아이템 리스트
		ArrayList<Item> mlist = new ArrayList<Item>();
		try {
			setConn();
			String sql = "SELECT a.MEM_NO, a.ITEM_NO, b.ITEM_FILE, c.ITEM_NAME, c.ITEM_TYPE FROM MEMBERITEM a, ITEMFILE b, ITEM c  WHERE (a.ITEM_NO = b.ITEM_NO) AND (a.ITEM_NO = c.ITEM_NO) AND a.MEM_NO ="+mem_no;
			stmt = con.createStatement();
			// 3. 결과값 ArrayList로 변환
			//		1) Statement를 수행하면 수행한 결과를 ResultSet 객체로 받을 수 있다
			ResultSet rs = stmt.executeQuery(sql);
			Item m = null;
			while(rs.next()) {
				m = new Item();
				m.setMem_no(rs.getInt(1));; // select의 순서로도 처리할 수 있다
				m.setItem_no(rs.getInt(2));;
				m.setItem_file(rs.getString(3));
				m.setItem_name(rs.getString(4));
				m.setItem_type(rs.getString(5));
				
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
	public ArrayList<Item> mini_look(Item p) {
		ArrayList<Item> list = new ArrayList<Item>();
		try {
			setConn();
			String sql = "SELECT a.item_no,a.x,a.y FROM put_item a, item b WHERE (a.ITEM_NO = b.ITEM_NO) AND b.ITEM_TYPE='"+p.getMitem_type()+"' AND mem_no ="+p.getMem_no();
			String sql2 = "SELECT item_file FROM ITEMFILE WHERE item_no=(SELECT a.item_no FROM put_item a, item b WHERE (a.ITEM_NO = b.ITEM_NO) AND b.ITEM_TYPE ='"+p.getMitem_type()+"' AND mem_no ="+p.getMem_no()+")";
			stmt = con.createStatement();
			Statement stmt2 = con.createStatement();
			// 3. 결과값 ArrayList로 변환
			//		1) Statement를 수행하면 수행한 결과를 ResultSet 객체로 받을 수 있다
			ResultSet rs = stmt.executeQuery(sql);
			ResultSet rs2 = stmt2.executeQuery(sql2);
			Item m = null;
			
			while(rs.next()) {
				m = new Item();
				m.setItem_no(rs.getInt(1));
				if(rs2.next())m.setItem_file(rs2.getString(1));
				m.setX(rs.getInt(2));
				m.setY(rs.getInt(3));
				list.add(m);
			}
			rs.close();
			rs2.close();
			stmt.close();
			stmt2.close();
			con.close();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return list;
		
	}
	
	public boolean uptcoor(Item upt) {
		boolean isSess = false;
//		# 연결하고 대화를 하고, 자원해제, 
//		1. 연결
//		2. 자동 commit 방지 처리.
//		3. sql 처리 PreparedStatement
//		4. commit 처리.
//		5. 자원 해제, 정상처리 isSess=true;
//		6. 예외 처리 -  rollback
//		
//		1. 연결..
		try {
			setConn();
//		2. 자동 commit 방지 처리.
			System.out.println("시작!!");
			con.setAutoCommit(false);
			String sql = "UPDATE put_item " + 
					"SET X=?, " + 
					"	Y=? " + 
					"WHERE ITEM_NO=? and MEM_NO=?";
			System.out.println(sql);
			//MEM_NO,ITEM_NO,X,Y
//		3. sql 처리 PreparedStatement
//			1) PreparedStatement로 사전에 sql에 처리하기..
//				- sql injection : input에 sql script를 통해 인증되게 하는 것을 말하고, 
//			                    sql을 문자열로 조합해서 만들 때, 보안적으로 취약해진다.
//								이것을 방지하기 위해, Statement보다는 PreparedStatement를 활용한다.
//				  select * member where id = '' like '%%'
//			    - Database의 속도개선 : sql의 재해석을 하지 않기 때문에.
//			2) ? 순서대로 넘겨온 데이터를 mapping 처리 
//			   pstmt.set데이터형식(순서, 넘겨온 vo의 get메서드)
			pstmt = con.prepareStatement(sql);
//			sql 안에 있는 ? 순서대로 데이터 입력 하기..
			pstmt.setInt(1, upt.getX());
			pstmt.setInt(2, upt.getY());
			pstmt.setInt(3, upt.getItem_no());
			pstmt.setInt(4, upt.getMem_no());
			// 실행처리.
			pstmt.executeUpdate();
			System.out.println("실행 완료");
//			4. commit 처리.
			con.commit(); // DML문자 확정..
//			5. 자원 해제, 정상처리 isSess=true;
			pstmt.close();
			con.close();
			isSess = true;
//			6. 예외 처리 -  rollback			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("드라이버 로딩 문제 발생:"+e.getMessage());
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("데이터베이스 처리문제:"+e.getMessage());
			// DB 처리에 문제가 발생시 전체 데이터 rollback 처리..
			try {
				con.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
				System.out.println("rollback문제발생:"+e.getMessage());
			}
		} catch(Exception e) {
			System.out.println("기타 예외 발생:"+e.getMessage());
		}finally {
			// 정상 여부 상관 없이 현재 자원이 해제 되지 않았을 때,
			// 자원 해제 처리..
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
		return isSess;
	}

	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
