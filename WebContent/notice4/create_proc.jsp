<%@ page contentType="text/plain; charset=UTF-8" %> 
 
<%@ include file="./ssi-json.jsp" %> 

<jsp:useBean id="noticeVO" class="nation.web.notice4.Notice4VO"/> 
<jsp:setProperty property="*" name="noticeVO"/> 
 
<%
	JSONObject json = new JSONObject();
	ArrayList<String> msgs = new ArrayList<String>();
	
	int count = notice4DAO.create(noticeVO);
	
	if(count == 1) { 
	  msgs.add("공지사항을 등록했습니다.");
	} else {
	  msgs.add("공지사항 등록에 실패하였습니다.");
	  msgs.add("다시한번 시도해주세요.");
	}
	json.put("msgs", msgs);
	out.print(json);
%>
