<%@ page contentType="text/html; charset=UTF-8" %>
 
<%@ include file="./ssi.jsp" %>
 
<%
int admin4no = Integer.parseInt(request.getParameter("admin4no"));
 
Admin4VO adminVO = adminProc.read(admin4no);
 
String email = adminVO.getEmail();
%>
  
<!DOCTYPE html> 
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>회원 정보 삭제</title>
<link href="../css/style.css" rel='Stylesheet' type='text/css'>
</head>
<body>
<DIV class='container'>
<DIV class='content'>
 
  <DIV class='aside_menu'>
    <ASIDE style='float: left;'>회원 > 목록 > 회원 정보 삭제</ASIDE> 
    <ASIDE style='float: right;'>
    </ASIDE> 
    <DIV class='menu_line' style='clear: both;'></DIV>
  </DIV>
 
<FORM name='frm' method='POST' action='./delete_proc.jsp'>
  <input type='hidden' name='admin4no' value='<%=admin4no %>'>    
        
  <fieldset class='fieldset_no_line'>
    <ul>
      <li class='li_none'>
        <span class='span_alert'>회원 탈퇴시 복구 할 수 없습니다.</span>
        <br><br>
        <span class='span_alert'>회원 탈퇴를 계속 하시려면 [탈퇴 진행] 버튼 눌러주세요.</span>
        <br>
        삭제할 이메일: <%=email %>
      </li>
      <li class='li_right'>
        <button type="submit">탈퇴 진행</button>
        <button type='button' id='close' onclick="window.close();">취소(닫기)</button> 
      </li>
    </ul>
  </fieldset>
</FORM>
 
</DIV> <!-- content END -->
</DIV> <!-- container END -->
 
</body>
</html>