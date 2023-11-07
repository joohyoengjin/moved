<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="human.dao.ClientDao" %>
<%@ page import="human.vo.ClientVo" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<%
		ClientDao memdao = new ClientDao();
	
		int total = memdao.getClientCount();
		
		out.println("총갯수:" + total);
		
	%>

</body>
</html>