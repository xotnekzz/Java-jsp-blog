<%@ page contentType="text/html; charset=UTF-8" %>
 
<%@ include file="./ssi.jsp" %>
 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>공지시항</title>
<link href="../css/style.css" rel="Stylesheet" type="text/css"> 
<script type="text/JavaScript"
        src="http://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
 
<script type="text/javascript">


$(function() { // 페이지 실행시 자바스크립트 실행 (window.onload랑 같은거라 생각하면됨)
  $('#btn_send').html('등록'); // button label 지정
  $('#btn_send').on('click', create_proc_req); // click 이벤트 등록 
  $('#btn_init').on('click', init); // click 이벤트 등록 
  
  $('#title').on('keydown', function(key) {
    if(key.keyCode == 13) {
    $('#rname').focus();
    }
  });
  
  $('#rname').on('keydown', function(key) {
    if(key.keyCode == 13) {
    $('#btn_send').focus();
    }
  });
  
  $('#btn_send').on('keydown', function(key) {
    if(key.keyCode == 13) {
    $('#panel_close_a').focus();
    }
  });
  
  list();
});

// 등록 처리
function create_proc_req() { 
  $.ajax({   	
    url: './create_proc.jsp',
    type: "post", // or GET
    cache: false, // 최신 캐시데이터를 가져온다.
    async: true, // true: 비동기 , false: 동기   
    dataType: "json", // html or json, text, xml... (응답데이터형식)
    data: $('#frm').serialize(),
    success: function(received_data) { // callback 함수  -> 개발자는 선언만 할 뿐 호출은 프레임워크가 담당한다.
      var display_msgs = ''; // 출력용 display msgs
      var msgs = received_data.msgs;
      
      for(var i=0; i < msgs.length ; i++){
        display_msgs += msgs[i] + '<br>';
      }
      
      $('#title').val();
      var panel_close = $('#panel_close').clone(); // 태그 복제
      // panel_close.css('display','');
      $('#panel').html(display_msgs);
      $('#panel').append(panel_close.show());
      $('#panel').show();
      
      $('#btn_panel_close').focus();
    },
    // Ajax 통신 에러, 응답 코드가 200이 아닌 경우 에러 , 응답 dataType이 다른 경우 error 루틴이 
    // 실행되나 Console로만 출력되고 , 화면경우에는 보안상 출력하지 않는다.
    error: function (request, status, error) { 
      console.log('<strong>ERROR</strong><br>' +  error + '<br>');
    }
  });
 }  

// 목록
function list() { 
  $.ajax({   	
    url: './list_html.jsp',
    type: "get", // or GET
    cache: false, // 최신 캐시데이터를 가져온다.
    async: true, // true: 비동기 , false: 동기  
    dataType: "html", // html or json 
    success: function(received_data) { // callback 함수  -> 개발자는 선언만 할 뿐 호출은 프레임워크가 담당한다.
     $('#list').html(received_data); 
		 setTimeout(function() { $('#title').focus() }, 100) // 0.01초
    },
    // Ajax 통신 에러, 응답 코드가 200이 아닌 경우 에러 , 응답 dataType이 다른 경우 error 루틴이 
    // 실행되나 Console로만 출력되고 , 화면경우에는 보안상 출력하지 않는다.
    error: function (request, status, error) { 
      console.log('<strong>ERROR</strong><br>' +  error + '<br>');
    }
  });
}

// 수정 폼
function update_form_req(notice4no) { 
  console.log("notice4no: " + notice4no);
  $.ajax({   	
    url: './update_form.jsp',
    type: "get", // or GET  
    cache: false, // 최신 캐시데이터를 가져온다.
    async: true, // true: 비동기 , false: 동기   
    dataType: "json", // html or json, text, xml... (응답데이터형식)
    data: 'notice4no=' + notice4no,
    success: function(received_data) { // callback 함수  -> 개발자는 선언만 할 뿐 호출은 프레임워크가 담당한다.
     
     $('#notice4no').val(received_data.notice4no);
     $('#title').val(received_data.title); 
     $('#rname').val(received_data.rname);
     
     $('#btn_send').html('수정');
     $('#btn_send').off('click'); // 이벤트 해제
     $('#btn_send').on('click', update_proc_req); // click 이벤트 등록 
     
     $('#btn_init').html('취소');
     
    },
    // Ajax 통신 에러, 응답 코드가 200이 아닌 경우 에러 , 응답 dataType이 다른 경우 error 루틴이 
    // 실행되나 Console로만 출력되고 , 화면경우에는 보안상 출력하지 않는다.
    error: function (request, status, error) { 
      console.log('<strong>ERROR</strong><br>' +  error + '<br>');
    }
  });
}

// 수정 처리
function update_proc_req() { 
  $.ajax({   	
    url: './update_proc.jsp',
    type: "post", // or GET  
    cache: false, // 최신 캐시데이터를 가져온다.
    async: true, // true: 비동기 , false: 동기   
    dataType: "json", // html or json, text, xml... (응답데이터형식)
    data: $('#frm').serialize(),
    success: function(received_data) { // callback 함수  -> 개발자는 선언만 할 뿐 호출은 프레임워크가 담당한다.
      var display_msgs = ''; // 출력용 display msgs
      var msgs = received_data.msgs; 
      
      for(var i=0; i < msgs.length ; i++){
        display_msgs += msgs[i] + '<br>';
      }
      
      $('#title').val();   
      var panel_close = $('#panel_close').clone(); // 태그 복제
      // panel_close.css('display','');
      $('#panel').html(display_msgs);
      $('#panel').append(panel_close.show());
      $('#panel').show();
          
      $('#btn_panel_close').focus();
    },
    // Ajax 통신 에러, 응답 코드가 200이 아닌 경우 에러 , 응답 dataType이 다른 경우 error 루틴이 
    // 실행되나 Console로만 출력되고 , 화면경우에는 보안상 출력하지 않는다.
    error: function (request, status, error) { 
      console.log('<strong>ERROR</strong><br>' +  error + '<br>');
    }
  });
}

