<%@ page contentType="text/html; charset=UTF-8" %>
 
<%
if (session.getAttribute("act") == null) {
  session.setAttribute("act", "G"); // 손님 권한 적용
}
%>
  
<!DOCTYPE html>
<html lang="ko">
<head> 

<meta charset="UTF-8">
<title>개발일지</title>
<link href="./css/style.css" rel='Stylesheet' type='text/css'>
 <!-- <meta name="viewport" content="width=device-width"> --> 
 
  <!-- jQuery -->
  <script src="http://code.jquery.com/jquery-1.10.2.min.js"></script>
  
  <!-- Fotorama -->
  <link href="./fotorama/fotorama.css" rel="stylesheet">
  <script src="./fotorama/fotorama.js"></script>
  
  <!-- Just don’t want to repeat this prefix in every img[src] -->
  <!-- <base href="http://s.fotorama.io/okonechnikov/"> -->
  
  <script type="text/javascript">
    $(document).ready(function(e) {
      $(".fotorama").on("click",function(){
       
       var href = $(".fotorama").find("a").attr('href');
       location.href=href;
    });  
   }); 
    
  </script>
</head>
<body>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='container'>
<div class='content_top'>
<jsp:include page="/menu/home_menu.jsp" flush='false' />
</div>
<DIV class='content_home'>
  <DIV style='width: 40%; background-color: #ffffff; margin: 30px auto; font-size: 32px; font-weight: bold; text-align: center;'>
    Reference Tech blog
  </DIV>    
  
  <div class="fotorama" data-width="1000" data-ratio="700/466" data-max-width="80%"  data-click="false" data-autoplay="3000" align="center">
    <div  data-img="./fotorama/devblog/kakao.jpg" > 
      <a href='http://tech.kakao.com/'></a> 
    </div>        

    <div  data-img="./fotorama/devblog/ooah.jpg" >
      <a href='http://woowabros.github.io/'></a>
    </div>
    
    <div  data-img="./fotorama/devblog/sk.jpg" >
      <a href='http://readme.skplanet.com/'></a>
    </div>
    
    <div   data-img="./fotorama/devblog/tmon.jpg"> 
      <a href='https://tmondev.blog.me/'></a>
    </div> 
    
    <div data-img="./fotorama/devblog/spoqa.jpg"> 
      <a href='https://spoqa.github.io/'></a>
    </div>
  </div> 
   <hr style="border: 1px solid #eeeeee ; margin-bottom: 50px;">
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
 
</body>
</html>
 
 