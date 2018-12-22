<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="./ssi.jsp" %>
 
<%
String upDir = application.getRealPath("/devdiary/storage");
 
int count = 0;
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
      // 기존 파일 삭제
      // ---------------------------------------------------------
      DevdiaryVO devdiaryVO = devdiaryProc.read(devdiaryno);
    
      Tool.deleteFile(upDir, devdiaryVO.getFstor1());
      Tool.deleteFile(upDir, devdiaryVO.getThumb());
      // ---------------------------------------------------------
      
      count = devdiaryProc.delete(devdiaryno); // DBMS 레코드 삭제 처리
      if (count == 1) {
      devcategoryProc.decreaseCnt(devcateno);
      	// 4개의 레코드가 하나의 페이지인 경우 5번째 레코드가 삭제되면 페이지도 2페이지에서 1페이지로 돌아갑니다.
      	/* if(devdiaryProc.count(devcateno, col, word) % recordPerPage == 0) {
      	  nowPage = nowPage -1;
      	  if(nowPage < 1) {
      	    nowPage = 1;
      	  }
      	} */
      %>
        <SPAN class='span_info'>자료를 삭제 했습니다.</SPAN><br><br>
        <%
        if (devdiaryVO.getSize1() > 0) { // 파일이 존재하는 경우
        %>          
                  삭제된 파일명: <%=devdiaryVO.getFile()%> 
        <% } %>
      <%  
      } else {
      %>
        <SPAN class='span_warning'>에러가 발생하여 자료 삭제에 실패했습니다.</SPAN>
      <%  
      }
    } else {
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
    }
    %>
    
    <button type='button' onclick="location.href='./list.jsp?devcateno=<%=devcateno %>&col=<%=col%>&word=<%=word%>&nowPage=<%=nowPage%>&recordPerPage=<%=recordPerPage%>'">목록</button>
  </DIV>
     
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
 
</body>
</html>