<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="human.dao.MemberDao" %>
<%@ page import="human.vo.MemberVo" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		String id = request.getParameter("memid");
		String pw = request.getParameter("mempw");
		// out.println(id+"<br>");
		// out.println(pw+"<br>");
		
		
		// DTO에 처리할 값을 저장
		MemberVo tempvo = new MemberVo();
		tempvo.setId(id);
		tempvo.setPwd(pw);
		
		MemberDao memdao = new MemberDao();
		
		//int result = memdao.loginCheck(id,pw);
		int result = memdao.loginCheck(tempvo);
		
		if(result==1) {
			session.setAttribute("memid", id); // id는 로그인시 받은 값
			out.println("<script>alert('로그인성공')</script>");
			out.println("<script>location.href='../../include/index.jsp'</script>");
		}else{
			out.println("<script>alert('로그인실패')</script>");
			out.println("<script>location.href='../../moved/login/login.jsp'</script>");
		}
	%>

</body>
</html>