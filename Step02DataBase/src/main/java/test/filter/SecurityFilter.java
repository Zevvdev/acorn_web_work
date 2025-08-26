package test.filter;
/*
 * 웹서버의 보안을 담당할 보안 필터 만들기 
 */

import java.io.IOException;
import java.net.URLEncoder;
import java.util.Set;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

//들어오는 모든 요청에 대해 필터링을 하겠다는 의미
@WebFilter("/*")
public class SecurityFilter implements Filter{
	//로그인 없이 접근 가능한 경로 목록
	Set<String> whiteList=Set.of(
			"/index.jsp",
			"/user/loginform.jsp","/user/login.jsp",
			"/user/signup-form.jsp","/user/signup.jsp",
			"/user/check-id.jsp",
			"/images/",
			"/upload/",
			"/board/list.jsp",
			"/board/view.jsp",
			"/test/",
			"/gallery/list",
			"/gallery/view"
	);
	
	
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		//로그인 했는지 확인하기
		//부모 type을 자식 type로 casting
		HttpServletRequest req=(HttpServletRequest)request;
		HttpServletResponse res=(HttpServletResponse)response;
		
		//HttpSession 객체의 참조값 얻어내기
		HttpSession session=req.getSession();
		
		//context path
		String cPath=req.getContextPath();
		//클라이언트의 요청경로 얻어내기
		String uri=req.getRequestURI(); //ex) /member/list.jsp
		//uri에서 context path를 제거한 순수 경로 얻어내기
		String path=uri.substring(cPath.length());
		
		
		//로그인 없이 접근 가능한 요청 경로면 필터링 하지 않음
		if(isWhiteList(path)) {
			chain.doFilter(request, response);
			return; //메소드 여기서 종료		
		}
		
		//로그인 여부 확인
		String userName=(String)session.getAttribute("userName");
		//role 정보
		String role=(String)session.getAttribute("role");
			
		//만일 로그인을 하지 않았다면 
		if(userName == null) {
			//로그인 페이지로 리다일렉트(새로운 경로로 요청을 다시하라고 응답) 이동 시킨다 
			//query 문자열이 있으면 읽어와서 
	        String query = req.getQueryString();
	        //인코딩을 한다음 
	        String encodedUrl = query == null ? URLEncoder.encode(uri, "UTF-8")
	                                          : URLEncoder.encode(uri + "?" + query, "UTF-8");
	        //리다일렉트 되는 경로뒤에 url 이라는 파라미터명으로 전달한다 
	        res.sendRedirect(req.getContextPath() + "/user/loginform.jsp?url=" + encodedUrl); 
			return; //메소드를 여기서 끝내기
		}
		
		//권한 체크
		//만일 isAuthorized() 메소드가 false를 리턴하다면(접근 불가하다고 판정된다면)_
		if(!isAuthorized(path, role)) {
			//금지된 요청이라고 응답하고
			res.sendError(HttpServletResponse.SC_FORBIDDEN, "접근 권한이 없습니다.");
			return;
		}
		
		chain.doFilter(request, response);
		
	}
	
		
	
	//화이트리스트 검사
	private boolean isWhiteList(String path) {
		if("/".equals(path)) return true;
		
		//error 페이지
		if(path.startsWith("/error")) return true;
		
		for(String prefix:whiteList) {
			if(path.startsWith(prefix)) {
				return true;
			}
		}
		return false;
	}
	
    // 역할 기반 권한 검사
	// 클라이언트의 요청경로와 role 정보를 넣어서 접근 가능한지 여부를 리턴하는 메소드
    private boolean isAuthorized(String path, String role) {
        if ("ROLE_ADMIN".equals(role)) {
            return true; // 모든 경로 접근 허용
        } else if ("ROLE_STAFF".equals(role)) {
        	// "/admin/"하위 경로를 제외한 모든 경로 접근 허용
            return !path.startsWith("/admin/");
        } else if ("ROLE_USER".equals(role)) {
        	// "/admin/"하위와 "/staff/" 경로를 제외한 모든 경로 접근 허용
            return !path.startsWith("/admin/") && !path.startsWith("/staff/");
        }
        return false; // unknown role
    }
}
