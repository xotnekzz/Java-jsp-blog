<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="./ssi.jsp"%>

<%
int devcateno = Integer.parseInt(request.getParameter("devcateno"));
String visible = request.getParameter("visible");

if(visible.equals("Y")){
 devcategoryProc.hide(devcateno);   
} else {
 devcategoryProc.show(devcateno);  
}

response.sendRedirect("./list.jsp");	
%>
