<%@page import="nation.web.devdiary.DevdiaryProc"%>
<%@ page contentType="text/html; charset=UTF-8" %>
 
<%@ page import="java.util.ArrayList" %>
 
 <%@ page import="nation.web.admin4.AdminTool" %>
<%@ page import="nation.web.devdiary.*" %>
<%@ page import="nation.web.devcategory.*" %>

<% 
String root = request.getContextPath();
request.setCharacterEncoding("utf-8"); 
%>
 
<%  
DevcategoryProc devcategoryProc = new DevcategoryProc();
DevdiaryProc devdiaryProc = new DevdiaryProc(); 
%>
