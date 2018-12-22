<%@ page contentType="text/plain; charset=UTF-8" %>
 
<%@ include file="./ssi.jsp" %>
 
<%
int cno = Integer.parseInt(request.getParameter("cno"));
String email = request.getParameter("email");
String rname = request.getParameter("rname");
String content = request.getParameter("content");
String passwd = request.getParameter("passwd");

commentVO.setCno(cno);
commentVO.setEmail(email);
commentVO.setRname(rname);
commentVO.setContent(content);
               
JSONObject json = new JSONObject();
ArrayList<String> msgs = new ArrayList<String>();

int confirm = commentProc.confirmPassword(cno, passwd);
int count = 0;
System.out.println("update_proc.jsp confirm ->" + confirm);
if(confirm == 1) {
 count = commentProc.update(commentVO);
 System.out.println("update_proc.jsp confirm ->" + count);
 if (count == 1) {
 } else {
   msgs.add("댓글 수정에 실패했습니다.");
   msgs.add("다시한번 시도해주세요.");
 }
} else {
  msgs.add("비밀번호를 확인해주세요.");
}
 
json.put("msgs", msgs);
out.println(json);
%>