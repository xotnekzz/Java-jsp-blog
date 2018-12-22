<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="./ssi.jsp"%>

<%
int devcateno = Integer.parseInt(request.getParameter("devcateno"));

devcategoryProc.decreaseSeqno(devcateno); 

response.sendRedirect("./list.jsp");	
%>
