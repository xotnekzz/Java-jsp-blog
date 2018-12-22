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

//�������� ����� ���ڵ� ����
int recordPerPage =  0;
if (request.getParameter("recordPerPage") == null) {
recordPerPage = 5;
} else {
recordPerPage = Integer.parseInt(request.getParameter("recordPerPage"));
}

//���� ������
int nowPage =  0;
if (request.getParameter("nowPage") == null) {
nowPage = 1; // ���� ������ 1���� ����
} else {
nowPage = Integer.parseInt(request.getParameter("nowPage"));
}

System.out.println("recordPage = " +recordPerPage);
System.out.println("nowPage = " +nowPage);

//-----------------------------------------------------------------------------
//����¡ ���� �ڵ� ����
//-----------------------------------------------------------------------------

//listFile ��� ���ϸ�
//recordCount ��ü ���ڵ�� 
//nowPage ���� ������
//recordPerPage �������� ���ڵ� ��
//col �˻� �÷� 
//word �˻���  
String paging = new Paging().paging4(cnt, nowPage, recordPerPage, devdiaryno, devcateno);
//-----------------------------------------------------------------------------
%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>�Խ���</title>
<script type="text/JavaScript"
  src="http://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>

<script type="text/javascript">

$(function() { // ������ ����� �ڹٽ�ũ��Ʈ ���� (window.onload�� �����Ŷ� �����ϸ��)
  list();
  
  $('#btn_send').on('click', create_proc_req); // click �̺�Ʈ ��� 
  $('#btn_init').on('click', init); // click �̺�Ʈ ��� 
  $('#btn_init2').on('click', init2); // click �̺�Ʈ ���  

   
  $('#btn_send').on('keydown', function(key) {
    if(key.keyCode == 13) {
    $('#panel_close_a').focus();
    }
  });
   
});

//�±��� �Է°� �ʱ�ȭ
function init() {
  $('#content').val('');
  $('#email').val('');
  $('#rname').val('');
  $('#passwd').val('');
  $('#btn_send').html('���');
  $('#btn_send').off('click'); // �̺�Ʈ ����
  $('#btn_send').on('click', create_proc_req); // click �̺�Ʈ ��� 
   
  $('#content').focus();
  $('#fail_info').hide();  
}

// �亯 �±� �Է°� �ʱ�ȭ
function reply_init(cno) {
  $('#reply_content'+cno).val('');
  $('#reply_email'+cno).val('');
  $('#reply_rname'+cno).val('');          
  $('#reply_passwd'+cno).val(''); 
  $('#reply_btn_send'+cno).html('���');
  $('#reply_content'+cno).focus();     
  
  $('#reply_fail_info'+cno).hide(); 
}

//�±��� �Է°� �ʱ�ȭ
function init2() {
  
  $('#content').css('display' , '');   
  $('#li_comment').css('display' , '');   

  $('#delete_form').css('display' , 'none');   
  $('#comment_info').css('display', 'none');
  
  $('#passwd2').val('');
  
  $('#content').focus();
  list();
}

//�±��� �Է°� �ʱ�ȭ
function reply_init2(cno) {
  console.log("reply_init2 ȣ�� - >" + cno);
  $('#reply_content'+cno).show();
  $('#reply_li_comment'+cno).show();
 
  $('#reply_delete_form'+cno).remove();
  $('#reply_comment_info'+cno).remove();
  
  $('#reply_passwd2'+cno).remove();  
  
  $('#reply_content').focus();
}

//���
function list() { 
  console.log("list() ->" + <%=devdiaryno%> );
  $.ajax({      
    url: '../comment/list_html.jsp',
    type: "get", // or GET
    cache: false, // �ֽ� ĳ�õ����͸� �����´�.
    async: true, // true: �񵿱� , false: ����  
    dataType: "html", // html or json 
    data: 'devdiaryno=' + <%=devdiaryno%> + '&devcateno=' +<%=devcateno%> + '&recordPerPage=' +<%=recordPerPage%> + '&nowPage=' +<%=nowPage%>, 
    success: function(received_data) { // callback �Լ�  -> �����ڴ� ���� �� �� ȣ���� �����ӿ�ũ�� ����Ѵ�.
     $('#list').html(received_data); 
    }, 
    // Ajax ��� ����, ���� �ڵ尡 200�� �ƴ� ��� ���� , ���� dataType�� �ٸ� ��� error ��ƾ�� 
    // ����ǳ� Console�θ� ��µǰ� , ȭ���쿡�� ���Ȼ� ������� �ʴ´�.
    error: function (request, status, error) { 
      console.log('<strong>ERROR</strong><br>' +  error + '<br>');
    }
  });
}

