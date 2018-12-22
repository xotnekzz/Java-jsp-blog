<%@ page contentType="text/html; charset=UTF-8" %>
 
<%@ include file="./ssi.jsp" %>
 
<%
String upDir = application.getRealPath("/devdiary/storage");
 
int count = 0;
int devcateno = Integer.parseInt(request.getParameter("devcateno"));
devcategoryVO = devcategoryProc.selectOne(devcategoryVO, devcateno);
String devcategory_title = devcategoryVO.getTitle();
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
 
  <DIV class='aside_menu'>
  <ASIDE style='float: left;'><A href='../devcategory4/list.jsp'>게시판</A>＞<A href='./list.jsp?devcateno=<%=devcateno %>'><%=devcategory_title %></A>＞수정 > 파일 삭제</ASIDE> 
    <ASIDE style='float: right;'>
    <A href='./list_devcategory_table2.jsp?devcateno=<%=devcateno %>'>목록형</A> <span class='menu_divide'> |</span> 
    <A href='./list.jsp?devcateno=<%=devcateno %>'>앨범형</A> <span class='menu_divide'> |</span>
    <A href='./list_read.jsp'>펼쳐보기</A>
    </ASIDE> 
    <DIV class='menu_line' style='clear: both;'></DIV>
  </DIV>
 
  <DIV class='message'>
    <%
    int devdiaryno = Integer.parseInt(request.getParameter("devdiaryno"));
    String passwd  = request.getParameter("passwd");
    
    if (devdiaryProc.passwordCheck(devdiaryno, passwd) == 1) { // 패스워드 일치여부 검사
 
      DevdiaryVO devdiaryVO = devdiaryProc.read(devdiaryno); // 삭제할 파일 정보 읽기
      
      Tool.deleteFile(upDir, devdiaryVO.getFstor1());       // 기존 파일 삭제
      Tool.deleteFile(upDir, devdiaryVO.getThumb());      // 기존 파일 삭제
      
      count = devdiaryProc.delete_file1(devdiaryno); // DBMS 파일 정보 삭제 처리
      if (count == 1) { 
      	if (devdiaryVO.getSize1() > 0) {
      %>
        <SPAN class='span_info'>파일을 삭제 했습니다.</SPAN>
      <% }
      } else {
      %>
        <SPAN class='span_warning'>에러가 발생하여 파일 삭제에 실패했습니다.</SPAN>
      <%  
      }
    } else {
      %>
      <SPAN class='span_warning'>패스워드가 일치하지 않습니다.</SPAN>
      <%  
    }
    %>
  </DIV>  
 
  <DIV class='bottom_menu' style='text-align: center;'>
    <%
    if (count == 0) {
    %>
      <button type='button' onclick="history.back()">다시 시도</button>  
    <%  
    } else {
    %>
      <button type='button' onclick="location.href='./update_form.jsp?devcateno=<%=devcateno %>&devdiaryno=<%=devdiaryno %>'">계속 수정 [글 수정화면으로 돌아가기]</button>
    <%  
    }
    %>   
    
    <button type='button' onclick="location.href='./list.jsp?devcateno=<%=devcateno %>'">목록</button>
  </DIV>
  
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
 
</body>
</html>
 