//삭제 폼
function delete_form_req(notice4no) { 
  $.ajax({   	
    url: './delete_form.jsp',
    type: "get", // or GET  
    cache: false, // 최신 캐시데이터를 가져온다.
    async: true, // true: 비동기 , false: 동기   
    dataType: "json", // html or json, text, xml... (응답데이터형식)
    data: 'notice4no=' + notice4no,
    success: function(received_data) { // callback 함수  -> 개발자는 선언만 할 뿐 호출은 프레임워크가 담당한다.
     
     $('#notice4no').val(received_data.notice4no);
     $('#title').val(received_data.title); 
     $('#rname').val(received_data.rname);
     
     $('#btn_send').html('삭제');
     $('#btn_send').off('click'); // 이벤트 해제
     $('#btn_send').on('click', delete_proc_confirm); // click 이벤트 등록 
     
     $('#btn_init').html('취소');
     
    },
    // Ajax 통신 에러, 응답 코드가 200이 아닌 경우 에러 , 응답 dataType이 다른 경우 error 루틴이 
    // 실행되나 Console로만 출력되고 , 화면경우에는 보안상 출력하지 않는다.
    error: function (request, status, error) { 
      console.log('<strong>ERROR</strong><br>' +  error + '<br>');
    }
  });
}

// 삭제 확인
function delete_proc_confirm() {
  $('#panel').html('');
  var panel_delete_confirm = $('#panel_delete_confirm').clone(); // 태그 복제
  $('#panel').append(panel_delete_confirm.show());
  $('#panel').show();
}


// 삭제 처리
function delete_proc_req() { 
  $.ajax({   	
    url: './delete_proc.jsp',
    type: "post", // or GET  
    cache: false, // 최신 캐시데이터를 가져온다.
    async: true, // true: 비동기 , false: 동기   
    dataType: "json", // html or json, text, xml... (응답데이터형식)
    data: $('#frm').serialize(),
    success: function(received_data) { // callback 함수  -> 개발자는 선언만 할 뿐 호출은 프레임워크가 담당한다.
      var display_msgs = ''; // 출력용 display msgs
      var msgs = received_data.msgs; 
      
      for(var i=0; i < msgs.length ; i++){
        display_msgs += msgs[i] + '<br>';
      }
      
      $('#title').val();   
      var panel_close = $('#panel_close').clone(); // 태그 복제
      // panel_close.css('display','');
      $('#panel').html(display_msgs);
      $('#panel').append(panel_close.show());
      $('#panel').show();
          
      $('#btn_panel_close').focus();
      init();
    },
    // Ajax 통신 에러, 응답 코드가 200이 아닌 경우 에러 , 응답 dataType이 다른 경우 error 루틴이 
    // 실행되나 Console로만 출력되고 , 화면경우에는 보안상 출력하지 않는다.
    error: function (request, status, error) { 
      console.log('<strong>ERROR</strong><br>' +  error + '<br>');
    }
  });
}

// 태그의 입력값 초기화
function init() {
	$('#notice4no').val('');
  $('#title').val('');
  $('#rname').val('');
  $('#btn_send').html('등록');
  
  $('#title').focus();
}

function btn_panel_close() {
  $('#panel').hide();
  $('#title').focus();
  
  list();
}

</script>
 
</head>
<body>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='container'>
<jsp:include page="/menu/menu.jsp" flush='false' />
<DIV class='content'>
  <!-- 전송시 체크된 값 관련 메시지 출력 -->
  <div id='panel' class='popup1' style='display: none; height: 150px;'>
  </div>
  <DIV id='panel_close' style='display: none; height: 150px;'>
    <!--  <br>[<A href="javascript: $('#panel').hide(); $('#title').focus();" id="panel_close_a">CLOSE</A>]-->
    <br>[<button type='button' onclick="btn_panel_close();" id="btn_panel_close">닫기</button>]
  </DIV>
  
   <DIV id='panel_delete_confirm' style='display: none;'>
   	 <span style='color: white;'>정말로 삭제하시겠습니까?</span><br>
    <button type='button' onclick="delete_proc_req();" id="delete_proc">삭제</button>
    <button type='button' onclick="btn_panel_close();" id="btn_panel_close">취소</button>
  </DIV>
  
      
  
  <form name='frm' id='frm' action='' method='POST'>
  			<input type='hidden' name='notice4no' id='notice4no' value=''>
    <fieldset class='fieldset_basic'>
      <legend class='legend_basic'>공지시항</legend>
      <ul>
        <li class='li_none'>
          <label for='title'>내용: </label>
          <input type='text' name='title' id='title' size='50'  style='width: 90%;'>
        </li>
        <li class='li_none'>
          <label for='rname'>성명: </label>
          <input type='text' name='rname' id='rname' size='40'  style='width: 70%;'>
          <button type='button' id='btn_send'>등록</button>
          <button type='button' id='btn_init'>취소</button>     
        </li>
      </ul>
    </fieldset>
  </form>
  
  <DIV id='list'></DIV>
 
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>
 
</html>
 
 