<%@ page contentType="text/html; charset=UTF-8" %>
 
<%@ include file="./ssi.jsp" %>
 
  <TABLE class='table_basic'>
    <colgroup>
      <col style='width: 5%;' />
      <col style='width: 50%;' />
      <col style='width: 10%;' />
      <col style='width: 20%;' />
      <col style='width: 15%;' />
    </colgroup>
    <TR>
      <TH class='th_basic'>NO</TH>
      <TH class='th_basic'>내용</TH>
      <TH class='th_basic'>성명</TH>
      <TH class='th_basic'>등록일</TH>
      <TH class='th_basic'>기타</TH>
    </TR>
<%
ArrayList<Notice4VO> list = notice4DAO.list();
for (int index=0; index < list.size(); index++) { 
  Notice4VO notice4VO = list.get(index);
%>
    <TR>
      <TD class='td_basic'><%=notice4VO.getNotice4no() %></TD>
      <TD class='td_left'><%=notice4VO.getTitle() %></TD>
      <TD class='td_basic'><%=notice4VO.getRname() %></TD>
      <TD class='td_basic'><%=notice4VO.getRdate().substring(0, 10) %></TD>
      <TD class='td_basic'>
        <A href='javascript:update_form_req(<%=notice4VO.getNotice4no() %>)'>수정</A>
        /
        <A href='javascript:delete_form_req(<%=notice4VO.getNotice4no() %>)'>삭제</A></TD>
    </TR>
<%  
}
%>
  </TABLE>
 