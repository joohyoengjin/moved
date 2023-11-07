<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="human.dao.CompanyDao" %>
<%@ page import="human.vo.CompanyVo" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>고객 정보</title>
</head>
<body>
    <%
        String url = "jdbc:oracle:thin:@localhost:1521:orcl";
        String username = "jsp";
        String password = "123456";
    
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection connection = DriverManager.getConnection(url, username, password);
            Statement statement = connection.createStatement();
    		
            String selectDataSQL = "SELECT * FROM CLIENT";
            ResultSet rs = statement.executeQuery(selectDataSQL);
    
    %>
            <h2>고객 정보</h2>
            <table border="1">
                <tr>
                    <th>주문번호</th>
                    <th>이름</th>
                    <th>이사희망일</th>  
                    <th>출발지</th>
                    <th>도착지</th>
                    <th>가격</th>
                    <th>처리상태</th>
                </tr>
    <%
            while (rs.next()) {
                String orderNo = rs.getString("ORDER_NO");
                String name = rs.getString("NAME");
                Date date = rs.getDate("M_DATE");
                String origin = rs.getString("ORIGIN");
                String destin = rs.getString("DESTIN");
                int cost = rs.getInt("COST");
                String process = rs.getString("PROCESS");
    %>
                <tr onclick="navigateToDetailPage('<%= orderNo %>');">
                    <td><%= orderNo %></td>
                    <td><%= name %></td>
                    <td><%= date %></td>
                    <td><%= origin %></td>
                    <td><%= destin %></td>
                    <td><%= cost %></td>
                    <td><%= process %></td>
                </tr>
    <%
            }
    
            rs.close();
            statement.close();
            connection.close();
        } catch (Exception e) {
            out.println("오류 발생: " + e.getMessage());
        }
    %>

    </table>
    
    <script>
        function navigateToDetailPage(orderNo) {
            var detailPageURL = "estimate_detail.jsp?orderNo=" + orderNo;
            window.location.href = detailPageURL;
        }
    </script>
</body>
</html>
