<%@ page language="java" contentType="text/html; charset=EUC-KR"
  pageEncoding="EUC-KR"%>
<%@ include file="./ssi.jsp"%>
<%
String email = "";
String rname = "";
if(session.getAttribute("email") != null) { 
 email = (String)session.getAttribute("email");
 rname = (String)session.getAttribute("mname");
}  

int devdiaryno = Integer.parseInt(request.getParameter("devdiaryno"));
int devcateno = Integer.parseInt(request.getParameter("devcateno"));
int cnt = commentProc.count(devdiaryno);

//페이지당 출력할 레코드 갯수
int recordPerPage =  0;
if (request.getParameter("recordPerPage") == null) {
recordPerPage = 5;
} else {
recordPerPage = Integer.parseInt(request.getParameter("recordPerPage"));
}

//현재 페이지
int nowPage =  0;
if (request.getParameter("nowPage") == null) {
nowPage = 1; // 현재 페이지 1부터 시작
} else {
nowPage = Integer.parseInt(request.getParameter("nowPage"));
}

System.out.println("recordPage = " +recordPerPage);
System.out.println("nowPage = " +nowPage);

//-----------------------------------------------------------------------------
//페이징 관련 코드 시작
//-----------------------------------------------------------------------------

//listFile 목록 파일명
//recordCount 전체 레코드수 
//nowPage 현재 페이지
//recordPerPage 페이지당 레코드 수
//col 검색 컬럼 
//word 검색어  
String paging = new Paging().paging4(cnt, nowPage, recordPerPage, devdiaryno, devcateno);
//-----------------------------------------------------------------------------
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
  list();
  
  $('#btn_send').on('click', create_proc_req); // click 이벤트 등록 
  $('#btn_init').on('click', init); // click 이벤트 등록 
  $('#btn_init2').on('click', init2); // click 이벤트 등록  

   
  $('#btn_send').on('keydown', function(key) {
    if(key.keyCode == 13) {
    $('#panel_close_a').focus();
    }
  });
   
});

//태그의 입력값 초기화
function init() {
  $('#content').val('');
  $('#email').val('');
  $('#rname').val('');
  $('#passwd').val('');
  $('#btn_send').html('등록');
  $('#btn_send').off('click'); // 이벤트 해제
  $('#btn_send').on('click', create_proc_req); // click 이벤트 등록 
   
  $('#content').focus();
  $('#fail_info').hide();  
}

// 답변 태그 입력값 초기화
function reply_init(cno) {
  $('#reply_content'+cno).val('');
  $('#reply_email'+cno).val('');
  $('#reply_rname'+cno).val('');          
  $('#reply_passwd'+cno).val(''); 
  $('#reply_btn_send'+cno).html('등록');
  $('#reply_content'+cno).focus();     
  
  $('#reply_fail_info'+cno).hide(); 
}

//태그의 입력값 초기화
function init2() {
  
  $('#content').css('display' , '');   
  $('#li_comment').css('display' , '');   

  $('#delete_form').css('display' , 'none');   
  $('#comment_info').css('display', 'none');
  
  $('#passwd2').val('');
  
  $('#content').focus();
  list();
}

//태그의 입력값 초기화
function reply_init2(cno) {
  console.log("reply_init2 호출 - >" + cno);
  $('#reply_content'+cno).show();
  $('#reply_li_comment'+cno).show();
 
  $('#reply_delete_form'+cno).remove();
  $('#reply_comment_info'+cno).remove();
  
  $('#reply_passwd2'+cno).remove();  
  
  $('#reply_content').focus();
}

//목록
function list() { 
  console.log("list() ->" + <%=devdiaryno%> );
  $.ajax({      
    url: '../comment/list_html.jsp',
    type: "get", // or GET
    cache: false, // 최신 캐시데이터를 가져온다.
    async: true, // true: 비동기 , false: 동기  
    dataType: "html", // html or json 
    data: 'devdiaryno=' + <%=devdiaryno%> + '&devcateno=' +<%=devcateno%> + '&recordPerPage=' +<%=recordPerPage%> + '&nowPage=' +<%=nowPage%>, 
    success: function(received_data) { // callback 함수  -> 개발자는 선언만 할 뿐 호출은 프레임워크가 담당한다.
     $('#list').html(received_data); 
    }, 
    // Ajax 통신 에러, 응답 코드가 200이 아닌 경우 에러 , 응답 dataType이 다른 경우 error 루틴이 
    // 실행되나 Console로만 출력되고 , 화면경우에는 보안상 출력하지 않는다.
    error: function (request, status, error) { 
      console.log('<strong>ERROR</strong><br>' +  error + '<br>');
    }
  });
}

