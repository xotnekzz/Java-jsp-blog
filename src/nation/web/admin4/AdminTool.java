package nation.web.admin4;
 
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
 
public class AdminTool {
  /**
   * 관리자 계정인지 검사합니다. 
   * @param request
   * @return true or false
   */
  public static synchronized boolean isAdmin(HttpServletRequest request){
    boolean sw = false;
    
    HttpSession session = request.getSession(); // java class에서 session 객체 추출
    String act = (String)session.getAttribute("act"); // 권한 산출
    
    if (act != null){
      if (act.equals("M") || act.equals("A")){ // 관리자
        sw = true;
      }
    }
    return sw;
  }
 
  /**
   * 마스터 계정인지 검사합니다.
   * @param request
   * @return true: 마스터 계정
   */
  public static synchronized boolean isMaster(HttpServletRequest request){
    boolean sw = false;
    
    HttpSession session = request.getSession();
    String act = (String)session.getAttribute("act"); // 역활
    // System.out.println("--> Tool.java act: " + act);
    
    if (act != null){
      if (act.equals("M")){ // 마스터인지 검사
        sw = true;
      }
    }
    return sw;
  }
  
}
 