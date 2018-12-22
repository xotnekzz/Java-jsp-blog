<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
 <%
 int devdiaryno = Integer.parseInt(request.getParameter("devdiaryno"));
 int devcateno = Integer.parseInt(request.getParameter("devcateno"));
  System.out.println("comment devdiary --> " + devdiaryno); 
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>게시판</title>
<script type="text/JavaScript"
        src="http://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
 
<script type="text/javascript">


$(function() { // 페이지 실행시 자바스크립트 실행 (window.onload랑 같은거라 생각하면됨)
  $('#btn_send').on('click', create_proc_req); // click 이벤트 등록 
  
  $('#btn_send').on('keydown', function(key) {
    if(key.keyCode == 13) {
    $('#panel_close_a').focus();
    }
  });
  
});

// 등록 처리
function create_proc_req() { 
  console.log("frm data = >>" + $('frm'));
  $.ajax({     
    url: '../comment/create_proc.jsp',
    type: "post", // or GET
    cache: false, // 최신 캐시데이터를 가져온다.
    async: true, // true: 비동기 , false: 동기   
    dataType: "json", // html or json, text, xml... (응답데이터형식)
    data: $('#frm').serialize(),
    success: function(received_data) { // callback 함수  -> 개발자는 선언만 할 뿐 호출은 프레임워크가 담당한다.
      var display_msgs = ''; // 출력용 display msgs
      var msgs = received_data.msgs;
      
      if(msgs.length > 0) {
      for(var i=0; i < msgs.length ; i++){
        display_msgs += msgs[i] + '<br>';
      }
            
      var panel_close = $('#panel_close').clone(); // 태그 복제
      // panel_close.css('display','');
      $('#panel').html(display_msgs);
      $('#panel').append(panel_close.show());
      $('#panel').show();
      
      $('#btn_panel_close').focus();
      
    <%-- <% response.sendRedirect("./read.jsp?devcateno="+devcateno+"&devdiaryno="+devdiaryno); %> --%>
     location.replace("./read.jsp");
    } 
    },
    // Ajax 통신 에러, 응답 코드가 200이 아닌 경우 에러 , 응답 dataType이 다른 경우 error 루틴이 
    // 실행되나 Console로만 출력되고 , 화면경우에는 보안상 출력하지 않는다.
    error: function (request, status, error) { 
      console.log('<strong>ERROR</strong><br>' +  error + '<br>');
    }
  });
 }  
</script>  
</head> 

  <div id='panel' class='popup1' style='display: none; height: 150px;'>
  </div>
    <DIV id='panel_close' style='display: none; height: 150px;'>
    <!--  <br>[<A href="javascript: $('#panel').hide(); $('#title').focus();" id="panel_close_a">CLOSE</A>]-->
    <br>[<button type='button' onclick="btn_panel_close();" id="btn_panel_close">닫기</button>]
  </DIV>

<div class='comment_form' style="width: 100%; height: 280px;">
  <div class='comment_top'>
  <span style="text-align: left; font-weight: bold; font-size: 24pt;'">댓글</span> 24
  </div>
   <form id='frm' > 
      <input type='hidden'  id ='devdiaryno' name='devdiaryno'  value='<%=devdiaryno%>'> 
     <fieldset class='comment_content' style="height: 250px; border: none;" >
     <ul> 
      <li class='li_none'>  
        <textarea name='content' id='content' rows='5' style='width: 100%; resize: none;'></textarea>
      </li>    
      <li class='li_right' style="margin-right: 15px;">
        <label for='rname'>이름 : </label>
        <input type='text' id='rname' name='rname' size='10%'/>
        <label for='email'>이메일 : </label>
        <input type='text' id='email' name='email' size='10%'/>
        <label for='rname'>비밀번호 : </label>
        <input type='text' id='passwd' name='passwd' size='10%'/>
        <button type='button' id='btn_send'>등록</button>
      </li>     
    </ul> 
  </fieldset> 
  </form>  
</div>
</body>   
</html>  