<%@ page contentType="text/html; charset=UTF-8" %>
 
<%@ include file="./ssi.jsp" %>
 
<jsp:useBean id="admin4VO" class="nation.web.admin4.Admin4VO" />
<jsp:setProperty property="*" name="admin4VO" />
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
 
<link href="../css/style.css" rel="Stylesheet" type="text/css">
<script type="text/javascript" src="../js/tool.js"></script>
</head> 
<body> 
<DIV class='container'>
<DIV class='content'> 
  
<%
if (adminProc.update(admin4VO) == 1){ 
%>
  <script type="text/javascript">
    opener.location.reload();  // 하단에 있는 부모 윈도우 refresh
    // window.close();  // 현재 윈도우 닫기
  </script>
  회원 정보를 변경했습니다.
<%  
}else{
%>
  회원 정보를 변경하지 못했습니다.<br><br>
  다시 시도해주세요.<br><br>
<%
}
%>
 
<DIV class='bottom_menu'>
  <button type='button' onclick="location.href='./update_form.jsp?admin4no=<%=admin4VO.getAdmin4no() %>'">변경 확인</button>
  <button type='button' onclick="window.close();">닫기</button>
</DIV>
 
</DIV> <!-- content END -->
</DIV> <!-- container END -->
</body>
</html> 
  