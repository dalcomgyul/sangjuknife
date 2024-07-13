ava
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.google.gson.Gson; // JSON 라이브러리

@WebServlet("/menuServlet")
public class MenuServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String menuId = request.getParameter("id"); // 메뉴 아이템 ID

        String content = getContent(menuId); // 콘텐츠 조회 로직 (예: DB 조회, 파일 읽기 등)

        Alert alert = new Alert(Alert.AlertType.INFORMATION);
        alert.setTitle(content);
        alert.showAndWait();
    }

    private String getContent(String menuId) {
        // 메뉴 아이템 ID에 따라 해당 콘텐츠를 조회하는 로직 구현
        // 예: DB 쿼리, 파일 읽기 등
        if (menuId.equals("aa")) {
            return "<p>홈페이지에 오신 것을 환영합니다!</p>";
        } else if (menuId.equals("bb")) {
            return "<p>본 사이트 소개 내용</p>";
        } else if (menuId.equals("cc")) {
            return "<p>판매하는 상품 목록</p>";
        }
    }