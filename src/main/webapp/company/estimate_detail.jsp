<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>고객 상세</title>
</head>
<body>
    <%
    String url = "jdbc:oracle:thin:@localhost:1521:orcl";
    String username = "jsp";
    String password = "123456";
    String orderNo = request.getParameter("orderNo");
    
    String query = "SELECT " +
            "NVL(SUM(CASE WHEN PROD = 'refrigerator' THEN QUANT ELSE 0 END), 0) AS refrigerator_quant, " +
            "NVL(SUM(CASE WHEN PROD = 'refrigerator' THEN PRICE ELSE 0 END), 0) AS refrigerator_price, " +
            "NVL(SUM(CASE WHEN PROD = 'washing_machine' THEN QUANT ELSE 0 END), 0) AS washing_machine_quant, " +
            "NVL(SUM(CASE WHEN PROD = 'washing_machine' THEN PRICE ELSE 0 END), 0) AS washing_machine_price, " +
            "NVL(SUM(CASE WHEN PROD = 'chair' THEN QUANT ELSE 0 END), 0) AS chair_quant, " +
            "NVL(SUM(CASE WHEN PROD = 'chair' THEN PRICE ELSE 0 END), 0) AS chair_price, " +
            "NVL(SUM(CASE WHEN PROD = 'bed' THEN QUANT ELSE 0 END), 0) AS bed_quant, " +
            "NVL(SUM(CASE WHEN PROD = 'bed' THEN PRICE ELSE 0 END), 0) AS bed_price, " +
            "NVL(SUM(CASE WHEN PROD = 'table' THEN QUANT ELSE 0 END), 0) AS table_quant, " +
            "NVL(SUM(CASE WHEN PROD = 'table' THEN PRICE ELSE 0 END), 0) AS table_price, " +
            "NVL(SUM(CASE WHEN PROD = 'tv' THEN QUANT ELSE 0 END), 0) AS tv_quant, " +
            "NVL(SUM(CASE WHEN PROD = 'tv' THEN PRICE ELSE 0 END), 0) AS tv_price " +
            "FROM SELECTED_GOODS " +
            "WHERE ORDER_NO = ?";
    String query2 = "SELECT * FROM CLIENT WHERE ORDER_NO = ?";
    
    try {
        Connection conn = DriverManager.getConnection(url, username, password);
        PreparedStatement pstmt = conn.prepareStatement(query);
        pstmt.setString(1, orderNo);
        
        PreparedStatement pstmt2 = conn.prepareStatement(query2);
        pstmt2.setString(1, orderNo);
        
        ResultSet rs = pstmt.executeQuery();
        ResultSet rs2 = pstmt2.executeQuery();
        
        rs.next();
        rs2.next();
        
        int refrigerator_quant = rs.getInt("refrigerator_quant");
        int refrigerator_price = rs.getInt("refrigerator_price");
        int washing_machine_quant = rs.getInt("washing_machine_quant");
        int washing_machine_price = rs.getInt("washing_machine_price");
        int chair_quant = rs.getInt("chair_quant");
        int chair_price = rs.getInt("chair_price");
        int bed_quant = rs.getInt("bed_quant");
        int bed_price = rs.getInt("bed_price");
        int table_quant = rs.getInt("table_quant");
        int table_price = rs.getInt("table_price");
        int tv_quant = rs.getInt("tv_quant");
        int tv_price = rs.getInt("tv_price");
        String name = rs2.getString("NAME");
        String origin = rs2.getString("ORIGIN");
        String destin = rs2.getString("DESTIN");
        int moving_cost = rs2.getInt("moving_cost");
        
        int total_price = refrigerator_price + washing_machine_price + chair_price + bed_price + table_price + tv_price + moving_cost;
    %>
        <h2>상세 정보</h2>
	       <table border="1" style="width: 50%; margin: 0 auto;">
	    <tr>
	        <th>항목</th>
	        <th>수량</th>
	        <th>가격</th>
	    </tr>
	    <tr>
	        <td>신청자명</td>
	        <td colspan="2"><%= name %></td>
	    </tr>
	    <tr>
	        <td>냉장고</td>
	        <td><%= refrigerator_quant %></td>
	        <td><%= refrigerator_price %></td>
	    </tr>
	    <tr>
	        <td>세탁기</td>
	        <td><%= washing_machine_quant %></td>
	        <td><%= washing_machine_price %></td>
	    </tr>
	    <tr>
	        <td>의자</td>
	        <td><%= chair_quant %></td>
	        <td><%= chair_price %></td>
	    </tr>
	    <tr>
	        <td>침대</td>
	        <td><%= bed_quant %></td>
	        <td><%= bed_price %></td>
	    </tr>
	    <tr>
	        <td>테이블</td>
	        <td><%= table_quant %></td>
	        <td><%= table_price %></td>
	    </tr>
	    <tr>
	        <td>텔레비전</td>
	        <td><%= tv_quant %></td>
	        <td><%= tv_price %></td>
	    </tr>
	     <tr>
	        <td>운송료</td>
	        <td colspan="2"><%= moving_cost %></td>
	    </tr>
	    <tr>
	        <td>합계</td>
	        <td colspan="2"><%= total_price %></td>
	    </tr>
	</table>
	
<h2>업체용 견적 입력창</h2>
<form action="estimate_submit.jsp" method="POST">
  <table border="1" style="width: 50%; margin: 0 auto;">
    <tr>
      <th>항목</th>
      <th>수량</th>
      <th>가격</th>
    </tr>
    <tr>
      <td>냉장고</td>
      <td><input type="text" name="refrigerator" id="refrigerator" value="<%= refrigerator_quant %>" style="border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px;" readonly/></td>
      <td><input type="text" id="refrigerator_price" name="refrigerator_price" placeholder="<%= refrigerator_price %>" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" required></td>
    </tr>
    <tr>
      <td>세탁기</td>
      <td><input type="text" id="washing_machine" name="washing_machine" value="<%= washing_machine_quant %>" style="border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px;" readonly/></td>
      <td><input type="text" id="washing_machine_price" name="washing_machine_price" placeholder="<%= washing_machine_price %>" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" required></td>
    </tr>
    <tr>
      <td>의자</td>
      <td><input type="text" id="chair" name="chair" value="<%= chair_quant %>" style="border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px;" readonly/></td>
      <td><input type="text" id="chair_price" name="chair_price" placeholder="<%= chair_price %>" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" required></td>
    </tr>
    <tr>
      <td>침대</td>
      <td><input type="text" id="bed" name="bed" value="<%= bed_quant %>" style="border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px;" readonly/></td>
      <td><input type="text" id="bed_price" name="bed_price" placeholder="<%= bed_price %>" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" required></td>
    </tr>
    <tr>
      <td>테이블</td>
      <td><input type="text" id="table" name="table" value="<%= table_quant %>" style="border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px;" readonly/></td>
      <td><input type="text" id="table_price" name="table_price" placeholder="<%= table_price %>" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" required></td>
    </tr>
    <tr>
      <td>텔레비전</td>
      <td><input type="text" id="tv" name="tv" value="<%= tv_quant %>" style="border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px;" readonly/></td>
      <td><input type="text" id="tv_price" name="tv_price" placeholder="<%= tv_price %>" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" required></td>
    </tr>
    <tr>
      <th>출발지</th>
      <th>도착지</th>
      <th>운송료</th>
    </tr>
       <tr>
      <td><%=origin %></td>
      <td><%=destin %></td>
      <td><input type="text" id="distance_price" name="distance_price" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" required></td>
    </tr>
    
  </table>
   <input type="hidden" name="order_number" value ="<%=orderNo%>">
  <br>
  <input type="submit" value="견적 제출">
</form>
    <%
        rs.close();
        pstmt.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
    %>
</body>
</html>
