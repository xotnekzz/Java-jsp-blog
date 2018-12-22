<%@ page contentType="text/plain; charset=UTF-8" %>
 
<%@ include file="./ssi.jsp" %>
 
<%
int crno = Integer.parseInt(request.getParameter("reply_crno"));
int cno = Integer.parseInt(request.getParameter("reply_cno"));
String email = request.getParameter("reply_email");
String rname = request.getParameter("reply_rname");
String content = request.getParameter("reply_content");
String passwd = request.getParameter("reply_passwd");

System.out.println("cno : " + cno);
System.out.println("email : " + email);
System.out.println("passwd : " + passwd);

comment_replyVO.setCrno(crno);
comment_replyVO.setCno(cno);
comment_replyVO.setEmail(email);
comment_replyVO.setRname(rname);
comment_replyVO.setContent(content);
               
JSONObject json = new JSONObject();
ArrayList<String> msgs = new ArrayList<String>();

int confirm = comment_replyProc.confirmPassword(crno, passwd);
int count = 0;

if(confirm == 1) { // 비밀번호 일치
 count = comment_replyProc.update(comment_replyVO); // 답변 수정
 if (count == 1) { // 수정완료
 } else {  // 수정실패
   msgs.add("댓글 수정에 실패했습니다.");
   msgs.add("다시한번 시도해주세요.");
 }
} else { // 비밀번호 불일치
  msgs.add("비밀번호를 확인해주세요.");
}
 
json.put("msgs", msgs);
out.println(json);
%>