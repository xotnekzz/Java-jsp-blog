<%@ page contentType="text/html; charset=UTF-8" %> 
 
<%@ include file = "./ssi.jsp"  %>
 
<%
int devdiaryno = Integer.parseInt(request.getParameter("devdiaryno"));
DevdiaryVO devdiaryVO = devdiaryProc.read(devdiaryno); // 조회
int devcateno = Integer.parseInt(request.getParameter("devcateno"));
devcategoryVO = devcategoryProc.selectOne(devcategoryVO, devcateno);
String category_title = devcategoryVO.getTitle();
%>
<!DOCTYPE html> 
<html lang="ko">  
<head> 
<meta charset="UTF-8"> 
<title></title> 
 
<link href="../css/style.css" rel="Stylesheet" type="text/css">
 
</head> 
 
<body>
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'>  
 
<DIV class='aside_menu'>
  <ASIDE style='float: left;'><A href='../category4/list.jsp'>게시판</A>＞<A href='./list.jsp?devcateno=<%=devcateno %>'><%=category_title %></A>＞수정 > 파일 삭제</ASIDE> 
  <ASIDE style='float: right;'>
    <A href='./list_category_table2.jsp?devcateno=<%=devcateno %>'>목록형</A> <span class='menu_divide'> |</span> 
    <A href='./list.jsp?devcateno=<%=devcateno %>'>앨범형</A> <span class='menu_divide'> |</span>
    <A href='./list_read.jsp'>펼쳐보기</A>
  </ASIDE> 
  <DIV class='menu_line' style='clear: both;'></DIV>
</DIV>
 
<FORM name='frm' method='POST' action='./delete_file1_proc.jsp'>
  <input type='hidden' name='devcateno' value='<%=devcateno %>'>
  <input type='hidden' name='devdiaryno' value='<%=devdiaryno %>'>
  
  <fieldset class='fieldset_no_line'>
    <ul>
      <li class='li_center'>
        <label for='file1'>참고 파일: </label>
        
        <%
        if (Tool.isImage(devdiaryVO.getFstor1())) { // 이미지 일경우
        %>
          <IMG src='./storage/<%=devdiaryVO.getFstor1() %>' style='width: 200px;'>
        <%  
        } else { // 이미지가 아닐 경우
          out.println(devdiaryVO.getFile());              
        }
        %>
        
        <label for='passwd'>패스워드: </label>
        <input class='input_basic'  type='password' name='passwd' id='passwd' value='123' size='5'>
      
        <button type="submit">삭제 진행</button>
        <button type="button" onclick="location.href='./update_form.jsp?devcateno=<%=devcateno %>&devdiaryno=<%=devdiaryno%>'">삭제 취소</button>
        
      </li>        
 
    </ul>
  </fieldset>
 
</FORM>
 
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
 
</body>
</html> 
 