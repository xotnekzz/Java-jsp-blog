<%@page import="nation.web.comment_reply.Comment_replyVO"%>
<%@ page contentType="text/plain; charset=UTF-8" %>
 
<%@ include file="./ssi.jsp" %>
 
<%
int crno = Integer.parseInt(request.getParameter("crno"));
comment_replyVO = comment_replyProc.read(crno);
       
JSONObject json = new JSONObject();
  
json.put("crno", crno);
json.put("content", comment_replyVO.getContent());
json.put("rname", comment_replyVO.getRname());
json.put("email", comment_replyVO.getEmail());
json.put("cno", comment_replyVO.getCno());
out.println(json);
%> 