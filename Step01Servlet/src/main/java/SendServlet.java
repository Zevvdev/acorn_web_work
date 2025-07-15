import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/send")
public class SendServlet extends HttpServlet{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		/*
		 * 클라이언트가 요청하면서 전송한 요청파라미터 추출하기
		 * - HTTPServletRequest 객체의 기능(method)을 이용해서 추출하면 된다.
		 * - post 방식 전송인 경우 추출하기 전에 인코딩 설정을 해줘야 한글이 안 깨짐 (tomcat 10부터는 자동)
		 * - 응답 인코딩 설정 : response.setCharacterEncoding("utf-8");
		 */
		
		String uri=request.getRemoteHost();
		
		// 입력한 이름 추출
		String name=request.getParameter("name");
		// 입력한 메시지 추출
		String msg=request.getParameter("msg");
		// 콘솔창에 출력하기
		System.out.println(uri+" : "+name+" : "+msg);
		
		
		// 응답 컨텐츠 설정
		response.setContentType("text/html; charset=utf-8");

		//클라이언트에게 출력할 수 있는 객체의 참조값 얻어내기
		PrintWriter pw = response.getWriter();
		pw.println("<!doctype html>");
		pw.println("<html>");
		pw.println("<head>");
		pw.println("<meta charset='utf-8'>");
		pw.println("<title></title>");
		pw.println("</head>");
		pw.println("<body>");
		pw.println("<h1></h1>");
		pw.println("<ul>");
		
		pw.println("</ul>");
		pw.println("</body>");
		pw.println("</html>");
		pw.close();
		
	}
}
