<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="./ssi.jsp" %>
 
<%
int admin4no = Integer.parseInt(request.getParameter("admin4no"));
%>
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
 
<link href="../css/style.css" rel="Stylesheet" type="text/css">
 
</head> 
<body>
<DIV class='container'>
<DIV class='content'>
 
<%
if (adminProc.delete(admin4no) == 1){
%>
  <script type="text/javascript">
    opener.location.reload();
  </script>
  회원 정보를 탈퇴 처리했습니다.
<%  
}else{ 
%>
  회원 정보를 삭제하지 못했습니다.<br><br>
  다시 시도해주세요.<br><br>
<%
}
%>
 
<DIV class='bottom_menu'>
  <button type='button' onclick="window.close();">닫기</button>
</DIV>
</DIV> <!-- content END -->
</DIV> <!-- container END -->
</body>
</html> 