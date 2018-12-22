<%@ page contentType="text/html; charset=UTF-8" %> 
 
<%@ include file = "./ssi.jsp"  %>
 
<%
int devcateno = Integer.parseInt(request.getParameter("devcateno"));
devcategoryVO = devcategoryProc.selectOne(devcategoryVO, devcateno);
String category_title = devcategoryVO.getTitle();
int devdiaryno = Integer.parseInt(request.getParameter("devdiaryno"));
%>
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
 
<link href="../css/style.css" rel="Stylesheet" type="text/css">
 
</head> 
 
<body>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='container'> 
<jsp:include page="/menu/menu.jsp" flush='false' />
<DIV class='content'>  
 
<FORM name='frm' method='POST' action='./create_file1_proc.jsp' 
           enctype='multipart/form-data'>
  <input type='hidden' name='devcateno' value='<%=devcateno %>'>
  <input type='hidden' name='devdiaryno' value='<%=devdiaryno %>'>
  <input type='hidden' name='col' value='<%=col %>'>
  <input type='hidden' name='word' value='<%=word %>'>   
  
  <fieldset class='fieldset_no_line'>
    <ul>
      <li class='li_none' style='text-align: center; font-size: 1.2em;'>
        파일을 선택하세요.
      </li>
      <li class='li_none'>
        <label for='file1'>참고 파일: </label>
        <input class='input_basic'  type="file" name='file1' id='file1' size='50'> (10 MB 이하만 전송 가능)
      </li>        
      <li class='li_none'>
        <label for='passwd'>패스워드: </label>
        <input class='input_basic'  type='password' name='passwd' id='passwd' value='123' size='5'>
      </li>
 
      <li class='li_center'>
        <button type="submit">등록</button>
        <button type="button" onclick="history.back();">뒤로가기</button>
        <button type="button" onclick="location.href='./list.jsp?devcateno=<%=devcateno %>&col=<%=col%>&word=<%=word%>&nowPage=<%=nowPage%>&recordPerPage=<%=recordPerPage%>'">목록</button>
      </li>    
    </ul>
  </fieldset> 
  
</FORM>
 
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
 
</body>
</html> 