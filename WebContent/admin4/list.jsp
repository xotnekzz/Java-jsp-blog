<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="./ssi.jsp" %>
<%@ include file="./auth.jsp" %>
 
<!DOCTYPE html>  
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
 
<link href="../css/style.css" rel="Stylesheet" type="text/css">
<script type="text/javascript">
  function act_form(admin4no, act) {
    // 문자열: ', ""
    var url = './act_form.jsp?admin4no=' + admin4no + '&act=' + act;
    var width = 500;
    var height = 450;
    var win = window.open(url, '권한 변경', 'width='+width+'px, height='+height+'px');
    var x = (screen.width - width) / 2; 
    var y = (screen.height - height) / 2;
    
    win.moveTo(x, y);
  }
  
  function passwd_form(admin4no) {
    // 문자열: ', ""
    var url = './passwd_form.jsp?admin4no=' + admin4no;
    var width = 700;
    var height = 350;
    var win = window.open(url, '패스워드 변경', 'width='+width+'px, height='+height+'px');
    var x = (screen.width - width) / 2; 
    var y = (screen.height - height) / 2;
    
    win.moveTo(x, y);
  }  
  
  function update_form(admin4no) {
    // 문자열: ', ""
    var url = './update_form.jsp?admin4no=' + admin4no;
    var width = 640;
    var height = 280;
    var win = window.open(url, '관리자 정보 변경', 'width='+width+'px, height='+height+'px');
    var x = (screen.width - width) / 2; 
    var y = (screen.height - height) / 2;
    
    win.moveTo(x, y);
  }  
  
  function delete_form(admin4no) {
    // 문자열: ', ""
    var url = './delete_form.jsp?admin4no=' + admin4no;
    var width = 800;
    var height = 400;
    var win = window.open(url, '관리자 삭제', 'width='+width+'px, height='+height+'px');
    var x = (screen.width - width) / 2; 
    var y = (screen.height - height) / 2;
    
    win.moveTo(x, y);
  }  
  
</script>
</head>
 
<body>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='container'>
<jsp:include page="/menu/menu.jsp" flush='false' /> 
<DIV class='content'>
 
<DIV class='aside_menu' style="margin-bottom: 40px;">
  <ASIDE style='float: left;'>관리자 ＞ 목록</ASIDE> 
  <ASIDE style='float: right;'>
    <A href='./list.jsp'>목록</A> <span class='menu_divide'> |</span> 
    <A href='./create_form.jsp'>가입</A> <span class='menu_divide'> |</span>
    <A href='javascript: location.reload()'>새로고침</A> <span class='menu_divide'> |</span>
  </ASIDE> 
  <ASIDE style='float: right;'>
  </ASIDE> 
  <DIV class='menu_line' style='clear: both;'></DIV>
</DIV> 
<%
ArrayList<Admin4VO> list = adminProc.list();  
%>
  
<TABLE class='table_basic'>
  <CAPTION style="margin-bottom: 30px;">
  권한: M: Master, H: 대기(Hold), Y: 로그인 가능, N: 로그인 불가 / 이메일 확인: Y(확인), N(미확인)
  </CAPTION>
  <TR>
    <TH class='th_basic' style='width: 10%;'>번호</TH>
    <TH class='th_basic' style='width: 10%;'>성명</TH>
    <TH class='th_basic' style='width: 20%;'>이메일</TH>
    <TH class='th_basic' style='width: 10%;'>인증키</TH>
    <TH class='th_basic' style='width: 10%;'>권한</TH>
    <TH class='th_basic' style='width: 15%;'>이메일 확인</TH>
    <TH class='th_basic' style='width: 15%;'>등록일</TH>
    <TH class='th_basic' style='width: 10%;'>기타</TH>
  </TR>
 
<%
  for(int index=0; index < list.size(); index++){
    Admin4VO admin4VO = list.get(index);
    int admin4no = admin4VO.getAdmin4no();
 
%> 
  <TR>
    <TD class='td_basic'><%=admin4no %></TD>
    <TD class='td_basic'><%=admin4VO.getMname() %></TD>
    <TD class='td_left'><%=admin4VO.getEmail() %></A></TD>
    <TD class='td_basic'><%=admin4VO.getAuth() %></TD>
    <TD class='td_basic'>
      <A href="javascript: act_form(<%=admin4no %>, '<%=admin4VO.getAct() %>')"><%=admin4VO.getAct() %></A>
    </TD>
    <TD class='td_basic'><%=admin4VO.getConfirm() %></TD>
    <TD class='td_basic'><%=admin4VO.getMdate().substring(0, 10) %></TD>
    <TD class='td_basic'>
      <A href="javascript:passwd_form(<%=admin4no %>)"><IMG src='./images/passwd.png' title='패스워드 변경'></A>
      <A href="javascript:update_form(<%=admin4no %>)"><IMG src='./images/update.png' title='수정'></A>
      <A href="javascript:delete_form(<%=admin4no %>)"><IMG src='./images/delete.png' title='삭제'></A>
    </TD>
    
  </TR>
<%
  }
%>
 
</TABLE>
 
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>
 
</html> 
 
 