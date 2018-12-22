<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="./ssi.jsp" %>

<%
  ArrayList<Notice4VO> notices = new ArrayList<Notice4VO>();
  Notice4DAO noticeDAO = new Notice4DAO();
  notices = noticeDAO.list();
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
  <DIV class='title_box'>공 지 사 항</DIV>
  <TABLE class='table_basic' style="margin-bottom: 100px;">
    <colgroup>
      <col style='width: 5%;'>
      <col style='width: 65%;'>
      <col style='width: 12%;'>
      <col style='width: 18%;'>
    </colgroup>
    <thead>
      <tr>
        <th class='th_basic'>NO</th>
        <th class='th_basic'>내용</th>
        <th class='th_basic'>성명</th>
        <th class='th_basic'>등록일</th>
      </tr>
    </thead>
    <tbody>
    <% for(Notice4VO noticeVO : notices){
        int noticeno = noticeVO.getNotice4no();
      %>
     <tr>
      <td><%=noticeno %></td>
      <td><%=noticeVO.getTitle() %></td>
      <td><%=noticeVO.getRname() %></td>
      <td><%=noticeVO.getRdate().substring(0, 10) %></td>
     </tr>
    <% } %>
    </tbody> 
  </TABLE>
  
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
 
</body>
</html>