<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="./ssi.jsp" %>
 
<%
// 수정할 레코드의 pk 컬럼의 값
int devcateno = Integer.parseInt(request.getParameter("devcateno"));
int count = 0;                          // 처리된 레코드 갯수

count = devcategoryProc.delete(devcateno); 
 
 %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
  *{ font-family: Malgun Gothic; font-size: 26px;}
</style>
</head>
<body>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='container'>
<DIV class='content'>
  <fieldset style='width: 70%; margin: 10px auto;'>
    <legend class='legend_basic'>공지사항 삭제</legend>
    <ul>
    <%
      
    if (count == 1) {
      response.sendRedirect("./list.jsp");
    %>
    <%
    } else {
      %>
      <li class='li_none'>삭제처리에 실패했습니다.</li>
      <li class='li_none'>다시한번 시도해주세요.</li>
    <%
    }
    %>
    </ul>
  </fieldset>
  <DIV style='margin: 30px auto; text-align: center; background-color: #FFFFFF'>
    <button type='button' onclick="location.href='./list.jsp'">목록</button>
  </DIV>
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>
</html>