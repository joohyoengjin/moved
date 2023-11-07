<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
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
	String loginBtn = "로그인";
	String loginLink = "../../../moved/login/login.jsp";
	String id = "";
	String name = "";
	MemberVo resultvo = new MemberVo();
	// 세션정보를 확인해서 페이지를 보여줄지 여부를 판단
	if(session.getAttribute("memid")==null){
	   loginBtn = "로그인";
	   loginLink = "../../../moved/login/login.jsp";
	   out.println("<script>alert('로그인 후 사용가능합니다');</script>");
	   out.println("<script>location.href='../../../moved/login/login.jsp'</script>");
	}else{
	   id = (String)session.getAttribute("memid");
	   loginBtn = "로그아웃";
	   loginLink = "../../../moved/login/logout.jsp";
	   
	   // 세션이 생성 확인 후 
	   // 지역변수 자리
	   MemberDao memdao = new MemberDao();
	   resultvo = memdao.getMemberById(id);
	   
	   //이름 가져오기
	   name = resultvo.getName();
	}
	
	String totalPriceStr = request.getParameter("totalPrice");
	int totalPrice = Integer.parseInt(totalPriceStr);
	String prod1str = request.getParameter("PROD1");
	String prod2str = request.getParameter("PROD2");
	String prod3str = request.getParameter("PROD3");
	String prod4str = request.getParameter("PROD4");
	String prod5str = request.getParameter("PROD5");
	String prod6str = request.getParameter("PROD6");
	
	String prod1PriceStr = request.getParameter("PROD1_PRICE");
	String prod2PriceStr = request.getParameter("PROD2_PRICE");
	String prod3PriceStr = request.getParameter("PROD3_PRICE");
	String prod4PriceStr = request.getParameter("PROD4_PRICE");
	String prod5PriceStr = request.getParameter("PROD5_PRICE");
	String prod6PriceStr = request.getParameter("PROD6_PRICE");
	
	int prod1Price = 0;
	int prod2Price = 0;
	int prod3Price = 0;
	int prod4Price = 0;
	int prod5Price = 0;
	int prod6Price = 0;
	

