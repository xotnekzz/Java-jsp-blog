<%@ page contentType="text/html; charset=UTF-8" %>
 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>카테고리</title>
<link href="../css/style.css" rel='Stylesheet' type='text/css'>
</head>
<body>
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'>
 
  <form name='frm' action='./create_proc.jsp' method='POST'>
    <fieldset class='fieldset_basic'>
      <legend class='legend_basic'>카테고리 등록(*: 필수)</legend>
      <ul>
        <li class='li_none'>
          <input type='text' name='title' id='title' value='국내 영화' style='width: 25%;' placeholder="게시판 제목">*
           순서 <input type='number' name='seqno' id='seqno' value='1' min='1' max='1000' step='1'>
           View 
          <label>
            <input type='radio' name='visible' id='visible' value='Y' checked="checked"> Y
          </label>
          <label>
            <input type='radio' name='visible' id='visible' value='N'> N
          </label>
            <input type='text' name='ids' id='ids' value='<%=session.getAttribute("email") %>'  style='width: 20%;' placeholder="접근 계정">*
                     
          <button type='submit'>등록</button>
          <button type='reset'>취소</button>
        </li>
      </ul>
    </fieldset>
    
  </form>
 
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
 
</body>
</html>