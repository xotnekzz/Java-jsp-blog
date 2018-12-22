<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="./ssi.jsp"%>

<%
int devcateno = Integer.parseInt(request.getParameter("devcateno"));

devcategoryProc.increaseSeqno(devcateno); 

response.sendRedirect("./list.jsp");
%>
