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
		// 수정할 내용을 받기
		String id = null;
		String pw = null;
		String name = null;
		String email = null;
		String phone = null;
		int result = 0;
		if(session.getAttribute("memid") == null ) {
			out.println("<script>alert('세션타임 끝났습니다 로그인 후 다시 접속하세요');</script>");
			out.println("<script>location.href='../../moved/login/login.jsp'</script>");
		}else {
			id = (String)session.getAttribute("memid");
			pw = request.getParameter("mempw");
			name = request.getParameter("memname");
			email = request.getParameter("mememail");
			phone = request.getParameter("memtel");
			
			/* out.println(id+"<br>");
			out.println(pw+"<br>");
			out.println(name+"<br>");
			out.println(email+"<br>");
			out.println(phone+"<br>" );*/
			MemberVo tempvo = new MemberVo();
			tempvo.setId(id);
			tempvo.setPwd(pw);
			tempvo.setName(name);
			tempvo.setEmail(email);
			tempvo.setPhone(phone);
			
			MemberDao memdao = new MemberDao();
			result = memdao.modifyMember(tempvo);
			
			//out.println("결과는 "+result);
			if(result==1) {
				out.println("<script>alert('회원 정보를 수정되었습니다');</script>");
				out.println("<script>location.href='../../moved/mypage/mypage.jsp'</script>");
			}else {
				out.println("<script>alert('회원 정보 수정에 실패했습니다');</script>");
				out.println("<script>location.href='../../moved/mypage/mypage.jsp'</script>");
			}
		}
	%>

</body>
</html>