  <%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="./ssi.jsp" %>
 
<%
// 로그인 후 이동할 주소
String url_address = Tool.checkNull(request.getParameter("url_address"));
System.out.println("--> 3) login_form.jsp: url_address: " + url_address);
%>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title>로그인</title> 
 
<link href="../css/style.css" rel="Stylesheet" type="text/css">
</head> 
<body>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='container'>
<jsp:include page="/menu/menu.jsp" flush='false' />
<DIV class='content'>
 
<DIV class='aside_menu' >
  <ASIDE style='float: left;'>관리자 ＞ 로그인 </ASIDE> 
  <ASIDE style='float: right;'>
    <A href='./list.jsp'>목록</A> <span class='menu_divide'> |</span>  
    <A href='./create_form.jsp'>가입</A> <span class='menu_divide'> |</span>
    <A href='javascript: location.reload()'>새로고침</A> <span class='menu_divide'> |</span>
  </ASIDE> 
  <ASIDE style='float: right;'>
  </ASIDE> 
  <DIV class='menu_line' style='margin-bottom: 90px;'></DIV>
</DIV>
    
<DIV style='width: 50%; margin: 10px auto;'>
<FORM name='frm' method='POST' action='./login_proc.jsp'>
  <input type="hidden" name="url_address" value="<%=url_address %>">
  
  <fieldset class='fieldset_no_line'>
    <ul>
      <li class='li_none'>
        <label class='label_basic' style='width: 20%;' for='email'>이메일</label>
        <input type='email' name='email' id='email'  value='xotnekzz@naver.com' style='width: 50%;'>
      </li>
      <li class='li_none'>
        <label class='label_basic' style='width: 20%;' for='passwd'>패스워드</label>
        <input type='password' name='passwd' id='passwd' value='123'  style='width: 50%;'>
      </li>
      <li class='li_center'>
        <button type='submit'>로그인</button>
        <button type='button' onclick="history.back();">취소</button>
        
      </li>
    </ul>
  </fieldset>
</FORM>
</DIV>
 
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>
 
</html> 