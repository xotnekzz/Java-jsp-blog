package nation.web.tool;
 
import java.io.IOException;
import java.net.URLEncoder;
import java.util.Enumeration;
 
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 
public class AdminFilter implements Filter {
  private String charSet = null;
  private DBOpen dbopen = null;
  private DBClose dbclose = null;
 
  public AdminFilter() {
    dbopen = new DBOpen();
    dbclose = new DBClose();
  }
 
  @Override
  public void init(FilterConfig config) throws ServletException {
    // /WEB-INF/web.xml파일의 <init-param>태그의 값
    charSet = config.getInitParameter("charSet");
 
    System.out.println("────────────");
    System.out.println(" Admin Filter start...");
    System.out.println("────────────");
  }
 
  // 요청이 오면 자동 실행
  public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain chain)
      throws IOException, ServletException {
 
    HttpServletRequest request = (HttpServletRequest) servletRequest;
    HttpServletResponse response = (HttpServletResponse) servletResponse;
 
    // ------------------------------------------------------------------------------
    // session의 사용 ★
    // ------------------------------------------------------------------------------
    // 새로운 세션을 생성하지않고 기존의 세션 객체를 반환
    HttpSession session = request.getSession(true);
    // System.out.println("session: " + session);
    // ------------------------------------------------------------------------------
 
    // 한글 문자셋 변경
    request.setCharacterEncoding(charSet);
 
    // 요청 uri 추출 부분, 도메인을 제거한 주소
    String uri = request.getRequestURI();
    String act = (String) session.getAttribute("act"); // 권한
    if (act == null) {
      act = "N"; // 접근 불가
    }
 
    // 웹사이트 전체를 대상으로 마스터 관리자만 접근 가능
    // if ("M".indexOf(act) == -1) {
    // response.sendRedirect(request.getContextPath() +
    // "/admin1/login_ck_form.jsp");
    // }
 
    // 웹사이트 전체를 대상으로 마스터 및 일반 관리자만 접근 가능
    // if ("MY".indexOf(act) == -1) {
    // response.sendRedirect(request.getContextPath() +
    // "/admin1/login_ck_form.jsp");
    // }
 
    // ----------------------------------------------------------------------------
    // 요청된 주소로 자동 이동 구성
    // ----------------------------------------------------------------------------
    String url = request.getRequestURL().toString();
    System.out.println("--> url: " + url);
    // --> url: http://localhost:9090/blog_v3jq/admin4/list.jsp
 
    // <Input> 태그의 'name' 속성의 값을 열거형으로 추출합니다.
    Enumeration<String> enumeration = request.getParameterNames();
    String params = "";
 
    while (enumeration.hasMoreElements()) { // 요소가 있는지 검사
      // System.out.println("-->" + enumeration.nextElement());
      String name = enumeration.nextElement(); // 폼 태그의 <Input> 태그의 'name' 속성 값
      String value = request.getParameter(name); // 폼 태그의 <Input> 태그의 'value' 속성 값
      params = params + name + "=" + value + "&"; // 파라미터 조합
      System.out.println("--> params: " + params);
    }
 
    String url_address = request.getRequestURL() + "?" + params;
    System.out.println("--> 1) auth.jsp: url_address: " + url_address);
    // --> 1) auth.jsp: url_address:
    // http://localhost:9090/travel_v1jq/admin1/update_form.jsp?admin1no=2&email=test1@mail.com&
    url_address = URLEncoder.encode(url_address, "UTF-8"); // 한글 1바이트 코드로 변환
    System.out.println("--> 2) auth.jsp: url_address: " + url_address);
    // --> 2) auth.jsp: url_address:
    // http%3A%2F%2Flocalhost%3A9090%2Fadmin_v1jq%2Fadmin1%2Fupdate_form.jsp%3Fadmin1no%3D2%26email%3Dtest1%40mail.com%26
    // ----------------------------------------------------------------------------
 
    // '/log/' 폴더만 대상으로 관리자만 접근 가능
    if (uri.indexOf("/log/") >= 0) {
      if ("M".indexOf(act) == -1) {
        response.sendRedirect(request.getContextPath() + "/admin4/login_ck_form.jsp?url_address=" + url_address);
      }
    } 
  
/*   // /storage/ 폴더에 한해서 관리자, 정상 웹 접근자(Guest)만 접근 가능
    if (uri.indexOf("/storage/") >= 0) {
      if ("MY".indexOf(act) == -1) {
        response.sendRedirect(request.getContextPath() + "/admin4/login_ck_form.jsp?url_address=" + url_address);
      }
    } */
    
       
    // 다른 필터 실행, 요청 JSP 실행
    chain.doFilter(request, response);
 
  }
  
  @Override
  public void destroy() {
 
  }
 
}   