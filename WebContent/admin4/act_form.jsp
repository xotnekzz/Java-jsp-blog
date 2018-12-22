<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="./ssi.jsp" %>
 
<%
int admin4no = Integer.parseInt(request.getParameter("admin4no"));
String act = request.getParameter("act");
%>
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title>권한 변경</title> 
 
<link href="../css/style.css" rel="Stylesheet" type="text/css">
 
</head> 
 
<body>
<DIV class='container'>
<DIV class='content'>
  <DIV class='aside_menu'>
    <ASIDE style='float: left;'>관리자 > 목록 > 권한 변경</ASIDE> 
    <ASIDE style='float: right;'>
    </ASIDE> 
    <DIV class='menu_line' style='clear: both;'></DIV>
  </DIV>
 
<FORM name='frm' method='POST' action='./act_proc.jsp'>
  <input type='hidden' name='admin4no' value='<%=admin4no %>'>
  <fieldset class='fieldset_no_line'>
    <ul>
      <li class='li_none'>
        <label>
          <input type='radio' name='act' id='act1' value='M' <%=(act.equals("M"))?"checked='checked'":"" %>>
          M: 마스터
        </label>
      </li>
      <li class='li_none'>
        <label>
          <input type='radio' name='act' id='act2' value='A'  <%=(act.equals("A"))?"checked='checked'":"" %>>
          A: 관리자
        </label>
      </li>      
      <li class='li_none'>
        <label>
          <input type='radio' name='act' id='act3' value='Y'  <%=(act.equals("Y"))?"checked='checked'":"" %>>
          Y: 일반 유저
        </label>
      </li>      
      <li class='li_none'>
        <label>
          <input type='radio' name='act' id='act4' value='N'  <%=(act.equals("N"))?"checked='checked'":"" %>>
          N: 로그인 불가
        </label>
      </li>
      <li class='li_none'>
        <label>
          <input type='radio' name='act' id='act5' value='H'  <%=(act.equals("H"))?"checked='checked'":"" %>>
          H: 보류(신규 가입)
        </label>      
      </li>            
      <li class='li_right'>
        <button type="submit">권한 변경 적용</button>
        <button type='button' onclick="window.close();">닫기</button> 
      </li>
    </ul>
  </fieldset>
</FORM>
 
</DIV> <!-- content END -->
</DIV> <!-- container END -->
</body>
 
</html> 