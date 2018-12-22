<%@ page contentType="text/html; charset=UTF-8" %>

<%@ include file="./ssi.jsp" %>

<%
// 수정할 레코드의 pk 컬럼의 값
int devcateno = Integer.parseInt(request.getParameter("devcateno"));

devcategoryVO = devcategoryProc.selectOne(devcategoryVO, devcateno);

%>
 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<link href="../css/style.css" rel='Stylesheet' type='text/css'>
</head>
<body>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='container'>
<jsp:include page="/menu/menu.jsp" flush='false' />
<DIV class='content'>
 
  <form name='frm' action='./update_proc.jsp' method='POST'>
    <input type='hidden' name='categoryno' id='categoryno' value='<%=devcateno%>'>
    
  <fieldset class='fieldset_basic' style="margin-bottom: 70px;">
      <legend class='legend_basic'>카테고리 수정(*: 필수)</legend>
      <DIV style='text-align: center;'>
      <ul>
        <li class='li_none'>
          <input type='text' name='title' id='title' value='<%=devcategoryVO.getTitle() %>' style='width: 25%;' placeholder="게시판 제목">*
           순서 <input type='number' name='seqno' id='seqno' value='<%=devcategoryVO.getSeqno() %>' min='1' max='1000' step='1' style='width: 5%;'>
           View
        <%if(devcategoryVO.getVisible().equals("Y")){ %> 
          <label>
            <input type='radio' name='visible' id='visible' value='Y' checked="checked"> Y
          </label>
          <label>
            <input type='radio' name='visible' id='visible' value='N'> N
          </label>
        <%} else { %>
          <label>
            <input type='radio' name='visible' id='visible' value='Y'> Y
          </label>
          <label>
            <input type='radio' name='visible' id='visible' value='N' checked="checked"> N
          </label>
        <% } %>
            <input type='text' name='ids' id='ids' value='<%=session.getAttribute("email") %>'  style='width: 20%;' placeholder="접근 계정">*
                     
          <button type='submit'>저장</button>
          <button type='reset' onclick="location.href='./list.jsp'">취소</button>
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
	   
	   for(DevcategoryVO category : categorys) { 
	    devcateno = category.getDevcateno();
	 %>
	 <tr>
	 	<td><%=category.getSeqno() %></td>
 	   	<td><%=category.getTitle() %></td>
 	   	<td><%=category.getIds() %></td>
 	   	<td><%=category.getVisible() %></td>
 	   	<td><%=category.getCnt() %></td>
		<td><a class="a_lineclean" href='update_form.jsp?categoryno=<%=devcateno %>'>수정</a>
		    /<a class="a_lineclean" href='delete_form.jsp?categoryno=<%=devcateno %>'>삭제</a>
		</td> 	  
	 </tr>
	<% } %>

  </TABLE>
  
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>
</html>