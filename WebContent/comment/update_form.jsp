<%@ page contentType="text/plain; charset=UTF-8" %>
 
<%@ include file="./ssi.jsp" %>
 
<%
int cno = Integer.parseInt(request.getParameter("cno"));
commentVO = commentProc.read(cno); 
    
JSONObject json = new JSONObject();
  
json.put("cno", cno); 
json.put("content", commentVO.getContent());
json.put("rname", commentVO.getRname());
json.put("email", commentVO.getEmail());
 
out.println(json);
%> 