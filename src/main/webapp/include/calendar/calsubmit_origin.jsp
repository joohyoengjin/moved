<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="human.dao.MemberDao" %>
<%@ page import="human.vo.MemberVo" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>날짜 확인</title>
</head>
<body>
<%
	String loginBtn = "로그인";
	String loginLink = "login.jsp";
	String id = "";
	String name = "";
	MemberVo resultvo = new MemberVo();
	// 세션정보를 확인해서 페이지를 보여줄지 여부를 판단
	if(session.getAttribute("memid")==null){
	   loginBtn = "로그인";
	   loginLink = "login.jsp";
	   out.println("<script>alert('로그인 후 사용가능합니다');</script>");
	   out.println("<script>location.href='login.jsp'</script>");
	}else{
	   id = (String)session.getAttribute("memid");
	   loginBtn = "로그아웃";
	   loginLink = "logout.jsp";
	   
	   // 세션이 생성 확인 후 
	   // 지역변수 자리
	   MemberDao memdao = new MemberDao();
	   resultvo = memdao.getMemberById(id);
	   
	   //이름 가져오기
	   name = resultvo.getName();     
	}
	String most1 = request.getParameter("most1");
	
	// 오라클 데이터베이스 연결 설정
	String url = "jdbc:oracle:thin:@localhost:1521:ORCL";
	String user = "jsp";
	String password = "123456";

	try {
	    Class.forName("oracle.jdbc.driver.OracleDriver");

	    Connection conn = DriverManager.getConnection(url, user, password);

	    PreparedStatement pstmt1 = conn.prepareStatement("INSERT INTO CLIENT (NAME) VALUES (?)");
	    pstmt1.setString(1, name);
		PreparedStatement pstmt2 = conn.prepareStatement("UPDATE CLIENT SET M_DATE = (?) WHERE NAME = (?)");
	    pstmt2.setString(1, most1);
	    pstmt2.setString(2, name);
	    int rowsAffected = pstmt1.executeUpdate();
	    rowsAffected = pstmt2.executeUpdate();
	} catch (Exception e) {
	    out.println("오류 발생: " + e.getMessage());
	}
%>
<p><%=name%> 이사희망일 : <%=most1 %></p>
<a href="man.jsp"><button type="button" class="">직접 견적으로</button></a><br>
<a href="sol.jsp"><button type="button" class="">AI 견적으로</button></a>
</body>
</html>