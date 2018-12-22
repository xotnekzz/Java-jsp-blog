<%@ page contentType="text/html; charset=UTF-8" %>
 
<%@ include file="./ssi.jsp" %>

<%
int devdiaryno = Integer.parseInt(request.getParameter("devdiaryno"));
int devcateno = Integer.parseInt(request.getParameter("devcateno"));
int nowPage = Integer.parseInt(request.getParameter("nowPage"));
int recordPerPage = Integer.parseInt(request.getParameter("recordPerPage"));

 list = commentProc.list_devdiary(devdiaryno, nowPage, recordPerPage);

for(CommentVO comment : list) {

%>  
<!-- 댓글 목록 영역 -->
<div class='comment' >
<hr style="border: 0.5px solid #000000;">
     <ul>
      <li class='li_none' style="margin-top: 20px; margin-left: 15px">  
        <span style="font-size: 20pt; font-weight: bold; "><%=comment.getRname() %></span>(<%=comment.getEmail() %>)  
        <span style="float: right;">
         <A href='javascript:update_form_req(<%=comment.getCno() %>)'><IMG src='./images/update.png' title='수정'></A>
         <A href='javascript:delete_form_req(<%=comment.getCno() %>)'><IMG src='./images/delete.png' title='삭제'></A>
        </span>   
      </li>     
      <li class='li_none' style="margin-top: 20px;   margin-left: 10px;"> 
      <span style="font-size: 15pt; line-height:1em;">
         <%=comment.getContent() %><br>  
        </span>
        <span style="margin-left: 1px; font-size: 10pt;"><%=comment.getCdate() %></span>
         <a href='javascript:reply_show(<%=comment.getCno() %>)' style="float: right; margin-right: 10px;" id='reply_show<%=comment.getCno() %>' >답변</a>
         <a href='javascript:reply_hide(<%=comment.getCno() %>)' style="display: none; float: right; margin-right: 10px;" id='reply_hide<%=comment.getCno() %>' >답변 접기</a>
        </li> 
    </ul>   
</div>  
<!-- 답글 목록 영역 -->
<div class='comment_reply'  id='comment_reply<%=comment.getCno() %>'>
</div> 
<!-- 답글 등록 영역 -->
<div class='comment_form'
       style="clear:both; width: 99%; height: 280px; margin-left:15px; margin-bottom: 50px; display: none;"
       id="reply_form<%=comment.getCno() %>">  
    <div class='comment_top'>
      <span
        style="text-align: left; font-weight: bold; font-size: 24pt;'">답변</span>
    </div>
    <form id='reply_frm<%=comment.getCno() %>'>      
      <input type='hidden' id='reply_cro<%=comment.getCno() %>' name='reply_cno' value='<%=comment.getCno() %>'> 
      <input type='hidden' id='reply_crno<%=comment.getCno() %>' name='reply_crno' value=''> 
      <fieldset class='comment_content' style="height: 250px; border: none;"> 
        <ul>  
          <li class='li_none' id='reply_delete_form<%=comment.getCno() %>' style="display: none; text-align: center;"> 
          <span id='reply_comment_info<%=comment.getCno() %>'></span>
          해당 댓글의 비밀번호를 입력해주세요.<br><br>
          <label for='passwd' id='reply_label_passwd'>비밀번호 : </label> 
          <input type='password' id='reply_passwd2<%=comment.getCno() %>' name='reply_passwd2'size='10%' />
           <button type='button' id='reply_btn_delete<%=comment.getCno() %>'  style="margin-top: 20px;"></button> 
           <button type='button' id='reply_btn_init2<%=comment.getCno() %>'>취소</button> 
          </li>  
          <li class='li_none'> 
          <textarea name='reply_content'  id='reply_content<%=comment.getCno() %>' rows='5' style='width: 100%; resize: none;'></textarea>
           </li>  
          <li id='reply_li_comment<%=comment.getCno() %>' class='li_right' style="margin-right: 15px;">
          <label for='rname' id='label_rname'>이름 : </label> 
          <input type='text' id='reply_rname<%=comment.getCno() %>' name='reply_rname' value =''  size='10%' /> 
          <label for='email' id='label_email'>이메일 : </label> 
          <input type='email' id='reply_email<%=comment.getCno() %>' name='reply_email'  value ='' size='20%' /> 
          <label for='passwd' id='label_passwd'>비밀번호 : </label> 
          <input type='password' id='reply_passwd'<%=comment.getCno() %> name='reply_passwd' size='10%' />  
            <a href='javascript:create_reply_proc_req(<%=comment.getCno() %>)'><button type='button' id='reply_btn_send<%=comment.getCno() %>'>등록</button> </a>
            <a href='javascript:update_reply_proc_req(<%=comment.getCno() %>)'><button type='button' id='reply_btn_update<%=comment.getCno() %>' style="display: none;">수정</button> </a>
            <a href='javascript:cancel_reply_proc_req(<%=comment.getCno() %>)'><button type='button' id='reply_btn_init'>취소</button> </a>
            <span id='reply_fail_info<%=comment.getCno() %>' style="display: none; color: #fa2b05;"></span>
         </li>       
       </ul>    
     </fieldset>
   </form>
</div>  
<%    
}
%> 
