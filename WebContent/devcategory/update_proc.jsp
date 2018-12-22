<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="./ssi.jsp" %>


<% 
request.setCharacterEncoding("utf-8"); 
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
<DIV class='content'>
 
  <fieldset style='width: 70%; margin: 10px auto;'>
    <legend>카테고리 수정</legend>
      <ul>
      <%
      int devcateno = Integer.parseInt(request.getParameter("devcateno"));
      String title = request.getParameter("title");
      int seqno = Integer.parseInt(request.getParameter("seqno"));
      String visible = request.getParameter("visible");
      String ids = request.getParameter("ids");
      
      int count = 0;                          // 처리된 레코드 갯수

      devcategoryVO.setTitle(title);
      devcategoryVO.setSeqno(seqno);
      devcategoryVO.setVisible(visible);
      devcategoryVO.setIds(ids);
      
      count = devcategoryProc.update(devcategoryVO, devcateno);
      
      
     if (count == 1) {
       response.sendRedirect("./list.jsp");
     %>  
     <%   
     } else {
     %>  
       <li class='li_none'>카테고리 수정에 실패했습니다.</li>
       <li class='li_none'>다시한번 시도해주세요.</li>
     <%  } %>
      </ul>
  </fieldset>
  
  <DIV class='bottom_menu'>
    <button type='button' onclick="location.href='./update_form.jsp?categoryno=<%=devcateno %>'">다시 수정</button>
    <button type='button' onclick="location.href='./list.jsp'">목록</button>
  </DIV>
  
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
 
</body>
</html>
  