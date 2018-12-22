<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="./ssi.jsp" %>

 
<%
// 로그인 후 이동할 주소
String url_address = Tool.checkNull(request.getParameter("url_address"));
System.out.println("--> 3) login_form.jsp: url_address: " + url_address);
%>
 
<% 
Cookie[] cookies = request.getCookies();
Cookie cookie = null;
 
String ck_email = ""; // email 저장 변수
String ck_email_save = ""; // email 저장 여부를 체크하는 변수
//String ck_passwd = ""; // passwd 저장 변수
//String ck_passwd_save = ""; // passwd 저장 여부를 체크하는 변수
 
for (int i=0; i < cookies.length; i++){
  cookie = cookies[i];
  
  if (cookie.getName().equals("ck_email")){
    ck_email = cookie.getValue();         // test1@mail.com
  }else if(cookie.getName().equals("ck_email_save")){
    ck_email_save = cookie.getValue();  // Y, N
  }
}
%> 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title>로그인</title> 
 
<link href="../css/style.css" rel="Stylesheet" type="text/css">
<script type="text/javascript" src="../js/tool.js"></script>
<script type="text/javascript">
function send(f) {
	var sw = true;
	var msg = '';
/* 	
	if(length('email') == 0 && length('passwd') == 0){
		find('popup_content').innerHTML = '이메일과 비밀번호를 입력해주세요.<br>';  
		show('popup'); 
		f.email.focus();
		sw = false;   
	} else if(length('email') == 0 ) {
		find('popup_content').innerHTML = '이메일을 입력해주세요.<br>';  
		show('popup'); 
		f.email.focus();
		sw = false;   
	} else if(length('passwd') == 0 ) {
		find('popup_content').innerHTML = '비밀번호를 입력해주세요.<br>'; 
		show('popup');
		f.passwd.focus();  	
		sw = false; 
	} else { 
		hide('popup');
	}
	 */
	 
	if(length('email') == 0 && length('passwd') == 0){
		msg = '이메일과 비밀번호를 입력해주세요.<br>';  
		show('popup'); 
		f.email.focus();
		sw = false;   
	} else if(length('email') == 0 ) {
		msg = '이메일을 입력해주세요.<br>';  
		show('popup'); 
		f.email.focus();
		sw = false;   
	} else if(length('passwd') == 0 ) {
		msg = '비밀번호를 입력해주세요.<br>';  
		f.passwd.focus();  	
		sw = false; 
	}
	
	if(sw==false) { 
		find('popup_content').innerHTML = msg; 
		show('popup');
	}
	
	return sw;
} 
</script>
 
</head>  
<body>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='container'>
<jsp:include page="/menu/menu.jsp" flush='false' />
<DIV class='content'>
 
<DIV class='aside_menu'>
  <ASIDE style='float: left;'>회원 ＞ 로그인 </ASIDE> 
  <ASIDE style='float: right;'>
    <A href='./list.jsp'>목록</A> <span class='menu_divide'> |</span> 
    <A href='./create_form.jsp'>가입</A> <span class='menu_divide'> |</span>
    <A href='javascript: location.reload()'>새로고침</A> <span class='menu_divide'> |</span>
  </ASIDE> 
  <ASIDE style='float: right;'>
  </ASIDE> 
  <DIV class='menu_line' style='clear: both;'></DIV>
</DIV>  
 
<DIV style='width: 60%; margin: 10px auto;'>

  <!-- 레이어 선언 -->
  <DIV id='popup' class='popup1' style='display: none;'>
    <h2 style='color: #FFFFFF; text-decoration: underline;'>알림</h2>
    <DIV id='popup_content' class='popup_content'></DIV>
    [<A href="javascript: hide('popup'); focus();">CLOSE</A>]
  </DIV>
  
<FORM name='frm' method='POST' action='./login_ck_proc.jsp' onsubmit="return send(this);">
  <input type="hidden" name="url_address" value="<%=url_address %>">
  
  <fieldset class='fieldset_no_line'>
    <ul>
      <li class='li_none'> 
        <label class='label_basic' for='email'>이메일</label>
        <input type='email' name='email' id='email' value='<%=ck_email %>' style='width: 50%;' autocomplete="off">
        <label>
        <input type='checkbox' name='email_save' value='Y' <%=(ck_email_save.equals("Y"))?"checked='checked'": "" %>> 저장
        </label>
      </li>
      <li class='li_none'>
        <label class='label_basic' for='passwd'>패스워드</label>
        <input type='password' name='passwd' id='passwd' value='' style='width: 50%;' autocomplete="off">
      </li>
      <li class='li_center'>
        <button type='submit'>로그인</button>
        <button type='button' onclick="history.back();">취소</button>
        
      </li>
    </ul>
  </fieldset>
</FORM>
<!-- 전송시 체크된 값 관련 메시지 출력 -->
  <DIV id='panel' class='span_warning' style='display: none;'></DIV>
  <br>
</DIV>
 
</DIV> <!-- content END --> 
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>
 
</html> 