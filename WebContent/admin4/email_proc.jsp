<%@ page contentType="text/html; charset=UTF-8" %>
 
<%@ include file="./ssi.jsp" %>
 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title></title>
<link href="../css/style.css" rel='Stylesheet' type='text/css'>
 
<script type="text/javascript">
  function use(email) {
    // opener: window.open() 함수를 호출한 브러우저 
    // document: 브러우저에 렌더링된 하나의 화면
    opener.document.frm.email.value = email;
    opener.document.frm.passwd.focus(); // 특정 태그로 마우스 커서를 보냄
    window.close(); // 현재 윈도우 닫기
    
  } 
</script>
  
</head>
<body>
<DIV class='container'>
<DIV class='content' style=' float: none;'>
 
  <DIV class='aside_menu'>
    <ASIDE style='float: left;'>관리자 > 가입 > 이메일 중복 확인</ASIDE> 
    <ASIDE style='float: right;'>
    </ASIDE> 
    <DIV class='menu_line' style='clear: both;'></DIV>
  </DIV>
 
  <FORM name='frm' method='POST' action='./email_proc.jsp'>
    <fieldset class='fieldset_no_line'>
      <ul>
        <li class='li_center'>
          <span class='span_title'>중복 이메일 검사 결과</span><br>
          <%
          String email = request.getParameter("email");
          int count = adminProc.countEmail(email); 
          %> 
          <br>
          검사된 EMAIL: <%=email %><BR><BR>
          <%
          if (count == 0){ // 중복 안됨
          %>
            <span class='span_info'>이메일이 중복되지 않습니다.</span><br>
            사용 가능합니다.
          <%
          }else{
          %>
            <span class='span_alert'>이메일이 중복됩니다.</span><br>
            이메일 검사를 다시 해주세요.
          <%  
          }
          %> 
        </li>
        <li class='li_right'>
          <%
          if (count == 0){
          %>
            <button type='button' onclick="use('<%=email %>')">사용</button> 
          <%
          }
          %>
          <button type='button' onclick="location.href='./email_form.jsp'">다시 검사</button> 
          <button type='button' onclick="window.close()">닫기</button>
        </li>
      </ul>
    </fieldset> 
  </FORM>
 
</DIV> <!-- content END -->
</DIV> <!-- container END -->
 
</body>
</html>
 