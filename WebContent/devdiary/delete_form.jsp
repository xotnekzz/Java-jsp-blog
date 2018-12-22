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
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='container'>
<jsp:include page="/menu/menu.jsp" flush='false' /> 
<DIV class='content'>  
 
<FORM name='frm' method='POST' action='./delete_proc.jsp'>
  <input type='hidden' name='devcateno' value='<%=devcateno %>'>
  <input type='hidden' name='devdiaryno' value='<%=devdiaryno %>'>
<%--   <input type='hidden' name='col' value='<%=col %>'>
  <input type='hidden' name='word' value='<%=word %>'>    
  <input type='hidden' name='nowPage' value='<%=nowPage %>'>   
  <input type='hidden' name='recordPerPage' value='<%=recordPerPage %>'>   
  <input type='hidden' name='listFile' value='<%=listFile %>'>  --%>  
  
  <fieldset class='fieldset_no_line'>
    <ul>
      <li class='li_center'>
        <%
        if (devdiaryVO.getSize1() > 0) { // 파일이 존재하는 경우
          if (Tool.isImage(devdiaryVO.getFstor1())) { // 이미지 일경우
          %>
            <IMG src='./storage/<%=devdiaryVO.getFstor1() %>' style='width: 200px;'>
          <%  
          } else { // 이미지가 아닐 경우
            out.println(devdiaryVO.getFile());              
          }
        } 
        %>
      </li>     
      <li class='li_none' style='text-align: center; font-size: 1.2em;'>
        기존에 등록된 글과 파일은 삭제되고 복구 할 수 없습니다.
      </li>    
      <li class='li_center'>
        <label for='passwd'>패스워드: </label>
        <input class='input_basic'  type='password' name='passwd' id='passwd' value='123' size='5'>
      
        <button type="submit">삭제 진행</button>
        <button type="button" onclick="location.href='./list.jsp?devcateno=<%=devcateno %>&nowPage=<%=nowPage%>&recordPerPage=<%=recordPerPage%>&col=<%=col%>&word=<%=word%>&listFile=<%=listFile%>'">수정 취소</button>
      </li>      
    </ul> 
  </fieldset>
  
</FORM>
 
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
 
</body>
</html> 