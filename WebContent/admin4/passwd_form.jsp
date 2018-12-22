<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="./ssi.jsp" %>
 
<%
int admin4no = Integer.parseInt(request.getParameter("admin4no"));
%>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title> 패스워드 변경</title> 
 
<link href="../css/style.css" rel="Stylesheet" type="text/css">
<script type="text/javascript">
function send(f) {
  if (f.new_passwd.value == f.new_passwd2.value) {
    return true; // 서브밋 진행
  } else {
    alert('새로운 패스워드가 일치하지 않습니다.');
    f.new_passwd.value='';  // <input type='password' name='new_passwd' 
    f.new_passwd2.value='';
    f.new_passwd.focus(); // 커서 이동
    
    return false; // 서브밋 중지
  }
}
</script>
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
  
<FORM name='frm' method='POST' action='./passwd_proc.jsp'
           onsubmit="return send(this)">
  <input type='hidden' name='admin4no' value='<%=admin4no %>'>    
        
  <fieldset class='fieldset_no_line'>
    <ul>
      <li class='li_none'>
        <label for='passwd'  class='label_basic' style='width: 250px;'>기존 패스워드</label>
        <input type='password' name='passwd' id='passwd' required="required">
      </li>
      <li class='li_none'>
        <label for='new_passwd'  class='label_basic' style='width: 250px;'>새로운 패스워드</label>
        <input type='password' name='new_passwd' id='new_passwd' required="required">
      </li>
      <li class='li_none'>
        <label for='new_passwd2'  class='label_basic' style='width: 250px;'>새로운 패스워드 확인</label>
        <input type='password' name='new_passwd2' id='new_passwd2' required="required">
      </li>
      <li class='li_right'>
        <button type="submit">패스워드 변경</button>
        <button type='button' id='close' onclick="window.close()">닫기</button> 
      </li>
    </ul>
  </fieldset>
</FORM>
 
</DIV> <!-- content END -->
</DIV> <!-- container END -->
</body>
 
</html> 