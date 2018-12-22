<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="./ssi.jsp" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title>회원 가입 메일 인증</title> 
 
<link href="../css/style.css" rel="Stylesheet" type="text/css">
 
</head> 
<body>
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' /> 
<DIV class='content'>
<DIV class='aside_menu'>
  <ASIDE style='float: left;'>관리자 ＞ 회원 가입 메일 인증</ASIDE> 
  <ASIDE style='float: right;'>
    <A href='./list.jsp'>목록</A> <span class='menu_divide'> |</span> 
  </ASIDE> 
  <ASIDE style='float: right;'>
  </ASIDE> 
  <DIV class='menu_line' style='clear: both;'></DIV>
</DIV>
 
<DIV class='title_box'>회원 가입 메일 인증</DIV>
 
<%
String email = request.getParameter("email"); 
String auth = request.getParameter("auth");
 
if (adminProc.confirm(email, auth) == 1){ // N -> Y
%>
  이메일 확인이 완료 되었습니다.<br><br>
  관리자 확인후 로그인 가능합니다.<br><br>
  회원으로 최종 등록시 등록 처리 관련 메일이 발송됩니다.<br><br>
  감사합니다.<br><br>
<%
}else{
%>
  이메일 확인에 실패습니다.<br><br>
  계속 문제가 발생하면 관리자에게 문의해주세요.<br><br>
  (☎ 0000-0000-0000)<br><br>
<%  
}
%>  
 
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>
</html> 
 