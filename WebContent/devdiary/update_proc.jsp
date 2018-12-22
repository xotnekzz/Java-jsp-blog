<%@ page contentType="text/html; charset=UTF-8" %>
 
<%@ include file="./ssi.jsp" %>
 
<%
int count = 0; // 변경된 레코드 수
int devcateno = Integer.parseInt(request.getParameter("devcateno"));
devcategoryVO = devcategoryProc.selectOne(devcategoryVO, devcateno);
String category_title = devcategoryVO.getTitle();
%>
 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title></title>
<link href="../css/style.css" rel='Stylesheet' type='text/css'>
</head>
<body>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='container'> 
<jsp:include page="/menu/menu.jsp" flush='false' />
<DIV class='content'>
 
  <DIV class='message'>
    <%
    int devdiaryno = Integer.parseInt(request.getParameter("devdiaryno"));
    String passwd  = request.getParameter("passwd");
 
    if (devdiaryProc.passwordCheck(devdiaryno, passwd) == 1) { // 패스워드 일치
      String title_main = request.getParameter("title_main");
      String title_sub = request.getParameter("title_sub");
      String content = request.getParameter("content");
      String rname = request.getParameter("rname");
      String email = request.getParameter("email");
   
      DevdiaryVO devdiaryVO = new DevdiaryVO();
      devdiaryVO.setDevdiaryno(devdiaryno);
      devdiaryVO.setTitle_main(title_main);
      devdiaryVO.setTitle_sub(title_sub);
      devdiaryVO.setContent(content);
      devdiaryVO.setRname(rname);
      devdiaryVO.setEmail(email);
      
    count= devdiaryProc.update(devdiaryVO);
     

    
      if (count == 1) {
      %>
        <SPAN class='span_info'>글을 수정했습니다.</SPAN>
      <%  
      } else {
      %>
        <SPAN class='span_warning'>에러가 발생하여 글 수정에 실패했습니다.</SPAN>
      <%  
      }
  
    } else { // 패스워드 실패
      %>
      <SPAN class='span_warning'>패스워드가 일치하지 않습니다.</SPAN>
      <%  
    }
    %>
  </DIV> 
 
  <DIV class='bottom_menu'>
    <%
    if (count == 0) {
    %>
      <button type='button' onclick="history.back()">다시 시도</button>  
    <%  
    } else {
    %>
      <button type='button' onclick="location.href='./read.jsp?devcateno=<%=devcateno %>&devdiaryno=<%=devdiaryno %>&col=<%=col%>&word=<%=word%>'">수정 확인</button>
    <%  
    } 
    %> 
    <button type='button' onclick="location.href='./list.jsp?devcateno=<%=devcateno %>&devdiaryno=<%=devdiaryno %>&col=<%=col%>&word=<%=word%>'">목록</button>
  </DIV>
  
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
 
</body>
</html>