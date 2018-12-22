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
<title>회원 정보 변경</title>
<link href="../css/style.css" rel='Stylesheet' type='text/css'>
</head>
<body>
<DIV class='container'>
<DIV class='content' style='width: 100%;'>
 
  <DIV class='aside_menu'>
    <ASIDE style='float: left;'>회원 > 목록 > 회원 정보 변경</ASIDE> 
    <ASIDE style='float: right;'>
    </ASIDE> 
    <DIV class='menu_line' style='clear: both;'></DIV>
  </DIV>
 
<FORM name='frm' method='POST' action='./update_proc.jsp'>
  <input type='hidden' name='admin4no' value='<%=admin4no %>'>    
        
  <fieldset class='fieldset_no_line'>
    <ul>
      <li class='li_none'>
        <label for='mname' class='label_basic'>성명</label>
        <input type='text' name='mname' id='mname' value='<%=adminVO.getMname() %>'>
      </li>
      <li class='li_none'>
        <label for='email' class='label_basic'>이메일</label>
        <input type='email' name='email' id='email' value='<%=adminVO.getEmail() %>' style='width: 35%;' readonly="readonly" disabled="disabled">
        [변경 할 수 없습니다.] 
      </li>
      <li class='li_none'>
        <label for='tel' class='label_basic'>전화번호</label>
        <input type='text' name='tel' id='tel' value='<%=adminVO.getTel() %>'> 예) 0000-1111-1111
      </li>
      <li class='li_right'>
        <button type='submit'>회원 정보 수정 적용</button>
        <button type='button' onclick='window.close();'>취소</button>
        
      </li>
 
    </ul>
  </fieldset>
</FORM>
 
</DIV> <!-- content END -->
</DIV> <!-- container END -->
 
</body>
</html>
 