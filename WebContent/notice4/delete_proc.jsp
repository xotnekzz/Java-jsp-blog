<%@ page contentType="text/plain; charset=UTF-8" %>
 
<%@ include file="./ssi-json.jsp" %>
 
<%
int notice4no = Integer.parseInt(request.getParameter("notice4no"));

JSONObject json = new JSONObject();
ArrayList<String> msgs = new ArrayList<String>();
 
int count = notice4DAO.delete(notice4no);
 
if (count == 1) {
  msgs.add("공지사항을 삭제했습니다.");
} else {
  msgs.add("공지사항 삭제에 실패했습니다.");
  msgs.add("다시한번 시도해주세요.");
}
 
json.put("msgs", msgs);
out.println(json);
%>