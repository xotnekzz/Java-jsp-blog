<%@ page contentType="text/plain; charset=UTF-8" %> 
 
<%@ include file="./ssi.jsp" %> 

   
<%
  int devdiaryno = Integer.parseInt(request.getParameter("devdiaryno"));
  String content = request.getParameter("content");
  String email = request.getParameter("email");
  String rname = request.getParameter("rname");
  String passwd = request.getParameter("passwd");
  
  System.out.println(devdiaryno + rname);
  
  
  commentVO.setDevdiaryno(devdiaryno);
  commentVO.setContent(content);
  commentVO.setEmail(email);
  commentVO.setRname(rname);
  commentVO.setPasswd(passwd);

  System.out.println("create_proc comment --> " + commentVO.getContent()); 
  JSONObject json = new JSONObject();
  ArrayList<String> msgs = new ArrayList<String>();
  
  int count = 0;
  
  if(email !="" && rname != "" && passwd !="") {
   count = commentProc.insert(commentVO);
  }
   
  if(count == 1) { 
  } else {
    msgs.add("댓글 등록에 실패하였습니다.");
    msgs.add("이름, 이메일, 비밀번호를 입력해주세요.");
  }
  json.put("msgs", msgs);
  out.print(json); 
%>
