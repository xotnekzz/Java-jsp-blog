%@ page contentType="text/html; charset=UTF-8" %>
 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>IT 관심분야</title>
 
<link href="../../../css/style.css" rel='Stylesheet' type='text/css'>
<script type="text/JavaScript"
        src="http://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script type="text/javascript">
window.onload = function() {
  history.pushState(null, null, location.href);
  window.onpopstate = function () {
      history.go(1);
  };
 
}
</script>
</head>
<body>
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'>
 
<DIV style='width: 60%; margin: 50px auto;'>
  <h1>IT 관심분야</h1>
  <H2>GRP1: <%=request.getParameter("grp1") %></H2>
  <H2>GRP2: <%=request.getParameter("grp2") %></H2>
  <H2>GRP3: <%=request.getParameter("grp3") %></H2>
  
</DIV>
 
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
 
</body>
</html>