// 답변 출력 
function reply_show(cno) {
  $.ajax({      
    url: '../comment/list_reply_html.jsp',
    type: "get", // or GET 
    cache: false, // 최신 캐시데이터를 가져온다.
    async: true, // true: 비동기 , false: 동기   
    dataType: "html", // html or json 
    data: 'cno=' + cno, 
    success: function(received_data) { // callback 함수  -> 개발자는 선언만 할 뿐 호출은 프레임워크가 담당한다.
     $('#comment_reply'+cno).html(received_data); 
     $('#comment_reply'+cno).css('display', ''); 
     $('#reply_form'+cno).css('display', '');          
     $('#reply_show'+cno).css('display', 'none');  
     $('#reply_hide'+cno).css('display', '');  
    }, 
    // Ajax 통신 에러, 응답 코드가 200이 아닌 경우 에러 , 응답 dataType이 다른 경우 error 루틴이 
    // 실행되나 Console로만 출력되고 , 화면경우에는 보안상 출력하지 않는다.
    error: function (request, status, error) { 
      console.log('<strong>ERROR</strong><br>' +  error + '<br>');
    }
  }); 
}

function reply_hide(cno){
  $('#reply_show'+cno).css('display', '');     
  $('#comment_reply'+cno).css('display', 'none');
  $('#reply_hide'+cno).css('display', 'none');  
  $('#reply_form'+cno).css('display', 'none');    
  reply_init(cno);    
} 
     
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
            
      $('#fail_info').html("<br>" + display_msgs)  ;
      $('#fail_info').show();
       
      $('#btn_panel_close').focus();
        
    <%-- <% response.sendRedirect("./read.jsp?devcateno="+devcateno+"&devdiaryno="+devdiaryno); %> --%>
    } 
     },
    // Ajax 통신 에러, 응답 코드가 200이 아닌 경우 에러 , 응답 dataType이 다른 경우 error 루틴이 
    // 실행되나 Console로만 출력되고 , 화면경우에는 보안상 출력하지 않는다.
    error: function (request, status, error) { 
      console.log('<strong>ERROR</strong><br>' +  error + '<br>');
    }
  });
  init();
  // 리스트 리다이렉트
  setTimeout(function() { list();  }, 100) // 0.01초
}

// 답변 등록  처리
function create_reply_proc_req(cno) {
  console.log("create_reply_proc 호출 - > cno " + cno);
  $.ajax({     
    url: '../comment/create_reply_proc.jsp', 
    type: "post", // or GET  
    cache: false, // 최신 캐시데이터를 가져온다.
    async: true, // true: 비동기 , false: 동기   
    dataType: "json", // html or json, text, xml... (응답데이터형식)
    data: $('#reply_frm'+cno).serialize(),     
    success: function(received_data) { // callback 함수  -> 개발자는 선언만 할 뿐 호출은 프레임워크가 담당한다.
      console.log("create_reply_proc 성공 - >");
      var display_msgs = ''; // 출력용 display msgs
      var msgs = received_data.msgs;
      
      if(msgs.length > 0) {
      for(var i=0; i < msgs.length ; i++){
        display_msgs += msgs[i] + '<br>';
      }
              
      $('#reply_fail_info'+cno).html("<br>" + display_msgs);
      $('#reply_fail_info'+cno).show(); 
      
      $('#btn_panel_close').focus();
          
    <%-- <% response.sendRedirect("./read.jsp?devcateno="+devcateno+"&devdiaryno="+devdiaryno); %> --%>
    } 
     },
    // Ajax 통신 에러, 응답 코드가 200이 아닌 경우 에러 , 응답 dataType이 다른 경우 error 루틴이 
    // 실행되나 Console로만 출력되고 , 화면경우에는 보안상 출력하지 않는다.
    error: function (request, status, error) { 
      console.log('<strong>ERROR</strong><br>' +  error + '<br>');
    }
  });
  reply_init(cno);
  // 리스트 리다이렉트
  setTimeout(function() { reply_show(cno);  }, 100) // 0.01초
}

    
 // 수정 폼 