if (!"undefined".equals(prod1PriceStr)) {
    prod1Price = Integer.parseInt(prod1PriceStr);
}
if (!"undefined".equals(prod2PriceStr)) {
    prod2Price = Integer.parseInt(prod2PriceStr);
}
if (!"undefined".equals(prod3PriceStr)) {
    prod3Price = Integer.parseInt(prod3PriceStr);
}
if (!"undefined".equals(prod4PriceStr)) {
    prod4Price = Integer.parseInt(prod4PriceStr);
}
if (!"undefined".equals(prod5PriceStr)) {
    prod5Price = Integer.parseInt(prod5PriceStr);
}
if (!"undefined".equals(prod6PriceStr)) {
    prod6Price = Integer.parseInt(prod6PriceStr);
}
	
	// 오라클 데이터베이스 연결 설정
	String url = "jdbc:oracle:thin:@localhost:1521:ORCL";
	String user = "jsp";
	String dbPassword = "123456";
	ResultSet rs = null;

	try {
	    Class.forName("oracle.jdbc.driver.OracleDriver");

	    Connection conn = DriverManager.getConnection(url, user, dbPassword);

		PreparedStatement pstmt = conn.prepareStatement("UPDATE CLIENT SET COST = (?) WHERE NAME = (?)");
	    pstmt.setInt(1, totalPrice);
	    pstmt.setString(2, name);
	    int rowsAffected = pstmt.executeUpdate();
	    
		PreparedStatement pstmt2 = conn.prepareStatement("SELECT * FROM CLIENT WHERE NAME = (?)");
	    pstmt2.setString(1,name);
	    rs = pstmt2.executeQuery();
	    
	    rs.next();
	    
	    String orderNo = rs.getString("ORDER_NO");
	    
		PreparedStatement pstmt3 = conn.prepareStatement("SELECT * FROM GOODS");
	    ResultSet rs2 = pstmt3.executeQuery();
        int prod1quant = 0;
        int prod2quant = 0;
        int prod3quant = 0;
        int prod4quant = 0;
        int prod5quant = 0;
        int prod6quant = 0;
        
	    while (rs2.next()) {


            if (prod1str != null) {
                if (prod1str.equals("refrigerator")) {
                    prod1quant = prod1Price / 200000;
                } else if (prod1str.equals("chair")) {
                    prod1quant =  prod1Price / 40000;
                }
                else if (prod1str.equals("washing_machine")) {
                    prod1quant =  prod1Price / 120000;
                }
                else if (prod1str.equals("bed")) {
                    prod1quant =  prod1Price / 130000;
                }
                else if (prod1str.equals("table")) {
                    prod1quant = prod1Price / 80000;
                }
                else if (prod1str.equals("tv")) {
                    prod1quant =  prod1Price / 110000;
                }
            }
            
            if (prod2str != null) {
                if (prod2str.equals("refrigerator")) {
                    prod2quant = prod2Price / 200000;
                } else if (prod2str.equals("chair")) {
                    prod2quant =  prod2Price / 40000;
                }
                else if (prod2str.equals("washing_machine")) {
                    prod2quant =  prod2Price / 120000;
                }
                else if (prod2str.equals("bed")) {
                    prod2quant =  prod2Price / 130000;
                }
                else if (prod2str.equals("table")) {
                    prod2quant = prod2Price / 80000;
                }
                else if (prod2str.equals("tv")) {
                    prod2quant =  prod2Price / 110000;
                }
            }

            
            if (prod3str != null) {
                if (prod3str.equals("refrigerator")) {
                    prod3quant = prod3Price / 200000;
                } else if (prod3str.equals("chair")) {
                    prod3quant =  prod3Price / 40000;
                }
                else if (prod3str.equals("washing_machine")) {
                    prod3quant =  prod3Price / 120000;
                }
                else if (prod3str.equals("bed")) {
                    prod3quant =  prod3Price / 130000;
                }
                else if (prod3str.equals("table")) {
                    prod3quant = prod3Price / 80000;
                }
                else if (prod3str.equals("tv")) {
                    prod3quant =  prod3Price / 110000;
                }
            }

            
            if (prod4str != null) {
                if (prod4str.equals("refrigerator")) {
                    prod4quant = prod4Price / 200000;
                } else if (prod4str.equals("chair")) {
                    prod4quant =  prod4Price / 40000;
                }
                else if (prod4str.equals("washing_machine")) {
                    prod4quant =  prod4Price / 120000;
                }
                else if (prod4str.equals("bed")) {
                    prod4quant =  prod4Price / 130000;
                }
                else if (prod4str.equals("table")) {
                    prod4quant = prod4Price / 80000;
                }
                else if (prod4str.equals("tv")) {
                    prod4quant =  prod4Price / 110000;
                }
            }

            
            if (prod5str != null) {
                if (prod5str.equals("refrigerator")) {
                    prod5quant = prod5Price / 200000;
                } else if (prod5str.equals("chair")) {
                    prod5quant =  prod5Price / 40000;
                }
                else if (prod5str.equals("washing_machine")) {
                    prod5quant =  prod5Price / 120000;
                }
                else if (prod5str.equals("bed")) {
                    prod5quant =  prod5Price / 130000;
                }
                else if (prod5str.equals("table")) {
                    prod5quant = prod5Price / 80000;
                }
                else if (prod5str.equals("tv")) {
                    prod5quant =  prod5Price / 110000;
                }
            }

            
            if (prod6str != null) {
                if (prod6str.equals("refrigerator")) {
                    prod6quant = prod6Price / 200000;
                } else if (prod6str.equals("chair")) {
                    prod6quant =  prod6Price / 40000;
                }
                else if (prod6str.equals("washing_machine")) {
                    prod6quant =  prod6Price / 120000;
                }
                else if (prod6str.equals("bed")) {
                    prod6quant =  prod6Price / 130000;
                }
                else if (prod6str.equals("table")) {
                    prod6quant = prod6Price / 80000;
                }
                else if (prod6str.equals("tv")) {
                    prod6quant =  prod6Price / 110000;
                }
            }

        }
	    
		PreparedStatement pstmt4 = conn.prepareStatement("INSERT INTO SELECTED_GOODS (ORDER_NO, NAME,PROD,QUANT,PRICE) VALUES (?,?,?,?,?)");
	    pstmt4.setString(1, orderNo);
	    pstmt4.setString(2, name);
	    pstmt4.setString(3, prod1str);
	    pstmt4.setInt(4, prod1quant);
	    pstmt4.setInt(5, prod1Price);
	   	
		PreparedStatement pstmt5 = conn.prepareStatement("INSERT INTO SELECTED_GOODS (ORDER_NO, NAME,PROD,QUANT,PRICE) VALUES (?,?,?,?,?)");
	    pstmt5.setString(1, orderNo);
	    pstmt5.setString(2, name);
	    pstmt5.setString(3, prod2str);
	    pstmt5.setInt(4, prod2quant);
	    pstmt5.setInt(5, prod2Price);
	    
		PreparedStatement pstmt6 = conn.prepareStatement("INSERT INTO SELECTED_GOODS (ORDER_NO, NAME,PROD,QUANT,PRICE) VALUES (?,?,?,?,?)");
	    pstmt6.setString(1, orderNo);
	    pstmt6.setString(2, name);
	    pstmt6.setString(3, prod3str);
	    pstmt6.setInt(4, prod3quant);
	    pstmt6.setInt(5, prod3Price);
	    
		PreparedStatement pstmt7 = conn.prepareStatement("INSERT INTO SELECTED_GOODS (ORDER_NO, NAME,PROD,QUANT,PRICE) VALUES (?,?,?,?,?)");
	    pstmt7.setString(1, orderNo);
	    pstmt7.setString(2, name);
	    pstmt7.setString(3, prod4str);
	    pstmt7.setInt(4, prod4quant);
	    pstmt7.setInt(5, prod4Price);
	    
		PreparedStatement pstmt8 = conn.prepareStatement("INSERT INTO SELECTED_GOODS (ORDER_NO, NAME,PROD,QUANT,PRICE) VALUES (?,?,?,?,?)");
	    pstmt8.setString(1, orderNo);
	    pstmt8.setString(2, name);
	    pstmt8.setString(3, prod5str);
	    pstmt8.setInt(4, prod5quant);
	    pstmt8.setInt(5, prod5Price);
	    
		PreparedStatement pstmt9 = conn.prepareStatement("INSERT INTO SELECTED_GOODS (ORDER_NO, NAME,PROD,QUANT,PRICE) VALUES (?,?,?,?,?)");
	    pstmt9.setString(1, orderNo);
	    pstmt9.setString(2, name);
	    pstmt9.setString(3, prod6str);
	    pstmt9.setInt(4, prod6quant);
	    pstmt9.setInt(5, prod6Price);
	    
	    rowsAffected = pstmt4.executeUpdate();
	    rowsAffected = pstmt5.executeUpdate();
	    rowsAffected = pstmt6.executeUpdate();
	    rowsAffected = pstmt7.executeUpdate();
	    rowsAffected = pstmt8.executeUpdate();
	    rowsAffected = pstmt9.executeUpdate();
	    
	    PreparedStatement pstmt10 = conn.prepareStatement("DELETE FROM SELECTED_GOODS WHERE PROD = 'undefined'");
	    rowsAffected = pstmt10.executeUpdate();
	    
	} catch (Exception e) {
	    out.println("오류 발생: " + e.getMessage());
	}
%>
<h1>결과</h1>
<p><%= totalPrice %></p>
<%-- <p><%= classCount %></p> --%>
<a href="../../../include/distance/dist.jsp"><button type="button" class="">거리 계산으로</button></a>
</body>
</html>