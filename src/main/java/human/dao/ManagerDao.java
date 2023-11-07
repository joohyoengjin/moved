package human.dao;

import java.sql.*;
import human.vo.*;

public class ManagerDao {
	public static String user = "jsp";
	public static String passwd = "123456";
	public static String url = "jdbc:oracle:thin:@localhost:1521:orcl";
	
	public static Connection conn = null;
	public static Statement stmt = null;
	public static PreparedStatement pstmt = null;
	public static ResultSet rs = null;
	
	public void getConnect() {
		
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(url, user, passwd);			
		}catch(Exception e) {
			System.out.println("오라클접속에러: " + e.getMessage());
		}

	}
	
	public void closeConn() {
		try {
			if(conn!=null) conn.close();
			if(stmt!=null) stmt.close();
			if(rs!=null) rs.close();
			if(pstmt!=null) pstmt.close();
		}catch(SQLException se) {
			System.out.println("오라클닫기에게: " + se.getMessage());
		}
	}
	
	public void listMemberAll() {
		
		System.out.println("회원목록을 가져옴");
		
		getConnect();
		// 쿼리작업
		
		closeConn();
	}
	
	public int getMemberCount() {
		
		System.out.println("회원 목록 수를 가져옴");
		int rst = 0;
		
		getConnect();
		// 쿼리작업
		try {
			String sql = "SELECT COUNT(*) AS CNT FROM manager";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				rst = rs.getInt("CNT");
			}
		}catch(SQLException se) {
			System.out.println("getMemberCount 쿼리에러: " + se.getMessage());
		}
		
		closeConn();
		return rst;
	}
	
	// 회원정보를 저장하는 함수
	public int regMember(String id, String pwd, String name, String tel) {
		
		System.out.println("회원 정보를 저장함");
		int rst = 0;
		
		getConnect();
		
		//작업
		try {
			String sql = "INSERT INTO manager (id,pwd,name,phone) VALUES (?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pwd);
			pstmt.setString(3, name);
			pstmt.setString(4, tel);
			rst = pstmt.executeUpdate();
		}catch(SQLException se) {
			System.out.println("regMember 쿼리에러: " + se.getMessage());			
		}
		
		closeConn();
		
		return rst;
		
	}
	//로그인 인증 함수
	public int loginCheck(String id, String pwd) {
		
		System.out.println("회원정보 인증함");
		int rst = 0;// 1이면 로그인 성공, 0이면 로그인 실패
		
		getConnect();
		
		try {
			String sql = " select count(*)as cnt from manager where id= ? and pwd= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pwd);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				rst = rs.getInt("cnt");
			}
		}catch(SQLException se) {
			System.out.println("regMember 쿼리에러: " + se.getMessage());				
		}


		return rst;
	}
}


// 회원테이블에 접속하는 기능

		

