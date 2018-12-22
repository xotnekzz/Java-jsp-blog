<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="./ssi.jsp" %>
 
<%
int admin4no = Integer.parseInt(request.getParameter("admin4no"));
String passwd = request.getParameter("passwd");
String new_passwd = request.getParameter("new_passwd");
%>
<!DOCTYPE html>  
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title>패스워드 변경</title> 
 
<link href="../css/style.css" rel="Stylesheet" type="text/css">
 
</head>  
 
<body>
<DIV class='container'>
<DIV class='content'>
  <DIV class='aside_menu'>
    <ASIDE style='float: left;'>관리자 > 목록 > 패스워드 변경</ASIDE> 
    <ASIDE style='float: right;'>
    </ASIDE> 
    <DIV class='menu_line' style='clear: both;'></DIV>
  </DIV>
   
<% 
// 기존 패스워드 일치 여부 검사
if (adminProc.countPasswd(admin4no, passwd) == 1){
  // 새로운 패스워드로 변경
  if (adminProc.updatePasswd(admin4no, new_passwd) == 1){
  %>
    <br>
    패스워드를 변경하였습니다.
    <br> 
  <%  
  };
}else{
%>
  기존 패스워드가 일치하지 않습니다.<br><br>
  다시 시도해주세요.<br><br>
<%
} 
%>
</DIV>
 
<DIV class='bottom_menu'>
  <button type='button' onclick="location.href='./passwd_form.jsp?admin4no=<%=admin4no %>'">새로운 패스워드로 재변경</button>
  <button type='button' onclick="window.close()">닫기</button>
</DIV>
 
</DIV> <!-- content END -->
</DIV> <!-- container END -->
</body> 
 
</html> 
 