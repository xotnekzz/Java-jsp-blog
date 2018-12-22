<%@ page contentType="text/plain; charset=UTF-8" %>
 
<%@ include file="./ssi-json.jsp" %>
 
<%
int notice4no = Integer.parseInt(request.getParameter("notice4no"));
 
notice4DAO.selectOne(notice4VO, notice4no); 
   
JSONObject json = new JSONObject();
 
json.put("notice4no", notice4no);
json.put("title", notice4VO.getTitle());
json.put("rname", notice4VO.getRname());
 
out.println(json);
%>