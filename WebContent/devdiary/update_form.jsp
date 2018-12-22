<%@ page contentType="text/html; charset=UTF-8" %> 
 
<%@ include file = "./ssi.jsp"  %>
 
<%
int devdiaryno = Integer.parseInt(request.getParameter("devdiaryno")); 
DevdiaryVO devdiaryVO = devdiaryProc.read(devdiaryno);
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
 <script type="text/JavaScript"
        src="http://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<!-- <script type="text/javascript" src="http://code.jquery.com/jquery-1.11.0.min.js"></script> -->
<script type="text/javascript" src="./se2/js/HuskyEZCreator.js" charset="utf-8"></script>

<script type="text/javascript">
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
 
 <ASIDE style='float: right;'>
  <A href='./list.jsp?devdiaryno=<%=devdiaryno%>&devcateno=<%=devcateno%>&nowPage=<%=nowPage%>&recordPerPage=<%=recordPerPage%>&col=<%=col%>&word=<%=word%>&listFile=<%=listFile%>'>목록</A> <span class='menu_divide'> |</span>
  <A href='javascript: location.reload()'>새로고침</A>  
</ASIDE> 
<FORM name='frm' method='POST' action='./update_proc.jsp'>
  <input type='hidden' name='devcateno' value='<%=devcateno %>'>
  <input type='hidden' name='devdiaryno' value='<%=devdiaryno %>'>
   <input type='hidden' name='col' value='<%=col %>'>
  <input type='hidden' name='word' value='<%=word %>'>   
  
  <fieldset class='fieldset_no_line'>
    <ul>
      <li class='li_none'>
        <label for='title_main'>제목: </label>
        <input class='input_basic' type='text' name='title_main' id='title_main' size='70%' value='<%=devdiaryVO.getTitle_main() %>'>
      </li> 
      <li class='li_none'>
        <label for='title_sub'>소제목: </label> 
        <input class='input_basic' type='text' name='title_sub' id='title_sub' size='70%' value='<%=devdiaryVO.getTitle_sub() %>'>
      </li> 
      <li class='li_none'> 
        <textarea name='content' id='content' rows='20' style='width: 100%;'><%=devdiaryVO.getContent() %></textarea>
      </li>   
      <li class='li_none'>
        <label for='rname'>작성자: <%=devdiaryVO.getRname() %></label>
        &nbsp;&nbsp;&nbsp;
        <label for='email'>이메일: <%=devdiaryVO.getEmail() %> </label>
        &nbsp;&nbsp;&nbsp;
        <label for='passwd'>패스워드: </label>
        <input class='input_basic'  type='password' name='passwd' id='passwd' placeholder="수정하시려면 비밀번호를 입력하세요" size='40'>
      </li>
      <li class='li_none' style="text-align: center;">  
        <button type="submit" id="save">변경된 내용 저장</button>
        <button type="button" onclick="location.href='./list.jsp?&devcateno=<%=devcateno%>&nowPage=<%=nowPage%>&recordPerPage=<%=recordPerPage%>&col=<%=col%>&word=<%=word%>&listFile=<%=listFile%>'">수정 취소</button>
      </li>      
      <li class='li_none'> 
        <HR class='hr_dotted'>  
      </li>        
 
      <li class='li_center'>
       <label for='file1'>참고 파일: </label>
        
        <%
        if (devdiaryVO.getSize1() > 0) { // 파일이 존재하는 경우
          if (Tool.isImage(devdiaryVO.getFstor1())) { // 이미지 일경우
          %>
            <IMG src='./storage/<%=devdiaryVO.getFstor1() %>' style='width: 200px;'>
          <%  
          } else { // 이미지가 아닐 경우
            out.println(devdiaryVO.getFile());              
          }
        %>
          <A href="./replace_file1_form.jsp?devcateno=<%=devcateno %>&devdiaryno=<%=devdiaryno%>&nowPage=<%=nowPage%>&recordPerPage=<%=recordPerPage%>&col=<%=col%>&word=<%=word%>&listFile=<%=listFile%>"><IMG src='./images/update.png'></A>
          <A href="./delete_file1_form.jsp?devcateno=<%=devcateno %>&devdiaryno=<%=devdiaryno%>&nowPage=<%=nowPage%>&recordPerPage=<%=recordPerPage%>&col=<%=col%>&word=<%=word%>&listFile=<%=listFile%>"><IMG src='./images/delete.png'></A>   
        <%
        } else { // 파일이 없는 경우 
        %> 
        <!-- 
          <input class='input_basic'  type="file" name='file1' id='file1' size='50'> (10 MB 이하만 전송 가능)
           -->
           <button type='button' onclick="location.href='./create_file1_form.jsp?devcateno=<%=devcateno %>&devdiaryno=<%=devdiaryno%>&nowPage=<%=nowPage%>&recordPerPage=<%=recordPerPage%>&col=<%=col%>&word=<%=word%>&listFile=<%=listFile%>'">새로운 파일 등록시 클릭 하세요.</button>
        <%  
        } 
        %>         
      </li>    
    </ul>
  </fieldset>
 
</FORM>
 
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
 
</body>
</html> 