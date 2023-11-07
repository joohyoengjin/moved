<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="human.dao.MemberDao" %>
<%@ page import="human.vo.MemberVo" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>달력</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" />
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>

</head>
<body>

<form action = "calsubmit.jsp" type="POST">
<%
   String loginBtn = "로그인";
   String loginLink = "login.jsp";
   String id = "";
   String name ="";
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
%>
<p>날짜선택<%= name %></p>
<input name="most1" autocomplete="off" readonly="readonly">

<button type="submit">확정</button>
<a href="Dis.jsp"><span class="btn btn-square btn-primary"></span></a>
</form>

<script>
$(function() {
	  $( "선택자" ).datepicker();
	});
	
const config = {
	dateFormat: 'yy-mm-dd',
	showOn : "button",
	buttonText:"날짜 선택",
  prevText: '이전 달',
  nextText: '다음 달',
  monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
  monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
  dayNames: ['일','월','화','수','목','금','토'],
  dayNamesShort: ['일','월','화','수','목','금','토'],
  dayNamesMin: ['일','월','화','수','목','금','토'],
  yearSuffix: '년',
  changeMonth: true,
  changeYear: true
}

$(function() {
$( "input[name='most1']" ).datepicker(config);
});

</script>
</body>
</html>