<%@ page contentType="text/plain; charset=UTF-8" %> 
 
<%@ include file="./ssi.jsp" %> 

   
<%
  int cno = Integer.parseInt(request.getParameter("reply_cno"));
  String content = request.getParameter("reply_content");
  String email = request.getParameter("reply_email");
  String rname = request.getParameter("reply_rname");
  String passwd = request.getParameter("reply_passwd"); 
  
  System.out.println("cno : " + cno);
  System.out.println("email : " + email);
  System.out.println("passwd : " + passwd);
  
  
  comment_replyVO.setCno(cno); 
  comment_replyVO.setContent(content);
  comment_replyVO.setEmail(email);      
  comment_replyVO.setRname(rname); 
  comment_replyVO.setPasswd(passwd);
 
  JSONObject json = new JSONObject(); 
  ArrayList<String> msgs = new ArrayList<String>();
  
  int count = 0;
  
  if(email !="" && rname != "" && passwd !="") {
   count = comment_replyProc.insert(comment_replyVO);
  }
   
  if(count == 1) { 
  } else {
    msgs.add("댓글 등록에 실패하였습니다.");
    msgs.add("이름, 이메일, 비밀번호를 입력해주세요.");
  }
  json.put("msgs", msgs);
  out.print(json); 
%>
