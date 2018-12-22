<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="./ssi.jsp" %>
 
<%
int admin4no = Integer.parseInt(request.getParameter("admin4no"));
String act = request.getParameter("act");  // 선택된 권한 
%>
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8">  
<title>권한 변경</title> 
</head>  
 
<body>
<DIV class='container'>
<DIV class='content'>
 
<%
adminProc.updateAct(admin4no, act);  
%>
<script type="text/javascript">
  opener.location.reload(); // window.open() 호출한 부모 윈도우 새로 고침
  window.close(); // 현재 창 닫기
</script>
 
</DIV> <!-- content END -->
</DIV> <!-- container END -->
</body>
</html> 
  