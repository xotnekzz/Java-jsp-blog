<%@page import="nation.web.admin4.Admin4VO"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="./ssi.jsp" %>
 
<jsp:useBean id="admin4VO" class="nation.web.admin4.Admin4VO"></jsp:useBean>
<jsp:setProperty property="*" name="admin4VO"/> 

<%
//String email = request.getParameter("email");
//String passwd = request.getParameter("passwd");
String auth = adminProc.key(); // ABC012345678901234
%> 
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
  
<link href="../css/style.css" rel="Stylesheet" type="text/css">
 
</head> 
<body>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='container'>
<jsp:include page="/menu/menu.jsp" flush='false' />
<DIV class='content'>
 
<DIV class='aside_menu'>	
  <ASIDE style='float: left;'>관리자 ＞ 등록</ASIDE> 
  <ASIDE style='float: right;'>
    <A href='./list.jsp'>목록</A> <span class='menu_divide'> |</span> 
  </ASIDE> 
  <ASIDE style='float: right;'>
  </ASIDE> 
  <DIV class='menu_line' style='clear: both;'></DIV>
</DIV>
 
<FORM name='frm' method='POST' action='./.jsp'>
  <fieldset class='fieldset_no_line'>
    <ul>
      <li class='li_none'>
      <% 
   //   Admin4VO admin4VO = new Admin4VO();
  //    admin4VO.setEmail(email); 
  //    admin4VO.setPasswd(passwd);
      admin4VO.setAuth(auth);  // 고유한 인증키
       
      if (adminProc.isMaster() == true){ // 마스터 계정이 이미 존재한다면
        admin4VO.setAct("H");        // H: Hold, 관리자가 승인이 필요함.
        admin4VO.setConfirm("N"); // 메일 확인 안됨. 
      } else { %>
      <div style="text-align: center;">
      <%
        out.println("최초 등록 계정임으로 Master 계정입니다.<br>");
        admin4VO.setAct("M");       // 최고 관리자 지정
        admin4VO.setConfirm("Y"); //  최고 관리자임으로 메일 확인 처리
      }
       
      int count = adminProc.insert(admin4VO);
      
      if(admin4VO.getConfirm().equals("Y")){ // 최고관리자일 경우 메일 확인 처리
        if (count == 1){
          %>
            등록에 성공 했습니다.<br><br>
            <a href='../index.jsp'>메인페이지로 돌아가기</a>
            </div>
          <%  
          } else {
          %>
            관리자 등록에 실패했습니다. 계속 오류시 담당자에게 문의하세요.<br>
          <%  
          }
      } else { // 최고관리자가 아니므로 이메일 등록 
       if (count == 1){
       %>
         등록에 성공 했습니다.<br>
         전송된 이메일 링크를 클릭해야 관리자 등록이 종료됩니다.<br><br>
       <%  
       } else {
       %>
         관리자 등록에 실패했습니다. 계속 오류시 담당자에게 문의하세요.<br>
       <%  
       }
      }
      %>
      </li>
      <li class='li_none'>
<% 
// javamail lib 이 필요합니다.
class MyAuthentication extends Authenticator {
  PasswordAuthentication pa; 
  public MyAuthentication(){
    pa = new PasswordAuthentication("test@nulunggi.pe.kr", "test2016");
  }
 
  public PasswordAuthentication getPasswordAuthentication() {
    return pa;
  }
}

if(admin4VO.getConfirm().equals("N")){ // 최고관리자가 아닌 경우 메일 발송
String subject = "Blog 관리자 메일 인증입니다.";  // 제목
String content = "메일 인증<br><br>";  // 내용
content += "아래의 링크를 클릭하면 가입이 완료됩니다.<br><br>";
// http://172.16.7.100:9090/blog_v3jq/admin4/confirm.jsp?email=testcell2013@gmail.com&auth=ABC1234567890
 
content += "http://172.16.7.100:9090/blog_v3jq/admin4/confirm.jsp?email=" + admin4VO.getEmail() + "&auth=" + admin4VO.getAuth();
 
// mw-002.cafe24.com, Cafe24
String host = "mw-002.cafe24.com";    // smtp mail server(서버관리자)     
String from = "testcell2013@gmail.com";   // 보내는 주소, 블로그 관리자 주소
String to = admin4VO.getEmail();    // 받는 사람
 
Properties props = new Properties();  // SMTP 프로토콜 사용, port 25
props.put("mail.smtp.host", host);
props.put("mail.smtp.auth","true");
 
Authenticator authenticator = new MyAuthentication();
Session sess = Session.getInstance(props, authenticator);   // 계정 인증 검사
 
try {
  Message msg = new MimeMessage(sess);   // 메일 내용 객체 생성
  msg.setFrom(new InternetAddress(from));   // 보내는 사람 설정
        
  // 한명에게만 보냄
  InternetAddress[] address = {new InternetAddress(to)}; // 받는 사람 설정
  
  msg.setRecipients(Message.RecipientType.TO, address); // 수령인 주소 설정
        
  msg.setSubject(subject);                  // 제목 설정 
  msg.setSentDate(new Date());          // 보낸 날짜 설정
        
  // msg.setText(msgText); // 메일 내용으로 문자만 보낼 경우
 
  // 보내는 내용으로 HTML 형식으로 보낼 경우
  msg.setContent(content, "text/html;charset=utf-8");
        
  Transport.send(msg);  // 메일 전송
 
  out.println("<u>인증 메일이 '"+admin4VO.getEmail()+"'로 발송되었습니다.</u><br><br>");
  out.println("<u>메일을 열고 링크를 클릭해주세요.</u><br>");
  
} catch (MessagingException mex) {
  System.out.println(mex.getMessage());
  // out.println(mex.getMessage()+"<br><br>");
  // out.println(to + "님에게 메일 발송을 실패 했습니다.");
}
}
%>
      </li>
    </ul>
  </fieldset>
</FORM> 
 
 
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>
</html> 
 