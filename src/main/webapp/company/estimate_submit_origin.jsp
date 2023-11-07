<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="human.dao.CompanyDao" %>
<%@ page import="human.vo.CompanyVo" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제출 결과</title>
</head>
<body>
<%
String loginBtn = "로그인";
String loginLink = "clogin.jsp";
String id = "";
String companyName = "";
String cemail = "";
String cphone = "";

if (session.getAttribute("memid") == null) { 
    loginBtn = "로그인";
    loginLink = "clogin.jsp";
    out.println("<script>alert('로그인 후 사용가능합니다');</script>");
    out.println("<script>location.href='clogin.jsp'</script>");
} else {
    id = (String) session.getAttribute("memid");
    loginBtn = "로그아웃";
    loginLink = "logout.jsp";

    CompanyDao comdao = new CompanyDao();
    CompanyVo resultvo = comdao.getMemberById(id);

    companyName = resultvo.getCompanyname();

}	

String orderNo = request.getParameter("order_number");

String rfg_quant  = request.getParameter("refrigerator");
int rfgQuant = Integer.parseInt(rfg_quant);

String rfg_price  = request.getParameter("refrigerator_price");
int rfgPrice = Integer.parseInt(rfg_price);

String wsm_quant  = request.getParameter("washing_machine");
int wsmQuant = Integer.parseInt(wsm_quant);

String wsm_price  = request.getParameter("washing_machine_price");
int wsmPrice = Integer.parseInt(wsm_price);

String chr_quant  = request.getParameter("chair");
int chrQuant = Integer.parseInt(chr_quant);

String chr_price  = request.getParameter("chair_price");
int chrPrice = Integer.parseInt(chr_price);

String bed_quant  = request.getParameter("bed");
int bedQuant = Integer.parseInt(bed_quant);

String bed_price  = request.getParameter("bed_price");
int bedPrice = Integer.parseInt(bed_price);

String tab_quant  = request.getParameter("table");
int tabQuant = Integer.parseInt(tab_quant);

String tab_price  = request.getParameter("table_price");
int tabPrice = Integer.parseInt(tab_price);

String tv_quant  = request.getParameter("tv");
int tvQuant = Integer.parseInt(tv_quant);

String tv_price  = request.getParameter("tv_price");
int tvPrice = Integer.parseInt(tv_price);

String dist_price = request.getParameter("distance_price");
int distPrice = Integer.parseInt(dist_price);

int totalPrice = rfgPrice + wsmPrice + chrPrice + bedPrice + tabPrice + tvPrice + distPrice;

// 오라클 데이터베이스 연결 설정
String url = "jdbc:oracle:thin:@localhost:1521:ORCL";
String user = "jsp";
String password = "123456";

