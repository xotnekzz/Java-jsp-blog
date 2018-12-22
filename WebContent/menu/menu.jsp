<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="./ssi.jsp" %>
<%
String root1 = request.getContextPath();
%> 
<% 
request.setCharacterEncoding("utf-8"); 
%>
 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/style.css" rel='Stylesheet' type='text/css'>
</head>
<body> 
<!-- 화면 상단 메뉴 -->
 <div class='left_menu'>
  <div class='left_menu_title'>
   <strong>Category </strong>
  </div>  
  <nav class='left_menu_item'>
  <% if(session.getAttribute("email") != null){ %>
   <a href='<%=root%>/notice4/list.jsp'>공지사항</a><br><br>
  <%} else { %>
   <a href='<%=root%>/notice4/guest_list.jsp'>공지사항</a><br><br>
  <% 
     }
     ArrayList<DevcategoryVO> categorys = new ArrayList<DevcategoryVO>(); 
     categorys = devcategoryProc.c_list();  
  		
  for(DevcategoryVO devcategory : categorys) {  %>
   <a href='<%=root1%>/devdiary/list.jsp?devcateno=<%=devcategory.getDevcateno()%>' ><%=devcategory.getTitle() %></a><br><br>
   <% } %>
  </nav>
 </div>
</body>
</html>