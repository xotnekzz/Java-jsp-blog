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
  
 <hr style="border: 1px solid #eeeeee;">
 <div class='left_menu1'>
  <div class='left_menu_title'>
   <strong>Category</strong>
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
  <div class='center_menu'>
  <div class='left_menu_title'> 
   <strong>Polpular Posts</strong> 
  </div>
  <nav class='left_menu_item'>   
  <% 
     ArrayList<DevdiaryVO> pop_devdiarys;
     pop_devdiarys = devdiaryProc.pop_read();   
      
    for(DevdiaryVO devdiary : pop_devdiarys) {  %>
   <a href='<%=root1%>/devdiary/read.jsp?devcateno=<%=devdiary.getDevcateno()%>&devdiaryno=<%=devdiary.getDevdiaryno()%>'><%=devdiary.getTitle_main() %><span style="font-size: 16px;">(<%=devdiary.getCnt() %>)</span></a><br><br>
   <% } 
    pop_devdiarys.clear(); // ArrayList 충돌 방지
   %> 
  </nav>
 </div>
   <div class='right_menu'>
  <div class='left_menu_title'> 
   <strong>Recent Posts</strong>
  </div>
  <nav class='left_menu_item'>   
  <% 
     ArrayList<DevdiaryVO> devdiarys = new ArrayList<DevdiaryVO>(); 
     devdiarys = devdiaryProc.recent_read();   
     
    for(DevdiaryVO devdiary : devdiarys) {  %>
   <a href='<%=root1%>/devdiary/read.jsp?devcateno=<%=devdiary.getDevcateno()%>&devdiaryno=<%=devdiary.getDevdiaryno()%>'><%=devdiary.getTitle_main() %><span style="font-size: 16px;">(<%=devdiary.getRdate() %>)</span> </a><br><br>
   <% }
    %>
  </nav>
 </div>  
<div style="clear: both"></div>
 <hr style="border: 1px solid #eeeeee;">
</body>
</html>