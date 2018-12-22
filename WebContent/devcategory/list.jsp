<%@ page contentType="text/html; charset=UTF-8" %>
 
<%@ include file="./ssi.jsp" %>
 
<%
int maxSeqno = devcategoryProc.getMaxSeqno();  
%> 
 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>카테고리</title>
<link href="../css/style.css" rel='Stylesheet' type='text/css'>
</head>
<body>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='container'>
<jsp:include page="/menu/menu.jsp" flush='false' />
<DIV class='content'>
 
  <form name='frm' action='./create_proc.jsp' method='POST'>
    <fieldset class='fieldset_basic' style="margin-bottom: 70px;">
      <legend class='legend_basic'>카테고리 등록(*: 필수)</legend>
      <DIV style='text-align: center;'>
      <ul>
        <li class='li_none'>
          <input type='text' name='title' id='title' value='' style='width: 25%;' placeholder="게시판 제목">*
           순서 <input type='number' name='seqno' id='seqno' value='<%=maxSeqno %>' min='1' max='1000' step='1' style='width: 5%;'>
           View 
          <label>
            <input type='radio' name='visible' id='visible' value='Y' checked="checked"> Y
          </label>
          <label>
            <input type='radio' name='visible' id='visible' value='N'> N
          </label>
            <input type='text' name='ids' id='ids' value='<%=session.getAttribute("email") %>'  style='width: 20%;' placeholder="접근 계정">*
                     
          <button type='submit'>등록</button>
          <button type='reset'>취소</button>
        </li>
      </ul>
      </DIV>
    </fieldset>
    
  </form>
 
  <TABLE class='table_basic'>
    <colgroup>
      <col style='width: 5%;' />   <!-- 출력 순서 -->
      <col style='width: 40%;' /> <!-- 제목 -->
      <col style='width: 25%;' /> <!-- 접근 계정 -->
      <col style='width: 5%;' /> <!-- 출력 선택 -->
      <col style='width: 10%;' /> <!-- 등록된 자료수 -->
      <col style='width: 15%;' /> <!-- 기타 -->
    </colgroup>
    <TR>
      <TH class='th_basic'>순서</TH>
      <TH class='th_basic'>제목</TH>
      <TH class='th_basic'>계정</TH>
      <TH class='th_basic'>출력</TH>      
      <TH class='th_basic'>자료수</TH>
      <TH class='th_basic'>기타</TH>
    </TR>
	<% ArrayList<DevcategoryVO> categorys = new ArrayList<DevcategoryVO>(); 
	   categorys = devcategoryProc.list();
	   
	   for(DevcategoryVO devcategory : categorys) { 
	     int devcateno = devcategory.getDevcateno();
	 %>
	 <tr>
	 	<td><%=devcategory.getSeqno() %></td>
 	   	<td><A href='../devdiary/list.jsp?devcateno=<%=devcateno %>'><%=devcategory.getTitle() %></A></td>
 	   	<td><%=devcategory.getIds() %></td>
 	   	<td> 
		   <a class="a_lineclean" href='./show_hide.jsp?devcateno=<%=devcateno%>&visible=<%=devcategory.getVisible()%>'"><%=devcategory.getVisible() %></a>
		</td>  
 	   	<td><%=devcategory.getCnt() %></td>
		<td>
		    <a class="a_lineclean" href='../devdiary/create_form.jsp?devcateno=<%=devcateno %>'><img src='./images/create.png' style='width: 20px;' title="카테고리에 해당하는 글 등록"></a>
		    <a class="a_lineclean" href='decreaseSeqno.jsp?devcateno=<%=devcateno %>'><img src='./images/up.jpg' style='width: 20px;' title='우선순서를 높임'></a>
		    <a class="a_lineclean" href='increaseSeqno.jsp?devcateno=<%=devcateno %>'><img src='./images/down.jpg' style='width: 20px;' title='우선순서를 내림'></a>
			<a class="a_lineclean" href='update_form.jsp?devcateno=<%=devcateno %>'><img src='./images/update.png' style='width: 20px;' title='수정'></a>
		    <a class="a_lineclean" href='delete_form.jsp?devcateno=<%=devcateno %>'><img src='./images/delete.png' style='width: 20px;' title='삭제'></a>
		</td>
	 </tr> 
	<% } %>
 
  </TABLE>
  
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
 
</body>
</html>