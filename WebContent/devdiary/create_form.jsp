<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="./ssi.jsp" %>
<%
String email = "";
String rname = "";
if(session.getAttribute("email") != null) { 
 email = (String)session.getAttribute("email");
 rname = (String)session.getAttribute("mname");
}  

int devcateno = Integer.parseInt(request.getParameter("devcateno"));
devcategoryVO = devcategoryProc.selectOne(devcategoryVO, devcateno);
String category_title = devcategoryVO.getTitle();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/style.css" rel='Stylesheet' type='text/css'>
<script type="text/JavaScript"
        src="http://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<!-- <script type="text/javascript" src="http://code.jquery.com/jquery-1.11.0.min.js"></script> -->
<script type="text/javascript" src="./se2/js/HuskyEZCreator.js" charset="utf-8"></script>

<script type="text/javascript"  charset="utf-8">
var oEditors = [];
$(function(){  
      nhn.husky.EZCreator.createInIFrame({
          oAppRef: oEditors,
          elPlaceHolder: "content", //textarea에서 지정한 id와 일치해야 합니다. 
          //SmartEditor2Skin.html 파일이 존재하는 경로
          sSkinURI: "./se2/SmartEditor2Skin.html",  
          htParams : {
              // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
              bUseToolbar : true,             
              // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
              bUseVerticalResizer : true,     
              // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
              bUseModeChanger : true,         
              fOnBeforeUnload : function(){
                   
              } 
          }, 
          fOnAppLoad : function(){
              //기존 저장된 내용의 text 내용을 에디터상에 뿌려주고자 할때 사용
              oEditors.getById["content"].exec("PASTE_HTML", [""]);
          }, 
          fCreator: "createSEditor2"
      });
      
      //저장버튼 클릭시 form 전송
      $("#save").click(function(){
          oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
          $("#frm").submit();
      });    
});
 
</script>
</head>
<body>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='container'>
<jsp:include page="/menu/menu.jsp" flush='false' />
<DIV class='content'>
<div class='category_title'>
  HOME > <%=category_title %> > 게시글 등록 
</div> 
<ASIDE style='float: right;'>
  <A href='./list.jsp?devcateno=<%=devcateno%>&nowPage=<%=nowPage%>&recordPerPage=<%=recordPerPage%>&col=<%=col%>&word=<%=word%>&listFile=<%=listFile%>'>목록</A> <span class='menu_divide'> |</span>
  <A href='javascript: location.reload()'>새로고침</A>  
</ASIDE> 
<div style='margin-top: 30px;'>
<FORM name='frm' method='POST' action='./create_proc.jsp' 
           enctype='multipart/form-data' >
  <input type='hidden' name='devcateno' value='<%=devcateno%>'>
  <fieldset class='fieldset_no_line'>
    <ul>
      <li class='li_none'>
        <label for='title'>제목: </label> 
        <input class='input_basic' type='text' name='title_main' id='title_main' size='70%' >
      </li>
       <li class='li_none'>
        <label for='title'>소제목: </label>
        <input class='input_basic' type='text' name='title_sub' id='title_sub' size='70%' >
      </li>
      <li class='li_none'>
        <textarea name='content' id='content' rows='20' style='width: 100%;'></textarea>
      </li>  
      <li class='li_none'>
        <label for='file1'>참고 파일: </label>
        <input class='input_basic'  type="file" name='file' id='file' size='50'> (10 MB 이하만 전송 가능)
      </li>
      <li class='li_none'>
        <label for='rname'>성명: </label>
        <input class='input_basic'  type='text' name='rname' id='rname'  value='<%=rname %>'  size='10'>
 
        <label for='email'>이메일: </label>
        <input class='input_basic'  type='email' name='email' id='email'  value='<%=email %>'  size='25'>
 
        <label for='passwd'>패스워드: </label>
        <input class='input_basic'  type='password' name='passwd' id='passwd'  size='5'>
      </li>
      <li class='li_center'>
        <button type="submit" id='save' >등록</button>
        <button type="button" onclick="history.back();">목록</button>
        <button type="button" onclick="history.back();">취소</button>
      </li>    
    </ul>
  </fieldset> 
 
</FORM>
</div>
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
 
</body>
</html>