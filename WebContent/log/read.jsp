<%@ page contentType="text/html; charset=UTF-8" %>
 
<%@ page import ="java.io.File" %>
<%@ page import ="java.io.BufferedReader" %>
<%@ page import ="java.io.InputStreamReader" %>
<%@ page import ="java.io.FileInputStream" %>
 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Log 읽기</title>
 
<link href="../css/style.css" rel='Stylesheet' type='text/css'>
 
</head>
<body>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='container'>
<jsp:include page="/menu/menu.jsp" flush='false' />
<DIV class='content'>
<%
String fname = request.getParameter("fname");
String fname_abs = application.getRealPath("/log/" + fname);
File file = new File(fname_abs);
 
BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(file), "euc-kr"));
String line = null;
 
while(true) {
  line = br.readLine();  // 파일에서 한 라인씩 읽기
  if (line == null) { // 파일의 마지막인지 검사
    break;
  } else {
    System.out.println(line); // 화면 출력
%>
  <%=line %><br>
<%    
  }
}
 
br.close();
%>
 
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
 
</body>
</html>
 
 