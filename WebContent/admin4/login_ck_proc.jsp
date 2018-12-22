<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="./ssi.jsp" %>
 
<%
//로그인 후 이동할 주소
String url_address = Tool.checkNull(request.getParameter("url_address"));
System.out.println("--> 4) login_proc.jsp: url_address: " + url_address);
 
String email = request.getParameter("email");
// Checkbox를 체크를안하고 넘어오면 null 값을 가지고 있게됨.
String email_save = Tool.checkNull(request.getParameter("email_save"));
String passwd = request.getParameter("passwd");
//Checkbox를 체크를안하고 넘어오면 null 값을 가지고 있게됨.
String passwd_save = Tool.checkNull(request.getParameter("passwd_save"));
%>
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title>로그인</title> 
 
<link href="../css/style.css" rel="Stylesheet" type="text/css">
<script type="text/javascript" src="../js/tool.js"></script>
</head> 
 
<body>
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'>
 
<DIV class='aside_menu'>
  <ASIDE style='float: left;'>회원 ＞ 로그인 </ASIDE> 
  <ASIDE style='float: right;'>
    <A href='./list.jsp'>목록</A> <span class='menu_divide'> |</span> 
    <A href='./create_form.jsp'>가입</A> <span class='menu_divide'> |</span>
    <A href='javascript: location.reload()'>새로고침</A> <span class='menu_divide'> |</span>
  </ASIDE> 
  <ASIDE style='float: right;'>
  </ASIDE> 
  <DIV class='menu_line' style='clear: both;'></DIV>
</DIV>
 
 
  <fieldset class='fieldset_no_line'>
    <ul>
      <li class='li_center'> 
        <%
        int count = adminProc.login(email, passwd); 
        // System.out.println("--> count: " + count);
        int cookie_time = 60 * 60 * 24 * 3; // 3일 (60*60 1시간  * 24시간  * 3일)
        
        if (count == 1){
          String act = adminProc.read(email).getAct();  
          if ("MAY".indexOf(act) >= 0){ // 로그인 권한 있음. M: Master, A: 관리자  Y:일반 회원
            
            // Session 저장
            // ------------------------------------------------------------------
            session.setAttribute("email", email);
            session.setAttribute("passwd", passwd);
            session.setAttribute("act", act);
            session.setMaxInactiveInterval(20*60);
            // ------------------------------------------------------------------
         
            // email 저장 관련 쿠키 저장 
            // ------------------------------------------------------------------
            if (email_save.equals("Y")){ // 이메일 저장 할 경우
              Cookie ck_email = new Cookie("ck_email", email); // 이메일 저장
              ck_email.setMaxAge(cookie_time); // 초
              response.addCookie(ck_email);  
              
            }else{ // 이메일 저장하지 않을 경우
              Cookie ck_email = new Cookie("ck_email", ""); // 이메일 삭제
              ck_email.setMaxAge(0); // 초
              response.addCookie(ck_email);
              
            }
            
            // 이메일 저장 여부를 결정하는 쿠기 기록, Y or "" 저장
            Cookie ck_email_save = new Cookie("ck_email_save", email_save);
            ck_email_save.setMaxAge(cookie_time); // 초
            response.addCookie(ck_email_save);
            // ------------------------------------------------------------------
         
            // passwd 저장 관련 쿠키 저장
            // ------------------------------------------------------------------
            if (passwd_save.equals("Y")){ // 패스워드 저장 할 경우
              Cookie ck_passwd = new Cookie("ck_passwd", passwd); // 이메일 저장
              ck_passwd.setMaxAge(cookie_time); // 초
              response.addCookie(ck_passwd);
              
            }else{ // 패스워드를 저장하지 않을 경우
              Cookie ck_passwd = new Cookie("ck_passwd", ""); // 패스워드 삭제
              ck_passwd.setMaxAge(0); // 초
              response.addCookie(ck_passwd);
              
            }
            
            // 패스워드 저장 여부를 결정하는 쿠기 기록, Y or "" 저장
            Cookie ck_passwd_save = new Cookie("ck_passwd_save", passwd_save);
            ck_passwd_save.setMaxAge(cookie_time); // 초
            response.addCookie(ck_passwd_save);
            // ------------------------------------------------------------------
             Log.w(request, email + " 계정 로그인됨");  
         
            if (url_address.length() > 0) { // 자동으로 이동할 주소가 존재하는지 확인
              response.sendRedirect(url_address);
            } else {
              response.sendRedirect(root +"/index.jsp");
              
            }
            
          }else{
            count = 0;
          %>
            현재 계정이 사용 불가합니다.<br><br>
            관리자에게 문의해주세요.<br><br>
          <%  
          }
        }else{
        %>
          로그인 아이디와 패스워드가 일치하지 않습니다.<br>
          확인후 다시 로그인해주세요.<br>
        <%
        }
        %> 
      </li>
      <li class='li_center'>
      <%
      if (count == 0){
      %>
        <button type='button' onclick="history.back();">다시 시도</button>
        <button type='button' onclick="location.href='./create_form.jsp'">회원 가입</button>
        <button type='button' onclick="location.href='../index.jsp';">홈페이지</button>
       <%
      }
      %>
      </li>
    </ul>
  </fieldset>
 
 
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>
</html> 