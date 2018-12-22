<%@ page contentType="text/html; charset=UTF-8" %>
 
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.SimpleDateFormat" %>
 
<%@ page import="nation.web.tool.Tool" %>
  
<%@ page import="nation.web.devcategory.*" %>
 
<% 
String root = request.getContextPath();
request.setCharacterEncoding("utf-8"); 
 
%>
 
<%
DevcategoryProc devcategoryProc = new DevcategoryProc();
DevcategoryVO devcategoryVO = new DevcategoryVO();

//Pds4Proc pds4Proc = new Pds4Proc();
%>
