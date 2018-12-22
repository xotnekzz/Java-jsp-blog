<%@ page contentType="text/plain; charset=UTF-8" %>
 
<%@ include file="./ssi-json.jsp" %>
 
<%
int notice4no = Integer.parseInt(request.getParameter("notice4no"));
String title = request.getParameter("title");
String rname = request.getParameter("rname");

notice4VO.setNotice4no(notice4no);
notice4VO.setTitle(title);
notice4VO.setRname(rname);

System.out.println("Update_Proc : notice4no ->" + notice4no);
System.out.println("Update_Proc : title ->" + title);
System.out.println("Update_Proc : rname ->" + rname);
              
JSONObject json = new JSONObject();
ArrayList<String> msgs = new ArrayList<String>();
 
int count = notice4DAO.update(notice4VO, notice4VO.getNotice4no()); // 수정 처리
 
if (count == 1) {
  msgs.add("공지사항을 수정했습니다.");
} else {
  msgs.add("공지사항 수정에 실패했습니다.");
  msgs.add("다시한번 시도해주세요.");
}
 
json.put("msgs", msgs);
out.println(json);
%>