// �亯 ��� 
function reply_show(cno) {
  $.ajax({      
    url: '../comment/list_reply_html.jsp',
    type: "get", // or GET 
    cache: false, // �ֽ� ĳ�õ����͸� �����´�.
    async: true, // true: �񵿱� , false: ����   
    dataType: "html", // html or json 
    data: 'cno=' + cno, 
    success: function(received_data) { // callback �Լ�  -> �����ڴ� ���� �� �� ȣ���� �����ӿ�ũ�� ����Ѵ�.
     $('#comment_reply'+cno).html(received_data); 
     $('#comment_reply'+cno).css('display', ''); 
     $('#reply_form'+cno).css('display', '');          
     $('#reply_show'+cno).css('display', 'none');  
     $('#reply_hide'+cno).css('display', '');  
    }, 
    // Ajax ��� ����, ���� �ڵ尡 200�� �ƴ� ��� ���� , ���� dataType�� �ٸ� ��� error ��ƾ�� 
    // ����ǳ� Console�θ� ��µǰ� , ȭ���쿡�� ���Ȼ� ������� �ʴ´�.
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
     
// ��� ó��
function create_proc_req() { 
  console.log("frm data = >>" + $('frm'));
  $.ajax({     
    url: '../comment/create_proc.jsp', 
    type: "post", // or GET
    cache: false, // �ֽ� ĳ�õ����͸� �����´�.
    async: true, // true: �񵿱� , false: ����   
    dataType: "json", // html or json, text, xml... (���䵥��������)
    data: $('#frm').serialize(), 
    success: function(received_data) { // callback �Լ�  -> �����ڴ� ���� �� �� ȣ���� �����ӿ�ũ�� ����Ѵ�.
      var display_msgs = ''; // ��¿� display msgs
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
    // Ajax ��� ����, ���� �ڵ尡 200�� �ƴ� ��� ���� , ���� dataType�� �ٸ� ��� error ��ƾ�� 
    // ����ǳ� Console�θ� ��µǰ� , ȭ���쿡�� ���Ȼ� ������� �ʴ´�.
    error: function (request, status, error) { 
      console.log('<strong>ERROR</strong><br>' +  error + '<br>');
    }
  });
  init();
  // ����Ʈ �����̷�Ʈ
  setTimeout(function() { list();  }, 100) // 0.01��
}

// �亯 ���  ó��
function create_reply_proc_req(cno) {
  console.log("create_reply_proc ȣ�� - > cno " + cno);
  $.ajax({     
    url: '../comment/create_reply_proc.jsp', 
    type: "post", // or GET  
    cache: false, // �ֽ� ĳ�õ����͸� �����´�.
    async: true, // true: �񵿱� , false: ����   
    dataType: "json", // html or json, text, xml... (���䵥��������)
    data: $('#reply_frm'+cno).serialize(),     
    success: function(received_data) { // callback �Լ�  -> �����ڴ� ���� �� �� ȣ���� �����ӿ�ũ�� ����Ѵ�.
      console.log("create_reply_proc ���� - >");
      var display_msgs = ''; // ��¿� display msgs
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
    // Ajax ��� ����, ���� �ڵ尡 200�� �ƴ� ��� ���� , ���� dataType�� �ٸ� ��� error ��ƾ�� 
    // ����ǳ� Console�θ� ��µǰ� , ȭ���쿡�� ���Ȼ� ������� �ʴ´�.
    error: function (request, status, error) { 
      console.log('<strong>ERROR</strong><br>' +  error + '<br>');
    }
  });
  reply_init(cno);
  // ����Ʈ �����̷�Ʈ
  setTimeout(function() { reply_show(cno);  }, 100) // 0.01��
}

    
 // ���� �� 
function update_form_req(cno) { 
  $.ajax({    
  url: '../comment/update_form.jsp',
  type: "get", // or GET  
  cache: false, // �ֽ� ĳ�õ����͸� �����´�.
  async: true, // true: �񵿱� , false: ����   
  dataType: "json", // html or json, text, xml... (���䵥��������)
        data: 'cno=' + cno,
        success: function(received_data) { // callback �Լ�  -> �����ڴ� ���� �� �� ȣ���� �����ӿ�ũ�� ����Ѵ�.
         $('#cno').val(received_data.cno);
         $('#content').val(received_data.content); 
         $('#rname').val(received_data.rname);
         $('#email').val(received_data.email);
         
         $('#fail_info').css('display', 'none');
         
         $('#btn_send').html('����'); 
         $('#btn_send').off('click'); // �̺�Ʈ ����
         $('#btn_send').on('click', update_proc_req); // click �̺�Ʈ ��� 
         
         $('#btn_init').html('���');
         
        },
        // Ajax ��� ����, ���� �ڵ尡 200�� �ƴ� ��� ���� , ���� dataType�� �ٸ� ��� error ��ƾ�� 
        // ����ǳ� Console�θ� ��µǰ� , ȭ���쿡�� ���Ȼ� ������� �ʴ´�.
        error: function (request, status, error) { 
          console.log('<strong>ERROR</strong><br>' +  error + '<br>');
        }
      });
    }

// ���� ó��
function update_proc_req() {  
  console.log("update_proc_req ȣ��");   
  $.ajax({    
    url: '../comment/update_proc.jsp',
    type: "post", // or GET  
    cache: false, // �ֽ� ĳ�õ����͸� �����´�.
    async: true, // true: �񵿱� , false: ����   
    dataType: "json", // html or json, text, xml... (���䵥��������)
    data: $('#frm').serialize(), 
    success: function(received_data) { // callback �Լ�  -> �����ڴ� ���� �� �� ȣ���� �����ӿ�ũ�� ����Ѵ�.
      console.log("update_proc_req success ȣ��")
      var display_msgs = ''; // ��¿� display msgs
      var msgs = received_data.msgs; 
        
      for(var i=0; i < msgs.length ; i++){
        display_msgs += msgs[i] + '<br>';
      } 
          
      if(msgs.length > 0) {
       $('#fail_info').html("<br>" + display_msgs)  ;
       $('#fail_info').show();
      } 
    },
    // Ajax ��� ����, ���� �ڵ尡 200�� �ƴ� ��� ���� , ���� dataType�� �ٸ� ��� error ��ƾ�� 
    // ����ǳ� Console�θ� ��µǰ� , ȭ���쿡�� ���Ȼ� ������� �ʴ´�.
    error: function (request, status, error) { 
    console.log('<strong>ERROR</strong><br>' +  error + '<br>');
    }
  });
  init();
  // ����Ʈ �����̷�Ʈ
  setTimeout(function() { list();  }, 100) // 0.01��
  }
  
  
// �亯 ���� ��
function update_reply_form_req(crno) { 
  console.log("update_reply_form ȣ�� - >" + crno);
  $.ajax({    
  url: '../comment/update_reply_form.jsp',
  type: "get", // or GET     
  cache: false, // �ֽ� ĳ�õ����͸� �����´�.
  async: true, // true: �񵿱� , false: ����   
  dataType: "json", // html or json, text, xml... (���䵥��������)
        data: 'crno=' + crno,
        success: function(received_data) { // callback �Լ�  -> �����ڴ� ���� �� �� ȣ���� �����ӿ�ũ�� ����Ѵ�.
          console.log("update_reply_form ���� - >" + received_data.content);
         $('#reply_crno'+received_data.cno).val(crno);          
         $('#reply_content'+received_data.cno).val(received_data.content);  
         $('#reply_rname'+received_data.cno).val(received_data.rname);
         $('#reply_email'+received_data.cno).val(received_data.email);
         
         $('#reply_fail_info').css('display', 'none');
           
         $('#reply_btn_send'+received_data.cno).hide();  
         $('#reply_btn_update'+received_data.cno).show();
         
        },
        // Ajax ��� ����, ���� �ڵ尡 200�� �ƴ� ��� ���� , ���� dataType�� �ٸ� ��� error ��ƾ�� 
        // ����ǳ� Console�θ� ��µǰ� , ȭ���쿡�� ���Ȼ� ������� �ʴ´�.
        error: function (request, status, error) { 
          console.log('<strong>ERROR</strong><br>' +  error + '<br>');
        }
      });
    }
    
// �亯 ���� ó��  
function update_reply_proc_req(cno) {  
  console.log("update_proc_req ȣ��" );   
  $.ajax({    
    url: '../comment/update_reply_proc.jsp',
    type: "post", // or GET  
    cache: false, // �ֽ� ĳ�õ����͸� �����´�.
    async: true, // true: �񵿱� , false: ����   
    dataType: "json", // html or json, text, xml... (���䵥��������)
    data: $('#reply_frm'+cno).serialize(), 
    success: function(received_data) { // callback �Լ�  -> �����ڴ� ���� �� �� ȣ���� �����ӿ�ũ�� ����Ѵ�.
     
      var display_msgs = ''; // ��¿� display msgs    
      var msgs = received_data.msgs; 
        
      for(var i=0; i < msgs.length ; i++){
        display_msgs += msgs[i] + '<br>';
      } 
          
      if(msgs.length > 0) {
       $('#reply_fail_info'+cno).html("<br>" + display_msgs)  ;
       $('#reply_fail_info'+cno).show();
      } 
    },
    // Ajax ��� ����, ���� �ڵ尡 200�� �ƴ� ��� ���� , ���� dataType�� �ٸ� ��� error ��ƾ�� 
    // ����ǳ� Console�θ� ��µǰ� , ȭ���쿡�� ���Ȼ� ������� �ʴ´�.
    error: function (request, status, error) { 
    console.log('<strong>ERROR</strong><br>' +  error + '<br>');
    }
  });
      $('#reply_btn_update'+cno).hide();
      $('#reply_btn_send'+cno).show();     
      $('#reply_passwd'+cno).val('');       
      reply_init(cno);
  // ����Ʈ �����̷�Ʈ
  setTimeout(function() { reply_show(cno);  }, 100) // 0.01��
  }    

//�亯 ���� ��
function delete_reply_form_req(crno) { 
  $.ajax({    
  url: '../comment/update_reply_form.jsp',
  type: "post", // or GET     
  cache: false, // �ֽ� ĳ�õ����͸� �����´�.
  async: true, // true: �񵿱� , false: ����   
  dataType: "json", // html or json, text, xml... (���䵥��������)
        data: 'crno=' + crno,
        success: function(received_data) { // callback �Լ�  -> �����ڴ� ���� �� �� ȣ���� �����ӿ�ũ�� ����Ѵ�.
          $('#reply_content'+received_data.cno).hide();
          $('#reply_li_comment'+received_data.cno).css('display', 'none');
           
          $('#reply_delete_form'+received_data.cno).show();   
          $('#reply_comment_info'+received_data.cno).html('��۹�ȣ : '+ received_data.crno +'<br><br>'+received_data.rname +'('+ received_data.email + ')' + '���� �亯�� ���� �Ͻ÷���<br>'); 
          $('#reply_comment_info'+received_data.cno).show();  
          
          $('#reply_fail_info'+received_data.cno).hide();
           
          $('#reply_btn_delete'+received_data.cno).html('����');  
               
          $('#reply_btn_init2'+received_data.cno).html('���');
          $('#reply_btn_init2'+received_data.cno).on('click', function() { reply_init2(received_data.cno) } ); // click �̺�Ʈ ���  
        },           
        // Ajax ��� ����, ���� �ڵ尡 200�� �ƴ� ��� ���� , ���� dataType�� �ٸ� ��� error ��ƾ�� 
        // ����ǳ� Console�θ� ��µǰ� , ȭ���쿡�� ���Ȼ� ������� �ʴ´�.
        error: function (request, status, error) { 
          console.log('<strong>ERROR</strong><br>' +  error + '<br>');
        }
      });      
    }
     
// �亯 ���� ó��
function delete_reply_proc_req(crno, cno) { 
  console.log("����Ʈ�÷� crno : " + crno + " / cno : " + cno);
  console.log("����Ʈ�÷� ��� : " + $('#reply_passwd2'+cno).val());
  $.ajax({    
    url: '../comment/delete_reply_proc.jsp',
    type: "post", // or GET  
    cache: false, // �ֽ� ĳ�õ����͸� �����´�.
    async: true, // true: �񵿱� , false: ����   
    dataType: "json", // html or json, text, xml... (���䵥��������)
    data: 'crno=' + crno + '&passwd=' +$('#reply_passwd2'+cno).val(),
    success: function(received_data) { // callback �Լ�  -> �����ڴ� ���� �� �� ȣ���� �����ӿ�ũ�� ����Ѵ�.
      var display_msgs = ''; // ��¿� display msgs 
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
    // Ajax ��� ����, ���� �ڵ尡 200�� �ƴ� ��� ���� , ���� dataType�� �ٸ� ��� error ��ƾ�� 
    // ����ǳ� Console�θ� ��µǰ� , ȭ���쿡�� ���Ȼ� ������� �ʴ´�.
      error: function (request, status, error) { 
      console.log('<strong>ERROR</strong><br>' +  error + '<br>');
    } 
      });  
  // ����Ʈ �����̷�Ʈ 
  setTimeout(function() { reply_show(cno)  }, 200) // 0.01��
  reply_init2(cno);   
}     

//���� ��
function delete_form_req(cno) { 
  $.ajax({    
    url: '../comment/update_form.jsp',
    type: "post", // or GET  
    cache: false, // �ֽ� ĳ�õ����͸� �����´�.
    async: true, // true: �񵿱� , false: ����   
    dataType: "json", // html or json, text, xml... (���䵥��������)
    data: 'cno=' + cno,
    success: function(received_data) { // callback �Լ�  -> �����ڴ� ���� �� �� ȣ���� �����ӿ�ũ�� ����Ѵ�.    
     $('#content').css('display' , 'none');    
     $('#li_comment').css('display' , 'none');   
  
     $('#delete_form').css('display' , '');   
     $('#comment_info').html('��۹�ȣ : '+ received_data.cno +'<br><br>'+received_data.rname +'('+ received_data.email + ')' + '���� ����� ���� �Ͻ÷���<br>'); 
     $('#comment_info').css('display' , '');   
     
     $('#fail_info').css('display', 'none');
     
     $('#btn_delete').html('����'); 
     $('#btn_delete').on('click', function() { delete_proc_req(received_data.cno) }); // click �̺�Ʈ ��� 
         
     $('#btn_init2').html('���');
    },
    // Ajax ��� ����, ���� �ڵ尡 200�� �ƴ� ��� ���� , ���� dataType�� �ٸ� ��� error ��ƾ�� 
    // ����ǳ� Console�θ� ��µǰ� , ȭ���쿡�� ���Ȼ� ������� �ʴ´�.
    error: function (request, status, error) { 
    console.log('<strong>ERROR</strong><br>' +  error + '<br>');
    }
  });
 }
  
// ���� ó��
function delete_proc_req(cno) { 
  console.log(cno+"  , " + $('#passwd2').val() );
  $.ajax({    
    url: '../comment/delete_proc.jsp',
    type: "post", // or GET  
    cache: false, // �ֽ� ĳ�õ����͸� �����´�.
    async: true, // true: �񵿱� , false: ����   
    dataType: "json", // html or json, text, xml... (���䵥��������)
    data: 'cno=' + cno + '&passwd=' +$('#passwd2').val(),
    success: function(received_data) { // callback �Լ�  -> �����ڴ� ���� �� �� ȣ���� �����ӿ�ũ�� ����Ѵ�.
      var display_msgs = ''; // ��¿� display msgs
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
    // Ajax ��� ����, ���� �ڵ尡 200�� �ƴ� ��� ���� , ���� dataType�� �ٸ� ��� error ��ƾ�� 
    // ����ǳ� Console�θ� ��µǰ� , ȭ���쿡�� ���Ȼ� ������� �ʴ´�.
      error: function (request, status, error) { 
      console.log('<strong>ERROR</strong><br>' +  error + '<br>');
    }
      });
  init2();
  // ����Ʈ �����̷�Ʈ
  setTimeout(function() { list();  }, 100) // 0.01��
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
        style="text-align: left; font-weight: bold; font-size: 24pt;'">���</span>
      <%=cnt%>
    </div>
    <form id='frm'>
      <input type='hidden' id='devdiaryno' name='devdiaryno' value='<%=devdiaryno%>'> 
        <input type='hidden' id='cno' name='cno' value=''>
      <fieldset class='comment_content' style="height: 250px; border: none;">
        <ul>
          <li class='li_none' id='delete_form' style="display: none; text-align: center;"> 
          <span id='comment_info'></span>
          �ش� ����� ��й�ȣ�� �Է����ּ���.<br><br>
          <label for='passwd' id='label_passwd'>��й�ȣ : </label> 
          <input type='password' id='passwd2' name='passwd2'size='10%' />
           <button type='button' id='btn_delete'  style="margin-top: 20px;">����</button> 
           <button type='button' id='btn_init2'>���</button> 
          </li> 
          <li class='li_none'>
          <textarea name='content' id='content' rows='5' style='width: 100%; resize: none;'></textarea>
           </li> 
          <li id='li_comment' class='li_right' style="margin-right: 15px;">
          <label for='rname' id='label_rname'>�̸� : </label> 
          <input type='text' id='rname' name='rname' value ='<%=rname %>'  size='10%' /> 
          <label for='email' id='label_email'>�̸��� : </label> 
          <input type='email' id='email' name='email'  value ='<%=email %>' size='20%' /> 
          <label for='passwd' id='label_passwd'>��й�ȣ : </label> 
          <input type='password' id='passwd' name='passwd' size='10%' />  
            <button type='button' id='btn_send'>���</button>
            <button type='button' id='btn_init'>���</button> 
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
