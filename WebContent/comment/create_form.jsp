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
<title>�Խ���</title>
<script type="text/JavaScript"
        src="http://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
 
<script type="text/javascript">


$(function() { // ������ ����� �ڹٽ�ũ��Ʈ ���� (window.onload�� �����Ŷ� �����ϸ��)
  $('#btn_send').on('click', create_proc_req); // click �̺�Ʈ ��� 
  
  $('#btn_send').on('keydown', function(key) {
    if(key.keyCode == 13) {
    $('#panel_close_a').focus();
    }
  });
  
});

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
            
      var panel_close = $('#panel_close').clone(); // �±� ����
      // panel_close.css('display','');
      $('#panel').html(display_msgs);
      $('#panel').append(panel_close.show());
      $('#panel').show();
      
      $('#btn_panel_close').focus();
      
    <%-- <% response.sendRedirect("./read.jsp?devcateno="+devcateno+"&devdiaryno="+devdiaryno); %> --%>
     location.replace("./read.jsp");
    } 
    },
    // Ajax ��� ����, ���� �ڵ尡 200�� �ƴ� ��� ���� , ���� dataType�� �ٸ� ��� error ��ƾ�� 
    // ����ǳ� Console�θ� ��µǰ� , ȭ���쿡�� ���Ȼ� ������� �ʴ´�.
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
    <br>[<button type='button' onclick="btn_panel_close();" id="btn_panel_close">�ݱ�</button>]
  </DIV>

<div class='comment_form' style="width: 100%; height: 280px;">
  <div class='comment_top'>
  <span style="text-align: left; font-weight: bold; font-size: 24pt;'">���</span> 24
  </div>
   <form id='frm' > 
      <input type='hidden'  id ='devdiaryno' name='devdiaryno'  value='<%=devdiaryno%>'> 
     <fieldset class='comment_content' style="height: 250px; border: none;" >
     <ul> 
      <li class='li_none'>  
        <textarea name='content' id='content' rows='5' style='width: 100%; resize: none;'></textarea>
      </li>    
      <li class='li_right' style="margin-right: 15px;">
        <label for='rname'>�̸� : </label>
        <input type='text' id='rname' name='rname' size='10%'/>
        <label for='email'>�̸��� : </label>
        <input type='text' id='email' name='email' size='10%'/>
        <label for='rname'>��й�ȣ : </label>
        <input type='text' id='passwd' name='passwd' size='10%'/>
        <button type='button' id='btn_send'>���</button>
      </li>     
    </ul> 
  </fieldset> 
  </form>  
</div>
</body>   
</html>  