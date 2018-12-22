<%@ page contentType="text/html; charset=UTF-8" %>
 
<%@ include file="./ssi.jsp" %>
 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title></title>
<link href="../css/style.css" rel='Stylesheet' type='text/css'>
</head>
<body>
<DIV class='container'>
<DIV class='content' style='float: none;'>
 
  <DIV class='aside_menu'>
    <ASIDE style='float: left;'>관리자 > 가입 > 이메일 중복 확인</ASIDE> 
    <ASIDE style='float: right;'>
    </ASIDE> 
    <DIV class='menu_line' style='clear: both;'></DIV>
  </DIV>
 
  <FORM name='frm' method='POST' action='./email_proc.jsp'>
    <fieldset class='fieldset_no_line'>
      <ul>
        <li class='li_none'> 
        <label for='email'>이메일</label>
        <input type='email' name='email' id='email' required="required" class='input_basic' style='width: 60%;' >
      </li>
      <li class='li_right'>
        <button type="submit">중복 조회</button>
        <button type='button' id='close' onclick="window.close();">닫기</button> 
      </li>
    </ul>
  </fieldset>
</FORM>
 
</DIV> <!-- content END -->
</DIV> <!-- container END -->
 
</body>
</html>