function update_form_req(cno) { 
  $.ajax({    
  url: '../comment/update_form.jsp',
  type: "get", // or GET  
  cache: false, // 최신 캐시데이터를 가져온다.
  async: true, // true: 비동기 , false: 동기   
  dataType: "json", // html or json, text, xml... (응답데이터형식)
        data: 'cno=' + cno,
        success: function(received_data) { // callback 함수  -> 개발자는 선언만 할 뿐 호출은 프레임워크가 담당한다.
         $('#cno').val(received_data.cno);
         $('#content').val(received_data.content); 
         $('#rname').val(received_data.rname);
         $('#email').val(received_data.email);
         
         $('#fail_info').css('display', 'none');
         
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
  console.log("update_proc_req 호출");   
  $.ajax({    
    url: '../comment/update_proc.jsp',
    type: "post", // or GET  
    cache: false, // 최신 캐시데이터를 가져온다.
    async: true, // true: 비동기 , false: 동기   
    dataType: "json", // html or json, text, xml... (응답데이터형식)
    data: $('#frm').serialize(), 
    success: function(received_data) { // callback 함수  -> 개발자는 선언만 할 뿐 호출은 프레임워크가 담당한다.
      console.log("update_proc_req success 호출")
      var display_msgs = ''; // 출력용 display msgs
      var msgs = received_data.msgs; 
        
      for(var i=0; i < msgs.length ; i++){
        display_msgs += msgs[i] + '<br>';
      } 
          
      if(msgs.length > 0) {
       $('#fail_info').html("<br>" + display_msgs)  ;
       $('#fail_info').show();
      } 
    },
    // Ajax 통신 에러, 응답 코드가 200이 아닌 경우 에러 , 응답 dataType이 다른 경우 error 루틴이 
    // 실행되나 Console로만 출력되고 , 화면경우에는 보안상 출력하지 않는다.
    error: function (request, status, error) { 
    console.log('<strong>ERROR</strong><br>' +  error + '<br>');
    }
  });
  init();
  // 리스트 리다이렉트
  setTimeout(function() { list();  }, 100) // 0.01초
  }
  
  
// 답변 수정 폼
function update_reply_form_req(crno) { 
  console.log("update_reply_form 호출 - >" + crno);
  $.ajax({    
  url: '../comment/update_reply_form.jsp',
  type: "get", // or GET     
  cache: false, // 최신 캐시데이터를 가져온다.
  async: true, // true: 비동기 , false: 동기   
  dataType: "json", // html or json, text, xml... (응답데이터형식)
        data: 'crno=' + crno,
        success: function(received_data) { // callback 함수  -> 개발자는 선언만 할 뿐 호출은 프레임워크가 담당한다.
          console.log("update_reply_form 성공 - >" + received_data.content);
         $('#reply_crno'+received_data.cno).val(crno);          
         $('#reply_content'+received_data.cno).val(received_data.content);  
         $('#reply_rname'+received_data.cno).val(received_data.rname);
         $('#reply_email'+received_data.cno).val(received_data.email);
         
         $('#reply_fail_info').css('display', 'none');
           
         $('#reply_btn_send'+received_data.cno).hide();  
         $('#reply_btn_update'+received_data.cno).show();
         
        },
        // Ajax 통신 에러, 응답 코드가 200이 아닌 경우 에러 , 응답 dataType이 다른 경우 error 루틴이 
        // 실행되나 Console로만 출력되고 , 화면경우에는 보안상 출력하지 않는다.
        error: function (request, status, error) { 
          console.log('<strong>ERROR</strong><br>' +  error + '<br>');
        }
      });
    }
    
// 답변 수정 처리  
function update_reply_proc_req(cno) {  
  console.log("update_proc_req 호출" );   
  $.ajax({    
    url: '../comment/update_reply_proc.jsp',
    type: "post", // or GET  
    cache: false, // 최신 캐시데이터를 가져온다.
    async: true, // true: 비동기 , false: 동기   
    dataType: "json", // html or json, text, xml... (응답데이터형식)
    data: $('#reply_frm'+cno).serialize(), 
    success: function(received_data) { // callback 함수  -> 개발자는 선언만 할 뿐 호출은 프레임워크가 담당한다.
     
      var display_msgs = ''; // 출력용 display msgs    
      var msgs = received_data.msgs; 
        
      for(var i=0; i < msgs.length ; i++){
        display_msgs += msgs[i] + '<br>';
      } 
          
      if(msgs.length > 0) {
       $('#reply_fail_info'+cno).html("<br>" + display_msgs)  ;
       $('#reply_fail_info'+cno).show();
      } 
    },
    // Ajax 통신 에러, 응답 코드가 200이 아닌 경우 에러 , 응답 dataType이 다른 경우 error 루틴이 
    // 실행되나 Console로만 출력되고 , 화면경우에는 보안상 출력하지 않는다.
    error: function (request, status, error) { 
    console.log('<strong>ERROR</strong><br>' +  error + '<br>');
    }
  });
      $('#reply_btn_update'+cno).hide();
      $('#reply_btn_send'+cno).show();     
      $('#reply_passwd'+cno).val('');       
      reply_init(cno);
  // 리스트 리다이렉트
  setTimeout(function() { reply_show(cno);  }, 100) // 0.01초
  }    

//답변 삭제 폼
function delete_reply_form_req(crno) { 
  $.ajax({    
  url: '../comment/update_reply_form.jsp',
  type: "post", // or GET     
  cache: false, // 최신 캐시데이터를 가져온다.
  async: true, // true: 비동기 , false: 동기   
  dataType: "json", // html or json, text, xml... (응답데이터형식)
        data: 'crno=' + crno,
        success: function(received_data) { // callback 함수  -> 개발자는 선언만 할 뿐 호출은 프레임워크가 담당한다.
          $('#reply_content'+received_data.cno).hide();
          $('#reply_li_comment'+received_data.cno).css('display', 'none');
           
          $('#reply_delete_form'+received_data.cno).show();   
          $('#reply_comment_info'+received_data.cno).html('댓글번호 : '+ received_data.crno +'<br><br>'+received_data.rname +'('+ received_data.email + ')' + '님의 답변을 삭제 하시려면<br>'); 
          $('#reply_comment_info'+received_data.cno).show();  
          
          $('#reply_fail_info'+received_data.cno).hide();
           
          $('#reply_btn_delete'+received_data.cno).html('삭제');  
               
          $('#reply_btn_init2'+received_data.cno).html('취소');
          $('#reply_btn_init2'+received_data.cno).on('click', function() { reply_init2(received_data.cno) } ); // click 이벤트 등록  
        },           
        // Ajax 통신 에러, 응답 코드가 200이 아닌 경우 에러 , 응답 dataType이 다른 경우 error 루틴이 
        // 실행되나 Console로만 출력되고 , 화면경우에는 보안상 출력하지 않는다.
        error: function (request, status, error) { 
          console.log('<strong>ERROR</strong><br>' +  error + '<br>');
        }
      });      
    }
     
// 답변 삭제 처리
function delete_reply_proc_req(crno, cno) { 
  console.log("딜리트플록 crno : " + crno + " / cno : " + cno);
  console.log("딜리트플록 비번 : " + $('#reply_passwd2'+cno).val());
  $.ajax({    
    url: '../comment/delete_reply_proc.jsp',
    type: "post", // or GET  
    cache: false, // 최신 캐시데이터를 가져온다.
    async: true, // true: 비동기 , false: 동기   
    dataType: "json", // html or json, text, xml... (응답데이터형식)
    data: 'crno=' + crno + '&passwd=' +$('#reply_passwd2'+cno).val(),
    success: function(received_data) { // callback 함수  -> 개발자는 선언만 할 뿐 호출은 프레임워크가 담당한다.
      var display_msgs = ''; // 출력용 display msgs 
      var msgs = received_data.msgs;   
          
      for(var i=0; i < msgs.length ; i++){
        display_msgs += msgs[i] + '<br>';
      } 
          
      if(msgs.length > 0) {
        $('#reply_fail_info').html("<br>" + display_msgs) ;
        $('#reply_fail_info').show();
       } else {
         $('#reply_fail_info').css('display', 'none');
       }
      },
    // Ajax 통신 에러, 응답 코드가 200이 아닌 경우 에러 , 응답 dataType이 다른 경우 error 루틴이 
    // 실행되나 Console로만 출력되고 , 화면경우에는 보안상 출력하지 않는다.
      error: function (request, status, error) { 
      console.log('<strong>ERROR</strong><br>' +  error + '<br>');
    } 
      });  
  // 리스트 리다이렉트 
  setTimeout(function() { reply_show(cno)  }, 200) // 0.01초
  reply_init2(cno);   
}     

//삭제 폼
function delete_form_req(cno) { 
  $.ajax({    
    url: '../comment/update_form.jsp',
    type: "post", // or GET  
    cache: false, // 최신 캐시데이터를 가져온다.
    async: true, // true: 비동기 , false: 동기   
    dataType: "json", // html or json, text, xml... (응답데이터형식)
    data: 'cno=' + cno,
    success: function(received_data) { // callback 함수  -> 개발자는 선언만 할 뿐 호출은 프레임워크가 담당한다.    
     $('#content').css('display' , 'none');    
     $('#li_comment').css('display' , 'none');   
  
     $('#delete_form').css('display' , '');   
     $('#comment_info').html('댓글번호 : '+ received_data.cno +'<br><br>'+received_data.rname +'('+ received_data.email + ')' + '님의 댓글을 삭제 하시려면<br>'); 
     $('#comment_info').css('display' , '');   
     
     $('#fail_info').css('display', 'none');
     
     $('#btn_delete').html('삭제'); 
     $('#btn_delete').on('click', function() { delete_proc_req(received_data.cno) }); // click 이벤트 등록 
         
     $('#btn_init2').html('취소');
    },
    // Ajax 통신 에러, 응답 코드가 200이 아닌 경우 에러 , 응답 dataType이 다른 경우 error 루틴이 
    // 실행되나 Console로만 출력되고 , 화면경우에는 보안상 출력하지 않는다.
    error: function (request, status, error) { 
    console.log('<strong>ERROR</strong><br>' +  error + '<br>');
    }
  });
 }
  
// 삭제 처리
function delete_proc_req(cno) { 
  console.log(cno+"  , " + $('#passwd2').val() );
  $.ajax({    
    url: '../comment/delete_proc.jsp',
    type: "post", // or GET  
    cache: false, // 최신 캐시데이터를 가져온다.
    async: true, // true: 비동기 , false: 동기   
    dataType: "json", // html or json, text, xml... (응답데이터형식)
    data: 'cno=' + cno + '&passwd=' +$('#passwd2').val(),
    success: function(received_data) { // callback 함수  -> 개발자는 선언만 할 뿐 호출은 프레임워크가 담당한다.
      var display_msgs = ''; // 출력용 display msgs
      var msgs = received_data.msgs; 
          
      for(var i=0; i < msgs.length ; i++){
        display_msgs += msgs[i] + '<br>';
      } 
          
      if(msgs.length > 0) {
        $('#fail_info').html("<br>" + display_msgs) ;
        $('#fail_info').show();
       } else {
         $('#fail_info').css('display', 'none');
       }
      },
    // Ajax 통신 에러, 응답 코드가 200이 아닌 경우 에러 , 응답 dataType이 다른 경우 error 루틴이 
    // 실행되나 Console로만 출력되고 , 화면경우에는 보안상 출력하지 않는다.
      error: function (request, status, error) { 
      console.log('<strong>ERROR</strong><br>' +  error + '<br>');
    }
      });
  init2();
  // 리스트 리다이렉트
  setTimeout(function() { list();  }, 100) // 0.01초
}   

function cancel_reply_proc_req(cno) {
  $('#reply_btn_update'+cno).hide();
  $('#reply_btn_send'+cno).show();   
  reply_init(cno);
}
</script>
</head>

<body>
<div class='comment_form'
    style="width: 100%; height: 280px; margin-bottom: 50px;">
    <div class='comment_top'>
      <span
        style="text-align: left; font-weight: bold; font-size: 24pt;'">댓글</span>
      <%=cnt%>
    </div>
    <form id='frm'>
      <input type='hidden' id='devdiaryno' name='devdiaryno' value='<%=devdiaryno%>'> 
        <input type='hidden' id='cno' name='cno' value=''>
      <fieldset class='comment_content' style="height: 250px; border: none;">
        <ul>
          <li class='li_none' id='delete_form' style="display: none; text-align: center;"> 
          <span id='comment_info'></span>
          해당 댓글의 비밀번호를 입력해주세요.<br><br>
          <label for='passwd' id='label_passwd'>비밀번호 : </label> 
          <input type='password' id='passwd2' name='passwd2'size='10%' />
           <button type='button' id='btn_delete'  style="margin-top: 20px;">삭제</button> 
           <button type='button' id='btn_init2'>취소</button> 
          </li> 
          <li class='li_none'>
          <textarea name='content' id='content' rows='5' style='width: 100%; resize: none;'></textarea>
           </li> 
          <li id='li_comment' class='li_right' style="margin-right: 15px;">
          <label for='rname' id='label_rname'>이름 : </label> 
          <input type='text' id='rname' name='rname' value ='<%=rname %>'  size='10%' /> 
          <label for='email' id='label_email'>이메일 : </label> 
          <input type='email' id='email' name='email'  value ='<%=email %>' size='20%' /> 
          <label for='passwd' id='label_passwd'>비밀번호 : </label> 
          <input type='password' id='passwd' name='passwd' size='10%' />  
            <button type='button' id='btn_send'>등록</button>
            <button type='button' id='btn_init'>취소</button> 
            <span id='fail_info' style="display: none; color: #fa2b05;"></span>
         </li>
       </ul> 
     </fieldset>
   </form>
</div>

  <DIV id='list'> 
  </DIV>
  <DIV class='bottom_menu'>
    <%=paging%>
  </DIV> 
</body>
</html>
