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
<jsp:include page="/menu/menu.jsp" flush='false' /> 
<DIV class='content'>
  <fieldset style='width: 70%; margin: 10px auto;'>
    <legend class='legend_basic'>공지사항 등록</legend>
    <ul>
    <%
    
    int count = 0;
    
    /* create_form 전달받은 파라미터 */ 
    String title = request.getParameter("title");
    int seqno = Integer.parseInt(request.getParameter("seqno"));
    String visible = request.getParameter("visible");
    String ids = request.getParameter("ids");
    
	devcategoryVO.setTitle(title);
	devcategoryVO.setSeqno(seqno);
	devcategoryVO.setVisible(visible);
	devcategoryVO.setIds(ids);
    
	count = devcategoryProc.create(devcategoryVO); 
      
      if (count == 1) {
       
		response.sendRedirect("./list.jsp");      
      %>
      <%
      } else {
        %>
        <li class='li_none'>등록처리에 실패했습니다.</li>
        <li class='li_none'>다시한번 시도해주세요.</li>
      <%
      }
 
    %>
    </ul>
  </fieldset>
  
  
      
  <DIV style='margin: 30px auto; text-align: center; background-color: #FFFFFF'>
    <button type='button' onclick="location.href='./create_form.jsp'">계속 등록</button>
    <button type='button' onclick="location.href='./list.jsp'">목록</button>
  </DIV>
  
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
 
</body>
</html>