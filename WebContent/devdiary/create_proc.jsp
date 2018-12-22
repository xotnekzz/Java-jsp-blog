<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="./ssi.jsp" %>
 
<%
String tempDir = application.getRealPath("/devdiary/temp"); // WebContent 기준
String upDir = application.getRealPath("/divdiary/storage");
// request, 메모리에 저장할 크기, 업로드할 최대 파일 크기, 임시 저장 폴더
Upload upload = new Upload(request, -1, 1048576000, tempDir);
  
int devcateno = Integer.parseInt(upload.getParameter("devcateno"));
listFile = upload.toKor(upload.getParameter("listFile"));
devcategoryVO = devcategoryProc.selectOne(devcategoryVO, devcateno);
String category_title = devcategoryVO.getTitle(); 
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
 
<DIV class='message'>
<%
String title_main = upload.toKor(upload.getParameter("title_main"));
String title_sub = upload.toKor(upload.getParameter("title_sub"));
String content = upload.toKor(upload.getParameter("content"));
System.out.println("content tokor : " + content);
String rname = upload.toKor(upload.getParameter("rname"));
String email = upload.toKor(upload.getParameter("email"));
String passwd  = upload.toKor(upload.getParameter("passwd"));
   

DevdiaryVO devdiaryVO = new DevdiaryVO();
devdiaryVO.setDevcateno(devcateno);
devdiaryVO.setTitle_main(title_main);
devdiaryVO.setTitle_sub(title_sub);
devdiaryVO.setContent(content);
devdiaryVO.setRname(rname);
devdiaryVO.setEmail(email);  
devdiaryVO.setPasswd(passwd);
devdiaryVO.setVisible("Y");
  
// <input type='file' name='file1' style='width: 100%;'>
FileItem fileItem = upload.getFileItem("file");
String file = "";   // 사용자가 전송한 파일명
String fstor1 = ""; // 실제 서버상의 디스크에 저장되는 파일명
String thumb = ""; // preview mini 이미지
long size1 = 0;      // 원본 파일의 크기
 
file = fileItem.getName(); // 원본 파일명
devdiaryVO.setFile(file);
 
size1 = fileItem.getSize(); // 파일 크기
 
if (size1 > 0) {
  if (size1 < 10485760) { // 1 ~ 10485760 byte
    fstor1 = upload.saveFile(fileItem, upDir); // Tomcat이 전송받은 파일을 서버에 저장
    devdiaryVO.setFstor1(fstor1); // 저장된 파일명 적용
    devdiaryVO.setSize1(size1);   
    // 업로드 디렉토리, 소스 파일명, width, height
    if (Tool.isImage(fstor1)) {
      devdiaryVO.setThumb(Tool.preview(upDir, fstor1, 200, 150)); // Thumbnail 이미지 생성
    }
  } else {
%>
    <span class='span_warning'>
    전송 파일의 크기는 10 MB를 넘을 수 없습니다. 다시 시도해주세요.
    </span>
<%    
  }
}  
int count = 0;
count = devdiaryProc.insert(devdiaryVO); 
if (count == 1) {
  devcategoryProc.increaseCnt(devcateno);
%>
  <span class='span_info'>
    자료를 등록했습니다.
  </span> 
<%     
} else {
%>
  <span class='span_warning'>
    자료 등록에 실패했습니다. 다시 시도해 주세요.
  </span>
<%
}
%>
  </DIV>  
 
  <DIV class='bottom_menu' style='text-align: center;'>
    <button type='button' onclick="location.href='./create_form.jsp?./list.jsp?devcateno=<%=devcateno %>&col=<%=col%>&word=<%=word%>&nowPage=<%=nowPage%>&recordPerPage=<%=recordPerPage%>'">계속 등록</button>
    <button type='button' onclick="location.href='./list.jsp?devcateno=<%=devcateno %>&col=<%=col%>&word=<%=word%>&nowPage=<%=nowPage%>&recordPerPage=<%=recordPerPage%>'">목록</button>
  </DIV>
   
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
 
</body>
</html>