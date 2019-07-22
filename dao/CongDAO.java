package project03.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import project03.vo.Cong;
import project03.vo.Notice;

public class CongDAO {

	private Connection con;
	private Statement stmt;
	private ResultSet rs;
	
	public void setConn() throws ClassNotFoundException, SQLException {
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		Class.forName("oracle.jdbc.driver.OracleDriver");
		con = DriverManager.getConnection(url, "LYT", "duddj");
		System.out.println("DB 정상 접속");
	}
	
	// 콩 사용내역
	public ArrayList<Cong> usecongList(int mem_no){
		ArrayList<Cong> list = new ArrayList<Cong>();
		try {
			setConn();
			String sql = "SELECT * FROM usecong WHERE mem_no="+mem_no+" ORDER BY use_date DESC";
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			Cong cong = null;
			while(rs.next()) {
				cong = new Cong();
				cong.setMem_no(rs.getInt(1));
				cong.setCnt(rs.getInt(2));
				cong.setUse_content(rs.getString(3));
				cong.setDate(rs.getDate(4));
				list.add(cong);
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
	
	// 콩 구매내역
	public ArrayList<Cong> buycongList(int mem_no){
		ArrayList<Cong> list = new ArrayList<Cong>();
		try {
			setConn();
			String sql = "SELECT * FROM buycong WHERE mem_no="+mem_no+" ORDER BY buy_date DESC";
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			Cong cong = null;
			while(rs.next()) {
				cong = new Cong();
				cong.setMem_no(rs.getInt(1));
				cong.setCnt(rs.getInt(2));
				cong.setBuy_way(rs.getString(3));
				cong.setDate(rs.getDate(4));
				list.add(cong);
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
	
}
