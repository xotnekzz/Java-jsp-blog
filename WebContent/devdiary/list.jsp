
<%@ page contentType="text/html; charset=UTF-8" %>
 
<%@ include file="./ssi.jsp" %>
<%
int devcateno = Integer.parseInt(request.getParameter("devcateno"));
devcategoryVO = devcategoryProc.selectOne(devcategoryVO, devcateno);
String category_title = devcategoryVO.getTitle();

//목록 조회 DBMS
//list = devdiaryProc.list(devcateno);   
 
//listFile = "list_category_table2.jsp";
%>
<% 
// -----------------------------------------------------------------------------
// 페이징 관련 코드 시작
// -----------------------------------------------------------------------------
int recordCount = devdiaryProc.count(devcateno, col, word);
 
// listFile 목록 파일명
// recordCount 전체 레코드수 
// nowPage 현재 페이지
// recordPerPage 페이지당 레코드 수
// col 검색 컬럼 
// word 검색어 
String paging = new Paging().paging4(listFile, recordCount, nowPage, recordPerPage, col, word, devcateno);
//-----------------------------------------------------------------------------

%>  
<!DOCTYPE html>  
<html lang="ko"> 	
<head> 
<meta charset="UTF-8"> 
<title>게시판</title> 
 
<link href="../css/style.css" rel="Stylesheet" type="text/css">
 
</head> 
 
<body>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='container'>
<jsp:include page="/menu/menu.jsp" flush='false' />
<DIV class='content_list'>  
<div class='category_title'>
	HOME > <%=category_title %>   
  <ASIDE style='float: right; margin-top: 20px; margin-bottom: 25px'>
      <FORM name='frm' method='GET' action='./list.jsp'> 
        <input type='hidden' name='devcateno' value='<%=devcateno %>'>
    
        <SELECT name='col'>
          <OPTION value='none' <%=(col.equals("none"))?"selected='selected'":"" %>>전체 목록</OPTION>
          <OPTION value='rname' <%=(col.equals("rname"))?"selected='selected'":"" %>>이름</OPTION>
          <OPTION value='title' <%=(col.equals("title"))?"selected='selected'":"" %>>제목</OPTION>
          <OPTION value='content' <%=(col.equals("content"))?"selected='selected'":"" %>>내용</OPTION>
          <OPTION value='title_content' <%=(col.equals("title_content"))?"selected='selected'":"" %>>제목+내용</OPTION>
        </SELECT>
        <INPUT type='text' name='word' value='<%=word %>' placeholder="검색어">
        <BUTTON type='submit'>검색</BUTTON>
      </FORM> 
    </ASIDE>
</div>
  
<DIV class='menu_line' style='clear: both;'></DIV> 
<div style="text-align:right;">
<% if(session.getAttribute("email") != null) { %>
 <a href='./create_form.jsp?devcateno=<%=devcateno%>&nowPage=<%=nowPage%>&recordPerPage=<%=recordPerPage%>&col=<%=col%>&word=<%=word%>&listFile=<%=listFile%>'>포스트 쓰기</a> 
<% } %>
</div>
<%
// 게시판 목록 조회 Process 호출
list = devdiaryProc.list_category(devcateno, col, word, nowPage, recordPerPage);

if(list.size() > 0) {
  for(DevdiaryVO devdiaryVO : list){ 
    String thumb = devdiaryVO.getThumb(); 
    String file1 = Tool.checkNull(devdiaryVO.getFile());
    int devdiaryno = devdiaryVO.getDevdiaryno();
    //System.out.println("--> file1: " + file1); // 파일이 없어도  null이 아님
%> 
 <div class="devdiary_list">
 	<div class="devdiary_info">
 	 <span style="color: #000000;"><%=devdiaryVO.getRdate() %>&nbsp;<%=devdiaryVO.getRname() %></span><br>
 	</div>
 	<div class="title_main"> 
 	  <a href='./read.jsp?devcateno=<%=devcateno%>&devdiaryno=<%=devdiaryno%>&nowPage=<%=nowPage%>&recordPerPage=<%=recordPerPage%>&col=<%=col%>&word=<%=word%>&listFile=<%=listFile%>'><span style="font-size: 50px; font-weight: bold; color: #000000;"><%=devdiaryVO.getTitle_main() %></span></a>
 	</div>    
 	<div class="title_sub">
 	   <span style="margin-left: 10px;"><%=devdiaryVO.getTitle_sub() %></span> 
 	</div>  
 	 <div>  
     <%
      if(session.getAttribute("email") != null) {
      %>
      <A href='./update_form.jsp?devcateno=<%=devcateno %>&devdiaryno=<%=devdiaryVO.getDevdiaryno() %>&nowPage=<%=nowPage%>&recordPerPage=<%=recordPerPage%>&col=<%=col%>&word=<%=word%>&listFile=<%=listFile%>'><IMG src='./images/update.png' title='수정'></A>
      <A href='./delete_form.jsp?devcateno=<%=devcateno %>&devdiaryno=<%=devdiaryVO.getDevdiaryno() %>&nowPage=<%=nowPage%>&recordPerPage=<%=recordPerPage%>&col=<%=col%>&word=<%=word%>&listFile=<%=listFile%>'><IMG src='./images/delete.png' title='삭제'></A>
    <% } %>
  </div>
 </div>
<%
  }
} else {
  %> 
      <div style="text-align: center; margin-top: 70px; ">
      등록된 글이 없습니다.<br><br>
      <% if(session.getAttribute("email") != null) { %>
      <a href='./create_form.jsp?devcateno=<%=devcateno%>&nowPage=<%=nowPage%>&recordPerPage=<%=recordPerPage%>&col=<%=col%>&word=<%=word%>&listFile=<%=listFile%>'>포스트 쓰러가기</a></div>
  <%
      }
}
%> 
   
    
  
<DIV class='bottom_menu'>
  <%=paging %>
</DIV>
 
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
 
</body>
</html> 
 
  