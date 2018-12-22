<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="./ssi.jsp" %>
 
<%
Log.w(request, session.getAttribute("email") + " 계정 로그아웃됨");
session.invalidate(); // 모든 세션 변수 삭제

response.sendRedirect(root + "/index.jsp");
%>