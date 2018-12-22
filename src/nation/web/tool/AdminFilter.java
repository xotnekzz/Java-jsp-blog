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
    // /WEB-INF/web.xml������ <init-param>�±��� ��
    charSet = config.getInitParameter("charSet");
 
    System.out.println("������������������������");
    System.out.println(" Admin Filter start...");
    System.out.println("������������������������");
  }
 
  // ��û�� ���� �ڵ� ����
  public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain chain)
      throws IOException, ServletException {
 
    HttpServletRequest request = (HttpServletRequest) servletRequest;
    HttpServletResponse response = (HttpServletResponse) servletResponse;
 
    // ------------------------------------------------------------------------------
    // session�� ��� ��
    // ------------------------------------------------------------------------------
    // ���ο� ������ ���������ʰ� ������ ���� ��ü�� ��ȯ
    HttpSession session = request.getSession(true);
    // System.out.println("session: " + session);
    // ------------------------------------------------------------------------------
 
    // �ѱ� ���ڼ� ����
    request.setCharacterEncoding(charSet);
 
    // ��û uri ���� �κ�, �������� ������ �ּ�
    String uri = request.getRequestURI();
    String act = (String) session.getAttribute("act"); // ����
    if (act == null) {
      act = "N"; // ���� �Ұ�
    }
 
    // ������Ʈ ��ü�� ������� ������ �����ڸ� ���� ����
    // if ("M".indexOf(act) == -1) {
    // response.sendRedirect(request.getContextPath() +
    // "/admin1/login_ck_form.jsp");
    // }
 
    // ������Ʈ ��ü�� ������� ������ �� �Ϲ� �����ڸ� ���� ����
    // if ("MY".indexOf(act) == -1) {
    // response.sendRedirect(request.getContextPath() +
    // "/admin1/login_ck_form.jsp");
    // }
 
    // ----------------------------------------------------------------------------
    // ��û�� �ּҷ� �ڵ� �̵� ����
    // ----------------------------------------------------------------------------
    String url = request.getRequestURL().toString();
    System.out.println("--> url: " + url);
    // --> url: http://localhost:9090/blog_v3jq/admin4/list.jsp
 
    // <Input> �±��� 'name' �Ӽ��� ���� ���������� �����մϴ�.
    Enumeration<String> enumeration = request.getParameterNames();
    String params = "";
 
    while (enumeration.hasMoreElements()) { // ��Ұ� �ִ��� �˻�
      // System.out.println("-->" + enumeration.nextElement());
      String name = enumeration.nextElement(); // �� �±��� <Input> �±��� 'name' �Ӽ� ��
      String value = request.getParameter(name); // �� �±��� <Input> �±��� 'value' �Ӽ� ��
      params = params + name + "=" + value + "&"; // �Ķ���� ����
      System.out.println("--> params: " + params);
    }
 
    String url_address = request.getRequestURL() + "?" + params;
    System.out.println("--> 1) auth.jsp: url_address: " + url_address);
    // --> 1) auth.jsp: url_address:
    // http://localhost:9090/travel_v1jq/admin1/update_form.jsp?admin1no=2&email=test1@mail.com&
    url_address = URLEncoder.encode(url_address, "UTF-8"); // �ѱ� 1����Ʈ �ڵ�� ��ȯ
    System.out.println("--> 2) auth.jsp: url_address: " + url_address);
    // --> 2) auth.jsp: url_address:
    // http%3A%2F%2Flocalhost%3A9090%2Fadmin_v1jq%2Fadmin1%2Fupdate_form.jsp%3Fadmin1no%3D2%26email%3Dtest1%40mail.com%26
    // ----------------------------------------------------------------------------
 
    // '/log/' ������ ������� �����ڸ� ���� ����
    if (uri.indexOf("/log/") >= 0) {
      if ("M".indexOf(act) == -1) {
        response.sendRedirect(request.getContextPath() + "/admin4/login_ck_form.jsp?url_address=" + url_address);
      }
    } 
  
/*   // /storage/ ������ ���ؼ� ������, ���� �� ������(Guest)�� ���� ����
    if (uri.indexOf("/storage/") >= 0) {
      if ("MY".indexOf(act) == -1) {
        response.sendRedirect(request.getContextPath() + "/admin4/login_ck_form.jsp?url_address=" + url_address);
      }
    } */
    
       
    // �ٸ� ���� ����, ��û JSP ����
    chain.doFilter(request, response);
 
  }
  
  @Override
  public void destroy() {
 
  }
 
}   