<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="human.dao.MemberDao" %>
<%@ page import="human.vo.MemberVo" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>상품 목록 및 결제 정보</title>
</head>

<body style="text-align: center;">
<img src="imgs/moved.png" />
<div style="margin-top: 20px" id="imageContainer"></div>
<%

int totalAmount = 0;

Enumeration<String> parameterNames = request.getParameterNames();

while (parameterNames.hasMoreElements()) {
    String paramName = parameterNames.nextElement();
    if (paramName.startsWith("quantity_")) {
        String productName = paramName.substring("quantity_".length());
        int quantity = Integer.parseInt(request.getParameter(paramName));
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        String loginBtn = "로그인";
        String loginLink = "login.jsp";
        String id = "";
        String name = "";
        MemberVo resultvo = new MemberVo();
           id = (String)session.getAttribute("memid");
           loginBtn = "로그아웃";
           loginLink = "logout.jsp";
           MemberDao memdao = new MemberDao();
           resultvo = memdao.getMemberById(id);
           name = resultvo.getName();     
        
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:ORCL", "jsp", "123456");
            pstmt = conn.prepareStatement("SELECT PRICE FROM GOODS WHERE NAME = ?");
            pstmt.setString(1, productName);
            rs = pstmt.executeQuery();
    
            if (rs.next()) {
                double price = rs.getDouble("PRICE");
                int productPrice = (int) Math.floor(price);
                double subtotal = quantity * productPrice;
                int subtotalPrice = (int) Math.floor(subtotal);
                totalAmount += subtotalPrice;
                
				// 결과 DB에 저장
    			PreparedStatement pstmt2 = conn.prepareStatement("UPDATE CLIENT SET COST = (?) WHERE NAME = (?)");
    		    pstmt2.setInt(1, totalAmount);
    		    pstmt2.setString(2, name); 		    
    		    int rowsAffected = pstmt2.executeUpdate();
    %>

    <p style="text-align:left; font-weight:bold; color:black;"><%= productName %> - <%= quantity %>개, <%= subtotalPrice %>원</p>

    <%
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
    }
}
%>

<p style="font-weight:bold; color:blue;">총 <%= totalAmount %>원</p>

<h1 style="color: #5C5D5D;">가구 목록</h1>
<form action="" method="post" style="text-align:left;">
    <%
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    
    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:ORCL", "jsp", "123456");
        pstmt = conn.prepareStatement("SELECT NAME, PRICE FROM GOODS");
        rs = pstmt.executeQuery();
    
        while (rs.next()) {
            String productName = rs.getString("NAME");
            double price = rs.getDouble("PRICE");
            int productPrice = (int) Math.floor(price);
    %>
    <label> <input type="checkbox" name="selectedProducts"
        id="<%=productName%>" value="<%=price%>"> <%=productName%>
        - <%=productPrice%>원 <input type="number" size="2"
        style="width: 35px;" name="quantity_<%=productName%>" value="0"
        disabled>
    </label><br>
    <%
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
    %>
    <!-- 계산하기 버튼 -->
    <br> <input id="calculate" type="submit" value="계산하기">
    
    <p style="text-align:left;">다음 내용으로 넘어 가려면 아래 → 를 누르세요.</p>
    <a href="dist.jsp"><button type="button" class="">거리 계산으로</button></a>
</form>
<script>
    const calculate = document.getElementById("calculate");
    // 업로드 버튼
    calculate.style.backgroundColor = "#7ABDE9";
    calculate.style.color = "white";
    calculate.style.fontSize = "16px";
    calculate.style.fontFamily = "malgunGothic";
    calculate.style.border = "none";
    calculate.style.margin = '10px 0';
    calculate.style.padding = "10px 20px";

    // 체크박스 작동 스크립트
    var checkboxes = document.querySelectorAll('input[type="checkbox"][name="selectedProducts"]');
    checkboxes.forEach(function(checkbox) {
        checkbox.addEventListener('change', function() {
            var productName = this.nextSibling.textContent.split('-')[0].trim();
            var quantityInput = document.querySelector('input[type="number"][name="quantity_' + productName + '"]');
            var imageContainer = document.getElementById('imageContainer');
            var image = new Image();
            // 이미지 경로 지정
            var imagePath = 'imgs/' + productName + ".png";
            image.src = imagePath;
            image.alt = productName;

            // 현재 이미지가 없을 경우
            if (this.checked) {
                imageContainer.appendChild(image);
            } else {
                // 현재 이미지가 존재할 경우
                var existingImage = document.querySelector('img[alt="' + productName + '"]');
                if (existingImage) {
                    imageContainer.removeChild(existingImage);
                }
            }
            quantityInput.disabled = !this.checked;
        });
    });
    
    
</script>
</body>
</html>