try {
    Class.forName("oracle.jdbc.driver.OracleDriver");

    Connection conn = DriverManager.getConnection(url, user, password);

	PreparedStatement pstmt = conn.prepareStatement("MERGE INTO COMPANY_ESTIMATE dest USING (SELECT ? AS order_no, ? AS companyname, ? AS rfg_quant, ? AS rfg_price, ? AS wsm_quant, ? AS wsm_price, ? AS chr_quant, ? AS chr_price, ? AS bed_quant, ? AS bed_price, ? AS tab_quant, ? AS tab_price, ? AS tv_quant, ? AS tv_price, ? AS dist_price, ? AS total_price FROM dual) src ON (dest.order_no = src.order_no AND dest.companyname = src.companyname) WHEN MATCHED THEN UPDATE SET dest.rfg_quant = src.rfg_quant, dest.rfg_price = src.rfg_price, dest.wsm_quant = src.wsm_quant, dest.wsm_price = src.wsm_price, dest.chr_quant = src.chr_quant, dest.chr_price = src.chr_price, dest.bed_quant = src.bed_quant, dest.bed_price = src.bed_price, dest.tab_quant = src.tab_quant, dest.tab_price = src.tab_price, dest.tv_quant = src.tv_quant, dest.tv_price = src.tv_price, dest.dist_price = src.dist_price, dest.total_price = src.total_price WHEN NOT MATCHED THEN INSERT (order_no, companyname, rfg_quant, rfg_price, wsm_quant, wsm_price, chr_quant, chr_price, bed_quant, bed_price, tab_quant, tab_price, tv_quant, tv_price, dist_price, total_price) VALUES (src.order_no, src.companyname, src.rfg_quant, src.rfg_price, src.wsm_quant, src.wsm_price, src.chr_quant, src.chr_price, src.bed_quant, src.bed_price, src.tab_quant, src.tab_price, src.tv_quant, src.tv_price, src.dist_price, src.total_price)");
    pstmt.setString(1, orderNo);
    pstmt.setString(2, companyName);
    pstmt.setInt(3, rfgQuant);
    pstmt.setInt(4, rfgPrice);
    pstmt.setInt(5, wsmQuant);
    pstmt.setInt(6, wsmPrice);
    pstmt.setInt(7, chrQuant);
    pstmt.setInt(8, chrPrice);
    pstmt.setInt(9, bedQuant);
    pstmt.setInt(10, bedPrice);
    pstmt.setInt(11, tabQuant);
    pstmt.setInt(12, tabPrice);
    pstmt.setInt(13, tvQuant);
    pstmt.setInt(14, tvPrice);
    pstmt.setInt(15, distPrice);
    pstmt.setInt(16, totalPrice);
    int rowsAffected = pstmt.executeUpdate();
    
    PreparedStatement pstmt2 = conn.prepareStatement("UPDATE CLIENT SET PROCESS = (?) WHERE ORDER_NO = (?)");
    pstmt2.setString(1, "고객전달");
    pstmt2.setString(2, orderNo); 
    pstmt2.executeUpdate();
    
} catch (Exception e) {
    out.println("오류 발생: " + e.getMessage());
}
%>

<h2 style="text-align:center;">상세 정보</h2>
   <table border="1" style="width: 50%; margin: 0 auto;">
	    <tr>
	        <th>항목</th>
	        <th>수량</th>
	        <th>가격</th>
	    </tr>
	    <tr>
	        <td>업체명</td>
	        <td colspan="2"><%= companyName %></td>
	    </tr>
	    <tr>
	        <td>냉장고</td>
	        <td><%= rfgQuant %></td>
	        <td><%= rfgPrice %></td>
	    </tr>
	    <tr>
	        <td>세탁기</td>
	        <td><%= wsmQuant %></td>
	        <td><%= wsmPrice %></td>
	    </tr>
	    <tr>
	        <td>의자</td>
	        <td><%= chrQuant %></td>
	        <td><%= chrPrice %></td>
	    </tr>
	    <tr>
	        <td>침대</td>
	        <td><%= bedQuant %></td>
	        <td><%= bedPrice %></td>
	    </tr>
	    <tr>
	        <td>테이블</td>
	        <td><%=tabQuant %></td>
	        <td><%= tabPrice %></td>
	    </tr>
	    <tr>
	        <td>텔레비전</td>
	        <td><%= tvQuant %></td>
	        <td><%= tvPrice %></td>
	    </tr>
	    	    <tr>
	        <td>운송요금</td>
	        <td colspan="2"><%= distPrice %></td>
	    </tr>
	    <tr>
	        <td>합계</td>
	        <td colspan="2"><%= totalPrice %></td>
	    </tr>
	</table>
	<h2 style="text-align:center;padding-top: 10px;">M<span style="color:skyblue;">O</span>VED</h2>
	<h1 style="text-align:center;">견적이 성공적으로 전달되었습니다.</h1>
	<h1 style="text-align:center;"><a href="com_board.jsp"><button>확인</button></a></h1>
	<style>
	button {
	  background-color: skyblue;
	  color: white;
	  border: 0;
	  width: 100px;
	  height: 40px;
	
	  /* hover 적용 */
	  &:hover {
	    background-color: #5882FA;
	  }
	}
	</style>
</body>
</html>