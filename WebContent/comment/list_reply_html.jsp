<%@page import="nation.web.comment_reply.Comment_replyVO"%>
<%@ page contentType="text/html; charset=UTF-8" %>
 
<%@ include file="./ssi.jsp" %>
<%
 ArrayList<Comment_replyVO> list_reply = null;

 int cno = Integer.parseInt(request.getParameter("cno"));
 list_reply = comment_replyProc.list(cno);
 
for(Comment_replyVO comment : list_reply) {

%>  
  <hr style="border: 0.5px solid #ffffff;">  
     <ul style="margin-left: 30px;"> 
      <li class='li_none' style="margin-top: 20px; margin-left: 15px">  
        <span style="font-size: 20pt; font-weight: bold; ">ㄴ&nbsp;<%=comment.getRname() %></span>(<%=comment.getEmail() %>)  
        <span style="float: right;"> 
         <A href='javascript:update_reply_form_req(<%=comment.getCrno() %>)'><IMG src='./images/update.png' title='수정'></A>
         <A href='javascript:delete_reply_form_req(<%=comment.getCrno() %>)'><IMG src='./images/delete.png' title='삭제'></A>
        </span>           
      </li>      
      <li class='li_none' style="margin-top: 20px;   margin-left: 10px;"> 
      <span style="font-size: 15pt; line-height:1em;">
         <%=comment.getContent() %><br>  
        </span>
        <span style="margin-left: 1px; font-size: 10pt;"><%=comment.getCdate() %></span>
        </li> 
    </ul> 
<% 
}
%>
