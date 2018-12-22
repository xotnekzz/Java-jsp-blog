<%@ page contentType="text/html; charset=UTF-8" %> 
 
<%@ include file = "./ssi.jsp"  %>
 
<%
int devdiaryno = Integer.parseInt(request.getParameter("devdiaryno"));
DevdiaryVO devdiaryVO = devdiaryProc.read(devdiaryno); // 조회    

devdiaryProc.increaseCnt(devdiaryno); // 조회수 증가  

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
 <div class='category_title'>  
  HOME > <%=category_title %> >  
</div>
<ASIDE style='float: right;'>
  <A href='./list.jsp?devdiaryno=<%=devdiaryno%>&devcateno=<%=devcateno%>&nowPage=<%=nowPage%>&recordPerPage=<%=recordPerPage%>&col=<%=col%>&word=<%=word%>&listFile=<%=listFile%>'>목록</A> <span class='menu_divide'> |</span>
  <A href='javascript: location.reload()'>새로고침</A>  
</ASIDE> 
<FORM name='frm' method='POST' action='./create_proc.jsp' 
           enctype='multipart/form-data'>
  <input type='hidden' name='devcateno' value='<%=devcateno %>'>
  <input type='hidden' name='devdiaryno' value='<%=devdiaryno %>'>
  <input type='hidden' name='col' value='<%=col %>'>
  <input type='hidden' name='word' value='<%=word %>'>         
   
  <fieldset class='fieldset_no_line'> 
    <ul>
      <li class='li_none'>
        <span style="font-weight: bold; font-size: 50px; color: #000000;"">
				<%=devdiaryVO.getTitle_main() %>         
        </span> 
      </li> 
      <li class='li_none'>
        <span>
				 &nbsp;<%=devdiaryVO.getTitle_sub() %>           
        </span> 
        <span style="float: right;"><%=devdiaryVO.getRdate() %></span><br>  
        <span style="float: right;">조회수: <%=devdiaryVO.getCnt() %></span><br>
      </li>
      <li class='li_none' style="float:right;"> 
                파일: <A href='<%=request.getContextPath()%>/download2?dir=/devdiary/storage&filename=<%=devdiaryVO.getFstor1() %>'><%=devdiaryVO.getFile() %></A> (<%=Tool.unit(devdiaryVO.getSize1()) %>) 
      </li>
      <li class='li_underline'></li> 
      <li class='li_none' style='height: 80%;'>
  <%--       <DIV><%=Tool.convertChar(devdiaryVO.getContent()) %></DIV> --%>
        <DIV><%=devdiaryVO.getContent()%></DIV>
      </li>    
 			<li class='li_underline'></li>
      <li class='li_none' >
      <%=devdiaryVO.getRname() %>(<%=devdiaryVO.getEmail() %>)<br>
      </li>
    </ul>
  </fieldset> 
</FORM>
  <DIV class='bottom_menu' style='width: 90%; font-size: 0.8em;'>
    <A href='./update_form.jsp?devdiaryno=<%=devdiaryno%>&devcateno=<%=devcateno%>&nowPage=<%=nowPage%>&recordPerPage=<%=recordPerPage%>&col=<%=col%>&word=<%=word%>&listFile=<%=listFile%>'><span class='bottom_menu_item'>수정</span></A> <span class='menu_divide'> |</span>
    <A href='./delete_form.jsp?devdiaryno=<%=devdiaryno%>&devcateno=<%=devcateno%>&nowPage=<%=nowPage%>&recordPerPage=<%=recordPerPage%>&col=<%=col%>&word=<%=word%>&listFile=<%=listFile%>'><span class='bottom_menu_item'>삭제</span></A> <span class='menu_divide'> </span>
  </DIV>
<%-- <jsp:include page="/comment/create_form.jsp?devdiaryno=<%=devdiaryno %>" flush='false' /> --%>
<jsp:include page="/comment/list.jsp" flush='false' /> 
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
  
</DIV> <!-- container END -->
 
</body>
</html> 