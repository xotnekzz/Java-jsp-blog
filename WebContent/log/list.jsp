<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="../admin4/auth.jsp" %>
<%@ page import="java.io.*" %>
 
<%
// 개발시: 프로젝트명, /travel_v1jq
// 서비스시: http://test.cafe24.com → /
String root = request.getContextPath();
%>
<!DOCTYPE html> 
<html lang="ko">  
<head> 
<meta charset="UTF-8"> 
<title>Log 목록</title> 
 
<link href="../css/style.css" rel="Stylesheet" type="text/css">
 
</head> 
 
<body>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='container'>
<jsp:include page="/menu/menu.jsp" flush='false' />
<DIV class='content'>
 
  <ASIDE style='float: left;'> Log </ASIDE>
  <ASIDE style='float: right;'>
    <A href='./list.jsp'>목록</A>
  </ASIDE> 
  <DIV class='menu_line' style='clear: both;'></DIV>
  <form name='frm' action='' method='POST'>
  <OL>
  <%
  // File folder = new File(".");
  // out.println(folder.getAbsolutePath()); // C:\iot1\eclipse_luna\. 
  String path = request.getServletContext().getRealPath("/log");
  // out.println(path); // C:\iot2\ws_web\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\travel_v1jq\WEB-INF\classes\web\tool 
  File folder = new File(path);
  // File[] files = folder.listFiles(); // 모든 파일 목록 추출
  
  // Filter를 이용한 txt 파일 목록만 추출 
  File[] files = folder.listFiles(new FilenameFilter(){
    @Override
    public boolean accept(File dir, String name){
      return name.endsWith(".txt");
    }
  }); 
  
  for(int index=0; index < files.length; index++){
    File file = files[index];
    String fname = file.getName(); // 순수 파일명
    %>
    <LI style='margin-left: 10%;'>
      <A href='./read.jsp?fname=<%=fname %>'><%=fname %></A>
    </LI>
    <%
  }
  
  %>
  </OL>
  </form>
 
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>
 
</html> 