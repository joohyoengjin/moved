package human.dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/savetest")
public class SaveDateServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 클라이언트에서 받은 요청 파라미터 가져오기 (날짜를 선택한 경우)
        String date = request.getParameter("date");

        if (date != null && !date.isEmpty()) {
            // 오라클 데이터베이스 연결 정보 설정
            String jdbcUrl = "jdbc:oracle:thin:@localhost:1521:orcl";
            String dbUser = "jsp";
            String dbPassword = "123456";

            try {
                // 오라클 JDBC 드라이버 로드
                Class.forName("oracle.jdbc.driver.OracleDriver");

                // 데이터베이스 연결
                Connection connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

                // SQL 쿼리를 사용하여 데이터베이스에 날짜 저장
                String sql = "INSERT INTO CALENDAR (end_date) VALUES (?)"; // 테이블 이름과 컬럼 이름을 수정
                PreparedStatement statement = connection.prepareStatement(sql);
                statement.setString(1, date);

                int rowsInserted = statement.executeUpdate();
                if (rowsInserted > 0) {
                    System.out.println("날짜가 성공적으로 저장되었습니다.");
                } else {
                    System.out.println("날짜 저장 실패");
                }

                statement.close();
                connection.close();
            } catch (SQLException | ClassNotFoundException e) {
                e.printStackTrace();
            }
        }
    }
}
