<%@ page contentType="text/plain; charset=UTF-8" %> 
 
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
 
<%@ page import="org.json.simple.*" %>
 
<%@ page import="nation.web.tool.*" %>
<%@ page import="nation.web.notice4.*" %>
<%@ page import="nation.web.notice4.Notice4VO" %>
 
<% 
request.setCharacterEncoding("UTF-8");   
String root = request.getContextPath(); 
%>
 
<% 
Notice4DAO notice4DAO = new Notice4DAO();
Notice4VO notice4VO = new Notice4VO();
%>
 