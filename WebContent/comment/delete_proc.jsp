<%@ page contentType="text/plain; charset=UTF-8" %>
 
<%@ include file="./ssi.jsp" %>
 
<%
int cno = Integer.parseInt(request.getParameter("cno"));  
String passwd = request.getParameter("passwd");

JSONObject json = new JSONObject();
ArrayList<String> msgs = new ArrayList<String>();

int confirm = commentProc.confirmPassword(cno, passwd);
int count = 0;

// 비밀번호가 일치하면 삭제
if(confirm == 1) {
 count = commentProc.delete(cno);
  if (count == 1) {
    // 댓글 삭제 성공
  } else {
    msgs.add("댓글 삭제에 실패했습니다.");
    msgs.add("다시한번 시도해주세요.");
    }
} else {
   msgs.add("비밀번호를 확인해주세요.");  
 }

json.put("msgs", msgs);
out.println(json);
%>