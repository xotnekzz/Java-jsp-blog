<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="./ssi.jsp" %>

   
<%
devcategoryProc = new DevcategoryProc();
%>
 
<%
root = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="ko">  
<head>
<meta charset="UTF-8"> 
<title>Insert title here</title>
<style type="text/css">
  
  .site_header {
    border-bottom: 1px solid #eeeeee;
    height: 55px;
    position: fixed;
    top: 0;
    width: 100%;
    background-color: #ffffff;
    z-index: 10;
  }
  
  .header_title {
    style='text-align: left';
    padding: 15px;
    float: left;
  }
  
   .top_menu {
 	margin-top: 15px;
 	margin-right: 10px;
 	float: right;
 }
  
</style>
</head>
<body>
<!-- 화면 상단 메뉴 -->
 <header class='site_header'>
  <div class="header_title">
      <A class='menu_link' href='<%=root %>/index.jsp'>Developer`s Note</A></div>
      <!-- 화면 상단 메뉴 --> 
	<DIV class='top_menu'>
 	 <NAV class='top_menu_list'> 
 	   <A class='menu_link' href='<%=root %>/index.jsp'>HOME</A><span class='top_menu_sep'> | </span>
<%
		 if(session.getAttribute("email") == null){ // 비로그인 상 태
		%>
 	   <A class='menu_link' href='<%=root %>/admin4/agreement.jsp'>Join</A><span class='top_menu_sep'> | </span>
 	   <A class='menu_link'  href='<%=root %>/admin4/login_form.jsp'>Login</A>
 	   <%
		 } else { // 로그인 상태
	    if (AdminTool.isAdmin(request)) {
 	   %>
  	    [<%=session.getAttribute("email") %>]
  	    <A class='menu_link'  href='<%=root %>/devcategory/list.jsp'>Category</A>
  	    <span class='top_menu_sep'> | </span>
    
 	   <% 
	    
	    if (AdminTool.isMaster(request)) {
	    %>
  	    <A class='menu_link'  href='<%=root %>/admin4/list.jsp'>Member</A>
 	    <span class='top_menu_sep'> | </span>
 	    <A class='menu_link'  href='<%=root %>/log/list.jsp'>Log</A>
 	    <span class='top_menu_sep'> | </span>
   	   <%
 	    }
	   %>
  	  <%
  	  } else { 
	    %>
 	   <%  
 	    }
		 %>
	    <A class='menu_link'  href='<%=root %>/admin4/logout_proc.jsp'>Logout</A>
		 <%
		 }
	    %> 
	  </NAV>
	</DIV>
 </header>
 <div>  
  <img src='<%=request.getContextPath() %>/menu/images/mini.jpg' style='width: 100%; height: 400px'>
 </div>
  
 
</body>
</html>